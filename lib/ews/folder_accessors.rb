module Viewpoint::EWS::FolderAccessors
  include Viewpoint::EWS

  # Find subfolders of the passed root folder.  If no parameters are passed
  # this method will search from the Root folder.
  # @param [String,Symbol] root An folder id, either a DistinguishedFolderId (must me a Symbol)
  #   or a FolderId (String). This is where to start the search from. Usually :root,:msgfolderroot,:publicfoldersroot
  # @param [String] traversal Shallow/Deep/SoftDeleted
  # @param [String] shape the shape to return IdOnly/Default/AllProperties
  # @param [optional, String] folder_type an optional folder type to limit the search to like 'IPF.Task'
  # @return [Array] Returns an Array of Folder or subclasses of Folder
  # @raise [EwsError] raised when the backend SOAP method returns an error.
  def find_folders(root = :msgfolderroot, traversal = 'Shallow', shape = 'Default', folder_type = nil)
    if( folder_type )
      restr = { :is_equal_to => 
        [
          {:field_uRI => {:field_uRI=>'folder:FolderClass'}},
          {:field_uRI_or_constant=>{:constant => {:value => folder_type}}},
        ]
      }
    end

    args = {
      :parent_folder_ids => [{:id => root}],
      :traversal => traversal,
      :folder_shape => {:base_shape => shape}
    }
    args[:restriction] = restr if restr

    resp = @ews.find_folder( args )

    if(resp.status == 'Success')
      folders = []
      resp.items.each do |f|
        f_type = f.keys.first.to_s.camel_case
        folders << (eval "#{f_type}.new(@ews, f[f.keys.first])")
      end
      return folders
    else
      raise EwsError, "Could not retrieve folders. #{resp.code}: #{resp.message}"
    end
  end

  # Get a specific folder by its ID.
  # @param [String,Symbol] folder_id either a DistinguishedFolderID or simply a FolderID
  # @param [String,nil] act_as User to act on behalf as.  This user must have been given
  #   delegate access to this folder or else this operation will fail.
  # @param [Hash] folder_shape
  # @option folder_shape [String] :base_shape IdOnly/Default/AllProperties
  # @raise [EwsError] raised when the backend SOAP method returns an error.
  def get_folder(folder_id, act_as = nil, folder_shape = {:base_shape => 'Default'})
    args =  {
      :folder_ids   => [{:id => folder_id}],
      :folder_shape => folder_shape }
    args[:act_as] = act_as if act_as
    resp = @ews.get_folder(args)
    if(resp.status == 'Success')
      folder = resp.items.first
      f_type = folder.keys.first.to_s.camel_case
      return(eval "#{f_type}.new(@ews, folder[folder.keys.first])")
    else
      raise EwsError, "Could not retrieve folder. #{resp.code}: #{resp.message}"
    end
  end

end
