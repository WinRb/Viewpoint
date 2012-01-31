# This class is the glue between the Models and the Web Service.
class Viewpoint::EWSClient
  include Viewpoint::EWS

  # The instance of Viewpoint::EWS::SOAP::ExchangeWebService 
  attr_reader :ews

  # Initialize the EWSClient instance.
  # @param [String] endpoint The EWS endpoint we will be connecting to
  # @param [String] user The user to authenticate as. If you are using
  #   NTLM or Negotiate authentication you do not need to pass this parameter.
  # @param [String] pass The user password. If you are using NTLM or
  #   Negotiate authentication you do not need to pass this parameter.
  def initialize(endpoint, user = nil, pass = nil)
    con = Connection.new(endpoint)
    con.set_auth(user,pass) if(user && pass)
    @ews = SOAP::ExchangeWebService.new(con)
  end

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
        folders << (eval "#{f_type}.new(f[f.keys.first])")
      end
      return folders
    else
      raise EwsError, "Could not retrieve folders. #{resp.code}: #{resp.message}"
    end
  end

end
