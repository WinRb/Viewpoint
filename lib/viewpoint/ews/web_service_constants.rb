module Viewpoint::EWS::WebServiceConstants
  NS_SOAP         = 'soap'.freeze
  NS_EWS_TYPES    = 't'.freeze
  NS_EWS_MESSAGES = 'm'.freeze
  NAMESPACES = {
    "xmlns:#{NS_SOAP}"         => 'http://schemas.xmlsoap.org/soap/envelope/',
    "xmlns:#{NS_EWS_TYPES}"    => 'http://schemas.microsoft.com/exchange/services/2006/types',
    "xmlns:#{NS_EWS_MESSAGES}" => 'http://schemas.microsoft.com/exchange/services/2006/messages',
  }.freeze

  # used in ResolveNames to determine where names are resolved
  ActiveDirectory         = 'ActiveDirectory'
  ActiveDirectoryContacts = 'ActiveDirectoryContacts'
  Contacts                = 'Contacts'
  ContactsActiveDirectory = 'ContactsActiveDirectory'

  # Target specific Exchange Server versions
  # @see http://msdn.microsoft.com/en-us/library/bb891876(v=exchg.140).aspx
  VERSION_2007      = 'Exchange2007'
  VERSION_2007_SP1  = 'Exchange2007_SP1'
  VERSION_2010      = 'Exchange2010'
  VERSION_2010_SP1  = 'Exchange2010_SP1'
  VERSION_2010_SP2  = 'Exchange2010_SP2'
  VERSION_2013      = 'Exchange2013'
  VERSION_2013_SP1  = 'Exchange2013_SP1'
  VERSION_NONE      = 'none'

  HARD_DELETE = 'HardDelete'
  SOFT_DELETE = 'SoftDelete'
  MOVE_TO_DELETED_ITEMS = 'MoveToDeletedItems'
end
