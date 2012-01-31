require 'ews/folder_accessors'

# This class is the glue between the Models and the Web Service.
class Viewpoint::EWSClient
  include Viewpoint::EWS
  include Viewpoint::EWS::FolderAccessors

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
end
