module Viewpoint::EWS::FolderAccessors
  include Viewpoint::EWS

  # Return a list of folder names
  # @param [String,Symbol] root A DistinguishedFolderId(symbol) or
  #   FolderId(string). This is where we'll start the search from. Usually
  #   :root, :msgfolderroot, or :publicfoldersroot
  # @return [Array<String>] Return an Array of folder names.
  # @raise [EwsError] raised when the backend SOAP method returns an error.
  def folder_names(root = :msgfolderroot)
    resp = ews.find_folder( {
      :parent_folder_ids  => [{:id => root}],
      :traversal          => 'Deep',
      :folder_shape       => {
        :base_shape => 'IdOnly',
        :additional_properties => {:FieldURI => ['folder:DisplayName']}
      }
    })
    if(resp.status == 'Success')
      flds = []
      resp.items.each do |f|
        flds << f[f.keys.first][:display_name][:text]
      end
      flds
    else
      raise EwsError, "Could not retrieve folders. #{resp.code}: #{resp.message}"
    end
  end

  # Find subfolders of the passed root folder.  If no parameters are passed this
  # method will search from the Root folder.
  # @param [Hash] opts Misc options to control request
  # @option opts [String,Symbol] :root Either a FolderId(String) or a
  #   DistinguishedFolderId(Symbol) . This is where to start the search from.
  #   Usually :root,:msgfolderroot, or :publicfoldersroot
  # @option opts [String] :traversal Shallow/Deep/SoftDeleted
  # @option opts [String] :shape shape to return IdOnly/Default/AllProperties
  # @option opts [optional, String] :folder_type an optional folder type to
  #   limit the search to like 'IPF.Task'
  # @return [Array] Returns an Array of Folder or subclasses of Folder
  # @raise [EwsError] raised when the backend SOAP method returns an error.
  def find_folders(opts={})
    opts[:root] = :msgfolderroot unless opts[:root]
    opts[:traversal] = 'Shallow' unless opts[:traversal]
    opts[:shape] = 'Default' unless opts[:shape]
    if( opts[:folder_type] )
      restr = { :is_equal_to => 
        [
          {:field_uRI => {:field_uRI=>'folder:FolderClass'}},
          {:field_uRI_or_constant=>{:constant => {:value => folder_type}}},
        ]
      }
    end
    args = {
      :parent_folder_ids => [{:id => opts[:root]}],
      :traversal => opts[:traversal],
      :folder_shape => {:base_shape => opts[:shape]}
    }
    args[:restriction] = restr if restr
    resp = ews.find_folder( args )
    if(resp.status == 'Success')
      folders = []
      resp.items.each do |f|
        folders << class_by_name(f.keys.first).new(ews, f[f.keys.first])
      end
      folders
    else
      raise EwsError, "Could not retrieve folders. #{resp.code}: #{resp.message}"
    end
  end

  # Get a specific folder by its ID.
  # @param [String,Symbol] folder_id Either a FolderId(String) or a
  #   DistinguishedFolderId(Symbol).
  # @param [String,nil] act_as User to act on behalf as. This user must have
  #   been given delegate access to the folder or this operation will fail.
  # @param [Hash] opts Misc options to control request
  # @option opts [String] :base_shape IdOnly/Default/AllProperties
  # @raise [EwsError] raised when the backend SOAP method returns an error.
  def get_folder(folder_id, act_as = nil, opts = {})
    opts[:base_shape] = 'Default' unless opts[:base_shape]
    args =  {
      :folder_ids   => [{:id => folder_id}],
      :folder_shape => {:base_shape => opts[:base_shape]} }
    args[:act_as] = act_as if act_as
    resp = ews.get_folder(args)
    if(resp.status == 'Success')
      folder = resp.items.first
      class_by_name(folder.keys.first).new(ews, folder[folder.keys.first])
    else
      raise EwsError, "Could not retrieve folder. #{resp.code}: #{resp.message}"
    end
  end
end
