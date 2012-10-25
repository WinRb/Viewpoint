module Viewpoint::EWS::SOAP

  # Exchange Data Service operations as listed in the EWS Documentation.
  # @see http://msdn.microsoft.com/en-us/library/bb409286.aspx
  module ExchangeDataServices
    include Viewpoint::EWS::SOAP

    # -------------- Item Operations -------------

    # ------------- Folder Operations ------------

    # Creates folders, calendar folders, contacts folders, tasks folders, and search folders.
    # @see http://msdn.microsoft.com/en-us/library/aa563574.aspx CreateFolder
    #
    # @param [Hash] opts
    # @option opts [Hash] :parent_folder_id A hash with either the name of a
    #   folder or it's numerical ID.
    #   See: http://msdn.microsoft.com/en-us/library/aa565998.aspx 
    #   {:id => :root}  or {:id => 'myfolderid#'}
    # @option opts [Array<Hash>] :folders An array of hashes of folder types
    #   that conform to input for build_xml!
    #   @example [ 
    #     {:folder =>
    #       {:display_name => "New Folder"}},
    #     {:calendar_folder =>
    #       {:folder_id => {:id => 'blah', :change_key => 'blah'}}}
    def create_folder(opts)
      opts = opts.clone
      req = build_soap! do |type, builder|
        if(type == :header)
        else
          builder.nbuild.CreateFolder {|x|
            x.parent.default_namespace = @default_ns
            builder.parent_folder_id!(opts[:parent_folder_id])
            builder.folders!(opts[:folders])
          }
        end
      end
      do_soap_request(req)
    end

    # Defines a request to copy folders in the Exchange store
    # @see http://msdn.microsoft.com/en-us/library/aa563949.aspx
    # @param [Hash] to_folder_id The target FolderId
    #   {:id => <myid>, :change_key => <optional ck>}
    # @param [Array<Hash>] *sources The source Folders
    #   {:id => <myid>, :change_key => <optional_ck>},
    #   {:id => <myid2>, :change_key => <optional_ck>}
    def copy_folder(to_folder_id, *sources)
      req = build_soap! do |type, builder|
        if(type == :header)
        else
          builder.nbuild.CopyFolder {
            builder.nbuild.parent.default_namespace = @default_ns
            builder.to_folder_id!(to_folder_id)
            builder.folder_ids!(sources.flatten)
          }
        end
      end
      do_soap_request(req)
    end

    # Deletes folders from a mailbox.
    # @see http://msdn.microsoft.com/en-us/library/aa564767.aspx DeleteFolder
    #
    # @param [Hash] opts
    # @option opts [Array<Hash>] :folder_ids An array of folder_ids in the form:
    #   [ {:id => 'myfolderID##asdfs', :change_key => 'asdfasdf'},
    #     {:id => :msgfolderroot} ]  # Don't do this for real
    # @option opts [String,nil] :delete_type Type of delete to do:
    #   HardDelete/SoftDelete/MoveToDeletedItems
    # @option opts [String,nil] :act_as User to act on behalf as. This user
    #   must have been given delegate access to this folder or else this
    #   operation will fail.
    def delete_folder(opts)
      req = build_soap! do |type, builder|
        if(type == :header)
        else
          builder.nbuild.DeleteFolder('DeleteType' => opts[:delete_type]) {
            builder.nbuild.parent.default_namespace = @default_ns
            builder.folder_ids!(opts[:folder_ids], opts[:act_as])
          }
        end
      end
      do_soap_request(req)
    end

    # Find subfolders of an identified folder
    # @see http://msdn.microsoft.com/en-us/library/aa563918.aspx
    #
    # @param [Hash] opts
    # @option opts [Array<Hash>] :parent_folder_ids An Array of folder id Hashes,
    #   either a DistinguishedFolderId (must me a Symbol) or a FolderId (String)
    #   [{:id => <myid>, :change_key => <ck>}, {:id => :root}]
    # @option opts [String] :traversal Shallow/Deep/SoftDeleted
    # @option opts [Hash] :folder_shape defines the FolderShape node
    #   See: http://msdn.microsoft.com/en-us/library/aa494311.aspx
    # @option folder_shape [String] :base_shape IdOnly/Default/AllProperties
    # @option folder_shape :additional_properties
    #   See: http://msdn.microsoft.com/en-us/library/aa563810.aspx
    # @option opts [Hash] :restriction A well formatted restriction Hash.
    # @example
    #   { :parent_folder_ids => [{:id => root}],
    #     :traversal => 'Deep',
    #     :folder_shape  => {:base_shape => 'Default'} }
    # @todo Better error checking for opts parameters
    # @todo add FractionalPageFolderView
    def find_folder(opts)
      opts = opts.clone
      req = build_soap! do |type, builder|
        if(type == :header)
        else
          builder.nbuild.FindFolder(:Traversal => opts[:traversal]) {
            builder.nbuild.parent.default_namespace = @default_ns
            builder.folder_shape!(opts[:folder_shape])
            builder.restriction!(opts[:restriction]) if opts[:restriction]
            builder.parent_folder_ids!(opts[:parent_folder_ids])
          }
        end
      end
      do_soap_request(req)
    end

    # Gets folders from the Exchange store
    # @see http://msdn.microsoft.com/en-us/library/aa580274.aspx
    #
    # @param [Hash] opts
    # @option opts [Array<Hash>] :folder_ids An array of folder_ids in the form:
    #   [ {:id => 'myfolderID##asdfs', :change_key => 'asdfasdf'},
    #     {:id => :msgfolderroot} ]  # Don't do this for real
    # @option opts [Hash] :folder_shape defines the FolderShape node
    # @option folder_shape [String] :base_shape IdOnly/Default/AllProperties
    # @option folder_shape :additional_properties
    # @option opts [String,nil] :act_as User to act on behalf as. This user must
    #   have been given delegate access to this folder or else this operation
    #   will fail.
    # @example
    #   { :folder_ids   => [{:id => :msgfolderroot}],
    #     :folder_shape => {:base_shape => 'Default'} }
    def get_folder(opts)
      opts = opts.clone
      req = build_soap! do |type, builder|
        if(type == :header)
        else
          builder.nbuild.GetFolder {
            builder.nbuild.parent.default_namespace = @default_ns
            builder.folder_shape!(opts[:folder_shape])
            builder.folder_ids!(opts[:folder_ids], opts[:act_as])
          }
        end
      end
      do_soap_request(req)
    end
    
    # Defines a request to move folders in the Exchange store
    # @see http://msdn.microsoft.com/en-us/library/aa566202(v=EXCHG.140).aspx
    # @param [Array<Hash>] sources The source Folders
    #   [ {:id => <myid>, :change_key => <optional_ck>} ]
    # @param [Hash] to_fid The target FolderId {:id => <myid>, :change_key => <optional ck>}
    def move_folder(sources, to_fid)
      req = build_soap! do |type, builder|
        if(type == :header)
        else
          builder.nbuild.MoveFolder {
            builder.nbuild.parent.default_namespace = @default_ns
            builder.to_folder_id!(to_fid)
            builder.folder_ids!(sources)
          }
        end
      end
      do_soap_request(req)
    end

    # Update properties for a specified folder
    # There is a lot more building in this method because most of the builders are only used
    # for this operation so there was no need to externalize them for re-use.
    # @see http://msdn.microsoft.com/en-us/library/aa580519(v=EXCHG.140).aspx
    # @param [Array<Hash>] folder_changes an Array of well formatted Hashes
    def update_folder(folder_changes)
      req = build_soap! do |type, builder|
        if(type == :header)
        else
          builder.nbuild.UpdateFolder {
            builder.nbuild.parent.default_namespace = @default_ns
            builder.nbuild.FolderChanges {
              folder_changes.each do |fc|
                builder[NS_EWS_TYPES].FolderChange {
                  builder.dispatch_folder_id!(fc)
                  builder[NS_EWS_TYPES].Updates {
                    # @todo finish implementation
                  }
                }
              end
            }
          }
        end
      end
      do_soap_request(req)
    end

    # Empties folders in a mailbox.
    # @see http://msdn.microsoft.com/en-us/library/ff709484.aspx
    # @param [Hash] opts
    # @option opts [String] :delete_type Must be one of
    #   ExchangeDataServices::HARD_DELETE, SOFT_DELETE, or MOVE_TO_DELETED_ITEMS
    # @option opts [Boolean] :delete_sub_folders
    # @option opts [Array<Hash>] :folder_ids An array of folder_ids in the form:
    #   [ {:id => 'myfolderID##asdfs', :change_key => 'asdfasdf'},
    #     {:id => 'blah'} ]
    # @todo Finish
    def empty_folder(opts)
      validate_version(VERSION_2010_SP1)
      ef_opts = {}
      [:delete_type, :delete_sub_folders].each do |k|
        ef_opts[k.to_s.camel_case] = validate_param(opts, k, true)
      end
      fids = validate_param opts, :folder_ids, true

      req = build_soap! do |type, builder|
        if(type == :header)
        else
          builder.nbuild.EmptyFolder(ef_opts) {|x|
            builder.nbuild.parent.default_namespace = @default_ns
            builder.folder_ids!(fids)
          }
        end
      end
      do_soap_request(req)
    end

    # ----------- Attachment Operations ----------

    # ------------ Utility Operations ------------

    # Exposes the full membership of distribution lists.
    # @see http://msdn.microsoft.com/en-us/library/aa494152.aspx ExpandDL
    #
    # @todo Fully support all of the ExpandDL operations. Today it just supports
    #   taking an e-mail address as an argument
    # @param [Hash] opts
    # @option opts [String] :email_address The e-mail address of the
    #   distribution to resolve
    # @option opts [Hash] :item_id The ItemId of the private distribution to resolve.
    #   {:id => 'my id'}
    def expand_dl(opts)
      opts = opts.clone
      req = build_soap! do |type, builder|
        if(type == :header)
        else
        builder.nbuild.ExpandDL {|x|
          x.parent.default_namespace = @default_ns
          x.Mailbox {|mb|
            key = :email_address
            mb[NS_EWS_TYPES].EmailAddress(opts[key]) if opts[key]
            builder.item_id! if opts[:item_id]
          }
        }
        end
      end
      do_soap_request(req)
    end

    # Resolve ambiguous e-mail addresses and display names
    # @see http://msdn.microsoft.com/en-us/library/aa565329.aspx ResolveNames
    # @see http://msdn.microsoft.com/en-us/library/aa581054.aspx UnresolvedEntry
    # @param [Hash] opts
    # @option opts [String] :name the unresolved entry
    # @option opts [Boolean] :full_contact_data (true) Whether or not to return
    #   the full contact details.
    # @option opts [String] :search_scope where to seach for this entry, one of
    #   SOAP::Contacts, SOAP::ActiveDirectory, SOAP::ActiveDirectoryContacts
    #   (default), SOAP::ContactsActiveDirectory
    # @option opts [String, FolderId] :parent_folder_id either the name of a
    #   folder or it's numerical ID.
    #   @see http://msdn.microsoft.com/en-us/library/aa565998.aspx
    def resolve_names(opts)
      opts = opts.clone
      fcd = opts.has_key?(:full_contact_data) ? opts[:full_contact_data] : true
      req = build_soap! do |type, builder|
        if(type == :header)
        else
        builder.nbuild.ResolveNames {|x|
          x.parent['ReturnFullContactData'] = fcd.to_s
          x.parent['SearchScope'] = opts[:search_scope] if opts[:search_scope]
          x.parent.default_namespace = @default_ns
          # @todo builder.nbuild.ParentFolderIds
          x.UnresolvedEntry(opts[:name])
        }
        end
      end
      do_soap_request(req)
    end

    # Converts item and folder identifiers between formats.
    # @see http://msdn.microsoft.com/en-us/library/bb799665.aspx
    # @todo Needs to be finished
    def convert_id(opts)
      opts = opts.clone
      req = build_soap! do |type, builder|
        if(type == :header)
        else
        builder.nbuild.ConvertId {|x|
        }
        end
      end
      do_soap_request(req)
    end

  end #ExchangeDataServices
end
