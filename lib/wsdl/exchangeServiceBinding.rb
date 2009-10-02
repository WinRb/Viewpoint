require 'rubygems'
gem 'soap4r'
require 'wsdl/exchangeServiceTypes'
require 'wsdl/defaultMappingRegistry'
require 'soap/rpc/driver'

class ExchangeServiceBinding < ::SOAP::RPC::Driver
  DefaultEndpointUrl = nil

  Methods = [
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/ResolveNames",
      "resolveNames",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "ResolveNames"]],
        ["out", "ResolveNamesResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "ResolveNamesResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/ExpandDL",
      "expandDL",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "ExpandDL"]],
        ["out", "ExpandDLResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "ExpandDLResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/FindFolder",
      "findFolder",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "FindFolder"]],
        ["out", "FindFolderResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "FindFolderResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/FindItem",
      "findItem",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "FindItem"]],
        ["out", "FindItemResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "FindItemResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/GetFolder",
      "getFolder",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "GetFolder"]],
        ["out", "GetFolderResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "GetFolderResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/ConvertId",
      "convertId",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "ConvertId"]],
        ["out", "ConvertIdResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "ConvertIdResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/CreateFolder",
      "createFolder",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "CreateFolder"]],
        ["out", "CreateFolderResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "CreateFolderResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/DeleteFolder",
      "deleteFolder",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "DeleteFolder"]],
        ["out", "DeleteFolderResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "DeleteFolderResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/UpdateFolder",
      "updateFolder",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "UpdateFolder"]],
        ["out", "UpdateFolderResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "UpdateFolderResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/MoveFolder",
      "moveFolder",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "MoveFolder"]],
        ["out", "MoveFolderResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "MoveFolderResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/CopyFolder",
      "copyFolder",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "CopyFolder"]],
        ["out", "CopyFolderResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "CopyFolderResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/Subscribe",
      "subscribe",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "Subscribe"]],
        ["out", "SubscribeResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "SubscribeResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/Unsubscribe",
      "unsubscribe",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "Unsubscribe"]],
        ["out", "UnsubscribeResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "UnsubscribeResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/GetEvents",
      "getEvents",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "GetEvents"]],
        ["out", "GetEventsResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "GetEventsResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/SyncFolderHierarchy",
      "syncFolderHierarchy",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "SyncFolderHierarchy"]],
        ["out", "SyncFolderHierarchyResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "SyncFolderHierarchyResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/SyncFolderItems",
      "syncFolderItems",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "SyncFolderItems"]],
        ["out", "SyncFolderItemsResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "SyncFolderItemsResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/GetItem",
      "getItem",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "GetItem"]],
        ["out", "GetItemResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "GetItemResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/CreateItem",
      "createItem",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "CreateItem"]],
        ["out", "CreateItemResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "CreateItemResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/DeleteItem",
      "deleteItem",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "DeleteItem"]],
        ["out", "DeleteItemResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "DeleteItemResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/UpdateItem",
      "updateItem",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "UpdateItem"]],
        ["out", "UpdateItemResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "UpdateItemResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/SendItem",
      "sendItem",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "SendItem"]],
        ["out", "SendItemResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "SendItemResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/MoveItem",
      "moveItem",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "MoveItem"]],
        ["out", "MoveItemResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "MoveItemResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/CopyItem",
      "copyItem",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "CopyItem"]],
        ["out", "CopyItemResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "CopyItemResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/CreateAttachment",
      "createAttachment",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "CreateAttachment"]],
        ["out", "CreateAttachmentResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "CreateAttachmentResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/DeleteAttachment",
      "deleteAttachment",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "DeleteAttachment"]],
        ["out", "DeleteAttachmentResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "DeleteAttachmentResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/GetAttachment",
      "getAttachment",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "GetAttachment"]],
        ["out", "GetAttachmentResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "GetAttachmentResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/CreateManagedFolder",
      "createManagedFolder",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "CreateManagedFolder"]],
        ["out", "CreateManagedFolderResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "CreateManagedFolderResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/GetDelegate",
      "getDelegate",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "GetDelegate"]],
        ["out", "GetDelegateResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "GetDelegateResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/AddDelegate",
      "addDelegate",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "AddDelegate"]],
        ["out", "AddDelegateResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "AddDelegateResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/RemoveDelegate",
      "removeDelegate",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "RemoveDelegate"]],
        ["out", "RemoveDelegateResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "RemoveDelegateResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/UpdateDelegate",
      "updateDelegate",
      [ ["in", "request", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "UpdateDelegate"]],
        ["out", "UpdateDelegateResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "UpdateDelegateResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/GetUserAvailability",
      "getUserAvailability",
      [ ["in", "GetUserAvailabilityRequest", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "GetUserAvailabilityRequest"]],
        ["in", "SerializedSecurityContext", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "SerializedSecurityContext"]],
        ["in", "ProxyRequestTypeHeader", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ProxyRequestTypeHeader"]],
        ["out", "GetUserAvailabilityResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "GetUserAvailabilityResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/GetUserOofSettings",
      "getUserOofSettings",
      [ ["in", "GetUserOofSettingsRequest", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "GetUserOofSettingsRequest"]],
        ["out", "GetUserOofSettingsResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "GetUserOofSettingsResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://schemas.microsoft.com/exchange/services/2006/messages/SetUserOofSettings",
      "setUserOofSettings",
      [ ["in", "SetUserOofSettingsRequest", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "SetUserOofSettingsRequest"]],
        ["out", "SetUserOofSettingsResult", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/messages", "SetUserOofSettingsResponse"]],
        ["out", "ServerVersion", ["::SOAP::SOAPElement", "http://schemas.microsoft.com/exchange/services/2006/types", "ServerVersionInfo"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ]
  ]

  def initialize(endpoint_url = nil)
    endpoint_url ||= DefaultEndpointUrl
    super(endpoint_url, nil)
    self.mapping_registry = DefaultMappingRegistry::EncodedRegistry
    self.literal_mapping_registry = DefaultMappingRegistry::LiteralRegistry
    init_methods
  end

private

  def init_methods
    Methods.each do |definitions|
      opt = definitions.last
      if opt[:request_style] == :document
        add_document_operation(*definitions)
      else
        add_rpc_operation(*definitions)
        qname = definitions[0]
        name = definitions[2]
        if qname.name != name and qname.name.capitalize == name.capitalize
          ::SOAP::Mapping.define_singleton_method(self, qname.name) do |*arg|
            __send__(name, *arg)
          end
        end
      end
    end
  end
end

