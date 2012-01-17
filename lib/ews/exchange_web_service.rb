=begin
  This file is part of Viewpoint; the Ruby library for Microsoft Exchange Web Services.

  Copyright © 2011 Dan Wanek <dan.wanek@gmail.com>

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
=end

module Viewpoint::EWS::SOAP
  class ExchangeWebService
    include Viewpoint::EWS::SOAP
    include Viewpoint::EWS::SOAP::XmlBuilder

    def initialize(connection)
      super()
      @con = connection
    end

    # Resolve ambiguous e-mail addresses and display names
    # @see http://msdn.microsoft.com/en-us/library/aa565329.aspx ResolveNames
    # @see http://msdn.microsoft.com/en-us/library/aa581054.aspx UnresolvedEntry
    #
    # @param [String] name an unresolved entry
    # @param [Boolean] full_contact_data whether or not to return full contact info
    # @param [Hash] opts optional parameters to this method
    # @option opts [String] :search_scope where to seach for this entry, one of
    #   SOAP::Contacts, SOAP::ActiveDirectory, SOAP::ActiveDirectoryContacts (default),
    #   SOAP::ContactsActiveDirectory
    # @option opts [String, FolderId] :parent_folder_id either the name of a folder or
    #   it's numerical ID.  @see http://msdn.microsoft.com/en-us/library/aa565998.aspx
    def resolve_names(name, full_contact_data = true, opts = {})
      attribs = {:ReturnFullContactData => full_contact_data.to_s}
      attribs[:SearchScope] = opts[:search_scope] if opts[:search_scope]

      req = build_soap_envelope do |type, builder|
        if(type == :header)
        else
        builder.ResolveNames(attribs) {
          builder.parent.default_namespace = @default_ns
          # @todo builder.ParentFolderIds
          builder.UnresolvedEntry(name)
        }
        end
      end
      puts "DOC:\n#{req.to_xml}"
      # @todo rsp = Nokogiri::XML(send_soap_request(soapmsg.doc.to_xml))
      #parse!(resp)
    end

    # Exposes the full membership of distribution lists.
    # @see http://msdn.microsoft.com/en-us/library/aa494152.aspx ExpandDL
    #
    # @param [String] dist_email The e-mail address associated with the Distribution List
    # @todo Fully support all of the ExpandDL operations. Today it just supports
    #   taking an e-mail address as an argument
    def expand_dl(dist_email)
      req = build_soap_envelope do |type, builder|
        if(type == :header)
        else
        builder.ExpandDL {
          builder.parent.default_namespace = @default_ns
          builder.Mailbox {
            builder.parent.default_namespace = NAMESPACES["xmlns:#{NS_EWS_TYPES}"]
            builder.EmailAddress(dist_email)
          }
        }
        end
      end
      puts "DOC:\n#{req.to_xml}"

      #parse!(resp)
    end

    # Find subfolders of an identified folder
    # @see http://msdn.microsoft.com/en-us/library/aa563918.aspx
    #
    # @param [Array<Hash>] parent_folder_ids An Array of folder id Hashes, either a
    #   DistinguishedFolderId (must me a Symbol) or a FolderId (String)
    #   [{:id => <myid>, :change_key => <ck>}, {:id => :root}]
    # @param [String] traversal Shallow/Deep/SoftDeleted
    # @param [Hash] folder_shape defines the FolderShape node
    #   See: http://msdn.microsoft.com/en-us/library/aa494311.aspx
    # @option folder_shape [String] :base_shape IdOnly/Default/AllProperties
    # @option folder_shape :additional_properties
    #   See: http://msdn.microsoft.com/en-us/library/aa563810.aspx
    # @param [Hash] opts optional parameters to this method
    def find_folder(parent_folder_ids = [{:id => :root}], traversal = 'Shallow', folder_shape = {:base_shape => 'Default'}, opts = {})
      req = build_soap_envelope do |type, builder|
        if(type == :header)
        else
          builder.FindFolder(:Traversal => traversal) {
            builder.parent.default_namespace = @default_ns
            folder_shape!(builder, folder_shape)
            # @todo add FractionalPageFolderView
            restriction!(builder, opts[:restriction]) if opts[:restriction]
            parent_folder_ids!(builder, parent_folder_ids)
          }
        end
      end
      puts "DOC:\n#{req.to_xml}"
      #parse!(resp)
    end

    # Identifies items that are located in a specified folder
    # @see http://msdn.microsoft.com/en-us/library/aa566107.aspx
    #
    # @param [Array<Hash>] parent_folder_ids An Array of folder id Hashes, either a
    #   DistinguishedFolderId (must me a Symbol) or a FolderId (String)
    #   [{:id => <myid>, :change_key => <ck>}, {:id => :root}]
    # @param [String] traversal Shallow/Deep/SoftDeleted
    # @param [Hash] item_shape defines the FolderShape node
    #   See: http://msdn.microsoft.com/en-us/library/aa494311.aspx
    # @option item_shape [String] :base_shape IdOnly/Default/AllProperties
    # @option item_shape :additional_properties
    #   See: http://msdn.microsoft.com/en-us/library/aa563810.aspx
    # @param [Hash] opts optional parameters to this method
    # @option opts [Hash] :calendar_view Limit FindItem by a start and end date
    #   {:calendar_view => {:max_entries_returned => 2, :start_date => <DateTime Obj>, :end_date => <DateTime Obj>}}
    # @option opts [Hash] :contacts_view Limit FindItem between contact names
    #   {:contacts_view => {:max_entries_returned => 2, :initial_name => 'Dan', :final_name => 'Wally'}}
    def find_item(parent_folder_ids, traversal = 'Shallow', item_shape = {:base_shape => 'Default'}, opts = {})
      req = build_soap_envelope do |type, builder|
        if(type == :header)
        else
          builder.FindItem(:Traversal => traversal) {
            builder.parent.default_namespace = @default_ns
            item_shape!(builder, item_shape)
            # @todo add FractionalPageFolderView
            calendar_view!(builder, opts[:calendar_view]) if opts[:calendar_view]
            contacts_view!(builder, opts[:contacts_view]) if opts[:contacts_view]
            restriction!(builder, opts[:restriction]) if opts[:restriction]
            parent_folder_ids!(builder, parent_folder_ids)
          }
        end
      end
      puts "DOC:\n#{req.to_xml}"

      #parse!(resp)
    end

    # Gets folders from the Exchange store
    # @see http://msdn.microsoft.com/en-us/library/aa580274.aspx
    #
    # @param [Array<Hash>] folder_ids An array of folder_ids in the form:
    #   [ {:id => 'myfolderID##asdfs', :change_key => 'asdfasdf'},
    #     {:id => :msgfolderroot} ]  # Don't do this for real
    # @param [Hash] folder_shape defines the FolderShape node
    #   See: http://msdn.microsoft.com/en-us/library/aa494311.aspx
    # @option folder_shape [String] :base_shape IdOnly/Default/AllProperties
    # @option folder_shape :additional_properties
    #   See: http://msdn.microsoft.com/en-us/library/aa563810.aspx
    # @param [String,nil] act_as User to act on behalf as.  This user must have been
    #   given delegate access to this folder or else this operation will fail.
    # @param [Hash] opts optional parameters to this method
    def get_folder(folder_ids, folder_shape = {:base_shape => 'Default'}, act_as = nil)
      req = build_soap_envelope do |type, builder|
        if(type == :header)
        else
          builder.GetFolder {
            builder.parent.default_namespace = @default_ns
            folder_shape!(builder, folder_shape)
            folder_ids!(builder, folder_ids, act_as)
          }
        end
      end
      puts "DOC:\n#{req.to_xml}"

      #parse!(resp)
    end

    # @todo
    def convert_id
    end

    # Creates folders, calendar folders, contacts folders, tasks folders, and search folders.
    # @see http://msdn.microsoft.com/en-us/library/aa563574.aspx CreateFolder
    #
    # @param [Hash] parent_folder_id A hash with either the name of a folder or it's
    #   numerical ID.  See: http://msdn.microsoft.com/en-us/library/aa565998.aspx
    #   {:id => :root}  or {:id => 'myfolderid#'}
    # @param [Array<Hash>] folders An array of hashes of folder types that conform to
    #   input for build_xml!
    #   @example [ {:folder =>
    #               {:sub_elements => [{:display_name => {:text => 'New Folder'}}]}},
    #              {:calendar_folder =>
    #               {:sub_elements => [{:display_name => {:text => 'Agenda'}}]}} ]
    def create_folder(parent_folder_id, folders)
      req = build_soap_envelope do |type, builder|
        if(type == :header)
        else
          builder.CreateFolder {
            builder.parent.default_namespace = @default_ns
            parent_folder_id!(builder, parent_folder_id)
            folders!(builder, folders)
          }
        end
      end
      puts "DOC:\n#{req.to_xml}"

      #parse!(resp)
    end

    # Deletes folders from a mailbox.
    # @see http://msdn.microsoft.com/en-us/library/aa564767.aspx DeleteFolder
    #
    # @param [Array<Hash>] folder_ids An array of folder_ids in the form:
    #   [ {:id => 'myfolderID##asdfs', :change_key => 'asdfasdf'},
    #     {:id => :msgfolderroot} ]  # Don't do this for real
    # @param [String,nil] delete_type Type of delete to do: HardDelete/SoftDelete/MoveToDeletedItems
    def delete_folder(folder_ids, delete_type = 'MoveToDeletedItems', act_as = nil)
      req = build_soap_envelope do |type, builder|
        if(type == :header)
        else
          builder.DeleteFolder('DeleteType' => delete_type) {
            builder.parent.default_namespace = @default_ns
            folder_ids!(builder, folder_ids, act_as)
          }
        end
      end
      puts "DOC:\n#{req.to_xml}"

      #parse!(resp)
    end

    # Update properties for a specified folder
    # There is a lot more building in this method because most of the builders are only used
    # for this operation so there was no need to externalize them for re-use.
    # @see http://msdn.microsoft.com/en-us/library/aa580519(v=EXCHG.140).aspx
    # @param [Array<Hash>] folder_changes an Array of well-formatted Hashes
    def update_folder(folder_changes)
      req = build_soap_envelope do |type, builder|
        if(type == :header)
        else
          builder.UpdateFolder {
            builder.parent.default_namespace = @default_ns
            builder.FolderChanges {
              folder_changes.each do |fc|
                builder[NS_EWS_TYPES].FolderChange {
                  dispatch_folder_id!(builder, fc)
                  builder[NS_EWS_TYPES].Updates {
                    # @todo finish implementation
                  }
                }
              end
            }
          }
        end
      end
      puts "DOC:\n#{req.to_xml}"
    end
    
    # Defines a request to move folders in the Exchange store
    # @see http://msdn.microsoft.com/en-us/library/aa566202(v=EXCHG.140).aspx
    # @param [Hash] to_fid The target FolderId {:id => <myid>, :change_key => <optional ck>}
    # @param [Array<Hash>] sources The source Folders
    #   [ {:id => <myid>, :change_key => <optional_ck>} ]
    def move_folder(to_fid, sources)
      req = build_soap_envelope do |type, builder|
        if(type == :header)
        else
          builder.MoveFolder {
            builder.parent.default_namespace = @default_ns
            to_folder_id!(builder, to_fid)
            folder_ids!(builder, sources)
          }
        end
      end
      puts "DOC:\n#{req.to_xml}"
    end

    # Defines a request to copy folders in the Exchange store
    # @see http://msdn.microsoft.com/en-us/library/aa563949(v=EXCHG.140).aspx
    # @param [Hash] to_fid The target FolderId {:id => <myid>, :change_key => <optional ck>}
    # @param [Array<Hash>] sources The source Folders
    #   [ {:id => <myid>, :change_key => <optional_ck>} ]
    def copy_folder(to_fid, sources)
      req = build_soap_envelope do |type, builder|
        if(type == :header)
        else
          builder.CopyFolder {
            builder.parent.default_namespace = @default_ns
            to_folder_id!(builder, to_fid)
            folder_ids!(builder, sources)
          }
        end
      end
      puts "DOC:\n#{req.to_xml}"
    end

    # Used to subscribe client applications to either push, pull or stream notifications.
    # @see http://msdn.microsoft.com/en-us/library/aa566188(v=EXCHG.140).aspx
    # @param [Array<Hash>] subscriptions An array of Hash objects that describe each
    #   subscription.
    #   Ex: [ {:pull_subscription_request => {
    #         :subscribe_to_all_folders => false,
    #         :folder_ids => [ {:id => 'id', :change_key => 'ck'} ],
    #         :event_types=> %w{CopiedEvent CreatedEvent},
    #         :watermark  => 'watermark id',
    #         :timeout    => intval
    #       }},
    #       {:push_subscription_request => {
    #         :subscribe_to_all_folders => true,
    #         :event_types=> %w{CopiedEvent CreatedEvent},
    #         :status_frequency => 15,
    #         :uRL => 'http://my.endpoint.for.updates/',
    #       }},
    #       {:streaming_subscription_request => {
    #         :subscribe_to_all_folders => false,
    #         :folder_ids => [ {:id => 'id', :change_key => 'ck'} ],
    #         :event_types=> %w{NewMailEvent DeletedEvent},
    #       }},
    #       ]
    def subscribe(subscriptions)
      req = build_soap_envelope do |type, builder|
        if(type == :header)
        else
          builder.Subscribe {
            builder.parent.default_namespace = @default_ns
            subscriptions.each do |sub|
              subtype = sub.keys.first
              if(respond_to?(subtype))
                method(subtype).call(builder, sub[subtype])
              else
                raise EwsBadArgumentError, "Bad subscription type. #{subtype}"
              end
            end
          }
        end
      end
      puts "DOC:\n#{req.to_xml}"
    end

    # End a pull notification subscription.
    # @see http://msdn.microsoft.com/en-us/library/aa564263.aspx
    #
    # @param [String] subscription_id The Id of the subscription
    def unsubscribe(subscription_id)
      req = build_soap_envelope do |type, builder|
        if(type == :header)
        else
          builder.Unsubscribe {
            builder.parent.default_namespace = @default_ns
            subscription_id!(builder, subscription_id)
          }
        end
      end
      puts "DOC:\n#{req.to_xml}"
      #parse!(resp)
    end

    # Used by pull subscription clients to request notifications from the Client Access server
    # @see http://msdn.microsoft.com/en-us/library/aa566199.aspx GetEvents on MSDN
    #
    # @param [String] subscription_id Subscription identifier
    # @param [String] watermark Event bookmark in the events queue
    def get_events(subscription_id, watermark)
      req = build_soap_envelope do |type, builder|
        if(type == :header)
        else
          builder.GetEvents {
            builder.parent.default_namespace = @default_ns
            subscription_id!(builder, subscription_id)
            watermark!(builder, watermark)
          }
        end
      end
      puts "DOC:\n#{req.to_xml}"
    end

    # Defines a request to synchronize a folder hierarchy on a client
    # @see http://msdn.microsoft.com/en-us/library/aa580990.aspx
    # @param [Hash] opts
    # @option opts [Hash] :folder_shape The folder shape properties
    #   Ex: {:base_shape => 'Default', :additional_properties => 'bla bla bla'}
    # @option opts [Hash] :sync_folder_id An optional Hash that represents a FolderId or
    #   DistinguishedFolderId.
    #   Ex: {:id => :inbox}
    # @option opts [Hash] :sync_state The Base64 sync state id. If this is the
    #   first time syncing this does not need to be passed.
    def sync_folder_hierarchy(opts)
      req = build_soap_envelope do |type, builder|
        if(type == :header)
        else
          builder.SyncFolderHierarchy {
            builder.parent.default_namespace = @default_ns
            folder_shape!(builder, opts[:folder_shape])
            sync_folder_id!(builder, opts[:sync_folder_id]) if opts[:sync_folder_id]
            sync_state!(builder, opts[:sync_state]) if opts[:sync_state]
          }
        end
      end
      puts "DOC:\n#{req.to_xml}"
    end

    # Synchronizes items between the Exchange server and the client
    # @see http://msdn.microsoft.com/en-us/library/aa563967(v=EXCHG.140).aspx
    # @param [Hash] opts
    # @option opts [Hash] :item_shape The item shape properties
    #   Ex: {:base_shape => 'Default', :additional_properties => 'bla bla bla'}
    # @option opts [Hash] :sync_folder_id A Hash that represents a FolderId or
    #   DistinguishedFolderId. [ Ex: {:id => :inbox} ] OPTIONAL
    # @option opts [Hash] :sync_state The Base64 sync state id. If this is the
    #   first time syncing this does not need to be passed. OPTIONAL on first call
    # @option opts [Array <String>] :ignore An Array of ItemIds for items to ignore
    #   during the sync process. Ex: [{:id => 'id1', :change_key => 'ck'}, {:id => 'id2'}]
    #   OPTIONAL
    # @option opts [Integer] :max_changes_returned ('required') The amount of items to sync per call.
    # @option opts [String] :sync_scope specifies whether just items or items and folder associated
    #   information are returned. OPTIONAL
    #   options: 'NormalItems' or 'NormalAndAssociatedItems'
    def sync_folder_items(opts)
      req = build_soap_envelope do |type, builder|
        if(type == :header)
        else
          builder.SyncFolderItems {
            builder.parent.default_namespace = @default_ns
            item_shape!(builder, opts[:item_shape])
            sync_folder_id!(builder, opts[:sync_folder_id]) if opts[:sync_folder_id]
            sync_state!(builder, opts[:sync_state]) if opts[:sync_state]
            ignore!(builder, opts[:ignore]) if opts[:ignore]
            max_changes_returned!(builder, opts[:max_changes_returned])
            sync_scope!(builder, opts[:sync_scope]) if opts[:sync_scope]
          }
        end
      end
      puts "DOC:\n#{req.to_xml}"
      #parse!(resp)
    end

    # Gets items from the Exchange store
    # @see http://msdn.microsoft.com/en-us/library/aa565934(v=EXCHG.140).aspx
    #
    # @param [Hash] opts
    # @option opts [Hash] :item_shape The item shape properties
    #   Ex: {:base_shape => 'Default'}
    # @option opts [Array<Hash>] :item_ids ItemIds Hash. The keys in these Hashes can be
    #   :item_id, :occurrence_item_id, or :recurring_master_item_id. Please see the
    #   Microsoft docs for more information.
    # @example
    #   opts = {
    #     :item_shape => {:base_shape => 'Default'},
    #     :item_ids   => [
    #       {:item_id => {:id => 'id1'}},
    #       {:occurrence_item_id => {:recurring_master_id => 'rid1', :change_key => 'ck', :instance_index => 1}},
    #       {:recurring_master_item_id => {:occurrence_id => 'oid1', :change_key => 'ck'}}
    #       ]}
    #   get_item(opts)
    def get_item(opts)
      req = build_soap_envelope do |type, builder|
        if(type == :header)
        else
          builder.GetItem {
            builder.parent.default_namespace = @default_ns
            item_shape!(builder, opts[:item_shape])
            item_ids!(builder, opts[:item_ids])
          }
        end
      end
      puts "DOC:\n#{req.to_xml}"
      #parse!(resp)
    end

    # Defines a request to create an item in the Exchange store.
    # @see http://msdn.microsoft.com/en-us/library/aa565209(v=EXCHG.140).aspx
    #
    # @param [Hash] opts
    # @option opts [String] :message_disposition How the item will be handled after it is created.
    #   Only applicable for to e-mail. Must be one of 'SaveOnly', 'SendOnly', or 'SendAndSaveCopy'
    # @option opts [String] :send_meeting_invitations How meeting requests are handled after they
    #   are created. Required for calendar items. Must be one of 'SendToNone', 'SendOnlyToAll',
    #   'SendToAllAndSaveCopy'
    # @option opts [Hash] :saved_item_folder_id A well-formatted folder_id Hash. Ex: {:id => :inbox}
    #   Will on work if 'SendOnly' is specified for :message_disposition
    # @option opts [Array<Hash>] :items This is a complex Hash that conforms to various Item types.
    #   Please see the Microsoft documentation for this element.
    # @example
    #   email_item = {:message => {
    #   :xmlns => 'http://schemas.microsoft.com/exchange/services/2006/types',
    #   :sub_elements => [
    #     {:subject => {:text => 'Test Subject'}},
    #     {:sensitivity => {:text => 'Private'}},
    #     {:body => {:body_type => 'Text', :text => 'This is the body'}},
    #     {:to_recipients => {:sub_elements => [
    #       {:mailbox => {:sub_elements => [
    #         {:name => {:text => 'Test User'}},
    #         {:email_address => {:text => 'test@example.org'}}
    #       ]}}
    #     ]}}
    #   ]}}
    #   create_item(:message_disposition => 'SendAndSaveCopy', :items => [email_item])
    def create_item(opts)
      req = build_soap_envelope do |type, builder|
        attribs = {}
        attribs['MessageDisposition'] = opts[:message_disposition] if opts[:message_disposition]
        attribs['SendMeetingInvitations'] = opts[:send_meeting_invitations] if opts[:send_meeting_invitations]
        if(type == :header)
        else
          builder.CreateItem(attribs) {
            builder.parent.default_namespace = @default_ns
            saved_item_folder_id!(builder, opts[:saved_item_folder_id]) if opts[:saved_item_folder_id]
            builder.Items {
              build_xml!(builder, opts[:items])
            }
          }
        end
      end
      puts "DOC:\n#{req.to_xml}"
      #parse!(resp)
    end

    # Delete an item from a mailbox in the Exchange store
    # @see http://msdn.microsoft.com/en-us/library/aa580484(v=exchg.140).aspx
    #
    # @param [Hash] opts
    # @option opts [String] :delete_type Describes how an item is deleted. Must be one of
    #   'HardDelete', 'SoftDelete', or 'MoveToDeletedItems'
    # @option opts [String] :send_meeting_cancellations How meetings are handled after they
    #   are deleted. Required for calendar items. Must be one of 'SendToNone', 'SendOnlyToAll',
    #   'SendToAllAndSaveCopy'
    # @option opts [String] :affected_task_occurrences Describes whether a task instance or a
    #   task master is deleted by a DeleteItem Operation. This attribute is required when
    #   tasks are deleted. Must be one of 'AllOccurrences' or 'SpecifiedOccurrenceOnly'
    # @option opts [Array<Hash>] :item_ids ItemIds Hash. The keys in these Hashes can be
    #   :item_id, :occurrence_item_id, or :recurring_master_item_id. Please see the
    #   Microsoft docs for more information.
    # @example
    #   opts = {
    #     :delete_type => 'MoveToDeletedItems',
    #     :item_ids => [{:item_id => {:id => 'id1'}}]
    #     }
    #   inst.delete_item(opts)
    def delete_item(opts)
      req = build_soap_envelope do |type, builder|
        attribs = {}
        attribs['DeleteType'] = opts[:delete_type] if opts[:delete_type]
        attribs['SendMeetingCancellations'] = opts[:send_meeting_cancellations] if opts[:send_meeting_cancellations]
        attribs['AffectedTaskOccurrences'] = opts[:affected_task_occurrences] if opts[:affected_task_occurrences]
        if(type == :header)
        else
          builder.DeleteItem(attribs) {
            builder.parent.default_namespace = @default_ns
            item_ids!(builder, opts[:item_ids])
          }
        end
      end
      puts "DOC:\n#{req.to_xml}"
    end

    # Used to modify the properties of an existing item in the Exchange store
    # @see http://msdn.microsoft.com/en-us/library/aa581084(v=exchg.140).aspx
    #
    # @param [Hash] opts
    # @option opts [String] :conflict_resolution Identifies the type of conflict resolution to
    #   try during an update. The default value is AutoResolve. Available options are
    #   'NeverOverwrite', 'AutoResolve', 'AlwaysOverwrite'
    # @option opts [String] :message_disposition How the item will be handled after it is updated.
    #   Only applicable for to e-mail. Must be one of 'SaveOnly', 'SendOnly', or 'SendAndSaveCopy'
    # @option opts [String] :send_meeting_invitations_or_cancellations How meeting requests are
    #   handled after they are updated. Required for calendar items. Must be one of 'SendToNone',
    #   'SendOnlyToAll', 'SendOnlyToChanged', 'SendToAllAndSaveCopy', 'SendToChangedAndSaveCopy'
    # @option opts [Hash] :saved_item_folder_id A well-formatted folder_id Hash. Ex: {:id => :sentitems}
    #   Will on work if 'SendOnly' is specified for :message_disposition
    # @option opts [Array<Hash>] :item_changes an array of ItemChange elements that identify items
    #   and the updates to apply to the items. See the Microsoft docs for more information.
    # @example
    #   opts = {
    #     :send_meeting_invitations_or_cancellations => 'SendOnlyToChangedAndSaveCopy',
    #     :item_changes => [
    #       { :item_id => {:id => 'id1'},
    #         :updates => [
    #           {:set_item_field => {
    #             :field_uRI => {:field_uRI => 'item:Subject'},
    #             # The following needs to conform to #build_xml! format for now
    #             :calendar_item => { :sub_elements => [{:subject => {:text => 'Test Subject'}}]}
    #           }}
    #         ]
    #       }
    #     ]
    #   }
    def update_item(opts)
      req = build_soap_envelope do |type, builder|
        attribs = {}
        attribs['MessageDisposition'] = opts[:message_disposition] if opts[:message_disposition]
        attribs['ConflictResolution'] = opts[:conflict_resolution] if opts[:conflict_resolution]
        attribs['SendMeetingInvitationsOrCancellations'] = opts[:send_meeting_invitations_or_cancellations] if opts[:send_meeting_invitations_or_cancellations]
        if(type == :header)
        else
          builder.UpdateItem(attribs) {
            builder.parent.default_namespace = @default_ns
            saved_item_folder_id!(builder, opts[:saved_item_folder_id]) if opts[:saved_item_folder_id]
            item_changes!(builder, opts[:item_changes])
          }
        end
      end
      puts "DOC:\n#{req.to_xml}"
    end

    # Used to send e-mail messages that are located in the Exchange store.
    # @see http://msdn.microsoft.com/en-us/library/aa580238(v=exchg.140).aspx
    #
    # @param [Hash] opts
    # @option opts [Boolean] :save_item_to_folder To save or not to save... save! :-)
    # @option opts [Hash] :saved_item_folder_id A well-formatted folder_id Hash. Ex: {:id => :sentitems}
    # @option opts [Array<Hash>] :item_ids ItemIds Hash. The keys in these Hashes can be
    #   :item_id, :occurrence_item_id, or :recurring_master_item_id. Please see the
    #   Microsoft docs for more information.
    # @example
    #   opts = {
    #     :save_item_to_folder => true,
    #     :saved_item_folder_id => {:id => :sentitems},
    #     :item_ids => [
    #       {:item_id => {:id => 'id1'}},
    #       {:item_id => {:id => 'id2'}},
    #     ]}
    #   obj.send_item(opts)
    def send_item(opts)
      req = build_soap_envelope do |type, builder|
        attribs = {}
        attribs['SaveItemToFolder'] = opts[:save_item_to_folder]
        if(type == :header)
        else
          builder.SendItem(attribs) {
            builder.parent.default_namespace = @default_ns
            saved_item_folder_id!(builder, opts[:saved_item_folder_id]) if opts[:saved_item_folder_id]
            item_ids!(builder, opts[:item_ids])
          }
        end
      end
      puts "DOC:\n#{req.to_xml}"
    end

    # Used to move one or more items to a single destination folder.
    # @see http://msdn.microsoft.com/en-us/library/aa565781(v=exchg.140).aspx
    #
    # @param [Hash] opts
    # @option opts [Hash] :to_folder_id A well-formatted folder_id Hash. Ex: {:id => :inbox}
    # @option opts [Array<Hash>] :item_ids ItemIds Hash. The keys in these Hashes can be
    #   :item_id, :occurrence_item_id, or :recurring_master_item_id. Please see the
    #   Microsoft docs for more information.
    # @option opts [Boolean] :return_new_item_ids Indicates whether the item identifiers of
    #   new items are returned in the response
    # @example
    #   opts = {
    #     :to_folder_id => {:id => :inbox},
    #     :item_ids => [
    #       {:item_id => {:id => 'id1'}},
    #       {:item_id => {:id => 'id2'}},
    #     ],
    #     :return_new_item_ids => true
    #     }
    #   obj.move_item(opts)
    def move_item(opts)
     req = build_soap_envelope do |type, builder|
        if(type == :header)
        else
          builder.MoveItem {
            builder.parent.default_namespace = @default_ns
            to_folder_id!(builder, opts[:to_folder_id])
            item_ids!(builder, opts[:item_ids])
            return_new_item_ids!(builder, opts[:return_new_item_ids]) if opts[:return_new_item_ids]
          }
        end
      end
      puts "DOC:\n#{req.to_xml}"
    end

    # Copies items and puts the items in a different folder
    # @see http://msdn.microsoft.com/en-us/library/aa565012(v=exchg.140).aspx
    #
    # @param [Hash] opts
    # @option opts [Hash] :to_folder_id A well-formatted folder_id Hash. Ex: {:id => :inbox}
    # @option opts [Array<Hash>] :item_ids ItemIds Hash. The keys in these Hashes can be
    #   :item_id, :occurrence_item_id, or :recurring_master_item_id. Please see the
    #   Microsoft docs for more information.
    # @option opts [Boolean] :return_new_item_ids Indicates whether the item identifiers of
    #   new items are returned in the response
    # @example
    #   opts = {
    #     :to_folder_id => {:id => :inbox},
    #     :item_ids => [
    #       {:item_id => {:id => 'id1'}},
    #       {:item_id => {:id => 'id2'}},
    #     ],
    #     :return_new_item_ids => true
    #     }
    #   obj.copy_item(opts)
    def copy_item(opts)
      req = build_soap_envelope do |type, builder|
        if(type == :header)
        else
          builder.CopyItem {
            builder.parent.default_namespace = @default_ns
            to_folder_id!(builder, opts[:to_folder_id])
            item_ids!(builder, opts[:item_ids])
            return_new_item_ids!(builder, opts[:return_new_item_ids]) if opts[:return_new_item_ids]
          }
        end
      end
      puts "DOC:\n#{req.to_xml}"
    end

    # Creates either an item or file attachment and attaches it to the specified item.
    # @see http://msdn.microsoft.com/en-us/library/aa565877.aspx
    # @param [String,Hash] parent_id The id of the Item.  If this is a Hash
    #   it should contain the Id and the ChangeKey.
    # @option parent_id [String] :id The item Id
    # @option parent_id [String] :change_key The ChangeKey
    # @param [Array<Hash>] files An Array of Base64 encoded Strings with an associated name
    #   hash format= :name => <name>, :content => <Base64 encoded string>
    # @param [Array] items Exchange Items to attach to this Item
    # @todo Need to implement attachment of Item types
    def create_attachment(parent_id, files = [], items = [])
      action = "#{SOAP_ACTION_PREFIX}/CreateAttachment"
      resp = invoke("#{NS_EWS_MESSAGES}:CreateAttachment", action) do |root|
        build!(root) do
          item_id!(root, parent_id, "#{NS_EWS_MESSAGES}:ParentItemId")
          attachments!(root, files, items)
        end
      end
      parse!(resp)
    end

    def delete_attachment
      action = "#{SOAP_ACTION_PREFIX}/DeleteAttachment"
      resp = invoke("#{NS_EWS_MESSAGES}:DeleteAttachment", action) do |delete_attachment|
        build_delete_attachment!(delete_attachment)
      end
      parse_delete_attachment(resp)
    end

    # Used to retrieve existing attachments on items in the Exchange store
    # @see http://msdn.microsoft.com/en-us/library/aa494316.aspx
    # @param [Array] attachment_ids Attachment Ids to fetch
    def get_attachment(attachment_ids)
      action = "#{SOAP_ACTION_PREFIX}/GetAttachment"
      resp = invoke("#{NS_EWS_MESSAGES}:GetAttachment", action) do |root|
        build!(root) do
          attachment_shape!(root)
          attachment_ids!(root, attachment_ids)
        end
      end
      parse!(resp)
    end

    def create_managed_folder
      action = "#{SOAP_ACTION_PREFIX}/CreateManagedFolder"
      resp = invoke("#{NS_EWS_MESSAGES}:CreateManagedFolder", action) do |create_managed_folder|
        build_create_managed_folder!(create_managed_folder)
      end
      parse_create_managed_folder(resp)
    end

    # Retrieves the delegate settings for a specific mailbox.
    # @see http://msdn.microsoft.com/en-us/library/bb799735.aspx
    #
    # @param [String] owner The user that is delegating permissions
    def get_delegate(owner)
      action = "#{SOAP_ACTION_PREFIX}/GetDelegate"
      resp = invoke("#{NS_EWS_MESSAGES}:GetDelegate", action) do |root|
        root.set_attr('IncludePermissions', 'true')
        build!(root) do
          mailbox!(root, {:email_address => {:text => owner}})
        end
      end
      parse!(resp)
    end

    # Adds one or more delegates to a principal's mailbox and sets specific access permissions.
    # @see http://msdn.microsoft.com/en-us/library/bb856527.aspx
    #
    # @param [String] owner The user that is delegating permissions
    # @param [String] delegate The user that is being given delegate permission
    # @param [Hash] permissions A hash of permissions that will be delegated.
    #   This Hash will eventually be passed to add_hierarchy! in the builder so it is in that format.
    def add_delegate(owner, delegate, permissions)
      action = "#{SOAP_ACTION_PREFIX}/AddDelegate"
      resp = invoke("#{NS_EWS_MESSAGES}:AddDelegate", action) do |root|
        build!(root) do
          add_delegate!(owner, delegate, permissions)
        end
      end
      parse!(resp)
    end

    # Removes one or more delegates from a user's mailbox.
    # @see http://msdn.microsoft.com/en-us/library/bb856564.aspx
    #
    # @param [String] owner The user that is delegating permissions
    # @param [String] delegate The user that is being given delegate permission
    def remove_delegate(owner, delegate)
      action = "#{SOAP_ACTION_PREFIX}/RemoveDelegate"
      resp = invoke("#{NS_EWS_MESSAGES}:RemoveDelegate", action) do |root|
        build!(root) do
          remove_delegate!(owner, delegate)
        end
      end
      parse!(resp)
    end

    # Updates delegate permissions on a principal's mailbox
    # @see http://msdn.microsoft.com/en-us/library/bb856529.aspx
    #
    # @param [String] owner The user that is delegating permissions
    # @param [String] delegate The user that is being given delegate permission
    # @param [Hash] permissions A hash of permissions that will be delegated.
    #   This Hash will eventually be passed to add_hierarchy! in the builder so it is in that format.
    def update_delegate(owner, delegate, permissions)
      action = "#{SOAP_ACTION_PREFIX}/UpdateDelegate"
      resp = invoke("#{NS_EWS_MESSAGES}:UpdateDelegate", action) do |root|
        build!(root) do
          add_delegate!(owner, delegate, permissions)
        end
      end
      parse!(resp)
    end

    # Provides detailed information about the availability of a set of users, rooms, and resources
    # within a specified time window.
    # @see http://msdn.microsoft.com/en-us/library/aa564001.aspx
    def get_user_availability(email_address, start_time, end_time)
      action = "#{SOAP_ACTION_PREFIX}/GetUserAvailability"
      resp = invoke("#{NS_EWS_MESSAGES}:GetUserAvailabilityRequest", action) do |root|
        build!(root) do
          get_user_availability!(email_address, start_time, end_time)
        end
      end
      parse!(resp)
    end

    # Gets a mailbox user's Out of Office (OOF) settings and messages.
    # @see http://msdn.microsoft.com/en-us/library/aa563465.aspx
    def get_user_oof_settings(mailbox)
      action = "#{SOAP_ACTION_PREFIX}/GetUserOofSettings"
      resp = invoke("#{NS_EWS_MESSAGES}:GetUserOofSettingsRequest", action) do |root|
        build!(root) do
          mailbox!(root,mailbox[:mailbox],NS_EWS_TYPES)
        end
      end
      parse!(resp)
    end

    # Sets a mailbox user's Out of Office (OOF) settings and message.
    # @see http://msdn.microsoft.com/en-us/library/aa580294.aspx
    def set_user_oof_settings(mailbox, oof_state, ext_audience, dt_start, dt_end, int_msg, ext_mg)
      action = "#{SOAP_ACTION_PREFIX}/SetUserOofSettings"
      resp = invoke("#{NS_EWS_MESSAGES}:SetUserOofSettings", action) do |root|
        build!(root)
      end
      parse!(resp)
    end


    # Private Methods (Builders and Parsers)
    private

    def parse!(response, opts = {})
      #return response if @@raw_soap
      raise EwsError, "Can't parse an empty response. Please check your endpoint." if(response.nil?)
      EwsParser.new(response).parse(opts)
    end

    # Build the common elements in the SOAP message and yield to any custom elements.
    def build_soap_envelope
      new_ent = Nokogiri::XML::Builder.new do |xml|
        xml.Envelope(NAMESPACES) do |ent|
          xml.parent.namespace = xml.parent.namespace_definitions.find{|ns|ns.prefix==NS_SOAP}
          ent[NS_SOAP].Header {
            yield(:header, ent) if block_given?
          }
          ent[NS_SOAP].Body {
            yield(:body, ent) if block_given?
          }
        end
      end
    end

    # Send the SOAP request to the endpoint
    # @param [String] soapmsg an XML formatted string
    # @todo make this work for Viewpoint (imported from SPWS)
    def send_soap_request(soapmsg)
      @log.debug "Sending SOAP Request:\n----------------\n#{soapmsg}\n----------------"
      respmsg = @con.post(soapmsg)
      @log.debug "Received SOAP Response:\n----------------\n#{Nokogiri::XML(respmsg).to_xml}\n----------------"
      respmsg
    end

  end # class ExchangeWebService
end # Viewpoint
