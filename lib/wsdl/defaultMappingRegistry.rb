require 'rubygems'
gem 'soap4r'
require 'wsdl/exchangeServiceTypes'
require 'soap/mapping'

module DefaultMappingRegistry
  EncodedRegistry = ::SOAP::Mapping::EncodedRegistry.new
  LiteralRegistry = ::SOAP::Mapping::LiteralRegistry.new
  NsMessages = "http://schemas.microsoft.com/exchange/services/2006/messages"
  NsNamespace = "http://www.w3.org/XML/1998/namespace"
  NsTypes = "http://schemas.microsoft.com/exchange/services/2006/types"
  NsXMLSchema = "http://www.w3.org/2001/XMLSchema"

  EncodedRegistry.register(
    :class => ResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["ResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => ResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  EncodedRegistry.register(
    :class => ArrayOfResponseMessagesType,
    :schema_type => XSD::QName.new(NsMessages, "ArrayOfResponseMessagesType"),
    :schema_element => [ :choice,
      ["createItemResponseMessage", ["ItemInfoResponseMessageType[]", XSD::QName.new(NsMessages, "CreateItemResponseMessage")]],
      ["deleteItemResponseMessage", ["ResponseMessageType[]", XSD::QName.new(NsMessages, "DeleteItemResponseMessage")]],
      ["getItemResponseMessage", ["ItemInfoResponseMessageType[]", XSD::QName.new(NsMessages, "GetItemResponseMessage")]],
      ["updateItemResponseMessage", ["UpdateItemResponseMessageType[]", XSD::QName.new(NsMessages, "UpdateItemResponseMessage")]],
      ["sendItemResponseMessage", ["ResponseMessageType[]", XSD::QName.new(NsMessages, "SendItemResponseMessage")]],
      ["deleteFolderResponseMessage", ["ResponseMessageType[]", XSD::QName.new(NsMessages, "DeleteFolderResponseMessage")]],
      ["createFolderResponseMessage", ["FolderInfoResponseMessageType[]", XSD::QName.new(NsMessages, "CreateFolderResponseMessage")]],
      ["getFolderResponseMessage", ["FolderInfoResponseMessageType[]", XSD::QName.new(NsMessages, "GetFolderResponseMessage")]],
      ["findFolderResponseMessage", ["FindFolderResponseMessageType[]", XSD::QName.new(NsMessages, "FindFolderResponseMessage")]],
      ["updateFolderResponseMessage", ["FolderInfoResponseMessageType[]", XSD::QName.new(NsMessages, "UpdateFolderResponseMessage")]],
      ["moveFolderResponseMessage", ["FolderInfoResponseMessageType[]", XSD::QName.new(NsMessages, "MoveFolderResponseMessage")]],
      ["copyFolderResponseMessage", ["FolderInfoResponseMessageType[]", XSD::QName.new(NsMessages, "CopyFolderResponseMessage")]],
      ["createAttachmentResponseMessage", ["AttachmentInfoResponseMessageType[]", XSD::QName.new(NsMessages, "CreateAttachmentResponseMessage")]],
      ["deleteAttachmentResponseMessage", ["DeleteAttachmentResponseMessageType[]", XSD::QName.new(NsMessages, "DeleteAttachmentResponseMessage")]],
      ["getAttachmentResponseMessage", ["AttachmentInfoResponseMessageType[]", XSD::QName.new(NsMessages, "GetAttachmentResponseMessage")]],
      ["findItemResponseMessage", ["FindItemResponseMessageType[]", XSD::QName.new(NsMessages, "FindItemResponseMessage")]],
      ["moveItemResponseMessage", ["ItemInfoResponseMessageType[]", XSD::QName.new(NsMessages, "MoveItemResponseMessage")]],
      ["copyItemResponseMessage", ["ItemInfoResponseMessageType[]", XSD::QName.new(NsMessages, "CopyItemResponseMessage")]],
      ["resolveNamesResponseMessage", ["ResolveNamesResponseMessageType[]", XSD::QName.new(NsMessages, "ResolveNamesResponseMessage")]],
      ["expandDLResponseMessage", ["ExpandDLResponseMessageType[]", XSD::QName.new(NsMessages, "ExpandDLResponseMessage")]],
      ["getEventsResponseMessage", ["GetEventsResponseMessageType[]", XSD::QName.new(NsMessages, "GetEventsResponseMessage")]],
      ["subscribeResponseMessage", ["SubscribeResponseMessageType[]", XSD::QName.new(NsMessages, "SubscribeResponseMessage")]],
      ["unsubscribeResponseMessage", ["ResponseMessageType[]", XSD::QName.new(NsMessages, "UnsubscribeResponseMessage")]],
      ["sendNotificationResponseMessage", ["SendNotificationResponseMessageType[]", XSD::QName.new(NsMessages, "SendNotificationResponseMessage")]],
      ["syncFolderHierarchyResponseMessage", ["SyncFolderHierarchyResponseMessageType[]", XSD::QName.new(NsMessages, "SyncFolderHierarchyResponseMessage")]],
      ["syncFolderItemsResponseMessage", ["SyncFolderItemsResponseMessageType[]", XSD::QName.new(NsMessages, "SyncFolderItemsResponseMessage")]],
      ["createManagedFolderResponseMessage", ["FolderInfoResponseMessageType[]", XSD::QName.new(NsMessages, "CreateManagedFolderResponseMessage")]],
      ["convertIdResponseMessage", ["ConvertIdResponseMessageType[]", XSD::QName.new(NsMessages, "ConvertIdResponseMessage")]]
    ]
  )

  EncodedRegistry.register(
    :class => BaseResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  EncodedRegistry.register(
    :class => GetFolderType,
    :schema_type => XSD::QName.new(NsMessages, "GetFolderType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["folderShape", ["FolderResponseShapeType", XSD::QName.new(NsMessages, "FolderShape")]],
      ["folderIds", ["NonEmptyArrayOfBaseFolderIdsType", XSD::QName.new(NsMessages, "FolderIds")]]
    ]
  )

  EncodedRegistry.register(
    :class => CreateFolderType,
    :schema_type => XSD::QName.new(NsMessages, "CreateFolderType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["parentFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "ParentFolderId")]],
      ["folders", ["NonEmptyArrayOfFoldersType", XSD::QName.new(NsMessages, "Folders")]]
    ]
  )

  EncodedRegistry.register(
    :class => FindFolderType,
    :schema_type => XSD::QName.new(NsMessages, "FindFolderType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["folderShape", ["FolderResponseShapeType", XSD::QName.new(NsMessages, "FolderShape")]],
      [ :choice,
        ["indexedPageFolderView", ["IndexedPageViewType", XSD::QName.new(NsMessages, "IndexedPageFolderView")]],
        ["fractionalPageFolderView", ["FractionalPageViewType", XSD::QName.new(NsMessages, "FractionalPageFolderView")]]
      ],
      ["restriction", ["RestrictionType", XSD::QName.new(NsMessages, "Restriction")], [0, 1]],
      ["parentFolderIds", ["NonEmptyArrayOfBaseFolderIdsType", XSD::QName.new(NsMessages, "ParentFolderIds")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "Traversal") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => FolderInfoResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "FolderInfoResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["FolderInfoResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["folders", ["ArrayOfFoldersType", XSD::QName.new(NsMessages, "Folders")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => FolderInfoResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  EncodedRegistry.register(
    :class => FindFolderResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "FindFolderResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["FindFolderResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["rootFolder", ["FindFolderParentType", XSD::QName.new(NsMessages, "RootFolder")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => FindFolderResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  EncodedRegistry.register(
    :class => FindFolderResponseType,
    :schema_type => XSD::QName.new(NsMessages, "FindFolderResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  EncodedRegistry.register(
    :class => DeleteFolderType,
    :schema_type => XSD::QName.new(NsMessages, "DeleteFolderType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["folderIds", ["NonEmptyArrayOfBaseFolderIdsType", XSD::QName.new(NsMessages, "FolderIds")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "DeleteType") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => DeleteFolderResponseType,
    :schema_type => XSD::QName.new(NsMessages, "DeleteFolderResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  EncodedRegistry.register(
    :class => BaseMoveCopyFolderType,
    :schema_type => XSD::QName.new(NsMessages, "BaseMoveCopyFolderType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["toFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "ToFolderId")]],
      ["folderIds", ["NonEmptyArrayOfBaseFolderIdsType", XSD::QName.new(NsMessages, "FolderIds")]]
    ]
  )

  EncodedRegistry.register(
    :class => MoveFolderType,
    :schema_type => XSD::QName.new(NsMessages, "MoveFolderType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseMoveCopyFolderType"),
    :schema_element => [
      ["toFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "ToFolderId")]],
      ["folderIds", ["NonEmptyArrayOfBaseFolderIdsType", XSD::QName.new(NsMessages, "FolderIds")]]
    ]
  )

  EncodedRegistry.register(
    :class => CopyFolderType,
    :schema_type => XSD::QName.new(NsMessages, "CopyFolderType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseMoveCopyFolderType"),
    :schema_element => [
      ["toFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "ToFolderId")]],
      ["folderIds", ["NonEmptyArrayOfBaseFolderIdsType", XSD::QName.new(NsMessages, "FolderIds")]]
    ]
  )

  EncodedRegistry.register(
    :class => UpdateFolderType,
    :schema_type => XSD::QName.new(NsMessages, "UpdateFolderType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["folderChanges", ["NonEmptyArrayOfFolderChangesType", XSD::QName.new(NsMessages, "FolderChanges")]]
    ]
  )

  EncodedRegistry.register(
    :class => CreateFolderResponseType,
    :schema_type => XSD::QName.new(NsMessages, "CreateFolderResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  EncodedRegistry.register(
    :class => GetFolderResponseType,
    :schema_type => XSD::QName.new(NsMessages, "GetFolderResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  EncodedRegistry.register(
    :class => UpdateFolderResponseType,
    :schema_type => XSD::QName.new(NsMessages, "UpdateFolderResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  EncodedRegistry.register(
    :class => MoveFolderResponseType,
    :schema_type => XSD::QName.new(NsMessages, "MoveFolderResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  EncodedRegistry.register(
    :class => CopyFolderResponseType,
    :schema_type => XSD::QName.new(NsMessages, "CopyFolderResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  EncodedRegistry.register(
    :class => GetItemType,
    :schema_type => XSD::QName.new(NsMessages, "GetItemType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["itemShape", ["ItemResponseShapeType", XSD::QName.new(NsMessages, "ItemShape")]],
      ["itemIds", ["NonEmptyArrayOfBaseItemIdsType", XSD::QName.new(NsMessages, "ItemIds")]]
    ]
  )

  EncodedRegistry.register(
    :class => CreateItemType,
    :schema_type => XSD::QName.new(NsMessages, "CreateItemType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["savedItemFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "SavedItemFolderId")], [0, 1]],
      ["items", ["NonEmptyArrayOfAllItemsType", XSD::QName.new(NsMessages, "Items")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "MessageDisposition") => "SOAP::SOAPString",
      XSD::QName.new(nil, "SendMeetingInvitations") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => UpdateItemType,
    :schema_type => XSD::QName.new(NsMessages, "UpdateItemType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["savedItemFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "SavedItemFolderId")], [0, 1]],
      ["itemChanges", ["NonEmptyArrayOfItemChangesType", XSD::QName.new(NsMessages, "ItemChanges")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ConflictResolution") => "SOAP::SOAPString",
      XSD::QName.new(nil, "MessageDisposition") => "SOAP::SOAPString",
      XSD::QName.new(nil, "SendMeetingInvitationsOrCancellations") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => ItemInfoResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "ItemInfoResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["ItemInfoResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["items", ["ArrayOfRealItemsType", XSD::QName.new(NsMessages, "Items")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => ItemInfoResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  EncodedRegistry.register(
    :class => UpdateItemResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "UpdateItemResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ItemInfoResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["UpdateItemResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["items", ["ArrayOfRealItemsType", XSD::QName.new(NsMessages, "Items")]],
      ["conflictResults", ["ConflictResultsType", XSD::QName.new(NsMessages, "ConflictResults")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => UpdateItemResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  EncodedRegistry.register(
    :class => DeleteItemType,
    :schema_type => XSD::QName.new(NsMessages, "DeleteItemType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["itemIds", ["NonEmptyArrayOfBaseItemIdsType", XSD::QName.new(NsMessages, "ItemIds")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "DeleteType") => "SOAP::SOAPString",
      XSD::QName.new(nil, "SendMeetingCancellations") => "SOAP::SOAPString",
      XSD::QName.new(nil, "AffectedTaskOccurrences") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => AttachmentInfoResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "AttachmentInfoResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["AttachmentInfoResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["attachments", ["ArrayOfAttachmentsType", XSD::QName.new(NsMessages, "Attachments")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => AttachmentInfoResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  EncodedRegistry.register(
    :class => DeleteAttachmentResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "DeleteAttachmentResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["DeleteAttachmentResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["rootItemId", ["RootItemIdType", XSD::QName.new(NsMessages, "RootItemId")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => DeleteAttachmentResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  EncodedRegistry.register(
    :class => BaseMoveCopyItemType,
    :schema_type => XSD::QName.new(NsMessages, "BaseMoveCopyItemType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["toFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "ToFolderId")]],
      ["itemIds", ["NonEmptyArrayOfBaseItemIdsType", XSD::QName.new(NsMessages, "ItemIds")]]
    ]
  )

  EncodedRegistry.register(
    :class => MoveItemType,
    :schema_type => XSD::QName.new(NsMessages, "MoveItemType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseMoveCopyItemType"),
    :schema_element => [
      ["toFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "ToFolderId")]],
      ["itemIds", ["NonEmptyArrayOfBaseItemIdsType", XSD::QName.new(NsMessages, "ItemIds")]]
    ]
  )

  EncodedRegistry.register(
    :class => CopyItemType,
    :schema_type => XSD::QName.new(NsMessages, "CopyItemType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseMoveCopyItemType"),
    :schema_element => [
      ["toFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "ToFolderId")]],
      ["itemIds", ["NonEmptyArrayOfBaseItemIdsType", XSD::QName.new(NsMessages, "ItemIds")]]
    ]
  )

  EncodedRegistry.register(
    :class => SendItemType,
    :schema_type => XSD::QName.new(NsMessages, "SendItemType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["itemIds", ["NonEmptyArrayOfBaseItemIdsType", XSD::QName.new(NsMessages, "ItemIds")]],
      ["savedItemFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "SavedItemFolderId")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "SaveItemToFolder") => "SOAP::SOAPBoolean"
    }
  )

  EncodedRegistry.register(
    :class => SendItemResponseType,
    :schema_type => XSD::QName.new(NsMessages, "SendItemResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  EncodedRegistry.register(
    :class => FindItemType,
    :schema_type => XSD::QName.new(NsMessages, "FindItemType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["itemShape", ["ItemResponseShapeType", XSD::QName.new(NsMessages, "ItemShape")]],
      [ :choice,
        ["indexedPageItemView", ["IndexedPageViewType", XSD::QName.new(NsMessages, "IndexedPageItemView")]],
        ["fractionalPageItemView", ["FractionalPageViewType", XSD::QName.new(NsMessages, "FractionalPageItemView")]],
        ["calendarView", ["CalendarViewType", XSD::QName.new(NsMessages, "CalendarView")]],
        ["contactsView", ["ContactsViewType", XSD::QName.new(NsMessages, "ContactsView")]]
      ],
      [ :choice,
        ["groupBy", ["GroupByType", XSD::QName.new(NsMessages, "GroupBy")]],
        ["distinguishedGroupBy", ["DistinguishedGroupByType", XSD::QName.new(NsMessages, "DistinguishedGroupBy")]]
      ],
      ["restriction", ["RestrictionType", XSD::QName.new(NsMessages, "Restriction")], [0, 1]],
      ["sortOrder", ["NonEmptyArrayOfFieldOrdersType", XSD::QName.new(NsMessages, "SortOrder")], [0, 1]],
      ["parentFolderIds", ["NonEmptyArrayOfBaseFolderIdsType", XSD::QName.new(NsMessages, "ParentFolderIds")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "Traversal") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => CreateAttachmentType,
    :schema_type => XSD::QName.new(NsMessages, "CreateAttachmentType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["parentItemId", ["ItemIdType", XSD::QName.new(NsMessages, "ParentItemId")]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsMessages, "Attachments")]]
    ]
  )

  EncodedRegistry.register(
    :class => CreateAttachmentResponseType,
    :schema_type => XSD::QName.new(NsMessages, "CreateAttachmentResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  EncodedRegistry.register(
    :class => DeleteAttachmentType,
    :schema_type => XSD::QName.new(NsMessages, "DeleteAttachmentType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["attachmentIds", ["NonEmptyArrayOfRequestAttachmentIdsType", XSD::QName.new(NsMessages, "AttachmentIds")]]
    ]
  )

  EncodedRegistry.register(
    :class => DeleteAttachmentResponseType,
    :schema_type => XSD::QName.new(NsMessages, "DeleteAttachmentResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  EncodedRegistry.register(
    :class => GetAttachmentType,
    :schema_type => XSD::QName.new(NsMessages, "GetAttachmentType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["attachmentShape", ["AttachmentResponseShapeType", XSD::QName.new(NsMessages, "AttachmentShape")], [0, 1]],
      ["attachmentIds", ["NonEmptyArrayOfRequestAttachmentIdsType", XSD::QName.new(NsMessages, "AttachmentIds")]]
    ]
  )

  EncodedRegistry.register(
    :class => GetAttachmentResponseType,
    :schema_type => XSD::QName.new(NsMessages, "GetAttachmentResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  EncodedRegistry.register(
    :class => CreateItemResponseType,
    :schema_type => XSD::QName.new(NsMessages, "CreateItemResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  EncodedRegistry.register(
    :class => UpdateItemResponseType,
    :schema_type => XSD::QName.new(NsMessages, "UpdateItemResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  EncodedRegistry.register(
    :class => GetItemResponseType,
    :schema_type => XSD::QName.new(NsMessages, "GetItemResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  EncodedRegistry.register(
    :class => MoveItemResponseType,
    :schema_type => XSD::QName.new(NsMessages, "MoveItemResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  EncodedRegistry.register(
    :class => CopyItemResponseType,
    :schema_type => XSD::QName.new(NsMessages, "CopyItemResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  EncodedRegistry.register(
    :class => DeleteItemResponseType,
    :schema_type => XSD::QName.new(NsMessages, "DeleteItemResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  EncodedRegistry.register(
    :class => FindItemResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "FindItemResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["FindItemResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["rootFolder", ["FindItemParentType", XSD::QName.new(NsMessages, "RootFolder")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => FindItemResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  EncodedRegistry.register(
    :class => FindItemResponseType,
    :schema_type => XSD::QName.new(NsMessages, "FindItemResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  EncodedRegistry.register(
    :class => ResolveNamesType,
    :schema_type => XSD::QName.new(NsMessages, "ResolveNamesType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["parentFolderIds", ["NonEmptyArrayOfBaseFolderIdsType", XSD::QName.new(NsMessages, "ParentFolderIds")], [0, 1]],
      ["unresolvedEntry", [nil, XSD::QName.new(NsMessages, "UnresolvedEntry")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ReturnFullContactData") => "SOAP::SOAPBoolean",
      XSD::QName.new(nil, "SearchScope") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => ResolveNamesResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "ResolveNamesResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["ResolveNamesResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["resolutionSet", ["ArrayOfResolutionType", XSD::QName.new(NsMessages, "ResolutionSet")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => ResolveNamesResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  EncodedRegistry.register(
    :class => ResolveNamesResponseType,
    :schema_type => XSD::QName.new(NsMessages, "ResolveNamesResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  EncodedRegistry.register(
    :class => ExpandDLType,
    :schema_type => XSD::QName.new(NsMessages, "ExpandDLType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["mailbox", ["EmailAddressType", XSD::QName.new(NsMessages, "Mailbox")]]
    ]
  )

  EncodedRegistry.register(
    :class => ExpandDLResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "ExpandDLResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["ExpandDLResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["dLExpansion", ["ArrayOfDLExpansionType", XSD::QName.new(NsMessages, "DLExpansion")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString",
      XSD::QName.new(nil, "IndexedPagingOffset") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "NumeratorOffset") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "AbsoluteDenominator") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "IncludesLastItemInRange") => "SOAP::SOAPBoolean",
      XSD::QName.new(nil, "TotalItemsInView") => "SOAP::SOAPInt"
    }
  )

  EncodedRegistry.register(
    :class => ExpandDLResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  EncodedRegistry.register(
    :class => ExpandDLResponseType,
    :schema_type => XSD::QName.new(NsMessages, "ExpandDLResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  EncodedRegistry.register(
    :class => CreateManagedFolderRequestType,
    :schema_type => XSD::QName.new(NsMessages, "CreateManagedFolderRequestType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["folderNames", ["NonEmptyArrayOfFolderNamesType", XSD::QName.new(NsMessages, "FolderNames")]],
      ["mailbox", ["EmailAddressType", XSD::QName.new(NsMessages, "Mailbox")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => CreateManagedFolderResponseType,
    :schema_type => XSD::QName.new(NsMessages, "CreateManagedFolderResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  EncodedRegistry.register(
    :class => SubscribeType,
    :schema_type => XSD::QName.new(NsMessages, "SubscribeType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [ :choice,
      ["pullSubscriptionRequest", ["PullSubscriptionRequestType", XSD::QName.new(NsMessages, "PullSubscriptionRequest")]],
      ["pushSubscriptionRequest", ["PushSubscriptionRequestType", XSD::QName.new(NsMessages, "PushSubscriptionRequest")]]
    ]
  )

  EncodedRegistry.register(
    :class => SubscribeResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "SubscribeResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["SubscribeResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["subscriptionId", [nil, XSD::QName.new(NsMessages, "SubscriptionId")], [0, 1]],
      ["watermark", [nil, XSD::QName.new(NsMessages, "Watermark")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => SubscribeResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  EncodedRegistry.register(
    :class => SubscribeResponseType,
    :schema_type => XSD::QName.new(NsMessages, "SubscribeResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  EncodedRegistry.register(
    :class => UnsubscribeType,
    :schema_type => XSD::QName.new(NsMessages, "UnsubscribeType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["subscriptionId", [nil, XSD::QName.new(NsMessages, "SubscriptionId")]]
    ]
  )

  EncodedRegistry.register(
    :class => UnsubscribeResponseType,
    :schema_type => XSD::QName.new(NsMessages, "UnsubscribeResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  EncodedRegistry.register(
    :class => GetEventsType,
    :schema_type => XSD::QName.new(NsMessages, "GetEventsType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["subscriptionId", [nil, XSD::QName.new(NsMessages, "SubscriptionId")]],
      ["watermark", [nil, XSD::QName.new(NsMessages, "Watermark")]]
    ]
  )

  EncodedRegistry.register(
    :class => GetEventsResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "GetEventsResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["GetEventsResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["notification", ["NotificationType", XSD::QName.new(NsMessages, "Notification")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => GetEventsResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  EncodedRegistry.register(
    :class => GetEventsResponseType,
    :schema_type => XSD::QName.new(NsMessages, "GetEventsResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  EncodedRegistry.register(
    :class => SendNotificationResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "SendNotificationResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["SendNotificationResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["notification", ["NotificationType", XSD::QName.new(NsMessages, "Notification")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => SendNotificationResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  EncodedRegistry.register(
    :class => SendNotificationResponseType,
    :schema_type => XSD::QName.new(NsMessages, "SendNotificationResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  EncodedRegistry.register(
    :class => SendNotificationResultType,
    :schema_type => XSD::QName.new(NsMessages, "SendNotificationResultType"),
    :schema_element => [
      ["subscriptionStatus", ["SubscriptionStatusType", XSD::QName.new(NsMessages, "SubscriptionStatus")]]
    ]
  )

  EncodedRegistry.register(
    :class => SyncFolderHierarchyType,
    :schema_type => XSD::QName.new(NsMessages, "SyncFolderHierarchyType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["folderShape", ["FolderResponseShapeType", XSD::QName.new(NsMessages, "FolderShape")]],
      ["syncFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "SyncFolderId")], [0, 1]],
      ["syncState", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "SyncState")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => SyncFolderHierarchyResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "SyncFolderHierarchyResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["SyncFolderHierarchyResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["syncState", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "SyncState")], [0, 1]],
      ["includesLastFolderInRange", ["SOAP::SOAPBoolean", XSD::QName.new(NsMessages, "IncludesLastFolderInRange")], [0, 1]],
      ["changes", ["SyncFolderHierarchyChangesType", XSD::QName.new(NsMessages, "Changes")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => SyncFolderHierarchyResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  EncodedRegistry.register(
    :class => SyncFolderHierarchyResponseType,
    :schema_type => XSD::QName.new(NsMessages, "SyncFolderHierarchyResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  EncodedRegistry.register(
    :class => SyncFolderItemsType,
    :schema_type => XSD::QName.new(NsMessages, "SyncFolderItemsType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["itemShape", ["ItemResponseShapeType", XSD::QName.new(NsMessages, "ItemShape")]],
      ["syncFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "SyncFolderId")]],
      ["syncState", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "SyncState")], [0, 1]],
      ["ignore", ["ArrayOfBaseItemIdsType", XSD::QName.new(NsMessages, "Ignore")], [0, 1]],
      ["maxChangesReturned", [nil, XSD::QName.new(NsMessages, "MaxChangesReturned")]]
    ]
  )

  EncodedRegistry.register(
    :class => SyncFolderItemsResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "SyncFolderItemsResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["SyncFolderItemsResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["syncState", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "SyncState")], [0, 1]],
      ["includesLastItemInRange", ["SOAP::SOAPBoolean", XSD::QName.new(NsMessages, "IncludesLastItemInRange")], [0, 1]],
      ["changes", ["SyncFolderItemsChangesType", XSD::QName.new(NsMessages, "Changes")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => SyncFolderItemsResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  EncodedRegistry.register(
    :class => SyncFolderItemsResponseType,
    :schema_type => XSD::QName.new(NsMessages, "SyncFolderItemsResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  EncodedRegistry.register(
    :class => GetUserAvailabilityRequestType,
    :schema_type => XSD::QName.new(NsMessages, "GetUserAvailabilityRequestType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["timeZone", ["SerializableTimeZone", XSD::QName.new(NsTypes, "TimeZone")]],
      ["mailboxDataArray", ["ArrayOfMailboxData", XSD::QName.new(NsMessages, "MailboxDataArray")]],
      ["freeBusyViewOptions", ["FreeBusyViewOptionsType", XSD::QName.new(NsTypes, "FreeBusyViewOptions")], [0, 1]],
      ["suggestionsViewOptions", ["SuggestionsViewOptionsType", XSD::QName.new(NsTypes, "SuggestionsViewOptions")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => FreeBusyResponseType,
    :schema_type => XSD::QName.new(NsMessages, "FreeBusyResponseType"),
    :schema_element => [
      ["responseMessage", ["ResponseMessageType", XSD::QName.new(NsMessages, "ResponseMessage")], [0, 1]],
      ["freeBusyView", ["FreeBusyView", XSD::QName.new(NsMessages, "FreeBusyView")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => ArrayOfFreeBusyResponse,
    :schema_type => XSD::QName.new(NsMessages, "ArrayOfFreeBusyResponse"),
    :schema_element => [
      ["freeBusyResponse", ["FreeBusyResponseType[]", XSD::QName.new(NsMessages, "FreeBusyResponse")], [0, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => SuggestionsResponseType,
    :schema_type => XSD::QName.new(NsMessages, "SuggestionsResponseType"),
    :schema_element => [
      ["responseMessage", ["ResponseMessageType", XSD::QName.new(NsMessages, "ResponseMessage")], [0, 1]],
      ["suggestionDayResultArray", ["ArrayOfSuggestionDayResult", XSD::QName.new(NsMessages, "SuggestionDayResultArray")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => GetUserAvailabilityResponseType,
    :schema_type => XSD::QName.new(NsMessages, "GetUserAvailabilityResponseType"),
    :schema_element => [
      ["freeBusyResponseArray", ["ArrayOfFreeBusyResponse", XSD::QName.new(NsMessages, "FreeBusyResponseArray")], [0, 1]],
      ["suggestionsResponse", ["SuggestionsResponseType", XSD::QName.new(NsMessages, "SuggestionsResponse")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => GetUserOofSettingsRequest,
    :schema_type => XSD::QName.new(NsMessages, "GetUserOofSettingsRequest"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["mailbox", ["EmailAddress", XSD::QName.new(NsTypes, "Mailbox")]]
    ]
  )

  EncodedRegistry.register(
    :class => GetUserOofSettingsResponse,
    :schema_type => XSD::QName.new(NsMessages, "GetUserOofSettingsResponse"),
    :schema_element => [
      ["responseMessage", ["ResponseMessageType", XSD::QName.new(NsMessages, "ResponseMessage")]],
      ["oofSettings", ["UserOofSettings", XSD::QName.new(NsTypes, "OofSettings")], [0, 1]],
      ["allowExternalOof", ["ExternalAudience", XSD::QName.new(NsMessages, "AllowExternalOof")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => SetUserOofSettingsRequest,
    :schema_type => XSD::QName.new(NsMessages, "SetUserOofSettingsRequest"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["mailbox", ["EmailAddress", XSD::QName.new(NsTypes, "Mailbox")]],
      ["userOofSettings", ["UserOofSettings", XSD::QName.new(NsTypes, "UserOofSettings")]]
    ]
  )

  EncodedRegistry.register(
    :class => SetUserOofSettingsResponse,
    :schema_type => XSD::QName.new(NsMessages, "SetUserOofSettingsResponse"),
    :schema_element => [
      ["responseMessage", ["ResponseMessageType", XSD::QName.new(NsMessages, "ResponseMessage")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => ConvertIdType,
    :schema_type => XSD::QName.new(NsMessages, "ConvertIdType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["sourceIds", ["NonEmptyArrayOfAlternateIdsType", XSD::QName.new(NsMessages, "SourceIds")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "DestinationFormat") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => ConvertIdResponseType,
    :schema_type => XSD::QName.new(NsMessages, "ConvertIdResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  EncodedRegistry.register(
    :class => ConvertIdResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "ConvertIdResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["ConvertIdResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["alternateId", ["AlternateIdBaseType", XSD::QName.new(NsMessages, "AlternateId")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => ConvertIdResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  EncodedRegistry.register(
    :class => GetDelegateType,
    :schema_type => XSD::QName.new(NsMessages, "GetDelegateType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseDelegateType"),
    :schema_element => [
      ["mailbox", ["EmailAddressType", XSD::QName.new(NsMessages, "Mailbox")]],
      ["userIds", ["ArrayOfUserIdType", XSD::QName.new(NsMessages, "UserIds")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "IncludePermissions") => "SOAP::SOAPBoolean"
    }
  )

  EncodedRegistry.register(
    :class => GetDelegateResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "GetDelegateResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseDelegateResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["GetDelegateResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["responseMessages", ["ArrayOfDelegateUserResponseMessageType", XSD::QName.new(NsMessages, "ResponseMessages")], [0, 1]],
      ["deliverMeetingRequests", ["DeliverMeetingRequestsType", XSD::QName.new(NsMessages, "DeliverMeetingRequests")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => GetDelegateResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  EncodedRegistry.register(
    :class => ArrayOfDelegateUserResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "ArrayOfDelegateUserResponseMessageType"),
    :schema_element => [
      ["delegateUserResponseMessageType", ["DelegateUserResponseMessageType[]", XSD::QName.new(NsMessages, "DelegateUserResponseMessageType")], [1, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => DelegateUserResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "DelegateUserResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["DelegateUserResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["delegateUser", ["DelegateUserType", XSD::QName.new(NsMessages, "DelegateUser")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => DelegateUserResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  EncodedRegistry.register(
    :class => AddDelegateType,
    :schema_type => XSD::QName.new(NsMessages, "AddDelegateType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseDelegateType"),
    :schema_element => [
      ["mailbox", ["EmailAddressType", XSD::QName.new(NsMessages, "Mailbox")]],
      ["delegateUsers", ["ArrayOfDelegateUserType", XSD::QName.new(NsMessages, "DelegateUsers")]],
      ["deliverMeetingRequests", ["DeliverMeetingRequestsType", XSD::QName.new(NsMessages, "DeliverMeetingRequests")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => AddDelegateResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "AddDelegateResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseDelegateResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["AddDelegateResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["responseMessages", ["ArrayOfDelegateUserResponseMessageType", XSD::QName.new(NsMessages, "ResponseMessages")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => AddDelegateResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  EncodedRegistry.register(
    :class => RemoveDelegateType,
    :schema_type => XSD::QName.new(NsMessages, "RemoveDelegateType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseDelegateType"),
    :schema_element => [
      ["mailbox", ["EmailAddressType", XSD::QName.new(NsMessages, "Mailbox")]],
      ["userIds", ["ArrayOfUserIdType", XSD::QName.new(NsMessages, "UserIds")]]
    ]
  )

  EncodedRegistry.register(
    :class => RemoveDelegateResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "RemoveDelegateResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseDelegateResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["RemoveDelegateResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["responseMessages", ["ArrayOfDelegateUserResponseMessageType", XSD::QName.new(NsMessages, "ResponseMessages")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => RemoveDelegateResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  EncodedRegistry.register(
    :class => UpdateDelegateType,
    :schema_type => XSD::QName.new(NsMessages, "UpdateDelegateType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseDelegateType"),
    :schema_element => [
      ["mailbox", ["EmailAddressType", XSD::QName.new(NsMessages, "Mailbox")]],
      ["delegateUsers", ["ArrayOfDelegateUserType", XSD::QName.new(NsMessages, "DelegateUsers")], [0, 1]],
      ["deliverMeetingRequests", ["DeliverMeetingRequestsType", XSD::QName.new(NsMessages, "DeliverMeetingRequests")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => UpdateDelegateResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "UpdateDelegateResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseDelegateResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["UpdateDelegateResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["responseMessages", ["ArrayOfDelegateUserResponseMessageType", XSD::QName.new(NsMessages, "ResponseMessages")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => UpdateDelegateResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  EncodedRegistry.register(
    :class => SidAndAttributesType,
    :schema_type => XSD::QName.new(NsTypes, "SidAndAttributesType"),
    :schema_element => [
      ["securityIdentifier", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "SecurityIdentifier")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "Attributes") => "SOAP::SOAPUnsignedInt"
    }
  )

  EncodedRegistry.register(
    :class => NonEmptyArrayOfGroupIdentifiersType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfGroupIdentifiersType"),
    :schema_element => [
      ["groupIdentifier", ["SidAndAttributesType[]", XSD::QName.new(NsTypes, "GroupIdentifier")], [1, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => NonEmptyArrayOfRestrictedGroupIdentifiersType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfRestrictedGroupIdentifiersType"),
    :schema_element => [
      ["restrictedGroupIdentifier", ["SidAndAttributesType[]", XSD::QName.new(NsTypes, "RestrictedGroupIdentifier")], [1, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => SerializedSecurityContextType,
    :schema_type => XSD::QName.new(NsTypes, "SerializedSecurityContextType"),
    :schema_element => [
      ["userSid", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "UserSid")]],
      ["groupSids", ["NonEmptyArrayOfGroupIdentifiersType", XSD::QName.new(NsTypes, "GroupSids")], [0, 1]],
      ["restrictedGroupSids", ["NonEmptyArrayOfRestrictedGroupIdentifiersType", XSD::QName.new(NsTypes, "RestrictedGroupSids")], [0, 1]],
      ["primarySmtpAddress", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "PrimarySmtpAddress")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => ConnectingSIDType,
    :schema_type => XSD::QName.new(NsTypes, "ConnectingSIDType"),
    :schema_element => [
      ["principalName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "PrincipalName")], [0, 1]],
      ["sID", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "SID")], [0, 1]],
      ["primarySmtpAddress", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "PrimarySmtpAddress")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => ExchangeImpersonationType,
    :schema_type => XSD::QName.new(NsTypes, "ExchangeImpersonationType"),
    :schema_element => [
      ["connectingSID", ["ConnectingSIDType", XSD::QName.new(NsTypes, "ConnectingSID")]]
    ]
  )

  EncodedRegistry.register(
    :class => ProxySecurityContextType,
    :schema_type => XSD::QName.new(NsTypes, "ProxySecurityContextType")
  )

  EncodedRegistry.register(
    :class => BaseEmailAddressType,
    :schema_type => XSD::QName.new(NsTypes, "BaseEmailAddressType"),
    :schema_element => []
  )

  EncodedRegistry.register(
    :class => EmailAddressType,
    :schema_type => XSD::QName.new(NsTypes, "EmailAddressType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseEmailAddressType"),
    :schema_element => [
      ["name", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Name")], [0, 1]],
      ["emailAddress", [nil, XSD::QName.new(NsTypes, "EmailAddress")], [0, 1]],
      ["routingType", [nil, XSD::QName.new(NsTypes, "RoutingType")], [0, 1]],
      ["mailboxType", ["MailboxTypeType", XSD::QName.new(NsTypes, "MailboxType")], [0, 1]],
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => ArrayOfRecipientsType,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfRecipientsType"),
    :schema_element => [
      ["mailbox", ["EmailAddressType[]", XSD::QName.new(NsTypes, "Mailbox")]]
    ]
  )

  EncodedRegistry.register(
    :class => SingleRecipientType,
    :schema_type => XSD::QName.new(NsTypes, "SingleRecipientType"),
    :schema_element => [ :choice,
      ["mailbox", ["EmailAddressType", XSD::QName.new(NsTypes, "Mailbox")]]
    ]
  )

  EncodedRegistry.register(
    :class => PathToUnindexedFieldType,
    :schema_type => XSD::QName.new(NsTypes, "PathToUnindexedFieldType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BasePathToElementType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "FieldURI") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => PathToIndexedFieldType,
    :schema_type => XSD::QName.new(NsTypes, "PathToIndexedFieldType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BasePathToElementType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "FieldURI") => "SOAP::SOAPString",
      XSD::QName.new(nil, "FieldIndex") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => PathToExceptionFieldType,
    :schema_type => XSD::QName.new(NsTypes, "PathToExceptionFieldType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BasePathToElementType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "FieldURI") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => PathToExtendedFieldType,
    :schema_type => XSD::QName.new(NsTypes, "PathToExtendedFieldType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BasePathToElementType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "DistinguishedPropertySetId") => "SOAP::SOAPString",
      XSD::QName.new(nil, "PropertySetId") => "SOAP::SOAPString",
      XSD::QName.new(nil, "PropertyTag") => nil,
      XSD::QName.new(nil, "PropertyName") => "SOAP::SOAPString",
      XSD::QName.new(nil, "PropertyId") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "PropertyType") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => NonEmptyArrayOfPathsToElementType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfPathsToElementType"),
    :schema_element => [
      ["path", ["BasePathToElementType[]", XSD::QName.new(NsTypes, "Path")]]
    ]
  )

  EncodedRegistry.register(
    :class => NonEmptyArrayOfPropertyValuesType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfPropertyValuesType"),
    :schema_element => [
      ["value", ["SOAP::SOAPString[]", XSD::QName.new(NsTypes, "Value")], [1, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => ExtendedPropertyType,
    :schema_type => XSD::QName.new(NsTypes, "ExtendedPropertyType"),
    :schema_element => [
      ["extendedFieldURI", ["PathToExtendedFieldType", XSD::QName.new(NsTypes, "ExtendedFieldURI")]],
      [ :choice,
        ["value", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Value")]],
        ["values", ["NonEmptyArrayOfPropertyValuesType", XSD::QName.new(NsTypes, "Values")]]
      ]
    ]
  )

  EncodedRegistry.register(
    :class => FolderResponseShapeType,
    :schema_type => XSD::QName.new(NsTypes, "FolderResponseShapeType"),
    :schema_element => [
      ["baseShape", ["DefaultShapeNamesType", XSD::QName.new(NsTypes, "BaseShape")]],
      ["additionalProperties", ["NonEmptyArrayOfPathsToElementType", XSD::QName.new(NsTypes, "AdditionalProperties")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => ItemResponseShapeType,
    :schema_type => XSD::QName.new(NsTypes, "ItemResponseShapeType"),
    :schema_element => [
      ["baseShape", ["DefaultShapeNamesType", XSD::QName.new(NsTypes, "BaseShape")]],
      ["includeMimeContent", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IncludeMimeContent")], [0, 1]],
      ["bodyType", ["BodyTypeResponseType", XSD::QName.new(NsTypes, "BodyType")], [0, 1]],
      ["additionalProperties", ["NonEmptyArrayOfPathsToElementType", XSD::QName.new(NsTypes, "AdditionalProperties")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => AttachmentResponseShapeType,
    :schema_type => XSD::QName.new(NsTypes, "AttachmentResponseShapeType"),
    :schema_element => [
      ["includeMimeContent", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IncludeMimeContent")], [0, 1]],
      ["bodyType", ["BodyTypeResponseType", XSD::QName.new(NsTypes, "BodyType")], [0, 1]],
      ["additionalProperties", ["NonEmptyArrayOfPathsToElementType", XSD::QName.new(NsTypes, "AdditionalProperties")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => ItemChangeDescriptionType,
    :schema_type => XSD::QName.new(NsTypes, "ItemChangeDescriptionType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ChangeDescriptionType"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]]
    ]
  )

  EncodedRegistry.register(
    :class => FolderChangeDescriptionType,
    :schema_type => XSD::QName.new(NsTypes, "FolderChangeDescriptionType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ChangeDescriptionType"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]]
    ]
  )

  EncodedRegistry.register(
    :class => SetItemFieldType,
    :schema_type => XSD::QName.new(NsTypes, "SetItemFieldType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ItemChangeDescriptionType"),
    :schema_element => [ :choice,
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["item", ["ItemType", XSD::QName.new(NsTypes, "Item")]],
      ["message", ["MessageType", XSD::QName.new(NsTypes, "Message")]],
      ["calendarItem", ["CalendarItemType", XSD::QName.new(NsTypes, "CalendarItem")]],
      ["contact", ["ContactItemType", XSD::QName.new(NsTypes, "Contact")]],
      ["distributionList", ["DistributionListType", XSD::QName.new(NsTypes, "DistributionList")]],
      ["meetingMessage", ["MeetingMessageType", XSD::QName.new(NsTypes, "MeetingMessage")]],
      ["meetingRequest", ["MeetingRequestMessageType", XSD::QName.new(NsTypes, "MeetingRequest")]],
      ["meetingResponse", ["MeetingResponseMessageType", XSD::QName.new(NsTypes, "MeetingResponse")]],
      ["meetingCancellation", ["MeetingCancellationMessageType", XSD::QName.new(NsTypes, "MeetingCancellation")]],
      ["task", ["TaskType", XSD::QName.new(NsTypes, "Task")]],
      ["postItem", ["PostItemType", XSD::QName.new(NsTypes, "PostItem")]]
    ]
  )

  EncodedRegistry.register(
    :class => SetFolderFieldType,
    :schema_type => XSD::QName.new(NsTypes, "SetFolderFieldType"),
    :schema_basetype => XSD::QName.new(NsTypes, "FolderChangeDescriptionType"),
    :schema_element => [ :choice,
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["folder", ["FolderType", XSD::QName.new(NsTypes, "Folder")]],
      ["calendarFolder", ["CalendarFolderType", XSD::QName.new(NsTypes, "CalendarFolder")]],
      ["contactsFolder", ["ContactsFolderType", XSD::QName.new(NsTypes, "ContactsFolder")]],
      ["searchFolder", ["SearchFolderType", XSD::QName.new(NsTypes, "SearchFolder")]],
      ["tasksFolder", ["TasksFolderType", XSD::QName.new(NsTypes, "TasksFolder")]]
    ]
  )

  EncodedRegistry.register(
    :class => DeleteItemFieldType,
    :schema_type => XSD::QName.new(NsTypes, "DeleteItemFieldType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ItemChangeDescriptionType"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]]
    ]
  )

  EncodedRegistry.register(
    :class => DeleteFolderFieldType,
    :schema_type => XSD::QName.new(NsTypes, "DeleteFolderFieldType"),
    :schema_basetype => XSD::QName.new(NsTypes, "FolderChangeDescriptionType"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]]
    ]
  )

  EncodedRegistry.register(
    :class => AppendToItemFieldType,
    :schema_type => XSD::QName.new(NsTypes, "AppendToItemFieldType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ItemChangeDescriptionType"),
    :schema_element => [ :choice,
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["item", ["ItemType", XSD::QName.new(NsTypes, "Item")]],
      ["message", ["MessageType", XSD::QName.new(NsTypes, "Message")]],
      ["calendarItem", ["CalendarItemType", XSD::QName.new(NsTypes, "CalendarItem")]],
      ["contact", ["ContactItemType", XSD::QName.new(NsTypes, "Contact")]],
      ["distributionList", ["DistributionListType", XSD::QName.new(NsTypes, "DistributionList")]],
      ["meetingMessage", ["MeetingMessageType", XSD::QName.new(NsTypes, "MeetingMessage")]],
      ["meetingRequest", ["MeetingRequestMessageType", XSD::QName.new(NsTypes, "MeetingRequest")]],
      ["meetingResponse", ["MeetingResponseMessageType", XSD::QName.new(NsTypes, "MeetingResponse")]],
      ["meetingCancellation", ["MeetingCancellationMessageType", XSD::QName.new(NsTypes, "MeetingCancellation")]],
      ["task", ["TaskType", XSD::QName.new(NsTypes, "Task")]],
      ["postItem", ["PostItemType", XSD::QName.new(NsTypes, "PostItem")]]
    ]
  )

  EncodedRegistry.register(
    :class => AppendToFolderFieldType,
    :schema_type => XSD::QName.new(NsTypes, "AppendToFolderFieldType"),
    :schema_basetype => XSD::QName.new(NsTypes, "FolderChangeDescriptionType"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      [ :choice,
        ["folder", ["FolderType", XSD::QName.new(NsTypes, "Folder")]],
        ["calendarFolder", ["CalendarFolderType", XSD::QName.new(NsTypes, "CalendarFolder")]],
        ["contactsFolder", ["ContactsFolderType", XSD::QName.new(NsTypes, "ContactsFolder")]],
        ["searchFolder", ["SearchFolderType", XSD::QName.new(NsTypes, "SearchFolder")]],
        ["tasksFolder", ["TasksFolderType", XSD::QName.new(NsTypes, "TasksFolder")]]
      ]
    ]
  )

  EncodedRegistry.register(
    :class => NonEmptyArrayOfItemChangeDescriptionsType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfItemChangeDescriptionsType"),
    :schema_element => [ :choice,
      ["appendToItemField", ["AppendToItemFieldType[]", XSD::QName.new(NsTypes, "AppendToItemField")]],
      ["setItemField", ["SetItemFieldType[]", XSD::QName.new(NsTypes, "SetItemField")]],
      ["deleteItemField", ["DeleteItemFieldType[]", XSD::QName.new(NsTypes, "DeleteItemField")]]
    ]
  )

  EncodedRegistry.register(
    :class => NonEmptyArrayOfFolderChangeDescriptionsType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfFolderChangeDescriptionsType"),
    :schema_element => [ :choice,
      ["appendToFolderField", ["AppendToFolderFieldType[]", XSD::QName.new(NsTypes, "AppendToFolderField")]],
      ["setFolderField", ["SetFolderFieldType[]", XSD::QName.new(NsTypes, "SetFolderField")]],
      ["deleteFolderField", ["DeleteFolderFieldType[]", XSD::QName.new(NsTypes, "DeleteFolderField")]]
    ]
  )

  EncodedRegistry.register(
    :class => ItemChangeType,
    :schema_type => XSD::QName.new(NsTypes, "ItemChangeType"),
    :schema_element => [
      [ :choice,
        ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")]],
        ["occurrenceItemId", ["OccurrenceItemIdType", XSD::QName.new(NsTypes, "OccurrenceItemId")]],
        ["recurringMasterItemId", ["RecurringMasterItemIdType", XSD::QName.new(NsTypes, "RecurringMasterItemId")]]
      ],
      ["updates", ["NonEmptyArrayOfItemChangeDescriptionsType", XSD::QName.new(NsTypes, "Updates")]]
    ]
  )

  EncodedRegistry.register(
    :class => NonEmptyArrayOfItemChangesType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfItemChangesType"),
    :schema_element => [
      ["itemChange", ["ItemChangeType[]", XSD::QName.new(NsTypes, "ItemChange")], [1, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => InternetHeaderType,
    :schema_type => XSD::QName.new(NsTypes, "InternetHeaderType"),
    :schema_attribute => {
      XSD::QName.new(nil, "HeaderName") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => NonEmptyArrayOfInternetHeadersType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfInternetHeadersType"),
    :schema_element => [
      ["internetMessageHeader", ["InternetHeaderType[]", XSD::QName.new(NsTypes, "InternetMessageHeader")], [1, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => RequestAttachmentIdType,
    :schema_type => XSD::QName.new(NsTypes, "RequestAttachmentIdType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseItemIdType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "Id") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => AttachmentIdType,
    :schema_type => XSD::QName.new(NsTypes, "AttachmentIdType"),
    :schema_basetype => XSD::QName.new(NsTypes, "RequestAttachmentIdType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "Id") => "SOAP::SOAPString",
      XSD::QName.new(nil, "RootItemId") => "SOAP::SOAPString",
      XSD::QName.new(nil, "RootItemChangeKey") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => RootItemIdType,
    :schema_type => XSD::QName.new(NsTypes, "RootItemIdType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseItemIdType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "RootItemId") => "SOAP::SOAPString",
      XSD::QName.new(nil, "RootItemChangeKey") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => NonEmptyArrayOfRequestAttachmentIdsType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfRequestAttachmentIdsType"),
    :schema_element => [
      ["attachmentId", ["RequestAttachmentIdType[]", XSD::QName.new(NsTypes, "AttachmentId")]]
    ]
  )

  EncodedRegistry.register(
    :class => AttachmentType,
    :schema_type => XSD::QName.new(NsTypes, "AttachmentType"),
    :schema_element => [
      ["attachmentId", ["AttachmentIdType", XSD::QName.new(NsTypes, "AttachmentId")], [0, 1]],
      ["name", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Name")], [0, 1]],
      ["contentType", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ContentType")], [0, 1]],
      ["contentId", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ContentId")], [0, 1]],
      ["contentLocation", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ContentLocation")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => ItemAttachmentType,
    :schema_type => XSD::QName.new(NsTypes, "ItemAttachmentType"),
    :schema_basetype => XSD::QName.new(NsTypes, "AttachmentType"),
    :schema_element => [ :choice,
      ["attachmentId", ["AttachmentIdType", XSD::QName.new(NsTypes, "AttachmentId")], [0, 1]],
      ["name", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Name")], [0, 1]],
      ["contentType", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ContentType")], [0, 1]],
      ["contentId", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ContentId")], [0, 1]],
      ["contentLocation", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ContentLocation")], [0, 1]],
      ["item", ["ItemType", XSD::QName.new(NsTypes, "Item")]],
      ["message", ["MessageType", XSD::QName.new(NsTypes, "Message")]],
      ["calendarItem", ["CalendarItemType", XSD::QName.new(NsTypes, "CalendarItem")]],
      ["contact", ["ContactItemType", XSD::QName.new(NsTypes, "Contact")]],
      ["meetingMessage", ["MeetingMessageType", XSD::QName.new(NsTypes, "MeetingMessage")]],
      ["meetingRequest", ["MeetingRequestMessageType", XSD::QName.new(NsTypes, "MeetingRequest")]],
      ["meetingResponse", ["MeetingResponseMessageType", XSD::QName.new(NsTypes, "MeetingResponse")]],
      ["meetingCancellation", ["MeetingCancellationMessageType", XSD::QName.new(NsTypes, "MeetingCancellation")]],
      ["task", ["TaskType", XSD::QName.new(NsTypes, "Task")]],
      ["postItem", ["PostItemType", XSD::QName.new(NsTypes, "PostItem")]]
    ]
  )

  EncodedRegistry.register(
    :class => SyncFolderItemsCreateOrUpdateType,
    :schema_type => XSD::QName.new(NsTypes, "SyncFolderItemsCreateOrUpdateType"),
    :schema_element => [ :choice,
      ["item", ["ItemType", XSD::QName.new(NsTypes, "Item")]],
      ["message", ["MessageType", XSD::QName.new(NsTypes, "Message")]],
      ["calendarItem", ["CalendarItemType", XSD::QName.new(NsTypes, "CalendarItem")]],
      ["contact", ["ContactItemType", XSD::QName.new(NsTypes, "Contact")]],
      ["distributionList", ["DistributionListType", XSD::QName.new(NsTypes, "DistributionList")]],
      ["meetingMessage", ["MeetingMessageType", XSD::QName.new(NsTypes, "MeetingMessage")]],
      ["meetingRequest", ["MeetingRequestMessageType", XSD::QName.new(NsTypes, "MeetingRequest")]],
      ["meetingResponse", ["MeetingResponseMessageType", XSD::QName.new(NsTypes, "MeetingResponse")]],
      ["meetingCancellation", ["MeetingCancellationMessageType", XSD::QName.new(NsTypes, "MeetingCancellation")]],
      ["task", ["TaskType", XSD::QName.new(NsTypes, "Task")]],
      ["postItem", ["PostItemType", XSD::QName.new(NsTypes, "PostItem")]]
    ]
  )

  EncodedRegistry.register(
    :class => FileAttachmentType,
    :schema_type => XSD::QName.new(NsTypes, "FileAttachmentType"),
    :schema_basetype => XSD::QName.new(NsTypes, "AttachmentType"),
    :schema_element => [
      ["attachmentId", ["AttachmentIdType", XSD::QName.new(NsTypes, "AttachmentId")], [0, 1]],
      ["name", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Name")], [0, 1]],
      ["contentType", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ContentType")], [0, 1]],
      ["contentId", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ContentId")], [0, 1]],
      ["contentLocation", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ContentLocation")], [0, 1]],
      ["content", ["SOAP::SOAPBase64", XSD::QName.new(NsTypes, "Content")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => ArrayOfAttachmentsType,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfAttachmentsType"),
    :schema_element => [ :choice,
      ["itemAttachment", ["ItemAttachmentType[]", XSD::QName.new(NsTypes, "ItemAttachment")]],
      ["fileAttachment", ["FileAttachmentType[]", XSD::QName.new(NsTypes, "FileAttachment")]]
    ]
  )

  EncodedRegistry.register(
    :class => NonEmptyArrayOfAttachmentsType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfAttachmentsType"),
    :schema_element => [ :choice,
      ["itemAttachment", ["ItemAttachmentType[]", XSD::QName.new(NsTypes, "ItemAttachment")]],
      ["fileAttachment", ["FileAttachmentType[]", XSD::QName.new(NsTypes, "FileAttachment")]]
    ]
  )

  EncodedRegistry.register(
    :class => BodyType,
    :schema_type => XSD::QName.new(NsTypes, "BodyType"),
    :schema_attribute => {
      XSD::QName.new(nil, "BodyType") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => DistinguishedFolderIdType,
    :schema_type => XSD::QName.new(NsTypes, "DistinguishedFolderIdType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseFolderIdType"),
    :schema_element => [
      ["mailbox", ["EmailAddressType", XSD::QName.new(NsTypes, "Mailbox")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "Id") => "SOAP::SOAPString",
      XSD::QName.new(nil, "ChangeKey") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => FolderIdType,
    :schema_type => XSD::QName.new(NsTypes, "FolderIdType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseFolderIdType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "Id") => "SOAP::SOAPString",
      XSD::QName.new(nil, "ChangeKey") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => NonEmptyArrayOfBaseFolderIdsType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfBaseFolderIdsType"),
    :schema_element => [ :choice,
      ["folderId", ["FolderIdType[]", XSD::QName.new(NsTypes, "FolderId")]],
      ["distinguishedFolderId", ["DistinguishedFolderIdType[]", XSD::QName.new(NsTypes, "DistinguishedFolderId")]]
    ]
  )

  EncodedRegistry.register(
    :class => TargetFolderIdType,
    :schema_type => XSD::QName.new(NsTypes, "TargetFolderIdType"),
    :schema_element => [ :choice,
      ["folderId", ["FolderIdType", XSD::QName.new(NsTypes, "FolderId")]],
      ["distinguishedFolderId", ["DistinguishedFolderIdType", XSD::QName.new(NsTypes, "DistinguishedFolderId")]]
    ]
  )

  EncodedRegistry.register(
    :class => FindFolderParentType,
    :schema_type => XSD::QName.new(NsTypes, "FindFolderParentType"),
    :schema_element => [
      ["folders", ["ArrayOfFoldersType", XSD::QName.new(NsTypes, "Folders")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "IndexedPagingOffset") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "NumeratorOffset") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "AbsoluteDenominator") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "IncludesLastItemInRange") => "SOAP::SOAPBoolean",
      XSD::QName.new(nil, "TotalItemsInView") => "SOAP::SOAPInt"
    }
  )

  EncodedRegistry.register(
    :class => ManagedFolderInformationType,
    :schema_type => XSD::QName.new(NsTypes, "ManagedFolderInformationType"),
    :schema_element => [
      ["canDelete", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "CanDelete")], [0, 1]],
      ["canRenameOrMove", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "CanRenameOrMove")], [0, 1]],
      ["mustDisplayComment", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "MustDisplayComment")], [0, 1]],
      ["hasQuota", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasQuota")], [0, 1]],
      ["isManagedFoldersRoot", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsManagedFoldersRoot")], [0, 1]],
      ["managedFolderId", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ManagedFolderId")], [0, 1]],
      ["comment", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Comment")], [0, 1]],
      ["storageQuota", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "StorageQuota")], [0, 1]],
      ["folderSize", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "FolderSize")], [0, 1]],
      ["homePage", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "HomePage")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => FolderType,
    :schema_type => XSD::QName.new(NsTypes, "FolderType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseFolderType"),
    :schema_element => [
      ["folderId", ["FolderIdType", XSD::QName.new(NsTypes, "FolderId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["folderClass", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "FolderClass")], [0, 1]],
      ["displayName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayName")], [0, 1]],
      ["totalCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "TotalCount")], [0, 1]],
      ["childFolderCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "ChildFolderCount")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["managedFolderInformation", ["ManagedFolderInformationType", XSD::QName.new(NsTypes, "ManagedFolderInformation")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["permissionSet", ["PermissionSetType", XSD::QName.new(NsTypes, "PermissionSet")], [0, 1]],
      ["unreadCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "UnreadCount")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => CalendarFolderType,
    :schema_type => XSD::QName.new(NsTypes, "CalendarFolderType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseFolderType"),
    :schema_element => [
      ["folderId", ["FolderIdType", XSD::QName.new(NsTypes, "FolderId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["folderClass", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "FolderClass")], [0, 1]],
      ["displayName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayName")], [0, 1]],
      ["totalCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "TotalCount")], [0, 1]],
      ["childFolderCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "ChildFolderCount")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["managedFolderInformation", ["ManagedFolderInformationType", XSD::QName.new(NsTypes, "ManagedFolderInformation")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["permissionSet", ["CalendarPermissionSetType", XSD::QName.new(NsTypes, "PermissionSet")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => ContactsFolderType,
    :schema_type => XSD::QName.new(NsTypes, "ContactsFolderType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseFolderType"),
    :schema_element => [
      ["folderId", ["FolderIdType", XSD::QName.new(NsTypes, "FolderId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["folderClass", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "FolderClass")], [0, 1]],
      ["displayName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayName")], [0, 1]],
      ["totalCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "TotalCount")], [0, 1]],
      ["childFolderCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "ChildFolderCount")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["managedFolderInformation", ["ManagedFolderInformationType", XSD::QName.new(NsTypes, "ManagedFolderInformation")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["permissionSet", ["PermissionSetType", XSD::QName.new(NsTypes, "PermissionSet")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => SearchFolderType,
    :schema_type => XSD::QName.new(NsTypes, "SearchFolderType"),
    :schema_basetype => XSD::QName.new(NsTypes, "FolderType"),
    :schema_element => [
      ["folderId", ["FolderIdType", XSD::QName.new(NsTypes, "FolderId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["folderClass", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "FolderClass")], [0, 1]],
      ["displayName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayName")], [0, 1]],
      ["totalCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "TotalCount")], [0, 1]],
      ["childFolderCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "ChildFolderCount")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["managedFolderInformation", ["ManagedFolderInformationType", XSD::QName.new(NsTypes, "ManagedFolderInformation")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["permissionSet", ["PermissionSetType", XSD::QName.new(NsTypes, "PermissionSet")], [0, 1]],
      ["unreadCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "UnreadCount")], [0, 1]],
      ["searchParameters", ["SearchParametersType", XSD::QName.new(NsTypes, "SearchParameters")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => TasksFolderType,
    :schema_type => XSD::QName.new(NsTypes, "TasksFolderType"),
    :schema_basetype => XSD::QName.new(NsTypes, "FolderType"),
    :schema_element => [
      ["folderId", ["FolderIdType", XSD::QName.new(NsTypes, "FolderId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["folderClass", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "FolderClass")], [0, 1]],
      ["displayName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayName")], [0, 1]],
      ["totalCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "TotalCount")], [0, 1]],
      ["childFolderCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "ChildFolderCount")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["managedFolderInformation", ["ManagedFolderInformationType", XSD::QName.new(NsTypes, "ManagedFolderInformation")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["permissionSet", ["PermissionSetType", XSD::QName.new(NsTypes, "PermissionSet")], [0, 1]],
      ["unreadCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "UnreadCount")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => NonEmptyArrayOfFoldersType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfFoldersType"),
    :schema_element => [ :choice,
      ["folder", ["FolderType[]", XSD::QName.new(NsTypes, "Folder")]],
      ["calendarFolder", ["CalendarFolderType[]", XSD::QName.new(NsTypes, "CalendarFolder")]],
      ["contactsFolder", ["ContactsFolderType[]", XSD::QName.new(NsTypes, "ContactsFolder")]],
      ["searchFolder", ["SearchFolderType[]", XSD::QName.new(NsTypes, "SearchFolder")]],
      ["tasksFolder", ["TasksFolderType[]", XSD::QName.new(NsTypes, "TasksFolder")]]
    ]
  )

  EncodedRegistry.register(
    :class => ArrayOfFoldersType,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfFoldersType"),
    :schema_element => [ :choice,
      ["folder", ["FolderType[]", XSD::QName.new(NsTypes, "Folder")]],
      ["calendarFolder", ["CalendarFolderType[]", XSD::QName.new(NsTypes, "CalendarFolder")]],
      ["contactsFolder", ["ContactsFolderType[]", XSD::QName.new(NsTypes, "ContactsFolder")]],
      ["searchFolder", ["SearchFolderType[]", XSD::QName.new(NsTypes, "SearchFolder")]],
      ["tasksFolder", ["TasksFolderType[]", XSD::QName.new(NsTypes, "TasksFolder")]]
    ]
  )

  EncodedRegistry.register(
    :class => ItemIdType,
    :schema_type => XSD::QName.new(NsTypes, "ItemIdType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseItemIdType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "Id") => "SOAP::SOAPString",
      XSD::QName.new(nil, "ChangeKey") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => NonEmptyArrayOfBaseItemIdsType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfBaseItemIdsType"),
    :schema_element => [ :choice,
      ["itemId", ["ItemIdType[]", XSD::QName.new(NsTypes, "ItemId")]],
      ["occurrenceItemId", ["OccurrenceItemIdType[]", XSD::QName.new(NsTypes, "OccurrenceItemId")]],
      ["recurringMasterItemId", ["RecurringMasterItemIdType[]", XSD::QName.new(NsTypes, "RecurringMasterItemId")]]
    ]
  )

  EncodedRegistry.register(
    :class => ArrayOfBaseItemIdsType,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfBaseItemIdsType"),
    :schema_element => [
      ["itemId", ["ItemIdType[]", XSD::QName.new(NsTypes, "ItemId")]]
    ]
  )

  EncodedRegistry.register(
    :class => NonEmptyArrayOfResponseObjectsType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfResponseObjectsType"),
    :schema_element => [ :choice,
      ["acceptItem", ["AcceptItemType[]", XSD::QName.new(NsTypes, "AcceptItem")]],
      ["tentativelyAcceptItem", ["TentativelyAcceptItemType[]", XSD::QName.new(NsTypes, "TentativelyAcceptItem")]],
      ["declineItem", ["DeclineItemType[]", XSD::QName.new(NsTypes, "DeclineItem")]],
      ["replyToItem", ["ReplyToItemType[]", XSD::QName.new(NsTypes, "ReplyToItem")]],
      ["forwardItem", ["ForwardItemType[]", XSD::QName.new(NsTypes, "ForwardItem")]],
      ["replyAllToItem", ["ReplyAllToItemType[]", XSD::QName.new(NsTypes, "ReplyAllToItem")]],
      ["cancelCalendarItem", ["CancelCalendarItemType[]", XSD::QName.new(NsTypes, "CancelCalendarItem")]],
      ["removeItem", ["RemoveItemType[]", XSD::QName.new(NsTypes, "RemoveItem")]],
      ["suppressReadReceipt", ["SuppressReadReceiptType[]", XSD::QName.new(NsTypes, "SuppressReadReceipt")]],
      ["postReplyItem", ["PostReplyItemType[]", XSD::QName.new(NsTypes, "PostReplyItem")]]
    ]
  )

  EncodedRegistry.register(
    :class => FolderChangeType,
    :schema_type => XSD::QName.new(NsTypes, "FolderChangeType"),
    :schema_element => [
      [ :choice,
        ["folderId", ["FolderIdType", XSD::QName.new(NsTypes, "FolderId")]],
        ["distinguishedFolderId", ["DistinguishedFolderIdType", XSD::QName.new(NsTypes, "DistinguishedFolderId")]]
      ],
      ["updates", ["NonEmptyArrayOfFolderChangeDescriptionsType", XSD::QName.new(NsTypes, "Updates")]]
    ]
  )

  EncodedRegistry.register(
    :class => NonEmptyArrayOfFolderChangesType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfFolderChangesType"),
    :schema_element => [
      ["folderChange", ["FolderChangeType[]", XSD::QName.new(NsTypes, "FolderChange")], [1, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => WellKnownResponseObjectType,
    :schema_type => XSD::QName.new(NsTypes, "WellKnownResponseObjectType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ResponseObjectType"),
    :schema_element => [
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["sender", ["SingleRecipientType", XSD::QName.new(NsTypes, "Sender")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["referenceItemId", ["ItemIdType", XSD::QName.new(NsTypes, "ReferenceItemId")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ObjectName") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => SmartResponseBaseType,
    :schema_type => XSD::QName.new(NsTypes, "SmartResponseBaseType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ResponseObjectType"),
    :schema_element => [
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["referenceItemId", ["ItemIdType", XSD::QName.new(NsTypes, "ReferenceItemId")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ObjectName") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => SmartResponseType,
    :schema_type => XSD::QName.new(NsTypes, "SmartResponseType"),
    :schema_basetype => XSD::QName.new(NsTypes, "SmartResponseBaseType"),
    :schema_element => [
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["referenceItemId", ["ItemIdType", XSD::QName.new(NsTypes, "ReferenceItemId")], [0, 1]],
      ["newBodyContent", ["BodyType", XSD::QName.new(NsTypes, "NewBodyContent")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ObjectName") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => ReplyToItemType,
    :schema_type => XSD::QName.new(NsTypes, "ReplyToItemType"),
    :schema_basetype => XSD::QName.new(NsTypes, "SmartResponseType"),
    :schema_element => [
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["referenceItemId", ["ItemIdType", XSD::QName.new(NsTypes, "ReferenceItemId")], [0, 1]],
      ["newBodyContent", ["BodyType", XSD::QName.new(NsTypes, "NewBodyContent")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ObjectName") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => ReplyAllToItemType,
    :schema_type => XSD::QName.new(NsTypes, "ReplyAllToItemType"),
    :schema_basetype => XSD::QName.new(NsTypes, "SmartResponseType"),
    :schema_element => [
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["referenceItemId", ["ItemIdType", XSD::QName.new(NsTypes, "ReferenceItemId")], [0, 1]],
      ["newBodyContent", ["BodyType", XSD::QName.new(NsTypes, "NewBodyContent")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ObjectName") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => ForwardItemType,
    :schema_type => XSD::QName.new(NsTypes, "ForwardItemType"),
    :schema_basetype => XSD::QName.new(NsTypes, "SmartResponseType"),
    :schema_element => [
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["referenceItemId", ["ItemIdType", XSD::QName.new(NsTypes, "ReferenceItemId")], [0, 1]],
      ["newBodyContent", ["BodyType", XSD::QName.new(NsTypes, "NewBodyContent")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ObjectName") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => CancelCalendarItemType,
    :schema_type => XSD::QName.new(NsTypes, "CancelCalendarItemType"),
    :schema_basetype => XSD::QName.new(NsTypes, "SmartResponseType"),
    :schema_element => [
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["referenceItemId", ["ItemIdType", XSD::QName.new(NsTypes, "ReferenceItemId")], [0, 1]],
      ["newBodyContent", ["BodyType", XSD::QName.new(NsTypes, "NewBodyContent")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ObjectName") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => ReferenceItemResponseType,
    :schema_type => XSD::QName.new(NsTypes, "ReferenceItemResponseType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ResponseObjectType"),
    :schema_element => [
      ["referenceItemId", ["ItemIdType", XSD::QName.new(NsTypes, "ReferenceItemId")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ObjectName") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => SuppressReadReceiptType,
    :schema_type => XSD::QName.new(NsTypes, "SuppressReadReceiptType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ReferenceItemResponseType"),
    :schema_element => [
      ["referenceItemId", ["ItemIdType", XSD::QName.new(NsTypes, "ReferenceItemId")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ObjectName") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => FindItemParentType,
    :schema_type => XSD::QName.new(NsTypes, "FindItemParentType"),
    :schema_element => [ :choice,
      ["items", ["ArrayOfRealItemsType", XSD::QName.new(NsTypes, "Items")]],
      ["groups", ["ArrayOfGroupedItemsType", XSD::QName.new(NsTypes, "Groups")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "IndexedPagingOffset") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "NumeratorOffset") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "AbsoluteDenominator") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "IncludesLastItemInRange") => "SOAP::SOAPBoolean",
      XSD::QName.new(nil, "TotalItemsInView") => "SOAP::SOAPInt"
    }
  )

  EncodedRegistry.register(
    :class => ItemType,
    :schema_type => XSD::QName.new(NsTypes, "ItemType"),
    :schema_element => [
      ["mimeContent", ["MimeContentType", XSD::QName.new(NsTypes, "MimeContent")], [0, 1]],
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["dateTimeReceived", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeReceived")], [0, 1]],
      ["size", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Size")], [0, 1]],
      ["categories", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Categories")], [0, 1]],
      ["importance", ["ImportanceChoicesType", XSD::QName.new(NsTypes, "Importance")], [0, 1]],
      ["inReplyTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InReplyTo")], [0, 1]],
      ["isSubmitted", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsSubmitted")], [0, 1]],
      ["isDraft", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDraft")], [0, 1]],
      ["isFromMe", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFromMe")], [0, 1]],
      ["isResend", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResend")], [0, 1]],
      ["isUnmodified", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsUnmodified")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["dateTimeSent", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeSent")], [0, 1]],
      ["dateTimeCreated", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeCreated")], [0, 1]],
      ["responseObjects", ["NonEmptyArrayOfResponseObjectsType", XSD::QName.new(NsTypes, "ResponseObjects")], [0, 1]],
      ["reminderDueBy", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "ReminderDueBy")], [0, 1]],
      ["reminderIsSet", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "ReminderIsSet")], [0, 1]],
      ["reminderMinutesBeforeStart", [nil, XSD::QName.new(NsTypes, "ReminderMinutesBeforeStart")], [0, 1]],
      ["displayCc", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayCc")], [0, 1]],
      ["displayTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayTo")], [0, 1]],
      ["hasAttachments", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasAttachments")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["culture", ["SOAP::SOAPLanguage", XSD::QName.new(NsTypes, "Culture")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["lastModifiedName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "LastModifiedName")], [0, 1]],
      ["lastModifiedTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "LastModifiedTime")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => ArrayOfStringsType,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfStringsType"),
    :schema_element => [
      ["string", ["SOAP::SOAPString[]", XSD::QName.new(NsTypes, "String")], [0, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => ArrayOfRealItemsType,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfRealItemsType"),
    :schema_element => [
      [
        ["item", ["ItemType[]", XSD::QName.new(NsTypes, "Item")]],
        ["message", ["MessageType[]", XSD::QName.new(NsTypes, "Message")]],
        ["calendarItem", ["CalendarItemType[]", XSD::QName.new(NsTypes, "CalendarItem")]],
        ["contact", ["ContactItemType[]", XSD::QName.new(NsTypes, "Contact")]],
        ["distributionList", ["DistributionListType[]", XSD::QName.new(NsTypes, "DistributionList")]],
        ["meetingMessage", ["MeetingMessageType[]", XSD::QName.new(NsTypes, "MeetingMessage")]],
        ["meetingRequest", ["MeetingRequestMessageType[]", XSD::QName.new(NsTypes, "MeetingRequest")]],
        ["meetingResponse", ["MeetingResponseMessageType[]", XSD::QName.new(NsTypes, "MeetingResponse")]],
        ["meetingCancellation", ["MeetingCancellationMessageType[]", XSD::QName.new(NsTypes, "MeetingCancellation")]],
        ["task", ["TaskType[]", XSD::QName.new(NsTypes, "Task")]],
        ["postItem", ["PostItemType[]", XSD::QName.new(NsTypes, "PostItem")]]
      ]
    ]
  )

  EncodedRegistry.register(
    :class => NonEmptyArrayOfAllItemsType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfAllItemsType"),
    :schema_element => [
      [
        ["item", ["ItemType[]", XSD::QName.new(NsTypes, "Item")]],
        ["message", ["MessageType[]", XSD::QName.new(NsTypes, "Message")]],
        ["calendarItem", ["CalendarItemType[]", XSD::QName.new(NsTypes, "CalendarItem")]],
        ["contact", ["ContactItemType[]", XSD::QName.new(NsTypes, "Contact")]],
        ["distributionList", ["DistributionListType[]", XSD::QName.new(NsTypes, "DistributionList")]],
        ["meetingMessage", ["MeetingMessageType[]", XSD::QName.new(NsTypes, "MeetingMessage")]],
        ["meetingRequest", ["MeetingRequestMessageType[]", XSD::QName.new(NsTypes, "MeetingRequest")]],
        ["meetingResponse", ["MeetingResponseMessageType[]", XSD::QName.new(NsTypes, "MeetingResponse")]],
        ["meetingCancellation", ["MeetingCancellationMessageType[]", XSD::QName.new(NsTypes, "MeetingCancellation")]],
        ["task", ["TaskType[]", XSD::QName.new(NsTypes, "Task")]],
        ["postItem", ["PostItemType[]", XSD::QName.new(NsTypes, "PostItem")]],
        ["replyToItem", ["ReplyToItemType[]", XSD::QName.new(NsTypes, "ReplyToItem")]],
        ["forwardItem", ["ForwardItemType[]", XSD::QName.new(NsTypes, "ForwardItem")]],
        ["replyAllToItem", ["ReplyAllToItemType[]", XSD::QName.new(NsTypes, "ReplyAllToItem")]],
        ["acceptItem", ["AcceptItemType[]", XSD::QName.new(NsTypes, "AcceptItem")]],
        ["tentativelyAcceptItem", ["TentativelyAcceptItemType[]", XSD::QName.new(NsTypes, "TentativelyAcceptItem")]],
        ["declineItem", ["DeclineItemType[]", XSD::QName.new(NsTypes, "DeclineItem")]],
        ["cancelCalendarItem", ["CancelCalendarItemType[]", XSD::QName.new(NsTypes, "CancelCalendarItem")]],
        ["removeItem", ["RemoveItemType[]", XSD::QName.new(NsTypes, "RemoveItem")]],
        ["suppressReadReceipt", ["SuppressReadReceiptType[]", XSD::QName.new(NsTypes, "SuppressReadReceipt")]],
        ["postReplyItem", ["PostReplyItemType[]", XSD::QName.new(NsTypes, "PostReplyItem")]]
      ]
    ]
  )

  EncodedRegistry.register(
    :class => AcceptItemType,
    :schema_type => XSD::QName.new(NsTypes, "AcceptItemType"),
    :schema_basetype => XSD::QName.new(NsTypes, "WellKnownResponseObjectType"),
    :schema_element => [
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["sender", ["SingleRecipientType", XSD::QName.new(NsTypes, "Sender")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["referenceItemId", ["ItemIdType", XSD::QName.new(NsTypes, "ReferenceItemId")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ObjectName") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => TentativelyAcceptItemType,
    :schema_type => XSD::QName.new(NsTypes, "TentativelyAcceptItemType"),
    :schema_basetype => XSD::QName.new(NsTypes, "WellKnownResponseObjectType"),
    :schema_element => [
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["sender", ["SingleRecipientType", XSD::QName.new(NsTypes, "Sender")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["referenceItemId", ["ItemIdType", XSD::QName.new(NsTypes, "ReferenceItemId")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ObjectName") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => DeclineItemType,
    :schema_type => XSD::QName.new(NsTypes, "DeclineItemType"),
    :schema_basetype => XSD::QName.new(NsTypes, "WellKnownResponseObjectType"),
    :schema_element => [
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["sender", ["SingleRecipientType", XSD::QName.new(NsTypes, "Sender")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["referenceItemId", ["ItemIdType", XSD::QName.new(NsTypes, "ReferenceItemId")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ObjectName") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => RemoveItemType,
    :schema_type => XSD::QName.new(NsTypes, "RemoveItemType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ResponseObjectType"),
    :schema_element => [
      ["mimeContent", ["MimeContentType", XSD::QName.new(NsTypes, "MimeContent")], [0, 1]],
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["dateTimeReceived", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeReceived")], [0, 1]],
      ["size", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Size")], [0, 1]],
      ["categories", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Categories")], [0, 1]],
      ["importance", ["ImportanceChoicesType", XSD::QName.new(NsTypes, "Importance")], [0, 1]],
      ["inReplyTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InReplyTo")], [0, 1]],
      ["isSubmitted", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsSubmitted")], [0, 1]],
      ["isDraft", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDraft")], [0, 1]],
      ["isFromMe", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFromMe")], [0, 1]],
      ["isResend", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResend")], [0, 1]],
      ["isUnmodified", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsUnmodified")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["dateTimeSent", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeSent")], [0, 1]],
      ["dateTimeCreated", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeCreated")], [0, 1]],
      ["responseObjects", ["NonEmptyArrayOfResponseObjectsType", XSD::QName.new(NsTypes, "ResponseObjects")], [0, 1]],
      ["reminderDueBy", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "ReminderDueBy")], [0, 1]],
      ["reminderIsSet", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "ReminderIsSet")], [0, 1]],
      ["reminderMinutesBeforeStart", [nil, XSD::QName.new(NsTypes, "ReminderMinutesBeforeStart")], [0, 1]],
      ["displayCc", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayCc")], [0, 1]],
      ["displayTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayTo")], [0, 1]],
      ["hasAttachments", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasAttachments")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["culture", ["SOAP::SOAPLanguage", XSD::QName.new(NsTypes, "Culture")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["lastModifiedName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "LastModifiedName")], [0, 1]],
      ["lastModifiedTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "LastModifiedTime")], [0, 1]],
      ["sender", ["SingleRecipientType", XSD::QName.new(NsTypes, "Sender")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["conversationIndex", ["SOAP::SOAPBase64", XSD::QName.new(NsTypes, "ConversationIndex")], [0, 1]],
      ["conversationTopic", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ConversationTopic")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["internetMessageId", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InternetMessageId")], [0, 1]],
      ["isRead", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsRead")], [0, 1]],
      ["isResponseRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResponseRequested")], [0, 1]],
      ["references", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "References")], [0, 1]],
      ["replyTo", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ReplyTo")], [0, 1]],
      ["receivedBy", ["SingleRecipientType", XSD::QName.new(NsTypes, "ReceivedBy")], [0, 1]],
      ["receivedRepresenting", ["SingleRecipientType", XSD::QName.new(NsTypes, "ReceivedRepresenting")], [0, 1]],
      ["referenceItemId", ["ItemIdType", XSD::QName.new(NsTypes, "ReferenceItemId")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ObjectName") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => PostReplyItemBaseType,
    :schema_type => XSD::QName.new(NsTypes, "PostReplyItemBaseType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ResponseObjectType"),
    :schema_element => [
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["referenceItemId", ["ItemIdType", XSD::QName.new(NsTypes, "ReferenceItemId")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ObjectName") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => PostReplyItemType,
    :schema_type => XSD::QName.new(NsTypes, "PostReplyItemType"),
    :schema_basetype => XSD::QName.new(NsTypes, "PostReplyItemBaseType"),
    :schema_element => [
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["referenceItemId", ["ItemIdType", XSD::QName.new(NsTypes, "ReferenceItemId")], [0, 1]],
      ["newBodyContent", ["BodyType", XSD::QName.new(NsTypes, "NewBodyContent")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ObjectName") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => MimeContentType,
    :schema_type => XSD::QName.new(NsTypes, "MimeContentType"),
    :schema_attribute => {
      XSD::QName.new(nil, "CharacterSet") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => MessageType,
    :schema_type => XSD::QName.new(NsTypes, "MessageType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ItemType"),
    :schema_element => [
      ["mimeContent", ["MimeContentType", XSD::QName.new(NsTypes, "MimeContent")], [0, 1]],
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["dateTimeReceived", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeReceived")], [0, 1]],
      ["size", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Size")], [0, 1]],
      ["categories", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Categories")], [0, 1]],
      ["importance", ["ImportanceChoicesType", XSD::QName.new(NsTypes, "Importance")], [0, 1]],
      ["inReplyTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InReplyTo")], [0, 1]],
      ["isSubmitted", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsSubmitted")], [0, 1]],
      ["isDraft", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDraft")], [0, 1]],
      ["isFromMe", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFromMe")], [0, 1]],
      ["isResend", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResend")], [0, 1]],
      ["isUnmodified", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsUnmodified")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["dateTimeSent", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeSent")], [0, 1]],
      ["dateTimeCreated", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeCreated")], [0, 1]],
      ["responseObjects", ["NonEmptyArrayOfResponseObjectsType", XSD::QName.new(NsTypes, "ResponseObjects")], [0, 1]],
      ["reminderDueBy", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "ReminderDueBy")], [0, 1]],
      ["reminderIsSet", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "ReminderIsSet")], [0, 1]],
      ["reminderMinutesBeforeStart", [nil, XSD::QName.new(NsTypes, "ReminderMinutesBeforeStart")], [0, 1]],
      ["displayCc", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayCc")], [0, 1]],
      ["displayTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayTo")], [0, 1]],
      ["hasAttachments", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasAttachments")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["culture", ["SOAP::SOAPLanguage", XSD::QName.new(NsTypes, "Culture")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["lastModifiedName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "LastModifiedName")], [0, 1]],
      ["lastModifiedTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "LastModifiedTime")], [0, 1]],
      ["sender", ["SingleRecipientType", XSD::QName.new(NsTypes, "Sender")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["conversationIndex", ["SOAP::SOAPBase64", XSD::QName.new(NsTypes, "ConversationIndex")], [0, 1]],
      ["conversationTopic", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ConversationTopic")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["internetMessageId", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InternetMessageId")], [0, 1]],
      ["isRead", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsRead")], [0, 1]],
      ["isResponseRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResponseRequested")], [0, 1]],
      ["references", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "References")], [0, 1]],
      ["replyTo", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ReplyTo")], [0, 1]],
      ["receivedBy", ["SingleRecipientType", XSD::QName.new(NsTypes, "ReceivedBy")], [0, 1]],
      ["receivedRepresenting", ["SingleRecipientType", XSD::QName.new(NsTypes, "ReceivedRepresenting")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => TaskType,
    :schema_type => XSD::QName.new(NsTypes, "TaskType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ItemType"),
    :schema_element => [
      ["mimeContent", ["MimeContentType", XSD::QName.new(NsTypes, "MimeContent")], [0, 1]],
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["dateTimeReceived", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeReceived")], [0, 1]],
      ["size", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Size")], [0, 1]],
      ["categories", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Categories")], [0, 1]],
      ["importance", ["ImportanceChoicesType", XSD::QName.new(NsTypes, "Importance")], [0, 1]],
      ["inReplyTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InReplyTo")], [0, 1]],
      ["isSubmitted", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsSubmitted")], [0, 1]],
      ["isDraft", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDraft")], [0, 1]],
      ["isFromMe", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFromMe")], [0, 1]],
      ["isResend", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResend")], [0, 1]],
      ["isUnmodified", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsUnmodified")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["dateTimeSent", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeSent")], [0, 1]],
      ["dateTimeCreated", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeCreated")], [0, 1]],
      ["responseObjects", ["NonEmptyArrayOfResponseObjectsType", XSD::QName.new(NsTypes, "ResponseObjects")], [0, 1]],
      ["reminderDueBy", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "ReminderDueBy")], [0, 1]],
      ["reminderIsSet", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "ReminderIsSet")], [0, 1]],
      ["reminderMinutesBeforeStart", [nil, XSD::QName.new(NsTypes, "ReminderMinutesBeforeStart")], [0, 1]],
      ["displayCc", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayCc")], [0, 1]],
      ["displayTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayTo")], [0, 1]],
      ["hasAttachments", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasAttachments")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["culture", ["SOAP::SOAPLanguage", XSD::QName.new(NsTypes, "Culture")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["lastModifiedName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "LastModifiedName")], [0, 1]],
      ["lastModifiedTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "LastModifiedTime")], [0, 1]],
      ["actualWork", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "ActualWork")], [0, 1]],
      ["assignedTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "AssignedTime")], [0, 1]],
      ["billingInformation", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "BillingInformation")], [0, 1]],
      ["changeCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "ChangeCount")], [0, 1]],
      ["companies", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Companies")], [0, 1]],
      ["completeDate", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "CompleteDate")], [0, 1]],
      ["contacts", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Contacts")], [0, 1]],
      ["delegationState", ["TaskDelegateStateType", XSD::QName.new(NsTypes, "DelegationState")], [0, 1]],
      ["delegator", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Delegator")], [0, 1]],
      ["dueDate", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DueDate")], [0, 1]],
      ["isAssignmentEditable", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "IsAssignmentEditable")], [0, 1]],
      ["isComplete", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsComplete")], [0, 1]],
      ["isRecurring", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsRecurring")], [0, 1]],
      ["isTeamTask", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsTeamTask")], [0, 1]],
      ["mileage", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Mileage")], [0, 1]],
      ["owner", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Owner")], [0, 1]],
      ["percentComplete", ["SOAP::SOAPDouble", XSD::QName.new(NsTypes, "PercentComplete")], [0, 1]],
      ["recurrence", ["TaskRecurrenceType", XSD::QName.new(NsTypes, "Recurrence")], [0, 1]],
      ["startDate", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "StartDate")], [0, 1]],
      ["status", ["TaskStatusType", XSD::QName.new(NsTypes, "Status")], [0, 1]],
      ["statusDescription", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "StatusDescription")], [0, 1]],
      ["totalWork", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "TotalWork")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => PostItemType,
    :schema_type => XSD::QName.new(NsTypes, "PostItemType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ItemType"),
    :schema_element => [
      ["mimeContent", ["MimeContentType", XSD::QName.new(NsTypes, "MimeContent")], [0, 1]],
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["dateTimeReceived", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeReceived")], [0, 1]],
      ["size", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Size")], [0, 1]],
      ["categories", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Categories")], [0, 1]],
      ["importance", ["ImportanceChoicesType", XSD::QName.new(NsTypes, "Importance")], [0, 1]],
      ["inReplyTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InReplyTo")], [0, 1]],
      ["isSubmitted", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsSubmitted")], [0, 1]],
      ["isDraft", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDraft")], [0, 1]],
      ["isFromMe", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFromMe")], [0, 1]],
      ["isResend", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResend")], [0, 1]],
      ["isUnmodified", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsUnmodified")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["dateTimeSent", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeSent")], [0, 1]],
      ["dateTimeCreated", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeCreated")], [0, 1]],
      ["responseObjects", ["NonEmptyArrayOfResponseObjectsType", XSD::QName.new(NsTypes, "ResponseObjects")], [0, 1]],
      ["reminderDueBy", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "ReminderDueBy")], [0, 1]],
      ["reminderIsSet", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "ReminderIsSet")], [0, 1]],
      ["reminderMinutesBeforeStart", [nil, XSD::QName.new(NsTypes, "ReminderMinutesBeforeStart")], [0, 1]],
      ["displayCc", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayCc")], [0, 1]],
      ["displayTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayTo")], [0, 1]],
      ["hasAttachments", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasAttachments")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["culture", ["SOAP::SOAPLanguage", XSD::QName.new(NsTypes, "Culture")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["lastModifiedName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "LastModifiedName")], [0, 1]],
      ["lastModifiedTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "LastModifiedTime")], [0, 1]],
      ["conversationIndex", ["SOAP::SOAPBase64", XSD::QName.new(NsTypes, "ConversationIndex")], [0, 1]],
      ["conversationTopic", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ConversationTopic")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["internetMessageId", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InternetMessageId")], [0, 1]],
      ["isRead", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsRead")], [0, 1]],
      ["postedTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "PostedTime")], [0, 1]],
      ["references", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "References")], [0, 1]],
      ["sender", ["SingleRecipientType", XSD::QName.new(NsTypes, "Sender")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => IndexedPageViewType,
    :schema_type => XSD::QName.new(NsTypes, "IndexedPageViewType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BasePagingType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "MaxEntriesReturned") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "Offset") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "BasePoint") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => FractionalPageViewType,
    :schema_type => XSD::QName.new(NsTypes, "FractionalPageViewType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BasePagingType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "MaxEntriesReturned") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "Numerator") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "Denominator") => "SOAP::SOAPInt"
    }
  )

  EncodedRegistry.register(
    :class => CalendarViewType,
    :schema_type => XSD::QName.new(NsTypes, "CalendarViewType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BasePagingType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "MaxEntriesReturned") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "StartDate") => "SOAP::SOAPDateTime",
      XSD::QName.new(nil, "EndDate") => "SOAP::SOAPDateTime"
    }
  )

  EncodedRegistry.register(
    :class => ContactsViewType,
    :schema_type => XSD::QName.new(NsTypes, "ContactsViewType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BasePagingType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "MaxEntriesReturned") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "InitialName") => "SOAP::SOAPString",
      XSD::QName.new(nil, "FinalName") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => ResolutionType,
    :schema_type => XSD::QName.new(NsTypes, "ResolutionType"),
    :schema_element => [
      ["mailbox", ["EmailAddressType", XSD::QName.new(NsTypes, "Mailbox")]],
      ["contact", ["ContactItemType", XSD::QName.new(NsTypes, "Contact")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => ArrayOfResolutionType,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfResolutionType"),
    :schema_element => [
      ["resolution", ["ResolutionType[]", XSD::QName.new(NsTypes, "Resolution")], [0, 100]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "IndexedPagingOffset") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "NumeratorOffset") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "AbsoluteDenominator") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "IncludesLastItemInRange") => "SOAP::SOAPBoolean",
      XSD::QName.new(nil, "TotalItemsInView") => "SOAP::SOAPInt"
    }
  )

  EncodedRegistry.register(
    :class => ArrayOfDLExpansionType,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfDLExpansionType"),
    :schema_element => [
      ["mailbox", ["EmailAddressType[]", XSD::QName.new(NsTypes, "Mailbox")], [0, nil]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "IndexedPagingOffset") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "NumeratorOffset") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "AbsoluteDenominator") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "IncludesLastItemInRange") => "SOAP::SOAPBoolean",
      XSD::QName.new(nil, "TotalItemsInView") => "SOAP::SOAPInt"
    }
  )

  EncodedRegistry.register(
    :class => AttendeeType,
    :schema_type => XSD::QName.new(NsTypes, "AttendeeType"),
    :schema_element => [
      ["mailbox", ["EmailAddressType", XSD::QName.new(NsTypes, "Mailbox")]],
      ["responseType", ["ResponseTypeType", XSD::QName.new(NsTypes, "ResponseType")], [0, 1]],
      ["lastResponseTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "LastResponseTime")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => NonEmptyArrayOfAttendeesType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfAttendeesType"),
    :schema_element => [
      ["attendee", ["AttendeeType[]", XSD::QName.new(NsTypes, "Attendee")], [1, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => OccurrenceItemIdType,
    :schema_type => XSD::QName.new(NsTypes, "OccurrenceItemIdType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseItemIdType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "RecurringMasterId") => "SOAP::SOAPString",
      XSD::QName.new(nil, "ChangeKey") => "SOAP::SOAPString",
      XSD::QName.new(nil, "InstanceIndex") => "SOAP::SOAPInt"
    }
  )

  EncodedRegistry.register(
    :class => RecurringMasterItemIdType,
    :schema_type => XSD::QName.new(NsTypes, "RecurringMasterItemIdType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseItemIdType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "OccurrenceId") => "SOAP::SOAPString",
      XSD::QName.new(nil, "ChangeKey") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => DailyRegeneratingPatternType,
    :schema_type => XSD::QName.new(NsTypes, "DailyRegeneratingPatternType"),
    :schema_basetype => XSD::QName.new(NsTypes, "RegeneratingPatternBaseType"),
    :schema_element => [
      ["interval", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Interval")]]
    ]
  )

  EncodedRegistry.register(
    :class => WeeklyRegeneratingPatternType,
    :schema_type => XSD::QName.new(NsTypes, "WeeklyRegeneratingPatternType"),
    :schema_basetype => XSD::QName.new(NsTypes, "RegeneratingPatternBaseType"),
    :schema_element => [
      ["interval", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Interval")]]
    ]
  )

  EncodedRegistry.register(
    :class => MonthlyRegeneratingPatternType,
    :schema_type => XSD::QName.new(NsTypes, "MonthlyRegeneratingPatternType"),
    :schema_basetype => XSD::QName.new(NsTypes, "RegeneratingPatternBaseType"),
    :schema_element => [
      ["interval", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Interval")]]
    ]
  )

  EncodedRegistry.register(
    :class => YearlyRegeneratingPatternType,
    :schema_type => XSD::QName.new(NsTypes, "YearlyRegeneratingPatternType"),
    :schema_basetype => XSD::QName.new(NsTypes, "RegeneratingPatternBaseType"),
    :schema_element => [
      ["interval", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Interval")]]
    ]
  )

  EncodedRegistry.register(
    :class => RelativeYearlyRecurrencePatternType,
    :schema_type => XSD::QName.new(NsTypes, "RelativeYearlyRecurrencePatternType"),
    :schema_basetype => XSD::QName.new(NsTypes, "RecurrencePatternBaseType"),
    :schema_element => [
      ["daysOfWeek", ["DayOfWeekType", XSD::QName.new(NsTypes, "DaysOfWeek")]],
      ["dayOfWeekIndex", ["DayOfWeekIndexType", XSD::QName.new(NsTypes, "DayOfWeekIndex")]],
      ["month", ["MonthNamesType", XSD::QName.new(NsTypes, "Month")]]
    ]
  )

  EncodedRegistry.register(
    :class => AbsoluteYearlyRecurrencePatternType,
    :schema_type => XSD::QName.new(NsTypes, "AbsoluteYearlyRecurrencePatternType"),
    :schema_basetype => XSD::QName.new(NsTypes, "RecurrencePatternBaseType"),
    :schema_element => [
      ["dayOfMonth", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "DayOfMonth")]],
      ["month", ["MonthNamesType", XSD::QName.new(NsTypes, "Month")]]
    ]
  )

  EncodedRegistry.register(
    :class => RelativeMonthlyRecurrencePatternType,
    :schema_type => XSD::QName.new(NsTypes, "RelativeMonthlyRecurrencePatternType"),
    :schema_basetype => XSD::QName.new(NsTypes, "IntervalRecurrencePatternBaseType"),
    :schema_element => [
      ["interval", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Interval")]],
      ["daysOfWeek", ["DayOfWeekType", XSD::QName.new(NsTypes, "DaysOfWeek")]],
      ["dayOfWeekIndex", ["DayOfWeekIndexType", XSD::QName.new(NsTypes, "DayOfWeekIndex")]]
    ]
  )

  EncodedRegistry.register(
    :class => AbsoluteMonthlyRecurrencePatternType,
    :schema_type => XSD::QName.new(NsTypes, "AbsoluteMonthlyRecurrencePatternType"),
    :schema_basetype => XSD::QName.new(NsTypes, "IntervalRecurrencePatternBaseType"),
    :schema_element => [
      ["interval", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Interval")]],
      ["dayOfMonth", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "DayOfMonth")]]
    ]
  )

  EncodedRegistry.register(
    :class => WeeklyRecurrencePatternType,
    :schema_type => XSD::QName.new(NsTypes, "WeeklyRecurrencePatternType"),
    :schema_basetype => XSD::QName.new(NsTypes, "IntervalRecurrencePatternBaseType"),
    :schema_element => [
      ["interval", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Interval")]],
      ["daysOfWeek", [nil, XSD::QName.new(NsTypes, "DaysOfWeek")]]
    ]
  )

  EncodedRegistry.register(
    :class => DailyRecurrencePatternType,
    :schema_type => XSD::QName.new(NsTypes, "DailyRecurrencePatternType"),
    :schema_basetype => XSD::QName.new(NsTypes, "IntervalRecurrencePatternBaseType"),
    :schema_element => [
      ["interval", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Interval")]]
    ]
  )

  EncodedRegistry.register(
    :class => TimeChangeType,
    :schema_type => XSD::QName.new(NsTypes, "TimeChangeType"),
    :schema_element => [
      ["offset", ["SOAP::SOAPDuration", XSD::QName.new(NsTypes, "Offset")]],
      [ :choice,
        ["relativeYearlyRecurrence", ["RelativeYearlyRecurrencePatternType", XSD::QName.new(NsTypes, "RelativeYearlyRecurrence")]],
        ["absoluteDate", ["SOAP::SOAPDate", XSD::QName.new(NsTypes, "AbsoluteDate")]]
      ],
      ["time", ["SOAP::SOAPTime", XSD::QName.new(NsTypes, "Time")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "TimeZoneName") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => TimeZoneType,
    :schema_type => XSD::QName.new(NsTypes, "TimeZoneType"),
    :schema_element => [
      ["baseOffset", ["SOAP::SOAPDuration", XSD::QName.new(NsTypes, "BaseOffset")]],
      [
        ["standard", ["TimeChangeType", XSD::QName.new(NsTypes, "Standard")]],
        ["daylight", ["TimeChangeType", XSD::QName.new(NsTypes, "Daylight")]]
      ]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "TimeZoneName") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => NoEndRecurrenceRangeType,
    :schema_type => XSD::QName.new(NsTypes, "NoEndRecurrenceRangeType"),
    :schema_basetype => XSD::QName.new(NsTypes, "RecurrenceRangeBaseType"),
    :schema_element => [
      ["startDate", ["SOAP::SOAPDate", XSD::QName.new(NsTypes, "StartDate")]]
    ]
  )

  EncodedRegistry.register(
    :class => EndDateRecurrenceRangeType,
    :schema_type => XSD::QName.new(NsTypes, "EndDateRecurrenceRangeType"),
    :schema_basetype => XSD::QName.new(NsTypes, "RecurrenceRangeBaseType"),
    :schema_element => [
      ["startDate", ["SOAP::SOAPDate", XSD::QName.new(NsTypes, "StartDate")]],
      ["endDate", ["SOAP::SOAPDate", XSD::QName.new(NsTypes, "EndDate")]]
    ]
  )

  EncodedRegistry.register(
    :class => NumberedRecurrenceRangeType,
    :schema_type => XSD::QName.new(NsTypes, "NumberedRecurrenceRangeType"),
    :schema_basetype => XSD::QName.new(NsTypes, "RecurrenceRangeBaseType"),
    :schema_element => [
      ["startDate", ["SOAP::SOAPDate", XSD::QName.new(NsTypes, "StartDate")]],
      ["numberOfOccurrences", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "NumberOfOccurrences")]]
    ]
  )

  EncodedRegistry.register(
    :class => RecurrenceType,
    :schema_type => XSD::QName.new(NsTypes, "RecurrenceType"),
    :schema_element => [
      [ :choice,
        ["relativeYearlyRecurrence", ["RelativeYearlyRecurrencePatternType", XSD::QName.new(NsTypes, "RelativeYearlyRecurrence")]],
        ["absoluteYearlyRecurrence", ["AbsoluteYearlyRecurrencePatternType", XSD::QName.new(NsTypes, "AbsoluteYearlyRecurrence")]],
        ["relativeMonthlyRecurrence", ["RelativeMonthlyRecurrencePatternType", XSD::QName.new(NsTypes, "RelativeMonthlyRecurrence")]],
        ["absoluteMonthlyRecurrence", ["AbsoluteMonthlyRecurrencePatternType", XSD::QName.new(NsTypes, "AbsoluteMonthlyRecurrence")]],
        ["weeklyRecurrence", ["WeeklyRecurrencePatternType", XSD::QName.new(NsTypes, "WeeklyRecurrence")]],
        ["dailyRecurrence", ["DailyRecurrencePatternType", XSD::QName.new(NsTypes, "DailyRecurrence")]]
      ],
      [ :choice,
        ["noEndRecurrence", ["NoEndRecurrenceRangeType", XSD::QName.new(NsTypes, "NoEndRecurrence")]],
        ["endDateRecurrence", ["EndDateRecurrenceRangeType", XSD::QName.new(NsTypes, "EndDateRecurrence")]],
        ["numberedRecurrence", ["NumberedRecurrenceRangeType", XSD::QName.new(NsTypes, "NumberedRecurrence")]]
      ]
    ]
  )

  EncodedRegistry.register(
    :class => TaskRecurrenceType,
    :schema_type => XSD::QName.new(NsTypes, "TaskRecurrenceType"),
    :schema_element => [
      [ :choice,
        ["relativeYearlyRecurrence", ["RelativeYearlyRecurrencePatternType", XSD::QName.new(NsTypes, "RelativeYearlyRecurrence")]],
        ["absoluteYearlyRecurrence", ["AbsoluteYearlyRecurrencePatternType", XSD::QName.new(NsTypes, "AbsoluteYearlyRecurrence")]],
        ["relativeMonthlyRecurrence", ["RelativeMonthlyRecurrencePatternType", XSD::QName.new(NsTypes, "RelativeMonthlyRecurrence")]],
        ["absoluteMonthlyRecurrence", ["AbsoluteMonthlyRecurrencePatternType", XSD::QName.new(NsTypes, "AbsoluteMonthlyRecurrence")]],
        ["weeklyRecurrence", ["WeeklyRecurrencePatternType", XSD::QName.new(NsTypes, "WeeklyRecurrence")]],
        ["dailyRecurrence", ["DailyRecurrencePatternType", XSD::QName.new(NsTypes, "DailyRecurrence")]],
        ["dailyRegeneration", ["DailyRegeneratingPatternType", XSD::QName.new(NsTypes, "DailyRegeneration")]],
        ["weeklyRegeneration", ["WeeklyRegeneratingPatternType", XSD::QName.new(NsTypes, "WeeklyRegeneration")]],
        ["monthlyRegeneration", ["MonthlyRegeneratingPatternType", XSD::QName.new(NsTypes, "MonthlyRegeneration")]],
        ["yearlyRegeneration", ["YearlyRegeneratingPatternType", XSD::QName.new(NsTypes, "YearlyRegeneration")]]
      ],
      [ :choice,
        ["noEndRecurrence", ["NoEndRecurrenceRangeType", XSD::QName.new(NsTypes, "NoEndRecurrence")]],
        ["endDateRecurrence", ["EndDateRecurrenceRangeType", XSD::QName.new(NsTypes, "EndDateRecurrence")]],
        ["numberedRecurrence", ["NumberedRecurrenceRangeType", XSD::QName.new(NsTypes, "NumberedRecurrence")]]
      ]
    ]
  )

  EncodedRegistry.register(
    :class => OccurrenceInfoType,
    :schema_type => XSD::QName.new(NsTypes, "OccurrenceInfoType"),
    :schema_element => [
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")]],
      ["start", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "Start")]],
      ["v_end", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "End")]],
      ["originalStart", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "OriginalStart")]]
    ]
  )

  EncodedRegistry.register(
    :class => NonEmptyArrayOfOccurrenceInfoType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfOccurrenceInfoType"),
    :schema_element => [
      ["occurrence", ["OccurrenceInfoType[]", XSD::QName.new(NsTypes, "Occurrence")], [1, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => DeletedOccurrenceInfoType,
    :schema_type => XSD::QName.new(NsTypes, "DeletedOccurrenceInfoType"),
    :schema_element => [
      ["start", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "Start")]]
    ]
  )

  EncodedRegistry.register(
    :class => NonEmptyArrayOfDeletedOccurrencesType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfDeletedOccurrencesType"),
    :schema_element => [
      ["deletedOccurrence", ["DeletedOccurrenceInfoType[]", XSD::QName.new(NsTypes, "DeletedOccurrence")], [1, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => CalendarItemType,
    :schema_type => XSD::QName.new(NsTypes, "CalendarItemType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ItemType"),
    :schema_element => [
      ["mimeContent", ["MimeContentType", XSD::QName.new(NsTypes, "MimeContent")], [0, 1]],
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["dateTimeReceived", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeReceived")], [0, 1]],
      ["size", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Size")], [0, 1]],
      ["categories", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Categories")], [0, 1]],
      ["importance", ["ImportanceChoicesType", XSD::QName.new(NsTypes, "Importance")], [0, 1]],
      ["inReplyTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InReplyTo")], [0, 1]],
      ["isSubmitted", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsSubmitted")], [0, 1]],
      ["isDraft", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDraft")], [0, 1]],
      ["isFromMe", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFromMe")], [0, 1]],
      ["isResend", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResend")], [0, 1]],
      ["isUnmodified", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsUnmodified")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["dateTimeSent", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeSent")], [0, 1]],
      ["dateTimeCreated", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeCreated")], [0, 1]],
      ["responseObjects", ["NonEmptyArrayOfResponseObjectsType", XSD::QName.new(NsTypes, "ResponseObjects")], [0, 1]],
      ["reminderDueBy", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "ReminderDueBy")], [0, 1]],
      ["reminderIsSet", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "ReminderIsSet")], [0, 1]],
      ["reminderMinutesBeforeStart", [nil, XSD::QName.new(NsTypes, "ReminderMinutesBeforeStart")], [0, 1]],
      ["displayCc", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayCc")], [0, 1]],
      ["displayTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayTo")], [0, 1]],
      ["hasAttachments", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasAttachments")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["culture", ["SOAP::SOAPLanguage", XSD::QName.new(NsTypes, "Culture")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["lastModifiedName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "LastModifiedName")], [0, 1]],
      ["lastModifiedTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "LastModifiedTime")], [0, 1]],
      ["uID", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "UID")], [0, 1]],
      ["recurrenceId", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "RecurrenceId")], [0, 1]],
      ["dateTimeStamp", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeStamp")], [0, 1]],
      ["start", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "Start")], [0, 1]],
      ["v_end", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "End")], [0, 1]],
      ["originalStart", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "OriginalStart")], [0, 1]],
      ["isAllDayEvent", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsAllDayEvent")], [0, 1]],
      ["legacyFreeBusyStatus", ["LegacyFreeBusyType", XSD::QName.new(NsTypes, "LegacyFreeBusyStatus")], [0, 1]],
      ["location", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Location")], [0, 1]],
      ["v_when", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "When")], [0, 1]],
      ["isMeeting", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsMeeting")], [0, 1]],
      ["isCancelled", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsCancelled")], [0, 1]],
      ["isRecurring", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsRecurring")], [0, 1]],
      ["meetingRequestWasSent", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "MeetingRequestWasSent")], [0, 1]],
      ["isResponseRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResponseRequested")], [0, 1]],
      ["calendarItemType", ["CalendarItemTypeType", XSD::QName.new(NsTypes, "CalendarItemType")], [0, 1]],
      ["myResponseType", ["ResponseTypeType", XSD::QName.new(NsTypes, "MyResponseType")], [0, 1]],
      ["organizer", ["SingleRecipientType", XSD::QName.new(NsTypes, "Organizer")], [0, 1]],
      ["requiredAttendees", ["NonEmptyArrayOfAttendeesType", XSD::QName.new(NsTypes, "RequiredAttendees")], [0, 1]],
      ["optionalAttendees", ["NonEmptyArrayOfAttendeesType", XSD::QName.new(NsTypes, "OptionalAttendees")], [0, 1]],
      ["resources", ["NonEmptyArrayOfAttendeesType", XSD::QName.new(NsTypes, "Resources")], [0, 1]],
      ["conflictingMeetingCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "ConflictingMeetingCount")], [0, 1]],
      ["adjacentMeetingCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "AdjacentMeetingCount")], [0, 1]],
      ["conflictingMeetings", ["NonEmptyArrayOfAllItemsType", XSD::QName.new(NsTypes, "ConflictingMeetings")], [0, 1]],
      ["adjacentMeetings", ["NonEmptyArrayOfAllItemsType", XSD::QName.new(NsTypes, "AdjacentMeetings")], [0, 1]],
      ["duration", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Duration")], [0, 1]],
      ["timeZone", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "TimeZone")], [0, 1]],
      ["appointmentReplyTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "AppointmentReplyTime")], [0, 1]],
      ["appointmentSequenceNumber", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "AppointmentSequenceNumber")], [0, 1]],
      ["appointmentState", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "AppointmentState")], [0, 1]],
      ["recurrence", ["RecurrenceType", XSD::QName.new(NsTypes, "Recurrence")], [0, 1]],
      ["firstOccurrence", ["OccurrenceInfoType", XSD::QName.new(NsTypes, "FirstOccurrence")], [0, 1]],
      ["lastOccurrence", ["OccurrenceInfoType", XSD::QName.new(NsTypes, "LastOccurrence")], [0, 1]],
      ["modifiedOccurrences", ["NonEmptyArrayOfOccurrenceInfoType", XSD::QName.new(NsTypes, "ModifiedOccurrences")], [0, 1]],
      ["deletedOccurrences", ["NonEmptyArrayOfDeletedOccurrencesType", XSD::QName.new(NsTypes, "DeletedOccurrences")], [0, 1]],
      ["meetingTimeZone", ["TimeZoneType", XSD::QName.new(NsTypes, "MeetingTimeZone")], [0, 1]],
      ["conferenceType", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "ConferenceType")], [0, 1]],
      ["allowNewTimeProposal", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "AllowNewTimeProposal")], [0, 1]],
      ["isOnlineMeeting", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsOnlineMeeting")], [0, 1]],
      ["meetingWorkspaceUrl", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "MeetingWorkspaceUrl")], [0, 1]],
      ["netShowUrl", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "NetShowUrl")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => MeetingMessageType,
    :schema_type => XSD::QName.new(NsTypes, "MeetingMessageType"),
    :schema_basetype => XSD::QName.new(NsTypes, "MessageType"),
    :schema_element => [
      ["mimeContent", ["MimeContentType", XSD::QName.new(NsTypes, "MimeContent")], [0, 1]],
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["dateTimeReceived", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeReceived")], [0, 1]],
      ["size", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Size")], [0, 1]],
      ["categories", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Categories")], [0, 1]],
      ["importance", ["ImportanceChoicesType", XSD::QName.new(NsTypes, "Importance")], [0, 1]],
      ["inReplyTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InReplyTo")], [0, 1]],
      ["isSubmitted", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsSubmitted")], [0, 1]],
      ["isDraft", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDraft")], [0, 1]],
      ["isFromMe", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFromMe")], [0, 1]],
      ["isResend", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResend")], [0, 1]],
      ["isUnmodified", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsUnmodified")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["dateTimeSent", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeSent")], [0, 1]],
      ["dateTimeCreated", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeCreated")], [0, 1]],
      ["responseObjects", ["NonEmptyArrayOfResponseObjectsType", XSD::QName.new(NsTypes, "ResponseObjects")], [0, 1]],
      ["reminderDueBy", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "ReminderDueBy")], [0, 1]],
      ["reminderIsSet", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "ReminderIsSet")], [0, 1]],
      ["reminderMinutesBeforeStart", [nil, XSD::QName.new(NsTypes, "ReminderMinutesBeforeStart")], [0, 1]],
      ["displayCc", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayCc")], [0, 1]],
      ["displayTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayTo")], [0, 1]],
      ["hasAttachments", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasAttachments")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["culture", ["SOAP::SOAPLanguage", XSD::QName.new(NsTypes, "Culture")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["lastModifiedName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "LastModifiedName")], [0, 1]],
      ["lastModifiedTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "LastModifiedTime")], [0, 1]],
      ["sender", ["SingleRecipientType", XSD::QName.new(NsTypes, "Sender")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["conversationIndex", ["SOAP::SOAPBase64", XSD::QName.new(NsTypes, "ConversationIndex")], [0, 1]],
      ["conversationTopic", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ConversationTopic")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["internetMessageId", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InternetMessageId")], [0, 1]],
      ["isRead", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsRead")], [0, 1]],
      ["isResponseRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResponseRequested")], [0, 1]],
      ["references", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "References")], [0, 1]],
      ["replyTo", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ReplyTo")], [0, 1]],
      ["receivedBy", ["SingleRecipientType", XSD::QName.new(NsTypes, "ReceivedBy")], [0, 1]],
      ["receivedRepresenting", ["SingleRecipientType", XSD::QName.new(NsTypes, "ReceivedRepresenting")], [0, 1]],
      ["associatedCalendarItemId", ["ItemIdType", XSD::QName.new(NsTypes, "AssociatedCalendarItemId")], [0, 1]],
      ["isDelegated", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDelegated")], [0, 1]],
      ["isOutOfDate", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsOutOfDate")], [0, 1]],
      ["hasBeenProcessed", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasBeenProcessed")], [0, 1]],
      ["responseType", ["ResponseTypeType", XSD::QName.new(NsTypes, "ResponseType")], [0, 1]],
      ["uID", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "UID")], [0, 1]],
      ["recurrenceId", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "RecurrenceId")], [0, 1]],
      ["dateTimeStamp", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeStamp")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => MeetingRequestMessageType,
    :schema_type => XSD::QName.new(NsTypes, "MeetingRequestMessageType"),
    :schema_basetype => XSD::QName.new(NsTypes, "MeetingMessageType"),
    :schema_element => [
      ["mimeContent", ["MimeContentType", XSD::QName.new(NsTypes, "MimeContent")], [0, 1]],
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["dateTimeReceived", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeReceived")], [0, 1]],
      ["size", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Size")], [0, 1]],
      ["categories", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Categories")], [0, 1]],
      ["importance", ["ImportanceChoicesType", XSD::QName.new(NsTypes, "Importance")], [0, 1]],
      ["inReplyTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InReplyTo")], [0, 1]],
      ["isSubmitted", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsSubmitted")], [0, 1]],
      ["isDraft", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDraft")], [0, 1]],
      ["isFromMe", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFromMe")], [0, 1]],
      ["isResend", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResend")], [0, 1]],
      ["isUnmodified", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsUnmodified")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["dateTimeSent", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeSent")], [0, 1]],
      ["dateTimeCreated", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeCreated")], [0, 1]],
      ["responseObjects", ["NonEmptyArrayOfResponseObjectsType", XSD::QName.new(NsTypes, "ResponseObjects")], [0, 1]],
      ["reminderDueBy", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "ReminderDueBy")], [0, 1]],
      ["reminderIsSet", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "ReminderIsSet")], [0, 1]],
      ["reminderMinutesBeforeStart", [nil, XSD::QName.new(NsTypes, "ReminderMinutesBeforeStart")], [0, 1]],
      ["displayCc", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayCc")], [0, 1]],
      ["displayTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayTo")], [0, 1]],
      ["hasAttachments", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasAttachments")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["culture", ["SOAP::SOAPLanguage", XSD::QName.new(NsTypes, "Culture")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["lastModifiedName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "LastModifiedName")], [0, 1]],
      ["lastModifiedTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "LastModifiedTime")], [0, 1]],
      ["sender", ["SingleRecipientType", XSD::QName.new(NsTypes, "Sender")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["conversationIndex", ["SOAP::SOAPBase64", XSD::QName.new(NsTypes, "ConversationIndex")], [0, 1]],
      ["conversationTopic", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ConversationTopic")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["internetMessageId", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InternetMessageId")], [0, 1]],
      ["isRead", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsRead")], [0, 1]],
      ["isResponseRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResponseRequested")], [0, 1]],
      ["references", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "References")], [0, 1]],
      ["replyTo", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ReplyTo")], [0, 1]],
      ["receivedBy", ["SingleRecipientType", XSD::QName.new(NsTypes, "ReceivedBy")], [0, 1]],
      ["receivedRepresenting", ["SingleRecipientType", XSD::QName.new(NsTypes, "ReceivedRepresenting")], [0, 1]],
      ["associatedCalendarItemId", ["ItemIdType", XSD::QName.new(NsTypes, "AssociatedCalendarItemId")], [0, 1]],
      ["isDelegated", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDelegated")], [0, 1]],
      ["isOutOfDate", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsOutOfDate")], [0, 1]],
      ["hasBeenProcessed", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasBeenProcessed")], [0, 1]],
      ["responseType", ["ResponseTypeType", XSD::QName.new(NsTypes, "ResponseType")], [0, 1]],
      ["uID", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "UID")], [0, 1]],
      ["recurrenceId", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "RecurrenceId")], [0, 1]],
      ["dateTimeStamp", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeStamp")], [0, 1]],
      ["meetingRequestType", ["MeetingRequestTypeType", XSD::QName.new(NsTypes, "MeetingRequestType")], [0, 1]],
      ["intendedFreeBusyStatus", ["LegacyFreeBusyType", XSD::QName.new(NsTypes, "IntendedFreeBusyStatus")], [0, 1]],
      ["start", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "Start")], [0, 1]],
      ["v_end", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "End")], [0, 1]],
      ["originalStart", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "OriginalStart")], [0, 1]],
      ["isAllDayEvent", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsAllDayEvent")], [0, 1]],
      ["legacyFreeBusyStatus", ["LegacyFreeBusyType", XSD::QName.new(NsTypes, "LegacyFreeBusyStatus")], [0, 1]],
      ["location", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Location")], [0, 1]],
      ["v_when", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "When")], [0, 1]],
      ["isMeeting", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsMeeting")], [0, 1]],
      ["isCancelled", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsCancelled")], [0, 1]],
      ["isRecurring", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsRecurring")], [0, 1]],
      ["meetingRequestWasSent", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "MeetingRequestWasSent")], [0, 1]],
      ["calendarItemType", ["CalendarItemTypeType", XSD::QName.new(NsTypes, "CalendarItemType")], [0, 1]],
      ["myResponseType", ["ResponseTypeType", XSD::QName.new(NsTypes, "MyResponseType")], [0, 1]],
      ["organizer", ["SingleRecipientType", XSD::QName.new(NsTypes, "Organizer")], [0, 1]],
      ["requiredAttendees", ["NonEmptyArrayOfAttendeesType", XSD::QName.new(NsTypes, "RequiredAttendees")], [0, 1]],
      ["optionalAttendees", ["NonEmptyArrayOfAttendeesType", XSD::QName.new(NsTypes, "OptionalAttendees")], [0, 1]],
      ["resources", ["NonEmptyArrayOfAttendeesType", XSD::QName.new(NsTypes, "Resources")], [0, 1]],
      ["conflictingMeetingCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "ConflictingMeetingCount")], [0, 1]],
      ["adjacentMeetingCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "AdjacentMeetingCount")], [0, 1]],
      ["conflictingMeetings", ["NonEmptyArrayOfAllItemsType", XSD::QName.new(NsTypes, "ConflictingMeetings")], [0, 1]],
      ["adjacentMeetings", ["NonEmptyArrayOfAllItemsType", XSD::QName.new(NsTypes, "AdjacentMeetings")], [0, 1]],
      ["duration", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Duration")], [0, 1]],
      ["timeZone", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "TimeZone")], [0, 1]],
      ["appointmentReplyTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "AppointmentReplyTime")], [0, 1]],
      ["appointmentSequenceNumber", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "AppointmentSequenceNumber")], [0, 1]],
      ["appointmentState", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "AppointmentState")], [0, 1]],
      ["recurrence", ["RecurrenceType", XSD::QName.new(NsTypes, "Recurrence")], [0, 1]],
      ["firstOccurrence", ["OccurrenceInfoType", XSD::QName.new(NsTypes, "FirstOccurrence")], [0, 1]],
      ["lastOccurrence", ["OccurrenceInfoType", XSD::QName.new(NsTypes, "LastOccurrence")], [0, 1]],
      ["modifiedOccurrences", ["NonEmptyArrayOfOccurrenceInfoType", XSD::QName.new(NsTypes, "ModifiedOccurrences")], [0, 1]],
      ["deletedOccurrences", ["NonEmptyArrayOfDeletedOccurrencesType", XSD::QName.new(NsTypes, "DeletedOccurrences")], [0, 1]],
      ["meetingTimeZone", ["TimeZoneType", XSD::QName.new(NsTypes, "MeetingTimeZone")], [0, 1]],
      ["conferenceType", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "ConferenceType")], [0, 1]],
      ["allowNewTimeProposal", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "AllowNewTimeProposal")], [0, 1]],
      ["isOnlineMeeting", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsOnlineMeeting")], [0, 1]],
      ["meetingWorkspaceUrl", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "MeetingWorkspaceUrl")], [0, 1]],
      ["netShowUrl", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "NetShowUrl")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => MeetingResponseMessageType,
    :schema_type => XSD::QName.new(NsTypes, "MeetingResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsTypes, "MeetingMessageType"),
    :schema_element => [
      ["mimeContent", ["MimeContentType", XSD::QName.new(NsTypes, "MimeContent")], [0, 1]],
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["dateTimeReceived", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeReceived")], [0, 1]],
      ["size", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Size")], [0, 1]],
      ["categories", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Categories")], [0, 1]],
      ["importance", ["ImportanceChoicesType", XSD::QName.new(NsTypes, "Importance")], [0, 1]],
      ["inReplyTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InReplyTo")], [0, 1]],
      ["isSubmitted", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsSubmitted")], [0, 1]],
      ["isDraft", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDraft")], [0, 1]],
      ["isFromMe", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFromMe")], [0, 1]],
      ["isResend", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResend")], [0, 1]],
      ["isUnmodified", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsUnmodified")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["dateTimeSent", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeSent")], [0, 1]],
      ["dateTimeCreated", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeCreated")], [0, 1]],
      ["responseObjects", ["NonEmptyArrayOfResponseObjectsType", XSD::QName.new(NsTypes, "ResponseObjects")], [0, 1]],
      ["reminderDueBy", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "ReminderDueBy")], [0, 1]],
      ["reminderIsSet", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "ReminderIsSet")], [0, 1]],
      ["reminderMinutesBeforeStart", [nil, XSD::QName.new(NsTypes, "ReminderMinutesBeforeStart")], [0, 1]],
      ["displayCc", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayCc")], [0, 1]],
      ["displayTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayTo")], [0, 1]],
      ["hasAttachments", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasAttachments")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["culture", ["SOAP::SOAPLanguage", XSD::QName.new(NsTypes, "Culture")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["lastModifiedName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "LastModifiedName")], [0, 1]],
      ["lastModifiedTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "LastModifiedTime")], [0, 1]],
      ["sender", ["SingleRecipientType", XSD::QName.new(NsTypes, "Sender")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["conversationIndex", ["SOAP::SOAPBase64", XSD::QName.new(NsTypes, "ConversationIndex")], [0, 1]],
      ["conversationTopic", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ConversationTopic")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["internetMessageId", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InternetMessageId")], [0, 1]],
      ["isRead", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsRead")], [0, 1]],
      ["isResponseRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResponseRequested")], [0, 1]],
      ["references", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "References")], [0, 1]],
      ["replyTo", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ReplyTo")], [0, 1]],
      ["receivedBy", ["SingleRecipientType", XSD::QName.new(NsTypes, "ReceivedBy")], [0, 1]],
      ["receivedRepresenting", ["SingleRecipientType", XSD::QName.new(NsTypes, "ReceivedRepresenting")], [0, 1]],
      ["associatedCalendarItemId", ["ItemIdType", XSD::QName.new(NsTypes, "AssociatedCalendarItemId")], [0, 1]],
      ["isDelegated", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDelegated")], [0, 1]],
      ["isOutOfDate", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsOutOfDate")], [0, 1]],
      ["hasBeenProcessed", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasBeenProcessed")], [0, 1]],
      ["responseType", ["ResponseTypeType", XSD::QName.new(NsTypes, "ResponseType")], [0, 1]],
      ["uID", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "UID")], [0, 1]],
      ["recurrenceId", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "RecurrenceId")], [0, 1]],
      ["dateTimeStamp", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeStamp")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => MeetingCancellationMessageType,
    :schema_type => XSD::QName.new(NsTypes, "MeetingCancellationMessageType"),
    :schema_basetype => XSD::QName.new(NsTypes, "MeetingMessageType"),
    :schema_element => [
      ["mimeContent", ["MimeContentType", XSD::QName.new(NsTypes, "MimeContent")], [0, 1]],
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["dateTimeReceived", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeReceived")], [0, 1]],
      ["size", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Size")], [0, 1]],
      ["categories", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Categories")], [0, 1]],
      ["importance", ["ImportanceChoicesType", XSD::QName.new(NsTypes, "Importance")], [0, 1]],
      ["inReplyTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InReplyTo")], [0, 1]],
      ["isSubmitted", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsSubmitted")], [0, 1]],
      ["isDraft", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDraft")], [0, 1]],
      ["isFromMe", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFromMe")], [0, 1]],
      ["isResend", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResend")], [0, 1]],
      ["isUnmodified", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsUnmodified")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["dateTimeSent", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeSent")], [0, 1]],
      ["dateTimeCreated", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeCreated")], [0, 1]],
      ["responseObjects", ["NonEmptyArrayOfResponseObjectsType", XSD::QName.new(NsTypes, "ResponseObjects")], [0, 1]],
      ["reminderDueBy", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "ReminderDueBy")], [0, 1]],
      ["reminderIsSet", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "ReminderIsSet")], [0, 1]],
      ["reminderMinutesBeforeStart", [nil, XSD::QName.new(NsTypes, "ReminderMinutesBeforeStart")], [0, 1]],
      ["displayCc", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayCc")], [0, 1]],
      ["displayTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayTo")], [0, 1]],
      ["hasAttachments", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasAttachments")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["culture", ["SOAP::SOAPLanguage", XSD::QName.new(NsTypes, "Culture")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["lastModifiedName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "LastModifiedName")], [0, 1]],
      ["lastModifiedTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "LastModifiedTime")], [0, 1]],
      ["sender", ["SingleRecipientType", XSD::QName.new(NsTypes, "Sender")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["conversationIndex", ["SOAP::SOAPBase64", XSD::QName.new(NsTypes, "ConversationIndex")], [0, 1]],
      ["conversationTopic", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ConversationTopic")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["internetMessageId", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InternetMessageId")], [0, 1]],
      ["isRead", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsRead")], [0, 1]],
      ["isResponseRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResponseRequested")], [0, 1]],
      ["references", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "References")], [0, 1]],
      ["replyTo", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ReplyTo")], [0, 1]],
      ["receivedBy", ["SingleRecipientType", XSD::QName.new(NsTypes, "ReceivedBy")], [0, 1]],
      ["receivedRepresenting", ["SingleRecipientType", XSD::QName.new(NsTypes, "ReceivedRepresenting")], [0, 1]],
      ["associatedCalendarItemId", ["ItemIdType", XSD::QName.new(NsTypes, "AssociatedCalendarItemId")], [0, 1]],
      ["isDelegated", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDelegated")], [0, 1]],
      ["isOutOfDate", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsOutOfDate")], [0, 1]],
      ["hasBeenProcessed", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasBeenProcessed")], [0, 1]],
      ["responseType", ["ResponseTypeType", XSD::QName.new(NsTypes, "ResponseType")], [0, 1]],
      ["uID", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "UID")], [0, 1]],
      ["recurrenceId", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "RecurrenceId")], [0, 1]],
      ["dateTimeStamp", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeStamp")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => CompleteNameType,
    :schema_type => XSD::QName.new(NsTypes, "CompleteNameType"),
    :schema_element => [
      ["title", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Title")], [0, 1]],
      ["firstName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "FirstName")], [0, 1]],
      ["middleName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "MiddleName")], [0, 1]],
      ["lastName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "LastName")], [0, 1]],
      ["suffix", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Suffix")], [0, 1]],
      ["initials", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Initials")], [0, 1]],
      ["fullName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "FullName")], [0, 1]],
      ["nickname", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Nickname")], [0, 1]],
      ["yomiFirstName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "YomiFirstName")], [0, 1]],
      ["yomiLastName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "YomiLastName")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => ImAddressDictionaryEntryType,
    :schema_type => XSD::QName.new(NsTypes, "ImAddressDictionaryEntryType"),
    :schema_attribute => {
      XSD::QName.new(nil, "Key") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => EmailAddressDictionaryEntryType,
    :schema_type => XSD::QName.new(NsTypes, "EmailAddressDictionaryEntryType"),
    :schema_attribute => {
      XSD::QName.new(nil, "Key") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => PhoneNumberDictionaryEntryType,
    :schema_type => XSD::QName.new(NsTypes, "PhoneNumberDictionaryEntryType"),
    :schema_attribute => {
      XSD::QName.new(nil, "Key") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => PhysicalAddressDictionaryEntryType,
    :schema_type => XSD::QName.new(NsTypes, "PhysicalAddressDictionaryEntryType"),
    :schema_element => [
      ["street", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Street")], [0, 1]],
      ["city", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "City")], [0, 1]],
      ["state", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "State")], [0, 1]],
      ["countryOrRegion", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "CountryOrRegion")], [0, 1]],
      ["postalCode", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "PostalCode")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "Key") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => ImAddressDictionaryType,
    :schema_type => XSD::QName.new(NsTypes, "ImAddressDictionaryType"),
    :schema_element => [
      ["entry", ["ImAddressDictionaryEntryType[]", XSD::QName.new(NsTypes, "Entry")], [1, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => EmailAddressDictionaryType,
    :schema_type => XSD::QName.new(NsTypes, "EmailAddressDictionaryType"),
    :schema_element => [
      ["entry", ["EmailAddressDictionaryEntryType[]", XSD::QName.new(NsTypes, "Entry")], [1, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => PhoneNumberDictionaryType,
    :schema_type => XSD::QName.new(NsTypes, "PhoneNumberDictionaryType"),
    :schema_element => [
      ["entry", ["PhoneNumberDictionaryEntryType[]", XSD::QName.new(NsTypes, "Entry")], [1, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => PhysicalAddressDictionaryType,
    :schema_type => XSD::QName.new(NsTypes, "PhysicalAddressDictionaryType"),
    :schema_element => [
      ["entry", ["PhysicalAddressDictionaryEntryType[]", XSD::QName.new(NsTypes, "Entry")], [1, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => ContactItemType,
    :schema_type => XSD::QName.new(NsTypes, "ContactItemType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ItemType"),
    :schema_element => [
      ["mimeContent", ["MimeContentType", XSD::QName.new(NsTypes, "MimeContent")], [0, 1]],
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["dateTimeReceived", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeReceived")], [0, 1]],
      ["size", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Size")], [0, 1]],
      ["categories", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Categories")], [0, 1]],
      ["importance", ["ImportanceChoicesType", XSD::QName.new(NsTypes, "Importance")], [0, 1]],
      ["inReplyTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InReplyTo")], [0, 1]],
      ["isSubmitted", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsSubmitted")], [0, 1]],
      ["isDraft", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDraft")], [0, 1]],
      ["isFromMe", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFromMe")], [0, 1]],
      ["isResend", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResend")], [0, 1]],
      ["isUnmodified", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsUnmodified")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["dateTimeSent", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeSent")], [0, 1]],
      ["dateTimeCreated", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeCreated")], [0, 1]],
      ["responseObjects", ["NonEmptyArrayOfResponseObjectsType", XSD::QName.new(NsTypes, "ResponseObjects")], [0, 1]],
      ["reminderDueBy", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "ReminderDueBy")], [0, 1]],
      ["reminderIsSet", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "ReminderIsSet")], [0, 1]],
      ["reminderMinutesBeforeStart", [nil, XSD::QName.new(NsTypes, "ReminderMinutesBeforeStart")], [0, 1]],
      ["displayCc", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayCc")], [0, 1]],
      ["displayTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayTo")], [0, 1]],
      ["hasAttachments", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasAttachments")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["culture", ["SOAP::SOAPLanguage", XSD::QName.new(NsTypes, "Culture")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["lastModifiedName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "LastModifiedName")], [0, 1]],
      ["lastModifiedTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "LastModifiedTime")], [0, 1]],
      ["fileAs", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "FileAs")], [0, 1]],
      ["fileAsMapping", ["FileAsMappingType", XSD::QName.new(NsTypes, "FileAsMapping")], [0, 1]],
      ["displayName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayName")], [0, 1]],
      ["givenName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "GivenName")], [0, 1]],
      ["initials", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Initials")], [0, 1]],
      ["middleName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "MiddleName")], [0, 1]],
      ["nickname", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Nickname")], [0, 1]],
      ["completeName", ["CompleteNameType", XSD::QName.new(NsTypes, "CompleteName")], [0, 1]],
      ["companyName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "CompanyName")], [0, 1]],
      ["emailAddresses", ["EmailAddressDictionaryType", XSD::QName.new(NsTypes, "EmailAddresses")], [0, 1]],
      ["physicalAddresses", ["PhysicalAddressDictionaryType", XSD::QName.new(NsTypes, "PhysicalAddresses")], [0, 1]],
      ["phoneNumbers", ["PhoneNumberDictionaryType", XSD::QName.new(NsTypes, "PhoneNumbers")], [0, 1]],
      ["assistantName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "AssistantName")], [0, 1]],
      ["birthday", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "Birthday")], [0, 1]],
      ["businessHomePage", ["SOAP::SOAPAnyURI", XSD::QName.new(NsTypes, "BusinessHomePage")], [0, 1]],
      ["children", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Children")], [0, 1]],
      ["companies", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Companies")], [0, 1]],
      ["contactSource", ["ContactSourceType", XSD::QName.new(NsTypes, "ContactSource")], [0, 1]],
      ["department", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Department")], [0, 1]],
      ["generation", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Generation")], [0, 1]],
      ["imAddresses", ["ImAddressDictionaryType", XSD::QName.new(NsTypes, "ImAddresses")], [0, 1]],
      ["jobTitle", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "JobTitle")], [0, 1]],
      ["manager", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Manager")], [0, 1]],
      ["mileage", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Mileage")], [0, 1]],
      ["officeLocation", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "OfficeLocation")], [0, 1]],
      ["postalAddressIndex", ["PhysicalAddressIndexType", XSD::QName.new(NsTypes, "PostalAddressIndex")], [0, 1]],
      ["profession", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Profession")], [0, 1]],
      ["spouseName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "SpouseName")], [0, 1]],
      ["surname", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Surname")], [0, 1]],
      ["weddingAnniversary", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "WeddingAnniversary")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => DistributionListType,
    :schema_type => XSD::QName.new(NsTypes, "DistributionListType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ItemType"),
    :schema_element => [
      ["mimeContent", ["MimeContentType", XSD::QName.new(NsTypes, "MimeContent")], [0, 1]],
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["dateTimeReceived", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeReceived")], [0, 1]],
      ["size", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Size")], [0, 1]],
      ["categories", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Categories")], [0, 1]],
      ["importance", ["ImportanceChoicesType", XSD::QName.new(NsTypes, "Importance")], [0, 1]],
      ["inReplyTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InReplyTo")], [0, 1]],
      ["isSubmitted", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsSubmitted")], [0, 1]],
      ["isDraft", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDraft")], [0, 1]],
      ["isFromMe", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFromMe")], [0, 1]],
      ["isResend", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResend")], [0, 1]],
      ["isUnmodified", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsUnmodified")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["dateTimeSent", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeSent")], [0, 1]],
      ["dateTimeCreated", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeCreated")], [0, 1]],
      ["responseObjects", ["NonEmptyArrayOfResponseObjectsType", XSD::QName.new(NsTypes, "ResponseObjects")], [0, 1]],
      ["reminderDueBy", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "ReminderDueBy")], [0, 1]],
      ["reminderIsSet", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "ReminderIsSet")], [0, 1]],
      ["reminderMinutesBeforeStart", [nil, XSD::QName.new(NsTypes, "ReminderMinutesBeforeStart")], [0, 1]],
      ["displayCc", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayCc")], [0, 1]],
      ["displayTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayTo")], [0, 1]],
      ["hasAttachments", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasAttachments")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["culture", ["SOAP::SOAPLanguage", XSD::QName.new(NsTypes, "Culture")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["lastModifiedName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "LastModifiedName")], [0, 1]],
      ["lastModifiedTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "LastModifiedTime")], [0, 1]],
      ["displayName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayName")], [0, 1]],
      ["fileAs", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "FileAs")], [0, 1]],
      ["contactSource", ["ContactSourceType", XSD::QName.new(NsTypes, "ContactSource")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => SearchParametersType,
    :schema_type => XSD::QName.new(NsTypes, "SearchParametersType"),
    :schema_element => [
      ["restriction", ["RestrictionType", XSD::QName.new(NsTypes, "Restriction")]],
      ["baseFolderIds", ["NonEmptyArrayOfBaseFolderIdsType", XSD::QName.new(NsTypes, "BaseFolderIds")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "Traversal") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => ConstantValueType,
    :schema_type => XSD::QName.new(NsTypes, "ConstantValueType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "Value") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => AggregateOnType,
    :schema_type => XSD::QName.new(NsTypes, "AggregateOnType"),
    :schema_element => [ :choice,
      ["fieldURI", ["PathToUnindexedFieldType", XSD::QName.new(NsTypes, "FieldURI")]],
      ["indexedFieldURI", ["PathToIndexedFieldType", XSD::QName.new(NsTypes, "IndexedFieldURI")]],
      ["extendedFieldURI", ["PathToExtendedFieldType", XSD::QName.new(NsTypes, "ExtendedFieldURI")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "Aggregate") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => GroupByType,
    :schema_type => XSD::QName.new(NsTypes, "GroupByType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseGroupByType"),
    :schema_element => [
      [ :choice,
        ["fieldURI", ["PathToUnindexedFieldType", XSD::QName.new(NsTypes, "FieldURI")]],
        ["indexedFieldURI", ["PathToIndexedFieldType", XSD::QName.new(NsTypes, "IndexedFieldURI")]],
        ["extendedFieldURI", ["PathToExtendedFieldType", XSD::QName.new(NsTypes, "ExtendedFieldURI")]]
      ],
      ["aggregateOn", ["AggregateOnType", XSD::QName.new(NsTypes, "AggregateOn")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "Order") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => DistinguishedGroupByType,
    :schema_type => XSD::QName.new(NsTypes, "DistinguishedGroupByType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseGroupByType"),
    :schema_element => [
      ["standardGroupBy", ["StandardGroupByType", XSD::QName.new(NsTypes, "StandardGroupBy")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "Order") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => GroupedItemsType,
    :schema_type => XSD::QName.new(NsTypes, "GroupedItemsType"),
    :schema_element => [
      ["groupIndex", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "GroupIndex")]],
      ["items", ["ArrayOfRealItemsType", XSD::QName.new(NsTypes, "Items")]]
    ]
  )

  EncodedRegistry.register(
    :class => ArrayOfGroupedItemsType,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfGroupedItemsType"),
    :schema_element => [
      ["groupedItems", ["GroupedItemsType[]", XSD::QName.new(NsTypes, "GroupedItems")], [0, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => ExistsType,
    :schema_type => XSD::QName.new(NsTypes, "ExistsType"),
    :schema_basetype => XSD::QName.new(NsTypes, "SearchExpressionType"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "FieldURI")]]
    ]
  )

  EncodedRegistry.register(
    :class => FieldURIOrConstantType,
    :schema_type => XSD::QName.new(NsTypes, "FieldURIOrConstantType"),
    :schema_element => [ :choice,
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["constant", ["ConstantValueType", XSD::QName.new(NsTypes, "Constant")]]
    ]
  )

  EncodedRegistry.register(
    :class => ExcludesValueType,
    :schema_type => XSD::QName.new(NsTypes, "ExcludesValueType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "Value") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => ExcludesType,
    :schema_type => XSD::QName.new(NsTypes, "ExcludesType"),
    :schema_basetype => XSD::QName.new(NsTypes, "SearchExpressionType"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["bitmask", ["ExcludesValueType", XSD::QName.new(NsTypes, "Bitmask")]]
    ]
  )

  EncodedRegistry.register(
    :class => IsEqualToType,
    :schema_type => XSD::QName.new(NsTypes, "IsEqualToType"),
    :schema_basetype => XSD::QName.new(NsTypes, "TwoOperandExpressionType"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["fieldURIOrConstant", ["FieldURIOrConstantType", XSD::QName.new(NsTypes, "FieldURIOrConstant")]]
    ]
  )

  EncodedRegistry.register(
    :class => IsNotEqualToType,
    :schema_type => XSD::QName.new(NsTypes, "IsNotEqualToType"),
    :schema_basetype => XSD::QName.new(NsTypes, "TwoOperandExpressionType"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["fieldURIOrConstant", ["FieldURIOrConstantType", XSD::QName.new(NsTypes, "FieldURIOrConstant")]]
    ]
  )

  EncodedRegistry.register(
    :class => IsGreaterThanType,
    :schema_type => XSD::QName.new(NsTypes, "IsGreaterThanType"),
    :schema_basetype => XSD::QName.new(NsTypes, "TwoOperandExpressionType"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["fieldURIOrConstant", ["FieldURIOrConstantType", XSD::QName.new(NsTypes, "FieldURIOrConstant")]]
    ]
  )

  EncodedRegistry.register(
    :class => IsGreaterThanOrEqualToType,
    :schema_type => XSD::QName.new(NsTypes, "IsGreaterThanOrEqualToType"),
    :schema_basetype => XSD::QName.new(NsTypes, "TwoOperandExpressionType"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["fieldURIOrConstant", ["FieldURIOrConstantType", XSD::QName.new(NsTypes, "FieldURIOrConstant")]]
    ]
  )

  EncodedRegistry.register(
    :class => IsLessThanType,
    :schema_type => XSD::QName.new(NsTypes, "IsLessThanType"),
    :schema_basetype => XSD::QName.new(NsTypes, "TwoOperandExpressionType"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["fieldURIOrConstant", ["FieldURIOrConstantType", XSD::QName.new(NsTypes, "FieldURIOrConstant")]]
    ]
  )

  EncodedRegistry.register(
    :class => IsLessThanOrEqualToType,
    :schema_type => XSD::QName.new(NsTypes, "IsLessThanOrEqualToType"),
    :schema_basetype => XSD::QName.new(NsTypes, "TwoOperandExpressionType"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["fieldURIOrConstant", ["FieldURIOrConstantType", XSD::QName.new(NsTypes, "FieldURIOrConstant")]]
    ]
  )

  EncodedRegistry.register(
    :class => ContainsExpressionType,
    :schema_type => XSD::QName.new(NsTypes, "ContainsExpressionType"),
    :schema_basetype => XSD::QName.new(NsTypes, "SearchExpressionType"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["constant", ["ConstantValueType", XSD::QName.new(NsTypes, "Constant")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ContainmentMode") => "SOAP::SOAPString",
      XSD::QName.new(nil, "ContainmentComparison") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => NotType,
    :schema_type => XSD::QName.new(NsTypes, "NotType"),
    :schema_basetype => XSD::QName.new(NsTypes, "SearchExpressionType"),
    :schema_element => [
      ["searchExpression", ["SearchExpressionType", XSD::QName.new(NsTypes, "SearchExpression")]]
    ]
  )

  EncodedRegistry.register(
    :class => AndType,
    :schema_type => XSD::QName.new(NsTypes, "AndType"),
    :schema_basetype => XSD::QName.new(NsTypes, "MultipleOperandBooleanExpressionType"),
    :schema_element => [
      ["searchExpression", ["SearchExpressionType[]", XSD::QName.new(NsTypes, "SearchExpression")], [2, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => OrType,
    :schema_type => XSD::QName.new(NsTypes, "OrType"),
    :schema_basetype => XSD::QName.new(NsTypes, "MultipleOperandBooleanExpressionType"),
    :schema_element => [
      ["searchExpression", ["SearchExpressionType[]", XSD::QName.new(NsTypes, "SearchExpression")], [2, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => RestrictionType,
    :schema_type => XSD::QName.new(NsTypes, "RestrictionType"),
    :schema_element => [ :choice,
        ["isEqualTo", ["IsEqualToType", XSD::QName.new(NsTypes, "IsEqualTo")]],
        ["exists", ["ExistsType", XSD::QName.new(NsTypes, "Exists")]],
        ["searchExpression", ["SearchExpressionType", XSD::QName.new(NsTypes, "SearchExpression")]]
      ]
  )

  EncodedRegistry.register(
    :class => FieldOrderType,
    :schema_type => XSD::QName.new(NsTypes, "FieldOrderType"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "Order") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => NonEmptyArrayOfFieldOrdersType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfFieldOrdersType"),
    :schema_element => [
      ["fieldOrder", ["FieldOrderType[]", XSD::QName.new(NsTypes, "FieldOrder")], [1, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => NonEmptyArrayOfFolderNamesType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfFolderNamesType"),
    :schema_element => [
      ["folderName", ["SOAP::SOAPString[]", XSD::QName.new(NsTypes, "FolderName")], [1, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => BaseNotificationEventType,
    :schema_type => XSD::QName.new(NsTypes, "BaseNotificationEventType"),
    :schema_element => [
      ["watermark", [nil, XSD::QName.new(NsTypes, "Watermark")]]
    ]
  )

  EncodedRegistry.register(
    :class => BaseObjectChangedEventType,
    :schema_type => XSD::QName.new(NsTypes, "BaseObjectChangedEventType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseNotificationEventType"),
    :schema_element => [
      ["watermark", [nil, XSD::QName.new(NsTypes, "Watermark")]],
      ["timeStamp", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "TimeStamp")]],
      [ :choice,
        ["folderId", ["FolderIdType", XSD::QName.new(NsTypes, "FolderId")]],
        ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")]]
      ],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")]]
    ]
  )

  EncodedRegistry.register(
    :class => ModifiedEventType,
    :schema_type => XSD::QName.new(NsTypes, "ModifiedEventType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseObjectChangedEventType"),
    :schema_element => [
      ["watermark", [nil, XSD::QName.new(NsTypes, "Watermark")]],
      ["timeStamp", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "TimeStamp")]],
      [ :choice,
        ["folderId", ["FolderIdType", XSD::QName.new(NsTypes, "FolderId")]],
        ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")]]
      ],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")]],
      ["unreadCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "UnreadCount")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => MovedCopiedEventType,
    :schema_type => XSD::QName.new(NsTypes, "MovedCopiedEventType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseObjectChangedEventType"),
    :schema_element => [
      ["watermark", [nil, XSD::QName.new(NsTypes, "Watermark")]],
      ["timeStamp", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "TimeStamp")]],
      [ :choice,
        ["folderId", ["FolderIdType", XSD::QName.new(NsTypes, "FolderId")]],
        ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")]]
      ],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")]],
      [ :choice,
        ["oldFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "OldFolderId")]],
        ["oldItemId", ["ItemIdType", XSD::QName.new(NsTypes, "OldItemId")]]
      ],
      ["oldParentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "OldParentFolderId")]]
    ]
  )

  EncodedRegistry.register(
    :class => NotificationType,
    :schema_type => XSD::QName.new(NsTypes, "NotificationType"),
    :schema_element => [
      ["subscriptionId", [nil, XSD::QName.new(NsTypes, "SubscriptionId")]],
      ["previousWatermark", [nil, XSD::QName.new(NsTypes, "PreviousWatermark")]],
      ["moreEvents", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "MoreEvents")]],
      [
        ["copiedEvent", ["MovedCopiedEventType[]", XSD::QName.new(NsTypes, "CopiedEvent")]],
        ["createdEvent", ["BaseObjectChangedEventType[]", XSD::QName.new(NsTypes, "CreatedEvent")]],
        ["deletedEvent", ["BaseObjectChangedEventType[]", XSD::QName.new(NsTypes, "DeletedEvent")]],
        ["modifiedEvent", ["ModifiedEventType[]", XSD::QName.new(NsTypes, "ModifiedEvent")]],
        ["movedEvent", ["MovedCopiedEventType[]", XSD::QName.new(NsTypes, "MovedEvent")]],
        ["newMailEvent", ["BaseObjectChangedEventType[]", XSD::QName.new(NsTypes, "NewMailEvent")]],
        ["statusEvent", ["BaseNotificationEventType[]", XSD::QName.new(NsTypes, "StatusEvent")]]
      ]
    ]
  )

  EncodedRegistry.register(
    :class => NonEmptyArrayOfNotificationEventTypesType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfNotificationEventTypesType"),
    :schema_element => [
      ["eventType", ["NotificationEventTypeType[]", XSD::QName.new(NsTypes, "EventType")]]
    ]
  )

  EncodedRegistry.register(
    :class => PushSubscriptionRequestType,
    :schema_type => XSD::QName.new(NsTypes, "PushSubscriptionRequestType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseSubscriptionRequestType"),
    :schema_element => [
      ["folderIds", ["NonEmptyArrayOfBaseFolderIdsType", XSD::QName.new(NsTypes, "FolderIds")]],
      ["eventTypes", ["NonEmptyArrayOfNotificationEventTypesType", XSD::QName.new(NsTypes, "EventTypes")]],
      ["watermark", [nil, XSD::QName.new(NsTypes, "Watermark")], [0, 1]],
      ["statusFrequency", [nil, XSD::QName.new(NsTypes, "StatusFrequency")]],
      ["uRL", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "URL")]]
    ]
  )

  EncodedRegistry.register(
    :class => PullSubscriptionRequestType,
    :schema_type => XSD::QName.new(NsTypes, "PullSubscriptionRequestType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseSubscriptionRequestType"),
    :schema_element => [
      ["folderIds", ["NonEmptyArrayOfBaseFolderIdsType", XSD::QName.new(NsTypes, "FolderIds")]],
      ["eventTypes", ["NonEmptyArrayOfNotificationEventTypesType", XSD::QName.new(NsTypes, "EventTypes")]],
      ["watermark", [nil, XSD::QName.new(NsTypes, "Watermark")], [0, 1]],
      ["timeout", [nil, XSD::QName.new(NsTypes, "Timeout")]]
    ]
  )

  EncodedRegistry.register(
    :class => SyncFolderItemsDeleteType,
    :schema_type => XSD::QName.new(NsTypes, "SyncFolderItemsDeleteType"),
    :schema_element => [
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")]]
    ]
  )

  EncodedRegistry.register(
    :class => SyncFolderItemsReadFlagType,
    :schema_type => XSD::QName.new(NsTypes, "SyncFolderItemsReadFlagType"),
    :schema_element => [
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")]],
      ["isRead", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsRead")]]
    ]
  )

  EncodedRegistry.register(
    :class => SyncFolderItemsChangesType,
    :schema_type => XSD::QName.new(NsTypes, "SyncFolderItemsChangesType"),
    :schema_element => [
      [
        ["create", ["SyncFolderItemsCreateOrUpdateType[]", XSD::QName.new(NsTypes, "Create")]],
        ["update", ["SyncFolderItemsCreateOrUpdateType[]", XSD::QName.new(NsTypes, "Update")]],
        ["delete", ["SyncFolderItemsDeleteType[]", XSD::QName.new(NsTypes, "Delete")]],
        ["readFlagChange", ["SyncFolderItemsReadFlagType[]", XSD::QName.new(NsTypes, "ReadFlagChange")]]
      ]
    ]
  )

  EncodedRegistry.register(
    :class => SyncFolderHierarchyCreateOrUpdateType,
    :schema_type => XSD::QName.new(NsTypes, "SyncFolderHierarchyCreateOrUpdateType"),
    :schema_element => [ :choice,
      ["folder", ["FolderType", XSD::QName.new(NsTypes, "Folder")]],
      ["calendarFolder", ["CalendarFolderType", XSD::QName.new(NsTypes, "CalendarFolder")]],
      ["contactsFolder", ["ContactsFolderType", XSD::QName.new(NsTypes, "ContactsFolder")]],
      ["searchFolder", ["SearchFolderType", XSD::QName.new(NsTypes, "SearchFolder")]],
      ["tasksFolder", ["TasksFolderType", XSD::QName.new(NsTypes, "TasksFolder")]]
    ]
  )

  EncodedRegistry.register(
    :class => SyncFolderHierarchyDeleteType,
    :schema_type => XSD::QName.new(NsTypes, "SyncFolderHierarchyDeleteType"),
    :schema_element => [
      ["folderId", ["FolderIdType", XSD::QName.new(NsTypes, "FolderId")]]
    ]
  )

  EncodedRegistry.register(
    :class => SyncFolderHierarchyChangesType,
    :schema_type => XSD::QName.new(NsTypes, "SyncFolderHierarchyChangesType"),
    :schema_element => [
      [
        ["create", ["SyncFolderHierarchyCreateOrUpdateType[]", XSD::QName.new(NsTypes, "Create")]],
        ["update", ["SyncFolderHierarchyCreateOrUpdateType[]", XSD::QName.new(NsTypes, "Update")]],
        ["delete", ["SyncFolderHierarchyDeleteType[]", XSD::QName.new(NsTypes, "Delete")]]
      ]
    ]
  )

  EncodedRegistry.register(
    :class => CalendarEventDetails,
    :schema_type => XSD::QName.new(NsTypes, "CalendarEventDetails"),
    :schema_element => [
      ["iD", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ID")], [0, 1]],
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["location", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Location")], [0, 1]],
      ["isMeeting", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsMeeting")]],
      ["isRecurring", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsRecurring")]],
      ["isException", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsException")]],
      ["isReminderSet", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReminderSet")]],
      ["isPrivate", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsPrivate")]]
    ]
  )

  EncodedRegistry.register(
    :class => CalendarEvent,
    :schema_type => XSD::QName.new(NsTypes, "CalendarEvent"),
    :schema_element => [
      ["startTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "StartTime")]],
      ["endTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "EndTime")]],
      ["busyType", ["LegacyFreeBusyType", XSD::QName.new(NsTypes, "BusyType")]],
      ["calendarEventDetails", ["CalendarEventDetails", XSD::QName.new(NsTypes, "CalendarEventDetails")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => ArrayOfCalendarEvent,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfCalendarEvent"),
    :schema_element => [
      ["calendarEvent", ["CalendarEvent[]", XSD::QName.new(NsTypes, "CalendarEvent")], [0, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => Duration,
    :schema_type => XSD::QName.new(NsTypes, "Duration"),
    :schema_element => [
      ["startTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "StartTime")]],
      ["endTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "EndTime")]]
    ]
  )

  EncodedRegistry.register(
    :class => EmailAddress,
    :schema_type => XSD::QName.new(NsTypes, "EmailAddress"),
    :schema_element => [
      ["name", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Name")], [0, 1]],
      ["address", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Address")]],
      ["routingType", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "RoutingType")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => FreeBusyViewOptionsType,
    :schema_type => XSD::QName.new(NsTypes, "FreeBusyViewOptionsType"),
    :schema_element => [
      ["timeWindow", ["Duration", XSD::QName.new(NsTypes, "TimeWindow")]],
      ["mergedFreeBusyIntervalInMinutes", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "MergedFreeBusyIntervalInMinutes")], [0, 1]],
      ["requestedView", [nil, XSD::QName.new(NsTypes, "RequestedView")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => WorkingPeriod,
    :schema_type => XSD::QName.new(NsTypes, "WorkingPeriod"),
    :schema_element => [
      ["dayOfWeek", [nil, XSD::QName.new(NsTypes, "DayOfWeek")]],
      ["startTimeInMinutes", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "StartTimeInMinutes")]],
      ["endTimeInMinutes", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "EndTimeInMinutes")]]
    ]
  )

  EncodedRegistry.register(
    :class => ArrayOfWorkingPeriod,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfWorkingPeriod"),
    :schema_element => [
      ["workingPeriod", ["WorkingPeriod[]", XSD::QName.new(NsTypes, "WorkingPeriod")], [0, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => SerializableTimeZoneTime,
    :schema_type => XSD::QName.new(NsTypes, "SerializableTimeZoneTime"),
    :schema_element => [
      ["bias", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Bias")]],
      ["time", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Time")]],
      ["dayOrder", ["SOAP::SOAPShort", XSD::QName.new(NsTypes, "DayOrder")]],
      ["month", ["SOAP::SOAPShort", XSD::QName.new(NsTypes, "Month")]],
      ["dayOfWeek", ["DayOfWeekType", XSD::QName.new(NsTypes, "DayOfWeek")]],
      ["year", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Year")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => SerializableTimeZone,
    :schema_type => XSD::QName.new(NsTypes, "SerializableTimeZone"),
    :schema_element => [
      ["bias", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Bias")]],
      ["standardTime", ["SerializableTimeZoneTime", XSD::QName.new(NsTypes, "StandardTime")]],
      ["daylightTime", ["SerializableTimeZoneTime", XSD::QName.new(NsTypes, "DaylightTime")]]
    ]
  )

  EncodedRegistry.register(
    :class => WorkingHours,
    :schema_type => XSD::QName.new(NsTypes, "WorkingHours"),
    :schema_element => [
      ["timeZone", ["SerializableTimeZone", XSD::QName.new(NsTypes, "TimeZone")]],
      ["workingPeriodArray", ["ArrayOfWorkingPeriod", XSD::QName.new(NsTypes, "WorkingPeriodArray")]]
    ]
  )

  EncodedRegistry.register(
    :class => FreeBusyView,
    :schema_type => XSD::QName.new(NsTypes, "FreeBusyView"),
    :schema_element => [
      ["freeBusyViewType", [nil, XSD::QName.new(NsTypes, "FreeBusyViewType")]],
      ["mergedFreeBusy", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "MergedFreeBusy")], [0, 1]],
      ["calendarEventArray", ["ArrayOfCalendarEvent", XSD::QName.new(NsTypes, "CalendarEventArray")], [0, 1]],
      ["workingHours", ["WorkingHours", XSD::QName.new(NsTypes, "WorkingHours")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => MailboxData,
    :schema_type => XSD::QName.new(NsTypes, "MailboxData"),
    :schema_element => [
      ["email", ["EmailAddress", XSD::QName.new(NsTypes, "Email")]],
      ["attendeeType", ["MeetingAttendeeType", XSD::QName.new(NsTypes, "AttendeeType")]],
      ["excludeConflicts", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "ExcludeConflicts")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => ArrayOfMailboxData,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfMailboxData"),
    :schema_element => [
      ["mailboxData", ["MailboxData[]", XSD::QName.new(NsTypes, "MailboxData")], [0, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => SuggestionsViewOptionsType,
    :schema_type => XSD::QName.new(NsTypes, "SuggestionsViewOptionsType"),
    :schema_element => [
      ["goodThreshold", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "GoodThreshold")], [0, 1]],
      ["maximumResultsByDay", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "MaximumResultsByDay")], [0, 1]],
      ["maximumNonWorkHourResultsByDay", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "MaximumNonWorkHourResultsByDay")], [0, 1]],
      ["meetingDurationInMinutes", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "MeetingDurationInMinutes")], [0, 1]],
      ["minimumSuggestionQuality", ["SuggestionQuality", XSD::QName.new(NsTypes, "MinimumSuggestionQuality")], [0, 1]],
      ["detailedSuggestionsWindow", ["Duration", XSD::QName.new(NsTypes, "DetailedSuggestionsWindow")]],
      ["currentMeetingTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "CurrentMeetingTime")], [0, 1]],
      ["globalObjectId", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "GlobalObjectId")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => ArrayOfAttendeeConflictData,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfAttendeeConflictData"),
    :schema_element => [ :choice,
      ["unknownAttendeeConflictData", ["UnknownAttendeeConflictData[]", XSD::QName.new(NsTypes, "UnknownAttendeeConflictData")]],
      ["individualAttendeeConflictData", ["IndividualAttendeeConflictData[]", XSD::QName.new(NsTypes, "IndividualAttendeeConflictData")]],
      ["tooBigGroupAttendeeConflictData", ["TooBigGroupAttendeeConflictData[]", XSD::QName.new(NsTypes, "TooBigGroupAttendeeConflictData")]],
      ["groupAttendeeConflictData", ["GroupAttendeeConflictData[]", XSD::QName.new(NsTypes, "GroupAttendeeConflictData")]]
    ]
  )

  EncodedRegistry.register(
    :class => UnknownAttendeeConflictData,
    :schema_type => XSD::QName.new(NsTypes, "UnknownAttendeeConflictData"),
    :schema_basetype => XSD::QName.new(NsTypes, "AttendeeConflictData"),
    :schema_element => []
  )

  EncodedRegistry.register(
    :class => TooBigGroupAttendeeConflictData,
    :schema_type => XSD::QName.new(NsTypes, "TooBigGroupAttendeeConflictData"),
    :schema_basetype => XSD::QName.new(NsTypes, "AttendeeConflictData"),
    :schema_element => []
  )

  EncodedRegistry.register(
    :class => IndividualAttendeeConflictData,
    :schema_type => XSD::QName.new(NsTypes, "IndividualAttendeeConflictData"),
    :schema_basetype => XSD::QName.new(NsTypes, "AttendeeConflictData"),
    :schema_element => [
      ["busyType", ["LegacyFreeBusyType", XSD::QName.new(NsTypes, "BusyType")]]
    ]
  )

  EncodedRegistry.register(
    :class => GroupAttendeeConflictData,
    :schema_type => XSD::QName.new(NsTypes, "GroupAttendeeConflictData"),
    :schema_basetype => XSD::QName.new(NsTypes, "AttendeeConflictData"),
    :schema_element => [
      ["numberOfMembers", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "NumberOfMembers")]],
      ["numberOfMembersAvailable", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "NumberOfMembersAvailable")]],
      ["numberOfMembersWithConflict", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "NumberOfMembersWithConflict")]],
      ["numberOfMembersWithNoData", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "NumberOfMembersWithNoData")]]
    ]
  )

  EncodedRegistry.register(
    :class => Suggestion,
    :schema_type => XSD::QName.new(NsTypes, "Suggestion"),
    :schema_element => [
      ["meetingTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "MeetingTime")]],
      ["isWorkTime", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsWorkTime")]],
      ["suggestionQuality", ["SuggestionQuality", XSD::QName.new(NsTypes, "SuggestionQuality")]],
      ["attendeeConflictDataArray", ["ArrayOfAttendeeConflictData", XSD::QName.new(NsTypes, "AttendeeConflictDataArray")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => ArrayOfSuggestion,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfSuggestion"),
    :schema_element => [
      ["suggestion", ["Suggestion[]", XSD::QName.new(NsTypes, "Suggestion")], [0, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => SuggestionDayResult,
    :schema_type => XSD::QName.new(NsTypes, "SuggestionDayResult"),
    :schema_element => [
      ["date", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "Date")]],
      ["dayQuality", ["SuggestionQuality", XSD::QName.new(NsTypes, "DayQuality")]],
      ["suggestionArray", ["ArrayOfSuggestion", XSD::QName.new(NsTypes, "SuggestionArray")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => ArrayOfSuggestionDayResult,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfSuggestionDayResult"),
    :schema_element => [
      ["suggestionDayResult", ["SuggestionDayResult[]", XSD::QName.new(NsTypes, "SuggestionDayResult")], [0, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => ReplyBody,
    :schema_type => XSD::QName.new(NsTypes, "ReplyBody"),
    :schema_element => [
      ["message", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Message")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(NsNamespace, "lang") => nil
    }
  )

  EncodedRegistry.register(
    :class => UserOofSettings,
    :schema_type => XSD::QName.new(NsTypes, "UserOofSettings"),
    :schema_element => [
      ["oofState", ["OofState", XSD::QName.new(NsTypes, "OofState")]],
      ["externalAudience", ["ExternalAudience", XSD::QName.new(NsTypes, "ExternalAudience")]],
      ["duration", ["Duration", XSD::QName.new(NsTypes, "Duration")], [0, 1]],
      ["internalReply", ["ReplyBody", XSD::QName.new(NsTypes, "InternalReply")], [0, 1]],
      ["externalReply", ["ReplyBody", XSD::QName.new(NsTypes, "ExternalReply")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => Value,
    :schema_type => XSD::QName.new(NsTypes, "Value"),
    :schema_attribute => {
      XSD::QName.new(nil, "Name") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => AlternateIdType,
    :schema_type => XSD::QName.new(NsTypes, "AlternateIdType"),
    :schema_basetype => XSD::QName.new(NsTypes, "AlternateIdBaseType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "Format") => "SOAP::SOAPString",
      XSD::QName.new(nil, "Id") => "SOAP::SOAPString",
      XSD::QName.new(nil, "Mailbox") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => AlternatePublicFolderIdType,
    :schema_type => XSD::QName.new(NsTypes, "AlternatePublicFolderIdType"),
    :schema_basetype => XSD::QName.new(NsTypes, "AlternateIdBaseType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "Format") => "SOAP::SOAPString",
      XSD::QName.new(nil, "FolderId") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => AlternatePublicFolderItemIdType,
    :schema_type => XSD::QName.new(NsTypes, "AlternatePublicFolderItemIdType"),
    :schema_basetype => XSD::QName.new(NsTypes, "AlternatePublicFolderIdType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "Format") => "SOAP::SOAPString",
      XSD::QName.new(nil, "FolderId") => "SOAP::SOAPString",
      XSD::QName.new(nil, "ItemId") => "SOAP::SOAPString"
    }
  )

  EncodedRegistry.register(
    :class => NonEmptyArrayOfAlternateIdsType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfAlternateIdsType"),
    :schema_element => [ :choice,
      ["alternateId", ["AlternateIdType[]", XSD::QName.new(NsTypes, "AlternateId")]],
      ["alternatePublicFolderId", ["AlternatePublicFolderIdType[]", XSD::QName.new(NsTypes, "AlternatePublicFolderId")]],
      ["alternatePublicFolderItemId", ["AlternatePublicFolderItemIdType[]", XSD::QName.new(NsTypes, "AlternatePublicFolderItemId")]]
    ]
  )

  EncodedRegistry.register(
    :class => UserIdType,
    :schema_type => XSD::QName.new(NsTypes, "UserIdType"),
    :schema_element => [
      ["sID", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "SID")], [0, 1]],
      ["primarySmtpAddress", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "PrimarySmtpAddress")], [0, 1]],
      ["displayName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayName")], [0, 1]],
      ["distinguishedUser", ["DistinguishedUserType", XSD::QName.new(NsTypes, "DistinguishedUser")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => ArrayOfPermissionsType,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfPermissionsType"),
    :schema_element => [
      ["permission", ["PermissionType[]", XSD::QName.new(NsTypes, "Permission")]]
    ]
  )

  EncodedRegistry.register(
    :class => ArrayOfCalendarPermissionsType,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfCalendarPermissionsType"),
    :schema_element => [
      ["calendarPermission", ["CalendarPermissionType[]", XSD::QName.new(NsTypes, "CalendarPermission")]]
    ]
  )

  EncodedRegistry.register(
    :class => ArrayOfUnknownEntriesType,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfUnknownEntriesType"),
    :schema_element => [
      ["unknownEntry", ["SOAP::SOAPString[]", XSD::QName.new(NsTypes, "UnknownEntry")]]
    ]
  )

  EncodedRegistry.register(
    :class => PermissionType,
    :schema_type => XSD::QName.new(NsTypes, "PermissionType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BasePermissionType"),
    :schema_element => [
      ["userId", ["UserIdType", XSD::QName.new(NsTypes, "UserId")]],
      ["canCreateItems", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "CanCreateItems")], [0, 1]],
      ["canCreateSubFolders", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "CanCreateSubFolders")], [0, 1]],
      ["isFolderOwner", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFolderOwner")], [0, 1]],
      ["isFolderVisible", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFolderVisible")], [0, 1]],
      ["isFolderContact", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFolderContact")], [0, 1]],
      ["editItems", ["PermissionActionType", XSD::QName.new(NsTypes, "EditItems")], [0, 1]],
      ["deleteItems", ["PermissionActionType", XSD::QName.new(NsTypes, "DeleteItems")], [0, 1]],
      ["readItems", ["PermissionReadAccessType", XSD::QName.new(NsTypes, "ReadItems")], [0, 1]],
      ["permissionLevel", ["PermissionLevelType", XSD::QName.new(NsTypes, "PermissionLevel")]]
    ]
  )

  EncodedRegistry.register(
    :class => CalendarPermissionType,
    :schema_type => XSD::QName.new(NsTypes, "CalendarPermissionType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BasePermissionType"),
    :schema_element => [
      ["userId", ["UserIdType", XSD::QName.new(NsTypes, "UserId")]],
      ["canCreateItems", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "CanCreateItems")], [0, 1]],
      ["canCreateSubFolders", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "CanCreateSubFolders")], [0, 1]],
      ["isFolderOwner", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFolderOwner")], [0, 1]],
      ["isFolderVisible", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFolderVisible")], [0, 1]],
      ["isFolderContact", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFolderContact")], [0, 1]],
      ["editItems", ["PermissionActionType", XSD::QName.new(NsTypes, "EditItems")], [0, 1]],
      ["deleteItems", ["PermissionActionType", XSD::QName.new(NsTypes, "DeleteItems")], [0, 1]],
      ["readItems", ["CalendarPermissionReadAccessType", XSD::QName.new(NsTypes, "ReadItems")], [0, 1]],
      ["calendarPermissionLevel", ["CalendarPermissionLevelType", XSD::QName.new(NsTypes, "CalendarPermissionLevel")]]
    ]
  )

  EncodedRegistry.register(
    :class => PermissionSetType,
    :schema_type => XSD::QName.new(NsTypes, "PermissionSetType"),
    :schema_element => [
      ["permissions", ["ArrayOfPermissionsType", XSD::QName.new(NsTypes, "Permissions")]],
      ["unknownEntries", ["ArrayOfUnknownEntriesType", XSD::QName.new(NsTypes, "UnknownEntries")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => CalendarPermissionSetType,
    :schema_type => XSD::QName.new(NsTypes, "CalendarPermissionSetType"),
    :schema_element => [
      ["calendarPermissions", ["ArrayOfCalendarPermissionsType", XSD::QName.new(NsTypes, "CalendarPermissions")]],
      ["unknownEntries", ["ArrayOfUnknownEntriesType", XSD::QName.new(NsTypes, "UnknownEntries")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => EffectiveRightsType,
    :schema_type => XSD::QName.new(NsTypes, "EffectiveRightsType"),
    :schema_element => [
      ["createAssociated", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "CreateAssociated")]],
      ["createContents", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "CreateContents")]],
      ["createHierarchy", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "CreateHierarchy")]],
      ["delete", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "Delete")]],
      ["modify", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "Modify")]],
      ["read", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "Read")]]
    ]
  )

  EncodedRegistry.register(
    :class => ArrayOfDelegateUserType,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfDelegateUserType"),
    :schema_element => [
      ["delegateUser", ["DelegateUserType[]", XSD::QName.new(NsTypes, "DelegateUser")], [1, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => ArrayOfUserIdType,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfUserIdType"),
    :schema_element => [
      ["userId", ["UserIdType[]", XSD::QName.new(NsTypes, "UserId")], [1, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => DelegateUserType,
    :schema_type => XSD::QName.new(NsTypes, "DelegateUserType"),
    :schema_element => [
      ["userId", ["UserIdType", XSD::QName.new(NsTypes, "UserId")]],
      ["delegatePermissions", ["DelegatePermissionsType", XSD::QName.new(NsTypes, "DelegatePermissions")], [0, 1]],
      ["receiveCopiesOfMeetingMessages", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "ReceiveCopiesOfMeetingMessages")], [0, 1]],
      ["viewPrivateItems", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "ViewPrivateItems")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => DelegatePermissionsType,
    :schema_type => XSD::QName.new(NsTypes, "DelegatePermissionsType"),
    :schema_element => [
      ["calendarFolderPermissionLevel", ["DelegateFolderPermissionLevelType", XSD::QName.new(NsTypes, "CalendarFolderPermissionLevel")], [0, 1]],
      ["tasksFolderPermissionLevel", ["DelegateFolderPermissionLevelType", XSD::QName.new(NsTypes, "TasksFolderPermissionLevel")], [0, 1]],
      ["inboxFolderPermissionLevel", ["DelegateFolderPermissionLevelType", XSD::QName.new(NsTypes, "InboxFolderPermissionLevel")], [0, 1]],
      ["contactsFolderPermissionLevel", ["DelegateFolderPermissionLevelType", XSD::QName.new(NsTypes, "ContactsFolderPermissionLevel")], [0, 1]],
      ["notesFolderPermissionLevel", ["DelegateFolderPermissionLevelType", XSD::QName.new(NsTypes, "NotesFolderPermissionLevel")], [0, 1]],
      ["journalFolderPermissionLevel", ["DelegateFolderPermissionLevelType", XSD::QName.new(NsTypes, "JournalFolderPermissionLevel")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => ConflictResultsType,
    :schema_type => XSD::QName.new(NsTypes, "ConflictResultsType"),
    :schema_element => [
      ["count", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Count")]]
    ]
  )

  EncodedRegistry.register(
    :class => ResponseCodeType,
    :schema_type => XSD::QName.new(NsMessages, "ResponseCodeType")
  )

  EncodedRegistry.register(
    :class => ExchangeVersionType,
    :schema_type => XSD::QName.new(NsTypes, "ExchangeVersionType")
  )

  EncodedRegistry.register(
    :class => MailboxTypeType,
    :schema_type => XSD::QName.new(NsTypes, "MailboxTypeType")
  )

  EncodedRegistry.register(
    :class => UnindexedFieldURIType,
    :schema_type => XSD::QName.new(NsTypes, "UnindexedFieldURIType")
  )

  EncodedRegistry.register(
    :class => DictionaryURIType,
    :schema_type => XSD::QName.new(NsTypes, "DictionaryURIType")
  )

  EncodedRegistry.register(
    :class => ExceptionPropertyURIType,
    :schema_type => XSD::QName.new(NsTypes, "ExceptionPropertyURIType")
  )

  EncodedRegistry.register(
    :class => DistinguishedPropertySetType,
    :schema_type => XSD::QName.new(NsTypes, "DistinguishedPropertySetType")
  )

  EncodedRegistry.register(
    :class => MapiPropertyTypeType,
    :schema_type => XSD::QName.new(NsTypes, "MapiPropertyTypeType")
  )

  EncodedRegistry.register(
    :class => FolderQueryTraversalType,
    :schema_type => XSD::QName.new(NsTypes, "FolderQueryTraversalType")
  )

  EncodedRegistry.register(
    :class => SearchFolderTraversalType,
    :schema_type => XSD::QName.new(NsTypes, "SearchFolderTraversalType")
  )

  EncodedRegistry.register(
    :class => ItemQueryTraversalType,
    :schema_type => XSD::QName.new(NsTypes, "ItemQueryTraversalType")
  )

  EncodedRegistry.register(
    :class => DefaultShapeNamesType,
    :schema_type => XSD::QName.new(NsTypes, "DefaultShapeNamesType")
  )

  EncodedRegistry.register(
    :class => BodyTypeResponseType,
    :schema_type => XSD::QName.new(NsTypes, "BodyTypeResponseType")
  )

  EncodedRegistry.register(
    :class => DisposalType,
    :schema_type => XSD::QName.new(NsTypes, "DisposalType")
  )

  EncodedRegistry.register(
    :class => ConflictResolutionType,
    :schema_type => XSD::QName.new(NsTypes, "ConflictResolutionType")
  )

  EncodedRegistry.register(
    :class => ResponseClassType,
    :schema_type => XSD::QName.new(NsTypes, "ResponseClassType")
  )

  EncodedRegistry.register(
    :class => SensitivityChoicesType,
    :schema_type => XSD::QName.new(NsTypes, "SensitivityChoicesType")
  )

  EncodedRegistry.register(
    :class => ImportanceChoicesType,
    :schema_type => XSD::QName.new(NsTypes, "ImportanceChoicesType")
  )

  EncodedRegistry.register(
    :class => BodyTypeType,
    :schema_type => XSD::QName.new(NsTypes, "BodyTypeType")
  )

  EncodedRegistry.register(
    :class => DistinguishedFolderIdNameType,
    :schema_type => XSD::QName.new(NsTypes, "DistinguishedFolderIdNameType")
  )

  EncodedRegistry.register(
    :class => MessageDispositionType,
    :schema_type => XSD::QName.new(NsTypes, "MessageDispositionType")
  )

  EncodedRegistry.register(
    :class => CalendarItemCreateOrDeleteOperationType,
    :schema_type => XSD::QName.new(NsTypes, "CalendarItemCreateOrDeleteOperationType")
  )

  EncodedRegistry.register(
    :class => CalendarItemUpdateOperationType,
    :schema_type => XSD::QName.new(NsTypes, "CalendarItemUpdateOperationType")
  )

  EncodedRegistry.register(
    :class => AffectedTaskOccurrencesType,
    :schema_type => XSD::QName.new(NsTypes, "AffectedTaskOccurrencesType")
  )

  EncodedRegistry.register(
    :class => TaskStatusType,
    :schema_type => XSD::QName.new(NsTypes, "TaskStatusType")
  )

  EncodedRegistry.register(
    :class => TaskDelegateStateType,
    :schema_type => XSD::QName.new(NsTypes, "TaskDelegateStateType")
  )

  EncodedRegistry.register(
    :class => IndexBasePointType,
    :schema_type => XSD::QName.new(NsTypes, "IndexBasePointType")
  )

  EncodedRegistry.register(
    :class => ResolveNamesSearchScopeType,
    :schema_type => XSD::QName.new(NsTypes, "ResolveNamesSearchScopeType")
  )

  EncodedRegistry.register(
    :class => MeetingRequestTypeType,
    :schema_type => XSD::QName.new(NsTypes, "MeetingRequestTypeType")
  )

  EncodedRegistry.register(
    :class => LegacyFreeBusyType,
    :schema_type => XSD::QName.new(NsTypes, "LegacyFreeBusyType")
  )

  EncodedRegistry.register(
    :class => CalendarItemTypeType,
    :schema_type => XSD::QName.new(NsTypes, "CalendarItemTypeType")
  )

  EncodedRegistry.register(
    :class => ResponseTypeType,
    :schema_type => XSD::QName.new(NsTypes, "ResponseTypeType")
  )

  EncodedRegistry.register(
    :class => DayOfWeekType,
    :schema_type => XSD::QName.new(NsTypes, "DayOfWeekType")
  )

  EncodedRegistry.register(
    :class => DayOfWeekIndexType,
    :schema_type => XSD::QName.new(NsTypes, "DayOfWeekIndexType")
  )

  EncodedRegistry.register(
    :class => MonthNamesType,
    :schema_type => XSD::QName.new(NsTypes, "MonthNamesType")
  )

  EncodedRegistry.register(
    :class => ImAddressKeyType,
    :schema_type => XSD::QName.new(NsTypes, "ImAddressKeyType")
  )

  EncodedRegistry.register(
    :class => EmailAddressKeyType,
    :schema_type => XSD::QName.new(NsTypes, "EmailAddressKeyType")
  )

  EncodedRegistry.register(
    :class => PhoneNumberKeyType,
    :schema_type => XSD::QName.new(NsTypes, "PhoneNumberKeyType")
  )

  EncodedRegistry.register(
    :class => PhysicalAddressIndexType,
    :schema_type => XSD::QName.new(NsTypes, "PhysicalAddressIndexType")
  )

  EncodedRegistry.register(
    :class => PhysicalAddressKeyType,
    :schema_type => XSD::QName.new(NsTypes, "PhysicalAddressKeyType")
  )

  EncodedRegistry.register(
    :class => FileAsMappingType,
    :schema_type => XSD::QName.new(NsTypes, "FileAsMappingType")
  )

  EncodedRegistry.register(
    :class => ContactSourceType,
    :schema_type => XSD::QName.new(NsTypes, "ContactSourceType")
  )

  EncodedRegistry.register(
    :class => AggregateType,
    :schema_type => XSD::QName.new(NsTypes, "AggregateType")
  )

  EncodedRegistry.register(
    :class => StandardGroupByType,
    :schema_type => XSD::QName.new(NsTypes, "StandardGroupByType")
  )

  EncodedRegistry.register(
    :class => ContainmentModeType,
    :schema_type => XSD::QName.new(NsTypes, "ContainmentModeType")
  )

  EncodedRegistry.register(
    :class => ContainmentComparisonType,
    :schema_type => XSD::QName.new(NsTypes, "ContainmentComparisonType")
  )

  EncodedRegistry.register(
    :class => SortDirectionType,
    :schema_type => XSD::QName.new(NsTypes, "SortDirectionType")
  )

  EncodedRegistry.register(
    :class => NotificationEventTypeType,
    :schema_type => XSD::QName.new(NsTypes, "NotificationEventTypeType")
  )

  EncodedRegistry.register(
    :class => SubscriptionStatusType,
    :schema_type => XSD::QName.new(NsTypes, "SubscriptionStatusType")
  )

  EncodedRegistry.register(
    :class => AvailabilityProxyRequestType,
    :schema_type => XSD::QName.new(NsTypes, "AvailabilityProxyRequestType")
  )

  EncodedRegistry.register(
    :class => MeetingAttendeeType,
    :schema_type => XSD::QName.new(NsTypes, "MeetingAttendeeType")
  )

  EncodedRegistry.register(
    :class => SuggestionQuality,
    :schema_type => XSD::QName.new(NsTypes, "SuggestionQuality")
  )

  EncodedRegistry.register(
    :class => OofState,
    :schema_type => XSD::QName.new(NsTypes, "OofState")
  )

  EncodedRegistry.register(
    :class => ExternalAudience,
    :schema_type => XSD::QName.new(NsTypes, "ExternalAudience")
  )

  EncodedRegistry.register(
    :class => IdFormatType,
    :schema_type => XSD::QName.new(NsTypes, "IdFormatType")
  )

  EncodedRegistry.register(
    :class => DistinguishedUserType,
    :schema_type => XSD::QName.new(NsTypes, "DistinguishedUserType")
  )

  EncodedRegistry.register(
    :class => PermissionReadAccessType,
    :schema_type => XSD::QName.new(NsTypes, "PermissionReadAccessType")
  )

  EncodedRegistry.register(
    :class => CalendarPermissionReadAccessType,
    :schema_type => XSD::QName.new(NsTypes, "CalendarPermissionReadAccessType")
  )

  EncodedRegistry.register(
    :class => PermissionActionType,
    :schema_type => XSD::QName.new(NsTypes, "PermissionActionType")
  )

  EncodedRegistry.register(
    :class => PermissionLevelType,
    :schema_type => XSD::QName.new(NsTypes, "PermissionLevelType")
  )

  EncodedRegistry.register(
    :class => CalendarPermissionLevelType,
    :schema_type => XSD::QName.new(NsTypes, "CalendarPermissionLevelType")
  )

  EncodedRegistry.register(
    :class => DeliverMeetingRequestsType,
    :schema_type => XSD::QName.new(NsTypes, "DeliverMeetingRequestsType")
  )

  EncodedRegistry.register(
    :class => DelegateFolderPermissionLevelType,
    :schema_type => XSD::QName.new(NsTypes, "DelegateFolderPermissionLevelType")
  )

  LiteralRegistry.register(
    :class => ResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["ResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => ResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  LiteralRegistry.register(
    :class => ArrayOfResponseMessagesType,
    :schema_type => XSD::QName.new(NsMessages, "ArrayOfResponseMessagesType"),
    :schema_element => [ :choice,
      ["createItemResponseMessage", ["ItemInfoResponseMessageType[]", XSD::QName.new(NsMessages, "CreateItemResponseMessage")]],
      ["deleteItemResponseMessage", ["ResponseMessageType[]", XSD::QName.new(NsMessages, "DeleteItemResponseMessage")]],
      ["getItemResponseMessage", ["ItemInfoResponseMessageType[]", XSD::QName.new(NsMessages, "GetItemResponseMessage")]],
      ["updateItemResponseMessage", ["UpdateItemResponseMessageType[]", XSD::QName.new(NsMessages, "UpdateItemResponseMessage")]],
      ["sendItemResponseMessage", ["ResponseMessageType[]", XSD::QName.new(NsMessages, "SendItemResponseMessage")]],
      ["deleteFolderResponseMessage", ["ResponseMessageType[]", XSD::QName.new(NsMessages, "DeleteFolderResponseMessage")]],
      ["createFolderResponseMessage", ["FolderInfoResponseMessageType[]", XSD::QName.new(NsMessages, "CreateFolderResponseMessage")]],
      ["getFolderResponseMessage", ["FolderInfoResponseMessageType[]", XSD::QName.new(NsMessages, "GetFolderResponseMessage")]],
      ["findFolderResponseMessage", ["FindFolderResponseMessageType[]", XSD::QName.new(NsMessages, "FindFolderResponseMessage")]],
      ["updateFolderResponseMessage", ["FolderInfoResponseMessageType[]", XSD::QName.new(NsMessages, "UpdateFolderResponseMessage")]],
      ["moveFolderResponseMessage", ["FolderInfoResponseMessageType[]", XSD::QName.new(NsMessages, "MoveFolderResponseMessage")]],
      ["copyFolderResponseMessage", ["FolderInfoResponseMessageType[]", XSD::QName.new(NsMessages, "CopyFolderResponseMessage")]],
      ["createAttachmentResponseMessage", ["AttachmentInfoResponseMessageType[]", XSD::QName.new(NsMessages, "CreateAttachmentResponseMessage")]],
      ["deleteAttachmentResponseMessage", ["DeleteAttachmentResponseMessageType[]", XSD::QName.new(NsMessages, "DeleteAttachmentResponseMessage")]],
      ["getAttachmentResponseMessage", ["AttachmentInfoResponseMessageType[]", XSD::QName.new(NsMessages, "GetAttachmentResponseMessage")]],
      ["findItemResponseMessage", ["FindItemResponseMessageType[]", XSD::QName.new(NsMessages, "FindItemResponseMessage")]],
      ["moveItemResponseMessage", ["ItemInfoResponseMessageType[]", XSD::QName.new(NsMessages, "MoveItemResponseMessage")]],
      ["copyItemResponseMessage", ["ItemInfoResponseMessageType[]", XSD::QName.new(NsMessages, "CopyItemResponseMessage")]],
      ["resolveNamesResponseMessage", ["ResolveNamesResponseMessageType[]", XSD::QName.new(NsMessages, "ResolveNamesResponseMessage")]],
      ["expandDLResponseMessage", ["ExpandDLResponseMessageType[]", XSD::QName.new(NsMessages, "ExpandDLResponseMessage")]],
      ["getEventsResponseMessage", ["GetEventsResponseMessageType[]", XSD::QName.new(NsMessages, "GetEventsResponseMessage")]],
      ["subscribeResponseMessage", ["SubscribeResponseMessageType[]", XSD::QName.new(NsMessages, "SubscribeResponseMessage")]],
      ["unsubscribeResponseMessage", ["ResponseMessageType[]", XSD::QName.new(NsMessages, "UnsubscribeResponseMessage")]],
      ["sendNotificationResponseMessage", ["SendNotificationResponseMessageType[]", XSD::QName.new(NsMessages, "SendNotificationResponseMessage")]],
      ["syncFolderHierarchyResponseMessage", ["SyncFolderHierarchyResponseMessageType[]", XSD::QName.new(NsMessages, "SyncFolderHierarchyResponseMessage")]],
      ["syncFolderItemsResponseMessage", ["SyncFolderItemsResponseMessageType[]", XSD::QName.new(NsMessages, "SyncFolderItemsResponseMessage")]],
      ["createManagedFolderResponseMessage", ["FolderInfoResponseMessageType[]", XSD::QName.new(NsMessages, "CreateManagedFolderResponseMessage")]],
      ["convertIdResponseMessage", ["ConvertIdResponseMessageType[]", XSD::QName.new(NsMessages, "ConvertIdResponseMessage")]]
    ]
  )

  LiteralRegistry.register(
    :class => BaseResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => GetFolderType,
    :schema_type => XSD::QName.new(NsMessages, "GetFolderType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["folderShape", ["FolderResponseShapeType", XSD::QName.new(NsMessages, "FolderShape")]],
      ["folderIds", ["NonEmptyArrayOfBaseFolderIdsType", XSD::QName.new(NsMessages, "FolderIds")]]
    ]
  )

  LiteralRegistry.register(
    :class => CreateFolderType,
    :schema_type => XSD::QName.new(NsMessages, "CreateFolderType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["parentFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "ParentFolderId")]],
      ["folders", ["NonEmptyArrayOfFoldersType", XSD::QName.new(NsMessages, "Folders")]]
    ]
  )

  LiteralRegistry.register(
    :class => FindFolderType,
    :schema_type => XSD::QName.new(NsMessages, "FindFolderType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["folderShape", ["FolderResponseShapeType", XSD::QName.new(NsMessages, "FolderShape")]],
      [ :choice,
        ["indexedPageFolderView", ["IndexedPageViewType", XSD::QName.new(NsMessages, "IndexedPageFolderView")]],
        ["fractionalPageFolderView", ["FractionalPageViewType", XSD::QName.new(NsMessages, "FractionalPageFolderView")]]
      ],
      ["restriction", ["RestrictionType", XSD::QName.new(NsMessages, "Restriction")], [0, 1]],
      ["parentFolderIds", ["NonEmptyArrayOfBaseFolderIdsType", XSD::QName.new(NsMessages, "ParentFolderIds")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "Traversal") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => FolderInfoResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "FolderInfoResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["FolderInfoResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["folders", ["ArrayOfFoldersType", XSD::QName.new(NsMessages, "Folders")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => FolderInfoResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  LiteralRegistry.register(
    :class => FindFolderResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "FindFolderResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["FindFolderResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["rootFolder", ["FindFolderParentType", XSD::QName.new(NsMessages, "RootFolder")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => FindFolderResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  LiteralRegistry.register(
    :class => FindFolderResponseType,
    :schema_type => XSD::QName.new(NsMessages, "FindFolderResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => DeleteFolderType,
    :schema_type => XSD::QName.new(NsMessages, "DeleteFolderType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["folderIds", ["NonEmptyArrayOfBaseFolderIdsType", XSD::QName.new(NsMessages, "FolderIds")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "DeleteType") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => DeleteFolderResponseType,
    :schema_type => XSD::QName.new(NsMessages, "DeleteFolderResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => BaseMoveCopyFolderType,
    :schema_type => XSD::QName.new(NsMessages, "BaseMoveCopyFolderType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["toFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "ToFolderId")]],
      ["folderIds", ["NonEmptyArrayOfBaseFolderIdsType", XSD::QName.new(NsMessages, "FolderIds")]]
    ]
  )

  LiteralRegistry.register(
    :class => MoveFolderType,
    :schema_type => XSD::QName.new(NsMessages, "MoveFolderType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseMoveCopyFolderType"),
    :schema_element => [
      ["toFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "ToFolderId")]],
      ["folderIds", ["NonEmptyArrayOfBaseFolderIdsType", XSD::QName.new(NsMessages, "FolderIds")]]
    ]
  )

  LiteralRegistry.register(
    :class => CopyFolderType,
    :schema_type => XSD::QName.new(NsMessages, "CopyFolderType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseMoveCopyFolderType"),
    :schema_element => [
      ["toFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "ToFolderId")]],
      ["folderIds", ["NonEmptyArrayOfBaseFolderIdsType", XSD::QName.new(NsMessages, "FolderIds")]]
    ]
  )

  LiteralRegistry.register(
    :class => UpdateFolderType,
    :schema_type => XSD::QName.new(NsMessages, "UpdateFolderType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["folderChanges", ["NonEmptyArrayOfFolderChangesType", XSD::QName.new(NsMessages, "FolderChanges")]]
    ]
  )

  LiteralRegistry.register(
    :class => CreateFolderResponseType,
    :schema_type => XSD::QName.new(NsMessages, "CreateFolderResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => GetFolderResponseType,
    :schema_type => XSD::QName.new(NsMessages, "GetFolderResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => UpdateFolderResponseType,
    :schema_type => XSD::QName.new(NsMessages, "UpdateFolderResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => MoveFolderResponseType,
    :schema_type => XSD::QName.new(NsMessages, "MoveFolderResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => CopyFolderResponseType,
    :schema_type => XSD::QName.new(NsMessages, "CopyFolderResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => GetItemType,
    :schema_type => XSD::QName.new(NsMessages, "GetItemType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["itemShape", ["ItemResponseShapeType", XSD::QName.new(NsMessages, "ItemShape")]],
      ["itemIds", ["NonEmptyArrayOfBaseItemIdsType", XSD::QName.new(NsMessages, "ItemIds")]]
    ]
  )

  LiteralRegistry.register(
    :class => CreateItemType,
    :schema_type => XSD::QName.new(NsMessages, "CreateItemType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["savedItemFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "SavedItemFolderId")], [0, 1]],
      ["items", ["NonEmptyArrayOfAllItemsType", XSD::QName.new(NsMessages, "Items")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "MessageDisposition") => "SOAP::SOAPString",
      XSD::QName.new(nil, "SendMeetingInvitations") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => UpdateItemType,
    :schema_type => XSD::QName.new(NsMessages, "UpdateItemType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["savedItemFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "SavedItemFolderId")], [0, 1]],
      ["itemChanges", ["NonEmptyArrayOfItemChangesType", XSD::QName.new(NsMessages, "ItemChanges")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ConflictResolution") => "SOAP::SOAPString",
      XSD::QName.new(nil, "MessageDisposition") => "SOAP::SOAPString",
      XSD::QName.new(nil, "SendMeetingInvitationsOrCancellations") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => ItemInfoResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "ItemInfoResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["ItemInfoResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["items", ["ArrayOfRealItemsType", XSD::QName.new(NsMessages, "Items")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => ItemInfoResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  LiteralRegistry.register(
    :class => UpdateItemResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "UpdateItemResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ItemInfoResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["UpdateItemResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["items", ["ArrayOfRealItemsType", XSD::QName.new(NsMessages, "Items")]],
      ["conflictResults", ["ConflictResultsType", XSD::QName.new(NsMessages, "ConflictResults")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => UpdateItemResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  LiteralRegistry.register(
    :class => DeleteItemType,
    :schema_type => XSD::QName.new(NsMessages, "DeleteItemType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["itemIds", ["NonEmptyArrayOfBaseItemIdsType", XSD::QName.new(NsMessages, "ItemIds")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "DeleteType") => "SOAP::SOAPString",
      XSD::QName.new(nil, "SendMeetingCancellations") => "SOAP::SOAPString",
      XSD::QName.new(nil, "AffectedTaskOccurrences") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => AttachmentInfoResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "AttachmentInfoResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["AttachmentInfoResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["attachments", ["ArrayOfAttachmentsType", XSD::QName.new(NsMessages, "Attachments")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => AttachmentInfoResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  LiteralRegistry.register(
    :class => DeleteAttachmentResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "DeleteAttachmentResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["DeleteAttachmentResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["rootItemId", ["RootItemIdType", XSD::QName.new(NsMessages, "RootItemId")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => DeleteAttachmentResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  LiteralRegistry.register(
    :class => BaseMoveCopyItemType,
    :schema_type => XSD::QName.new(NsMessages, "BaseMoveCopyItemType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["toFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "ToFolderId")]],
      ["itemIds", ["NonEmptyArrayOfBaseItemIdsType", XSD::QName.new(NsMessages, "ItemIds")]]
    ]
  )

  LiteralRegistry.register(
    :class => MoveItemType,
    :schema_type => XSD::QName.new(NsMessages, "MoveItemType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseMoveCopyItemType"),
    :schema_element => [
      ["toFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "ToFolderId")]],
      ["itemIds", ["NonEmptyArrayOfBaseItemIdsType", XSD::QName.new(NsMessages, "ItemIds")]]
    ]
  )

  LiteralRegistry.register(
    :class => CopyItemType,
    :schema_type => XSD::QName.new(NsMessages, "CopyItemType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseMoveCopyItemType"),
    :schema_element => [
      ["toFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "ToFolderId")]],
      ["itemIds", ["NonEmptyArrayOfBaseItemIdsType", XSD::QName.new(NsMessages, "ItemIds")]]
    ]
  )

  LiteralRegistry.register(
    :class => SendItemType,
    :schema_type => XSD::QName.new(NsMessages, "SendItemType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["itemIds", ["NonEmptyArrayOfBaseItemIdsType", XSD::QName.new(NsMessages, "ItemIds")]],
      ["savedItemFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "SavedItemFolderId")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "SaveItemToFolder") => "SOAP::SOAPBoolean"
    }
  )

  LiteralRegistry.register(
    :class => SendItemResponseType,
    :schema_type => XSD::QName.new(NsMessages, "SendItemResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => FindItemType,
    :schema_type => XSD::QName.new(NsMessages, "FindItemType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["itemShape", ["ItemResponseShapeType", XSD::QName.new(NsMessages, "ItemShape")]],
      [ :choice,
        ["indexedPageItemView", ["IndexedPageViewType", XSD::QName.new(NsMessages, "IndexedPageItemView")]],
        ["fractionalPageItemView", ["FractionalPageViewType", XSD::QName.new(NsMessages, "FractionalPageItemView")]],
        ["calendarView", ["CalendarViewType", XSD::QName.new(NsMessages, "CalendarView")]],
        ["contactsView", ["ContactsViewType", XSD::QName.new(NsMessages, "ContactsView")]]
      ],
      [ :choice,
        ["groupBy", ["GroupByType", XSD::QName.new(NsMessages, "GroupBy")]],
        ["distinguishedGroupBy", ["DistinguishedGroupByType", XSD::QName.new(NsMessages, "DistinguishedGroupBy")]]
      ],
      ["restriction", ["RestrictionType", XSD::QName.new(NsMessages, "Restriction")], [0, 1]],
      ["sortOrder", ["NonEmptyArrayOfFieldOrdersType", XSD::QName.new(NsMessages, "SortOrder")], [0, 1]],
      ["parentFolderIds", ["NonEmptyArrayOfBaseFolderIdsType", XSD::QName.new(NsMessages, "ParentFolderIds")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "Traversal") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => CreateAttachmentType,
    :schema_type => XSD::QName.new(NsMessages, "CreateAttachmentType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["parentItemId", ["ItemIdType", XSD::QName.new(NsMessages, "ParentItemId")]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsMessages, "Attachments")]]
    ]
  )

  LiteralRegistry.register(
    :class => CreateAttachmentResponseType,
    :schema_type => XSD::QName.new(NsMessages, "CreateAttachmentResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => DeleteAttachmentType,
    :schema_type => XSD::QName.new(NsMessages, "DeleteAttachmentType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["attachmentIds", ["NonEmptyArrayOfRequestAttachmentIdsType", XSD::QName.new(NsMessages, "AttachmentIds")]]
    ]
  )

  LiteralRegistry.register(
    :class => DeleteAttachmentResponseType,
    :schema_type => XSD::QName.new(NsMessages, "DeleteAttachmentResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => GetAttachmentType,
    :schema_type => XSD::QName.new(NsMessages, "GetAttachmentType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["attachmentShape", ["AttachmentResponseShapeType", XSD::QName.new(NsMessages, "AttachmentShape")], [0, 1]],
      ["attachmentIds", ["NonEmptyArrayOfRequestAttachmentIdsType", XSD::QName.new(NsMessages, "AttachmentIds")]]
    ]
  )

  LiteralRegistry.register(
    :class => GetAttachmentResponseType,
    :schema_type => XSD::QName.new(NsMessages, "GetAttachmentResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => CreateItemResponseType,
    :schema_type => XSD::QName.new(NsMessages, "CreateItemResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => UpdateItemResponseType,
    :schema_type => XSD::QName.new(NsMessages, "UpdateItemResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => GetItemResponseType,
    :schema_type => XSD::QName.new(NsMessages, "GetItemResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => MoveItemResponseType,
    :schema_type => XSD::QName.new(NsMessages, "MoveItemResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => CopyItemResponseType,
    :schema_type => XSD::QName.new(NsMessages, "CopyItemResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => DeleteItemResponseType,
    :schema_type => XSD::QName.new(NsMessages, "DeleteItemResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => FindItemResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "FindItemResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["FindItemResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["rootFolder", ["FindItemParentType", XSD::QName.new(NsMessages, "RootFolder")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => FindItemResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  LiteralRegistry.register(
    :class => FindItemResponseType,
    :schema_type => XSD::QName.new(NsMessages, "FindItemResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => ResolveNamesType,
    :schema_type => XSD::QName.new(NsMessages, "ResolveNamesType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["parentFolderIds", ["NonEmptyArrayOfBaseFolderIdsType", XSD::QName.new(NsMessages, "ParentFolderIds")], [0, 1]],
      ["unresolvedEntry", [nil, XSD::QName.new(NsMessages, "UnresolvedEntry")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ReturnFullContactData") => "SOAP::SOAPBoolean",
      XSD::QName.new(nil, "SearchScope") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => ResolveNamesResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "ResolveNamesResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["ResolveNamesResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["resolutionSet", ["ArrayOfResolutionType", XSD::QName.new(NsMessages, "ResolutionSet")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => ResolveNamesResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  LiteralRegistry.register(
    :class => ResolveNamesResponseType,
    :schema_type => XSD::QName.new(NsMessages, "ResolveNamesResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => ExpandDLType,
    :schema_type => XSD::QName.new(NsMessages, "ExpandDLType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["mailbox", ["EmailAddressType", XSD::QName.new(NsMessages, "Mailbox")]]
    ]
  )

  LiteralRegistry.register(
    :class => ExpandDLResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "ExpandDLResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["ExpandDLResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["dLExpansion", ["ArrayOfDLExpansionType", XSD::QName.new(NsMessages, "DLExpansion")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString",
      XSD::QName.new(nil, "IndexedPagingOffset") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "NumeratorOffset") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "AbsoluteDenominator") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "IncludesLastItemInRange") => "SOAP::SOAPBoolean",
      XSD::QName.new(nil, "TotalItemsInView") => "SOAP::SOAPInt"
    }
  )

  LiteralRegistry.register(
    :class => ExpandDLResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  LiteralRegistry.register(
    :class => ExpandDLResponseType,
    :schema_type => XSD::QName.new(NsMessages, "ExpandDLResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => CreateManagedFolderRequestType,
    :schema_type => XSD::QName.new(NsMessages, "CreateManagedFolderRequestType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["folderNames", ["NonEmptyArrayOfFolderNamesType", XSD::QName.new(NsMessages, "FolderNames")]],
      ["mailbox", ["EmailAddressType", XSD::QName.new(NsMessages, "Mailbox")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => CreateManagedFolderResponseType,
    :schema_type => XSD::QName.new(NsMessages, "CreateManagedFolderResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => SubscribeType,
    :schema_type => XSD::QName.new(NsMessages, "SubscribeType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [ :choice,
      ["pullSubscriptionRequest", ["PullSubscriptionRequestType", XSD::QName.new(NsMessages, "PullSubscriptionRequest")]],
      ["pushSubscriptionRequest", ["PushSubscriptionRequestType", XSD::QName.new(NsMessages, "PushSubscriptionRequest")]]
    ]
  )

  LiteralRegistry.register(
    :class => SubscribeResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "SubscribeResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["SubscribeResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["subscriptionId", [nil, XSD::QName.new(NsMessages, "SubscriptionId")], [0, 1]],
      ["watermark", [nil, XSD::QName.new(NsMessages, "Watermark")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => SubscribeResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  LiteralRegistry.register(
    :class => SubscribeResponseType,
    :schema_type => XSD::QName.new(NsMessages, "SubscribeResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => UnsubscribeType,
    :schema_type => XSD::QName.new(NsMessages, "UnsubscribeType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["subscriptionId", [nil, XSD::QName.new(NsMessages, "SubscriptionId")]]
    ]
  )

  LiteralRegistry.register(
    :class => UnsubscribeResponseType,
    :schema_type => XSD::QName.new(NsMessages, "UnsubscribeResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => GetEventsType,
    :schema_type => XSD::QName.new(NsMessages, "GetEventsType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["subscriptionId", [nil, XSD::QName.new(NsMessages, "SubscriptionId")]],
      ["watermark", [nil, XSD::QName.new(NsMessages, "Watermark")]]
    ]
  )

  LiteralRegistry.register(
    :class => GetEventsResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "GetEventsResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["GetEventsResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["notification", ["NotificationType", XSD::QName.new(NsMessages, "Notification")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => GetEventsResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  LiteralRegistry.register(
    :class => GetEventsResponseType,
    :schema_type => XSD::QName.new(NsMessages, "GetEventsResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => SendNotificationResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "SendNotificationResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["SendNotificationResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["notification", ["NotificationType", XSD::QName.new(NsMessages, "Notification")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => SendNotificationResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  LiteralRegistry.register(
    :class => SendNotificationResponseType,
    :schema_type => XSD::QName.new(NsMessages, "SendNotificationResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => SendNotificationResultType,
    :schema_type => XSD::QName.new(NsMessages, "SendNotificationResultType"),
    :schema_element => [
      ["subscriptionStatus", ["SubscriptionStatusType", XSD::QName.new(NsMessages, "SubscriptionStatus")]]
    ]
  )

  LiteralRegistry.register(
    :class => SyncFolderHierarchyType,
    :schema_type => XSD::QName.new(NsMessages, "SyncFolderHierarchyType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["folderShape", ["FolderResponseShapeType", XSD::QName.new(NsMessages, "FolderShape")]],
      ["syncFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "SyncFolderId")], [0, 1]],
      ["syncState", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "SyncState")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => SyncFolderHierarchyResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "SyncFolderHierarchyResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["SyncFolderHierarchyResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["syncState", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "SyncState")], [0, 1]],
      ["includesLastFolderInRange", ["SOAP::SOAPBoolean", XSD::QName.new(NsMessages, "IncludesLastFolderInRange")], [0, 1]],
      ["changes", ["SyncFolderHierarchyChangesType", XSD::QName.new(NsMessages, "Changes")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => SyncFolderHierarchyResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  LiteralRegistry.register(
    :class => SyncFolderHierarchyResponseType,
    :schema_type => XSD::QName.new(NsMessages, "SyncFolderHierarchyResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => SyncFolderItemsType,
    :schema_type => XSD::QName.new(NsMessages, "SyncFolderItemsType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["itemShape", ["ItemResponseShapeType", XSD::QName.new(NsMessages, "ItemShape")]],
      ["syncFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "SyncFolderId")]],
      ["syncState", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "SyncState")], [0, 1]],
      ["ignore", ["ArrayOfBaseItemIdsType", XSD::QName.new(NsMessages, "Ignore")], [0, 1]],
      ["maxChangesReturned", [nil, XSD::QName.new(NsMessages, "MaxChangesReturned")]]
    ]
  )

  LiteralRegistry.register(
    :class => SyncFolderItemsResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "SyncFolderItemsResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["SyncFolderItemsResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["syncState", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "SyncState")], [0, 1]],
      ["includesLastItemInRange", ["SOAP::SOAPBoolean", XSD::QName.new(NsMessages, "IncludesLastItemInRange")], [0, 1]],
      ["changes", ["SyncFolderItemsChangesType", XSD::QName.new(NsMessages, "Changes")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => SyncFolderItemsResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  LiteralRegistry.register(
    :class => SyncFolderItemsResponseType,
    :schema_type => XSD::QName.new(NsMessages, "SyncFolderItemsResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => GetUserAvailabilityRequestType,
    :schema_type => XSD::QName.new(NsMessages, "GetUserAvailabilityRequestType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["timeZone", ["SerializableTimeZone", XSD::QName.new(NsTypes, "TimeZone")]],
      ["mailboxDataArray", ["ArrayOfMailboxData", XSD::QName.new(NsMessages, "MailboxDataArray")]],
      ["freeBusyViewOptions", ["FreeBusyViewOptionsType", XSD::QName.new(NsTypes, "FreeBusyViewOptions")], [0, 1]],
      ["suggestionsViewOptions", ["SuggestionsViewOptionsType", XSD::QName.new(NsTypes, "SuggestionsViewOptions")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => FreeBusyResponseType,
    :schema_type => XSD::QName.new(NsMessages, "FreeBusyResponseType"),
    :schema_element => [
      ["responseMessage", ["ResponseMessageType", XSD::QName.new(NsMessages, "ResponseMessage")], [0, 1]],
      ["freeBusyView", ["FreeBusyView", XSD::QName.new(NsMessages, "FreeBusyView")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => ArrayOfFreeBusyResponse,
    :schema_type => XSD::QName.new(NsMessages, "ArrayOfFreeBusyResponse"),
    :schema_element => [
      ["freeBusyResponse", ["FreeBusyResponseType[]", XSD::QName.new(NsMessages, "FreeBusyResponse")], [0, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => SuggestionsResponseType,
    :schema_type => XSD::QName.new(NsMessages, "SuggestionsResponseType"),
    :schema_element => [
      ["responseMessage", ["ResponseMessageType", XSD::QName.new(NsMessages, "ResponseMessage")], [0, 1]],
      ["suggestionDayResultArray", ["ArrayOfSuggestionDayResult", XSD::QName.new(NsMessages, "SuggestionDayResultArray")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => GetUserAvailabilityResponseType,
    :schema_type => XSD::QName.new(NsMessages, "GetUserAvailabilityResponseType"),
    :schema_element => [
      ["freeBusyResponseArray", ["ArrayOfFreeBusyResponse", XSD::QName.new(NsMessages, "FreeBusyResponseArray")], [0, 1]],
      ["suggestionsResponse", ["SuggestionsResponseType", XSD::QName.new(NsMessages, "SuggestionsResponse")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => GetUserOofSettingsRequest,
    :schema_type => XSD::QName.new(NsMessages, "GetUserOofSettingsRequest"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["mailbox", ["EmailAddress", XSD::QName.new(NsTypes, "Mailbox")]]
    ]
  )

  LiteralRegistry.register(
    :class => GetUserOofSettingsResponse,
    :schema_type => XSD::QName.new(NsMessages, "GetUserOofSettingsResponse"),
    :schema_element => [
      ["responseMessage", ["ResponseMessageType", XSD::QName.new(NsMessages, "ResponseMessage")]],
      ["oofSettings", ["UserOofSettings", XSD::QName.new(NsTypes, "OofSettings")], [0, 1]],
      ["allowExternalOof", ["ExternalAudience", XSD::QName.new(NsMessages, "AllowExternalOof")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => SetUserOofSettingsRequest,
    :schema_type => XSD::QName.new(NsMessages, "SetUserOofSettingsRequest"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["mailbox", ["EmailAddress", XSD::QName.new(NsTypes, "Mailbox")]],
      ["userOofSettings", ["UserOofSettings", XSD::QName.new(NsTypes, "UserOofSettings")]]
    ]
  )

  LiteralRegistry.register(
    :class => SetUserOofSettingsResponse,
    :schema_type => XSD::QName.new(NsMessages, "SetUserOofSettingsResponse"),
    :schema_element => [
      ["responseMessage", ["ResponseMessageType", XSD::QName.new(NsMessages, "ResponseMessage")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => ConvertIdType,
    :schema_type => XSD::QName.new(NsMessages, "ConvertIdType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseRequestType"),
    :schema_element => [
      ["sourceIds", ["NonEmptyArrayOfAlternateIdsType", XSD::QName.new(NsMessages, "SourceIds")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "DestinationFormat") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => ConvertIdResponseType,
    :schema_type => XSD::QName.new(NsMessages, "ConvertIdResponseType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseResponseMessageType"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => ConvertIdResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "ConvertIdResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["ConvertIdResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["alternateId", ["AlternateIdBaseType", XSD::QName.new(NsMessages, "AlternateId")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => ConvertIdResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  LiteralRegistry.register(
    :class => GetDelegateType,
    :schema_type => XSD::QName.new(NsMessages, "GetDelegateType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseDelegateType"),
    :schema_element => [
      ["mailbox", ["EmailAddressType", XSD::QName.new(NsMessages, "Mailbox")]],
      ["userIds", ["ArrayOfUserIdType", XSD::QName.new(NsMessages, "UserIds")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "IncludePermissions") => "SOAP::SOAPBoolean"
    }
  )

  LiteralRegistry.register(
    :class => GetDelegateResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "GetDelegateResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseDelegateResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["GetDelegateResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["responseMessages", ["ArrayOfDelegateUserResponseMessageType", XSD::QName.new(NsMessages, "ResponseMessages")], [0, 1]],
      ["deliverMeetingRequests", ["DeliverMeetingRequestsType", XSD::QName.new(NsMessages, "DeliverMeetingRequests")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => GetDelegateResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  LiteralRegistry.register(
    :class => ArrayOfDelegateUserResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "ArrayOfDelegateUserResponseMessageType"),
    :schema_element => [
      ["delegateUserResponseMessageType", ["DelegateUserResponseMessageType[]", XSD::QName.new(NsMessages, "DelegateUserResponseMessageType")], [1, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => DelegateUserResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "DelegateUserResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "ResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["DelegateUserResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["delegateUser", ["DelegateUserType", XSD::QName.new(NsMessages, "DelegateUser")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => DelegateUserResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  LiteralRegistry.register(
    :class => AddDelegateType,
    :schema_type => XSD::QName.new(NsMessages, "AddDelegateType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseDelegateType"),
    :schema_element => [
      ["mailbox", ["EmailAddressType", XSD::QName.new(NsMessages, "Mailbox")]],
      ["delegateUsers", ["ArrayOfDelegateUserType", XSD::QName.new(NsMessages, "DelegateUsers")]],
      ["deliverMeetingRequests", ["DeliverMeetingRequestsType", XSD::QName.new(NsMessages, "DeliverMeetingRequests")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => AddDelegateResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "AddDelegateResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseDelegateResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["AddDelegateResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["responseMessages", ["ArrayOfDelegateUserResponseMessageType", XSD::QName.new(NsMessages, "ResponseMessages")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => AddDelegateResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  LiteralRegistry.register(
    :class => RemoveDelegateType,
    :schema_type => XSD::QName.new(NsMessages, "RemoveDelegateType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseDelegateType"),
    :schema_element => [
      ["mailbox", ["EmailAddressType", XSD::QName.new(NsMessages, "Mailbox")]],
      ["userIds", ["ArrayOfUserIdType", XSD::QName.new(NsMessages, "UserIds")]]
    ]
  )

  LiteralRegistry.register(
    :class => RemoveDelegateResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "RemoveDelegateResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseDelegateResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["RemoveDelegateResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["responseMessages", ["ArrayOfDelegateUserResponseMessageType", XSD::QName.new(NsMessages, "ResponseMessages")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => RemoveDelegateResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  LiteralRegistry.register(
    :class => UpdateDelegateType,
    :schema_type => XSD::QName.new(NsMessages, "UpdateDelegateType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseDelegateType"),
    :schema_element => [
      ["mailbox", ["EmailAddressType", XSD::QName.new(NsMessages, "Mailbox")]],
      ["delegateUsers", ["ArrayOfDelegateUserType", XSD::QName.new(NsMessages, "DelegateUsers")], [0, 1]],
      ["deliverMeetingRequests", ["DeliverMeetingRequestsType", XSD::QName.new(NsMessages, "DeliverMeetingRequests")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => UpdateDelegateResponseMessageType,
    :schema_type => XSD::QName.new(NsMessages, "UpdateDelegateResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsMessages, "BaseDelegateResponseMessageType"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["UpdateDelegateResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["responseMessages", ["ArrayOfDelegateUserResponseMessageType", XSD::QName.new(NsMessages, "ResponseMessages")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => UpdateDelegateResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  LiteralRegistry.register(
    :class => SidAndAttributesType,
    :schema_type => XSD::QName.new(NsTypes, "SidAndAttributesType"),
    :schema_element => [
      ["securityIdentifier", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "SecurityIdentifier")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "Attributes") => "SOAP::SOAPUnsignedInt"
    }
  )

  LiteralRegistry.register(
    :class => NonEmptyArrayOfGroupIdentifiersType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfGroupIdentifiersType"),
    :schema_element => [
      ["groupIdentifier", ["SidAndAttributesType[]", XSD::QName.new(NsTypes, "GroupIdentifier")], [1, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => NonEmptyArrayOfRestrictedGroupIdentifiersType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfRestrictedGroupIdentifiersType"),
    :schema_element => [
      ["restrictedGroupIdentifier", ["SidAndAttributesType[]", XSD::QName.new(NsTypes, "RestrictedGroupIdentifier")], [1, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => SerializedSecurityContextType,
    :schema_type => XSD::QName.new(NsTypes, "SerializedSecurityContextType"),
    :schema_element => [
      ["userSid", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "UserSid")]],
      ["groupSids", ["NonEmptyArrayOfGroupIdentifiersType", XSD::QName.new(NsTypes, "GroupSids")], [0, 1]],
      ["restrictedGroupSids", ["NonEmptyArrayOfRestrictedGroupIdentifiersType", XSD::QName.new(NsTypes, "RestrictedGroupSids")], [0, 1]],
      ["primarySmtpAddress", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "PrimarySmtpAddress")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => ConnectingSIDType,
    :schema_type => XSD::QName.new(NsTypes, "ConnectingSIDType"),
    :schema_element => [
      ["principalName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "PrincipalName")], [0, 1]],
      ["sID", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "SID")], [0, 1]],
      ["primarySmtpAddress", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "PrimarySmtpAddress")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => ExchangeImpersonationType,
    :schema_type => XSD::QName.new(NsTypes, "ExchangeImpersonationType"),
    :schema_element => [
      ["connectingSID", ["ConnectingSIDType", XSD::QName.new(NsTypes, "ConnectingSID")]]
    ]
  )

  LiteralRegistry.register(
    :class => ProxySecurityContextType,
    :schema_type => XSD::QName.new(NsTypes, "ProxySecurityContextType")
  )

  LiteralRegistry.register(
    :class => BaseEmailAddressType,
    :schema_type => XSD::QName.new(NsTypes, "BaseEmailAddressType"),
    :schema_element => []
  )

  LiteralRegistry.register(
    :class => EmailAddressType,
    :schema_type => XSD::QName.new(NsTypes, "EmailAddressType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseEmailAddressType"),
    :schema_element => [
      ["name", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Name")], [0, 1]],
      ["emailAddress", [nil, XSD::QName.new(NsTypes, "EmailAddress")], [0, 1]],
      ["routingType", [nil, XSD::QName.new(NsTypes, "RoutingType")], [0, 1]],
      ["mailboxType", ["MailboxTypeType", XSD::QName.new(NsTypes, "MailboxType")], [0, 1]],
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => ArrayOfRecipientsType,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfRecipientsType"),
    :schema_element => [
      ["mailbox", ["EmailAddressType[]", XSD::QName.new(NsTypes, "Mailbox")]]
    ]
  )

  LiteralRegistry.register(
    :class => SingleRecipientType,
    :schema_type => XSD::QName.new(NsTypes, "SingleRecipientType"),
    :schema_element => [ :choice,
      ["mailbox", ["EmailAddressType", XSD::QName.new(NsTypes, "Mailbox")]]
    ]
  )

  LiteralRegistry.register(
    :class => PathToUnindexedFieldType,
    :schema_type => XSD::QName.new(NsTypes, "PathToUnindexedFieldType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BasePathToElementType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "FieldURI") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => PathToIndexedFieldType,
    :schema_type => XSD::QName.new(NsTypes, "PathToIndexedFieldType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BasePathToElementType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "FieldURI") => "SOAP::SOAPString",
      XSD::QName.new(nil, "FieldIndex") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => PathToExceptionFieldType,
    :schema_type => XSD::QName.new(NsTypes, "PathToExceptionFieldType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BasePathToElementType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "FieldURI") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => PathToExtendedFieldType,
    :schema_type => XSD::QName.new(NsTypes, "PathToExtendedFieldType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BasePathToElementType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "DistinguishedPropertySetId") => "SOAP::SOAPString",
      XSD::QName.new(nil, "PropertySetId") => "SOAP::SOAPString",
      XSD::QName.new(nil, "PropertyTag") => nil,
      XSD::QName.new(nil, "PropertyName") => "SOAP::SOAPString",
      XSD::QName.new(nil, "PropertyId") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "PropertyType") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => NonEmptyArrayOfPathsToElementType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfPathsToElementType"),
    :schema_element => [
      ["path", ["BasePathToElementType[]", XSD::QName.new(NsTypes, "Path")]]
    ]
  )

  LiteralRegistry.register(
    :class => NonEmptyArrayOfPropertyValuesType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfPropertyValuesType"),
    :schema_element => [
      ["value", ["SOAP::SOAPString[]", XSD::QName.new(NsTypes, "Value")], [1, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => ExtendedPropertyType,
    :schema_type => XSD::QName.new(NsTypes, "ExtendedPropertyType"),
    :schema_element => [
      ["extendedFieldURI", ["PathToExtendedFieldType", XSD::QName.new(NsTypes, "ExtendedFieldURI")]],
      [ :choice,
        ["value", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Value")]],
        ["values", ["NonEmptyArrayOfPropertyValuesType", XSD::QName.new(NsTypes, "Values")]]
      ]
    ]
  )

  LiteralRegistry.register(
    :class => FolderResponseShapeType,
    :schema_type => XSD::QName.new(NsTypes, "FolderResponseShapeType"),
    :schema_element => [
      ["baseShape", ["DefaultShapeNamesType", XSD::QName.new(NsTypes, "BaseShape")]],
      ["additionalProperties", ["NonEmptyArrayOfPathsToElementType", XSD::QName.new(NsTypes, "AdditionalProperties")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => ItemResponseShapeType,
    :schema_type => XSD::QName.new(NsTypes, "ItemResponseShapeType"),
    :schema_element => [
      ["baseShape", ["DefaultShapeNamesType", XSD::QName.new(NsTypes, "BaseShape")]],
      ["includeMimeContent", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IncludeMimeContent")], [0, 1]],
      ["bodyType", ["BodyTypeResponseType", XSD::QName.new(NsTypes, "BodyType")], [0, 1]],
      ["additionalProperties", ["NonEmptyArrayOfPathsToElementType", XSD::QName.new(NsTypes, "AdditionalProperties")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => AttachmentResponseShapeType,
    :schema_type => XSD::QName.new(NsTypes, "AttachmentResponseShapeType"),
    :schema_element => [
      ["includeMimeContent", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IncludeMimeContent")], [0, 1]],
      ["bodyType", ["BodyTypeResponseType", XSD::QName.new(NsTypes, "BodyType")], [0, 1]],
      ["additionalProperties", ["NonEmptyArrayOfPathsToElementType", XSD::QName.new(NsTypes, "AdditionalProperties")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => ItemChangeDescriptionType,
    :schema_type => XSD::QName.new(NsTypes, "ItemChangeDescriptionType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ChangeDescriptionType"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]]
    ]
  )

  LiteralRegistry.register(
    :class => FolderChangeDescriptionType,
    :schema_type => XSD::QName.new(NsTypes, "FolderChangeDescriptionType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ChangeDescriptionType"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]]
    ]
  )

  LiteralRegistry.register(
    :class => SetItemFieldType,
    :schema_type => XSD::QName.new(NsTypes, "SetItemFieldType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ItemChangeDescriptionType"),
    :schema_element => [ :choice,
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["item", ["ItemType", XSD::QName.new(NsTypes, "Item")]],
      ["message", ["MessageType", XSD::QName.new(NsTypes, "Message")]],
      ["calendarItem", ["CalendarItemType", XSD::QName.new(NsTypes, "CalendarItem")]],
      ["contact", ["ContactItemType", XSD::QName.new(NsTypes, "Contact")]],
      ["distributionList", ["DistributionListType", XSD::QName.new(NsTypes, "DistributionList")]],
      ["meetingMessage", ["MeetingMessageType", XSD::QName.new(NsTypes, "MeetingMessage")]],
      ["meetingRequest", ["MeetingRequestMessageType", XSD::QName.new(NsTypes, "MeetingRequest")]],
      ["meetingResponse", ["MeetingResponseMessageType", XSD::QName.new(NsTypes, "MeetingResponse")]],
      ["meetingCancellation", ["MeetingCancellationMessageType", XSD::QName.new(NsTypes, "MeetingCancellation")]],
      ["task", ["TaskType", XSD::QName.new(NsTypes, "Task")]],
      ["postItem", ["PostItemType", XSD::QName.new(NsTypes, "PostItem")]]
    ]
  )

  LiteralRegistry.register(
    :class => SetFolderFieldType,
    :schema_type => XSD::QName.new(NsTypes, "SetFolderFieldType"),
    :schema_basetype => XSD::QName.new(NsTypes, "FolderChangeDescriptionType"),
    :schema_element => [ :choice,
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["folder", ["FolderType", XSD::QName.new(NsTypes, "Folder")]],
      ["calendarFolder", ["CalendarFolderType", XSD::QName.new(NsTypes, "CalendarFolder")]],
      ["contactsFolder", ["ContactsFolderType", XSD::QName.new(NsTypes, "ContactsFolder")]],
      ["searchFolder", ["SearchFolderType", XSD::QName.new(NsTypes, "SearchFolder")]],
      ["tasksFolder", ["TasksFolderType", XSD::QName.new(NsTypes, "TasksFolder")]]
    ]
  )

  LiteralRegistry.register(
    :class => DeleteItemFieldType,
    :schema_type => XSD::QName.new(NsTypes, "DeleteItemFieldType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ItemChangeDescriptionType"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]]
    ]
  )

  LiteralRegistry.register(
    :class => DeleteFolderFieldType,
    :schema_type => XSD::QName.new(NsTypes, "DeleteFolderFieldType"),
    :schema_basetype => XSD::QName.new(NsTypes, "FolderChangeDescriptionType"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]]
    ]
  )

  LiteralRegistry.register(
    :class => AppendToItemFieldType,
    :schema_type => XSD::QName.new(NsTypes, "AppendToItemFieldType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ItemChangeDescriptionType"),
    :schema_element => [ :choice,
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["item", ["ItemType", XSD::QName.new(NsTypes, "Item")]],
      ["message", ["MessageType", XSD::QName.new(NsTypes, "Message")]],
      ["calendarItem", ["CalendarItemType", XSD::QName.new(NsTypes, "CalendarItem")]],
      ["contact", ["ContactItemType", XSD::QName.new(NsTypes, "Contact")]],
      ["distributionList", ["DistributionListType", XSD::QName.new(NsTypes, "DistributionList")]],
      ["meetingMessage", ["MeetingMessageType", XSD::QName.new(NsTypes, "MeetingMessage")]],
      ["meetingRequest", ["MeetingRequestMessageType", XSD::QName.new(NsTypes, "MeetingRequest")]],
      ["meetingResponse", ["MeetingResponseMessageType", XSD::QName.new(NsTypes, "MeetingResponse")]],
      ["meetingCancellation", ["MeetingCancellationMessageType", XSD::QName.new(NsTypes, "MeetingCancellation")]],
      ["task", ["TaskType", XSD::QName.new(NsTypes, "Task")]],
      ["postItem", ["PostItemType", XSD::QName.new(NsTypes, "PostItem")]]
    ]
  )

  LiteralRegistry.register(
    :class => AppendToFolderFieldType,
    :schema_type => XSD::QName.new(NsTypes, "AppendToFolderFieldType"),
    :schema_basetype => XSD::QName.new(NsTypes, "FolderChangeDescriptionType"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      [ :choice,
        ["folder", ["FolderType", XSD::QName.new(NsTypes, "Folder")]],
        ["calendarFolder", ["CalendarFolderType", XSD::QName.new(NsTypes, "CalendarFolder")]],
        ["contactsFolder", ["ContactsFolderType", XSD::QName.new(NsTypes, "ContactsFolder")]],
        ["searchFolder", ["SearchFolderType", XSD::QName.new(NsTypes, "SearchFolder")]],
        ["tasksFolder", ["TasksFolderType", XSD::QName.new(NsTypes, "TasksFolder")]]
      ]
    ]
  )

  LiteralRegistry.register(
    :class => NonEmptyArrayOfItemChangeDescriptionsType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfItemChangeDescriptionsType"),
    :schema_element => [ :choice,
      ["appendToItemField", ["AppendToItemFieldType[]", XSD::QName.new(NsTypes, "AppendToItemField")]],
      ["setItemField", ["SetItemFieldType[]", XSD::QName.new(NsTypes, "SetItemField")]],
      ["deleteItemField", ["DeleteItemFieldType[]", XSD::QName.new(NsTypes, "DeleteItemField")]]
    ]
  )

  LiteralRegistry.register(
    :class => NonEmptyArrayOfFolderChangeDescriptionsType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfFolderChangeDescriptionsType"),
    :schema_element => [ :choice,
      ["appendToFolderField", ["AppendToFolderFieldType[]", XSD::QName.new(NsTypes, "AppendToFolderField")]],
      ["setFolderField", ["SetFolderFieldType[]", XSD::QName.new(NsTypes, "SetFolderField")]],
      ["deleteFolderField", ["DeleteFolderFieldType[]", XSD::QName.new(NsTypes, "DeleteFolderField")]]
    ]
  )

  LiteralRegistry.register(
    :class => ItemChangeType,
    :schema_type => XSD::QName.new(NsTypes, "ItemChangeType"),
    :schema_element => [
      [ :choice,
        ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")]],
        ["occurrenceItemId", ["OccurrenceItemIdType", XSD::QName.new(NsTypes, "OccurrenceItemId")]],
        ["recurringMasterItemId", ["RecurringMasterItemIdType", XSD::QName.new(NsTypes, "RecurringMasterItemId")]]
      ],
      ["updates", ["NonEmptyArrayOfItemChangeDescriptionsType", XSD::QName.new(NsTypes, "Updates")]]
    ]
  )

  LiteralRegistry.register(
    :class => NonEmptyArrayOfItemChangesType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfItemChangesType"),
    :schema_element => [
      ["itemChange", ["ItemChangeType[]", XSD::QName.new(NsTypes, "ItemChange")], [1, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => InternetHeaderType,
    :schema_type => XSD::QName.new(NsTypes, "InternetHeaderType"),
    :schema_attribute => {
      XSD::QName.new(nil, "HeaderName") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => NonEmptyArrayOfInternetHeadersType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfInternetHeadersType"),
    :schema_element => [
      ["internetMessageHeader", ["InternetHeaderType[]", XSD::QName.new(NsTypes, "InternetMessageHeader")], [1, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => RequestAttachmentIdType,
    :schema_type => XSD::QName.new(NsTypes, "RequestAttachmentIdType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseItemIdType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "Id") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => AttachmentIdType,
    :schema_type => XSD::QName.new(NsTypes, "AttachmentIdType"),
    :schema_basetype => XSD::QName.new(NsTypes, "RequestAttachmentIdType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "Id") => "SOAP::SOAPString",
      XSD::QName.new(nil, "RootItemId") => "SOAP::SOAPString",
      XSD::QName.new(nil, "RootItemChangeKey") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => RootItemIdType,
    :schema_type => XSD::QName.new(NsTypes, "RootItemIdType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseItemIdType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "RootItemId") => "SOAP::SOAPString",
      XSD::QName.new(nil, "RootItemChangeKey") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => NonEmptyArrayOfRequestAttachmentIdsType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfRequestAttachmentIdsType"),
    :schema_element => [
      ["attachmentId", ["RequestAttachmentIdType[]", XSD::QName.new(NsTypes, "AttachmentId")]]
    ]
  )

  LiteralRegistry.register(
    :class => AttachmentType,
    :schema_type => XSD::QName.new(NsTypes, "AttachmentType"),
    :schema_element => [
      ["attachmentId", ["AttachmentIdType", XSD::QName.new(NsTypes, "AttachmentId")], [0, 1]],
      ["name", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Name")], [0, 1]],
      ["contentType", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ContentType")], [0, 1]],
      ["contentId", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ContentId")], [0, 1]],
      ["contentLocation", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ContentLocation")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => ItemAttachmentType,
    :schema_type => XSD::QName.new(NsTypes, "ItemAttachmentType"),
    :schema_basetype => XSD::QName.new(NsTypes, "AttachmentType"),
    :schema_element => [ :choice,
      ["attachmentId", ["AttachmentIdType", XSD::QName.new(NsTypes, "AttachmentId")], [0, 1]],
      ["name", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Name")], [0, 1]],
      ["contentType", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ContentType")], [0, 1]],
      ["contentId", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ContentId")], [0, 1]],
      ["contentLocation", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ContentLocation")], [0, 1]],
      ["item", ["ItemType", XSD::QName.new(NsTypes, "Item")]],
      ["message", ["MessageType", XSD::QName.new(NsTypes, "Message")]],
      ["calendarItem", ["CalendarItemType", XSD::QName.new(NsTypes, "CalendarItem")]],
      ["contact", ["ContactItemType", XSD::QName.new(NsTypes, "Contact")]],
      ["meetingMessage", ["MeetingMessageType", XSD::QName.new(NsTypes, "MeetingMessage")]],
      ["meetingRequest", ["MeetingRequestMessageType", XSD::QName.new(NsTypes, "MeetingRequest")]],
      ["meetingResponse", ["MeetingResponseMessageType", XSD::QName.new(NsTypes, "MeetingResponse")]],
      ["meetingCancellation", ["MeetingCancellationMessageType", XSD::QName.new(NsTypes, "MeetingCancellation")]],
      ["task", ["TaskType", XSD::QName.new(NsTypes, "Task")]],
      ["postItem", ["PostItemType", XSD::QName.new(NsTypes, "PostItem")]]
    ]
  )

  LiteralRegistry.register(
    :class => SyncFolderItemsCreateOrUpdateType,
    :schema_type => XSD::QName.new(NsTypes, "SyncFolderItemsCreateOrUpdateType"),
    :schema_element => [ :choice,
      ["item", ["ItemType", XSD::QName.new(NsTypes, "Item")]],
      ["message", ["MessageType", XSD::QName.new(NsTypes, "Message")]],
      ["calendarItem", ["CalendarItemType", XSD::QName.new(NsTypes, "CalendarItem")]],
      ["contact", ["ContactItemType", XSD::QName.new(NsTypes, "Contact")]],
      ["distributionList", ["DistributionListType", XSD::QName.new(NsTypes, "DistributionList")]],
      ["meetingMessage", ["MeetingMessageType", XSD::QName.new(NsTypes, "MeetingMessage")]],
      ["meetingRequest", ["MeetingRequestMessageType", XSD::QName.new(NsTypes, "MeetingRequest")]],
      ["meetingResponse", ["MeetingResponseMessageType", XSD::QName.new(NsTypes, "MeetingResponse")]],
      ["meetingCancellation", ["MeetingCancellationMessageType", XSD::QName.new(NsTypes, "MeetingCancellation")]],
      ["task", ["TaskType", XSD::QName.new(NsTypes, "Task")]],
      ["postItem", ["PostItemType", XSD::QName.new(NsTypes, "PostItem")]]
    ]
  )

  LiteralRegistry.register(
    :class => FileAttachmentType,
    :schema_type => XSD::QName.new(NsTypes, "FileAttachmentType"),
    :schema_basetype => XSD::QName.new(NsTypes, "AttachmentType"),
    :schema_element => [
      ["attachmentId", ["AttachmentIdType", XSD::QName.new(NsTypes, "AttachmentId")], [0, 1]],
      ["name", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Name")], [0, 1]],
      ["contentType", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ContentType")], [0, 1]],
      ["contentId", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ContentId")], [0, 1]],
      ["contentLocation", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ContentLocation")], [0, 1]],
      ["content", ["SOAP::SOAPBase64", XSD::QName.new(NsTypes, "Content")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => ArrayOfAttachmentsType,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfAttachmentsType"),
    :schema_element => [ :choice,
      ["itemAttachment", ["ItemAttachmentType[]", XSD::QName.new(NsTypes, "ItemAttachment")]],
      ["fileAttachment", ["FileAttachmentType[]", XSD::QName.new(NsTypes, "FileAttachment")]]
    ]
  )

  LiteralRegistry.register(
    :class => NonEmptyArrayOfAttachmentsType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfAttachmentsType"),
    :schema_element => [ :choice,
      ["itemAttachment", ["ItemAttachmentType[]", XSD::QName.new(NsTypes, "ItemAttachment")]],
      ["fileAttachment", ["FileAttachmentType[]", XSD::QName.new(NsTypes, "FileAttachment")]]
    ]
  )

  LiteralRegistry.register(
    :class => BodyType,
    :schema_type => XSD::QName.new(NsTypes, "BodyType"),
    :schema_attribute => {
      XSD::QName.new(nil, "BodyType") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => DistinguishedFolderIdType,
    :schema_type => XSD::QName.new(NsTypes, "DistinguishedFolderIdType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseFolderIdType"),
    :schema_element => [
      ["mailbox", ["EmailAddressType", XSD::QName.new(NsTypes, "Mailbox")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "Id") => "SOAP::SOAPString",
      XSD::QName.new(nil, "ChangeKey") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => FolderIdType,
    :schema_type => XSD::QName.new(NsTypes, "FolderIdType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseFolderIdType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "Id") => "SOAP::SOAPString",
      XSD::QName.new(nil, "ChangeKey") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => NonEmptyArrayOfBaseFolderIdsType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfBaseFolderIdsType"),
    :schema_element => [ :choice,
      ["folderId", ["FolderIdType[]", XSD::QName.new(NsTypes, "FolderId")]],
      ["distinguishedFolderId", ["DistinguishedFolderIdType[]", XSD::QName.new(NsTypes, "DistinguishedFolderId")]]
    ]
  )

  LiteralRegistry.register(
    :class => TargetFolderIdType,
    :schema_type => XSD::QName.new(NsTypes, "TargetFolderIdType"),
    :schema_element => [ :choice,
      ["folderId", ["FolderIdType", XSD::QName.new(NsTypes, "FolderId")]],
      ["distinguishedFolderId", ["DistinguishedFolderIdType", XSD::QName.new(NsTypes, "DistinguishedFolderId")]]
    ]
  )

  LiteralRegistry.register(
    :class => FindFolderParentType,
    :schema_type => XSD::QName.new(NsTypes, "FindFolderParentType"),
    :schema_element => [
      ["folders", ["ArrayOfFoldersType", XSD::QName.new(NsTypes, "Folders")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "IndexedPagingOffset") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "NumeratorOffset") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "AbsoluteDenominator") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "IncludesLastItemInRange") => "SOAP::SOAPBoolean",
      XSD::QName.new(nil, "TotalItemsInView") => "SOAP::SOAPInt"
    }
  )

  LiteralRegistry.register(
    :class => ManagedFolderInformationType,
    :schema_type => XSD::QName.new(NsTypes, "ManagedFolderInformationType"),
    :schema_element => [
      ["canDelete", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "CanDelete")], [0, 1]],
      ["canRenameOrMove", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "CanRenameOrMove")], [0, 1]],
      ["mustDisplayComment", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "MustDisplayComment")], [0, 1]],
      ["hasQuota", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasQuota")], [0, 1]],
      ["isManagedFoldersRoot", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsManagedFoldersRoot")], [0, 1]],
      ["managedFolderId", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ManagedFolderId")], [0, 1]],
      ["comment", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Comment")], [0, 1]],
      ["storageQuota", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "StorageQuota")], [0, 1]],
      ["folderSize", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "FolderSize")], [0, 1]],
      ["homePage", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "HomePage")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => FolderType,
    :schema_type => XSD::QName.new(NsTypes, "FolderType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseFolderType"),
    :schema_element => [
      ["folderId", ["FolderIdType", XSD::QName.new(NsTypes, "FolderId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["folderClass", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "FolderClass")], [0, 1]],
      ["displayName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayName")], [0, 1]],
      ["totalCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "TotalCount")], [0, 1]],
      ["childFolderCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "ChildFolderCount")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["managedFolderInformation", ["ManagedFolderInformationType", XSD::QName.new(NsTypes, "ManagedFolderInformation")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["permissionSet", ["PermissionSetType", XSD::QName.new(NsTypes, "PermissionSet")], [0, 1]],
      ["unreadCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "UnreadCount")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => CalendarFolderType,
    :schema_type => XSD::QName.new(NsTypes, "CalendarFolderType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseFolderType"),
    :schema_element => [
      ["folderId", ["FolderIdType", XSD::QName.new(NsTypes, "FolderId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["folderClass", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "FolderClass")], [0, 1]],
      ["displayName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayName")], [0, 1]],
      ["totalCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "TotalCount")], [0, 1]],
      ["childFolderCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "ChildFolderCount")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["managedFolderInformation", ["ManagedFolderInformationType", XSD::QName.new(NsTypes, "ManagedFolderInformation")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["permissionSet", ["CalendarPermissionSetType", XSD::QName.new(NsTypes, "PermissionSet")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => ContactsFolderType,
    :schema_type => XSD::QName.new(NsTypes, "ContactsFolderType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseFolderType"),
    :schema_element => [
      ["folderId", ["FolderIdType", XSD::QName.new(NsTypes, "FolderId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["folderClass", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "FolderClass")], [0, 1]],
      ["displayName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayName")], [0, 1]],
      ["totalCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "TotalCount")], [0, 1]],
      ["childFolderCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "ChildFolderCount")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["managedFolderInformation", ["ManagedFolderInformationType", XSD::QName.new(NsTypes, "ManagedFolderInformation")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["permissionSet", ["PermissionSetType", XSD::QName.new(NsTypes, "PermissionSet")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => SearchFolderType,
    :schema_type => XSD::QName.new(NsTypes, "SearchFolderType"),
    :schema_basetype => XSD::QName.new(NsTypes, "FolderType"),
    :schema_element => [
      ["folderId", ["FolderIdType", XSD::QName.new(NsTypes, "FolderId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["folderClass", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "FolderClass")], [0, 1]],
      ["displayName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayName")], [0, 1]],
      ["totalCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "TotalCount")], [0, 1]],
      ["childFolderCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "ChildFolderCount")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["managedFolderInformation", ["ManagedFolderInformationType", XSD::QName.new(NsTypes, "ManagedFolderInformation")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["permissionSet", ["PermissionSetType", XSD::QName.new(NsTypes, "PermissionSet")], [0, 1]],
      ["unreadCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "UnreadCount")], [0, 1]],
      ["searchParameters", ["SearchParametersType", XSD::QName.new(NsTypes, "SearchParameters")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => TasksFolderType,
    :schema_type => XSD::QName.new(NsTypes, "TasksFolderType"),
    :schema_basetype => XSD::QName.new(NsTypes, "FolderType"),
    :schema_element => [
      ["folderId", ["FolderIdType", XSD::QName.new(NsTypes, "FolderId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["folderClass", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "FolderClass")], [0, 1]],
      ["displayName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayName")], [0, 1]],
      ["totalCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "TotalCount")], [0, 1]],
      ["childFolderCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "ChildFolderCount")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["managedFolderInformation", ["ManagedFolderInformationType", XSD::QName.new(NsTypes, "ManagedFolderInformation")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["permissionSet", ["PermissionSetType", XSD::QName.new(NsTypes, "PermissionSet")], [0, 1]],
      ["unreadCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "UnreadCount")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => NonEmptyArrayOfFoldersType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfFoldersType"),
    :schema_element => [ :choice,
      ["folder", ["FolderType[]", XSD::QName.new(NsTypes, "Folder")]],
      ["calendarFolder", ["CalendarFolderType[]", XSD::QName.new(NsTypes, "CalendarFolder")]],
      ["contactsFolder", ["ContactsFolderType[]", XSD::QName.new(NsTypes, "ContactsFolder")]],
      ["searchFolder", ["SearchFolderType[]", XSD::QName.new(NsTypes, "SearchFolder")]],
      ["tasksFolder", ["TasksFolderType[]", XSD::QName.new(NsTypes, "TasksFolder")]]
    ]
  )

  LiteralRegistry.register(
    :class => ArrayOfFoldersType,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfFoldersType"),
    :schema_element => [ :choice,
      ["folder", ["FolderType[]", XSD::QName.new(NsTypes, "Folder")]],
      ["calendarFolder", ["CalendarFolderType[]", XSD::QName.new(NsTypes, "CalendarFolder")]],
      ["contactsFolder", ["ContactsFolderType[]", XSD::QName.new(NsTypes, "ContactsFolder")]],
      ["searchFolder", ["SearchFolderType[]", XSD::QName.new(NsTypes, "SearchFolder")]],
      ["tasksFolder", ["TasksFolderType[]", XSD::QName.new(NsTypes, "TasksFolder")]]
    ]
  )

  LiteralRegistry.register(
    :class => ItemIdType,
    :schema_type => XSD::QName.new(NsTypes, "ItemIdType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseItemIdType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "Id") => "SOAP::SOAPString",
      XSD::QName.new(nil, "ChangeKey") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => NonEmptyArrayOfBaseItemIdsType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfBaseItemIdsType"),
    :schema_element => [ :choice,
      ["itemId", ["ItemIdType[]", XSD::QName.new(NsTypes, "ItemId")]],
      ["occurrenceItemId", ["OccurrenceItemIdType[]", XSD::QName.new(NsTypes, "OccurrenceItemId")]],
      ["recurringMasterItemId", ["RecurringMasterItemIdType[]", XSD::QName.new(NsTypes, "RecurringMasterItemId")]]
    ]
  )

  LiteralRegistry.register(
    :class => ArrayOfBaseItemIdsType,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfBaseItemIdsType"),
    :schema_element => [
      ["itemId", ["ItemIdType[]", XSD::QName.new(NsTypes, "ItemId")]]
    ]
  )

  LiteralRegistry.register(
    :class => NonEmptyArrayOfResponseObjectsType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfResponseObjectsType"),
    :schema_element => [ :choice,
      ["acceptItem", ["AcceptItemType[]", XSD::QName.new(NsTypes, "AcceptItem")]],
      ["tentativelyAcceptItem", ["TentativelyAcceptItemType[]", XSD::QName.new(NsTypes, "TentativelyAcceptItem")]],
      ["declineItem", ["DeclineItemType[]", XSD::QName.new(NsTypes, "DeclineItem")]],
      ["replyToItem", ["ReplyToItemType[]", XSD::QName.new(NsTypes, "ReplyToItem")]],
      ["forwardItem", ["ForwardItemType[]", XSD::QName.new(NsTypes, "ForwardItem")]],
      ["replyAllToItem", ["ReplyAllToItemType[]", XSD::QName.new(NsTypes, "ReplyAllToItem")]],
      ["cancelCalendarItem", ["CancelCalendarItemType[]", XSD::QName.new(NsTypes, "CancelCalendarItem")]],
      ["removeItem", ["RemoveItemType[]", XSD::QName.new(NsTypes, "RemoveItem")]],
      ["suppressReadReceipt", ["SuppressReadReceiptType[]", XSD::QName.new(NsTypes, "SuppressReadReceipt")]],
      ["postReplyItem", ["PostReplyItemType[]", XSD::QName.new(NsTypes, "PostReplyItem")]]
    ]
  )

  LiteralRegistry.register(
    :class => FolderChangeType,
    :schema_type => XSD::QName.new(NsTypes, "FolderChangeType"),
    :schema_element => [
      [ :choice,
        ["folderId", ["FolderIdType", XSD::QName.new(NsTypes, "FolderId")]],
        ["distinguishedFolderId", ["DistinguishedFolderIdType", XSD::QName.new(NsTypes, "DistinguishedFolderId")]]
      ],
      ["updates", ["NonEmptyArrayOfFolderChangeDescriptionsType", XSD::QName.new(NsTypes, "Updates")]]
    ]
  )

  LiteralRegistry.register(
    :class => NonEmptyArrayOfFolderChangesType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfFolderChangesType"),
    :schema_element => [
      ["folderChange", ["FolderChangeType[]", XSD::QName.new(NsTypes, "FolderChange")], [1, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => WellKnownResponseObjectType,
    :schema_type => XSD::QName.new(NsTypes, "WellKnownResponseObjectType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ResponseObjectType"),
    :schema_element => [
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["sender", ["SingleRecipientType", XSD::QName.new(NsTypes, "Sender")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["referenceItemId", ["ItemIdType", XSD::QName.new(NsTypes, "ReferenceItemId")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ObjectName") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => SmartResponseBaseType,
    :schema_type => XSD::QName.new(NsTypes, "SmartResponseBaseType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ResponseObjectType"),
    :schema_element => [
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["referenceItemId", ["ItemIdType", XSD::QName.new(NsTypes, "ReferenceItemId")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ObjectName") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => SmartResponseType,
    :schema_type => XSD::QName.new(NsTypes, "SmartResponseType"),
    :schema_basetype => XSD::QName.new(NsTypes, "SmartResponseBaseType"),
    :schema_element => [
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["referenceItemId", ["ItemIdType", XSD::QName.new(NsTypes, "ReferenceItemId")], [0, 1]],
      ["newBodyContent", ["BodyType", XSD::QName.new(NsTypes, "NewBodyContent")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ObjectName") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => ReplyToItemType,
    :schema_type => XSD::QName.new(NsTypes, "ReplyToItemType"),
    :schema_basetype => XSD::QName.new(NsTypes, "SmartResponseType"),
    :schema_element => [
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["referenceItemId", ["ItemIdType", XSD::QName.new(NsTypes, "ReferenceItemId")], [0, 1]],
      ["newBodyContent", ["BodyType", XSD::QName.new(NsTypes, "NewBodyContent")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ObjectName") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => ReplyAllToItemType,
    :schema_type => XSD::QName.new(NsTypes, "ReplyAllToItemType"),
    :schema_basetype => XSD::QName.new(NsTypes, "SmartResponseType"),
    :schema_element => [
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["referenceItemId", ["ItemIdType", XSD::QName.new(NsTypes, "ReferenceItemId")], [0, 1]],
      ["newBodyContent", ["BodyType", XSD::QName.new(NsTypes, "NewBodyContent")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ObjectName") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => ForwardItemType,
    :schema_type => XSD::QName.new(NsTypes, "ForwardItemType"),
    :schema_basetype => XSD::QName.new(NsTypes, "SmartResponseType"),
    :schema_element => [
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["referenceItemId", ["ItemIdType", XSD::QName.new(NsTypes, "ReferenceItemId")], [0, 1]],
      ["newBodyContent", ["BodyType", XSD::QName.new(NsTypes, "NewBodyContent")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ObjectName") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => CancelCalendarItemType,
    :schema_type => XSD::QName.new(NsTypes, "CancelCalendarItemType"),
    :schema_basetype => XSD::QName.new(NsTypes, "SmartResponseType"),
    :schema_element => [
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["referenceItemId", ["ItemIdType", XSD::QName.new(NsTypes, "ReferenceItemId")], [0, 1]],
      ["newBodyContent", ["BodyType", XSD::QName.new(NsTypes, "NewBodyContent")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ObjectName") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => ReferenceItemResponseType,
    :schema_type => XSD::QName.new(NsTypes, "ReferenceItemResponseType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ResponseObjectType"),
    :schema_element => [
      ["referenceItemId", ["ItemIdType", XSD::QName.new(NsTypes, "ReferenceItemId")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ObjectName") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => SuppressReadReceiptType,
    :schema_type => XSD::QName.new(NsTypes, "SuppressReadReceiptType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ReferenceItemResponseType"),
    :schema_element => [
      ["referenceItemId", ["ItemIdType", XSD::QName.new(NsTypes, "ReferenceItemId")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ObjectName") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => FindItemParentType,
    :schema_type => XSD::QName.new(NsTypes, "FindItemParentType"),
    :schema_element => [ :choice,
      ["items", ["ArrayOfRealItemsType", XSD::QName.new(NsTypes, "Items")]],
      ["groups", ["ArrayOfGroupedItemsType", XSD::QName.new(NsTypes, "Groups")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "IndexedPagingOffset") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "NumeratorOffset") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "AbsoluteDenominator") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "IncludesLastItemInRange") => "SOAP::SOAPBoolean",
      XSD::QName.new(nil, "TotalItemsInView") => "SOAP::SOAPInt"
    }
  )

  LiteralRegistry.register(
    :class => ItemType,
    :schema_type => XSD::QName.new(NsTypes, "ItemType"),
    :schema_element => [
      ["mimeContent", ["MimeContentType", XSD::QName.new(NsTypes, "MimeContent")], [0, 1]],
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["dateTimeReceived", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeReceived")], [0, 1]],
      ["size", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Size")], [0, 1]],
      ["categories", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Categories")], [0, 1]],
      ["importance", ["ImportanceChoicesType", XSD::QName.new(NsTypes, "Importance")], [0, 1]],
      ["inReplyTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InReplyTo")], [0, 1]],
      ["isSubmitted", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsSubmitted")], [0, 1]],
      ["isDraft", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDraft")], [0, 1]],
      ["isFromMe", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFromMe")], [0, 1]],
      ["isResend", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResend")], [0, 1]],
      ["isUnmodified", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsUnmodified")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["dateTimeSent", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeSent")], [0, 1]],
      ["dateTimeCreated", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeCreated")], [0, 1]],
      ["responseObjects", ["NonEmptyArrayOfResponseObjectsType", XSD::QName.new(NsTypes, "ResponseObjects")], [0, 1]],
      ["reminderDueBy", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "ReminderDueBy")], [0, 1]],
      ["reminderIsSet", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "ReminderIsSet")], [0, 1]],
      ["reminderMinutesBeforeStart", [nil, XSD::QName.new(NsTypes, "ReminderMinutesBeforeStart")], [0, 1]],
      ["displayCc", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayCc")], [0, 1]],
      ["displayTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayTo")], [0, 1]],
      ["hasAttachments", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasAttachments")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["culture", ["SOAP::SOAPLanguage", XSD::QName.new(NsTypes, "Culture")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["lastModifiedName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "LastModifiedName")], [0, 1]],
      ["lastModifiedTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "LastModifiedTime")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => ArrayOfStringsType,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfStringsType"),
    :schema_element => [
      ["string", ["SOAP::SOAPString[]", XSD::QName.new(NsTypes, "String")], [0, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => ArrayOfRealItemsType,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfRealItemsType"),
    :schema_element => [
      [
        ["item", ["ItemType[]", XSD::QName.new(NsTypes, "Item")]],
        ["message", ["MessageType[]", XSD::QName.new(NsTypes, "Message")]],
        ["calendarItem", ["CalendarItemType[]", XSD::QName.new(NsTypes, "CalendarItem")]],
        ["contact", ["ContactItemType[]", XSD::QName.new(NsTypes, "Contact")]],
        ["distributionList", ["DistributionListType[]", XSD::QName.new(NsTypes, "DistributionList")]],
        ["meetingMessage", ["MeetingMessageType[]", XSD::QName.new(NsTypes, "MeetingMessage")]],
        ["meetingRequest", ["MeetingRequestMessageType[]", XSD::QName.new(NsTypes, "MeetingRequest")]],
        ["meetingResponse", ["MeetingResponseMessageType[]", XSD::QName.new(NsTypes, "MeetingResponse")]],
        ["meetingCancellation", ["MeetingCancellationMessageType[]", XSD::QName.new(NsTypes, "MeetingCancellation")]],
        ["task", ["TaskType[]", XSD::QName.new(NsTypes, "Task")]],
        ["postItem", ["PostItemType[]", XSD::QName.new(NsTypes, "PostItem")]]
      ]
    ]
  )

  LiteralRegistry.register(
    :class => NonEmptyArrayOfAllItemsType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfAllItemsType"),
    :schema_element => [
      [
        ["item", ["ItemType[]", XSD::QName.new(NsTypes, "Item")]],
        ["message", ["MessageType[]", XSD::QName.new(NsTypes, "Message")]],
        ["calendarItem", ["CalendarItemType[]", XSD::QName.new(NsTypes, "CalendarItem")]],
        ["contact", ["ContactItemType[]", XSD::QName.new(NsTypes, "Contact")]],
        ["distributionList", ["DistributionListType[]", XSD::QName.new(NsTypes, "DistributionList")]],
        ["meetingMessage", ["MeetingMessageType[]", XSD::QName.new(NsTypes, "MeetingMessage")]],
        ["meetingRequest", ["MeetingRequestMessageType[]", XSD::QName.new(NsTypes, "MeetingRequest")]],
        ["meetingResponse", ["MeetingResponseMessageType[]", XSD::QName.new(NsTypes, "MeetingResponse")]],
        ["meetingCancellation", ["MeetingCancellationMessageType[]", XSD::QName.new(NsTypes, "MeetingCancellation")]],
        ["task", ["TaskType[]", XSD::QName.new(NsTypes, "Task")]],
        ["postItem", ["PostItemType[]", XSD::QName.new(NsTypes, "PostItem")]],
        ["replyToItem", ["ReplyToItemType[]", XSD::QName.new(NsTypes, "ReplyToItem")]],
        ["forwardItem", ["ForwardItemType[]", XSD::QName.new(NsTypes, "ForwardItem")]],
        ["replyAllToItem", ["ReplyAllToItemType[]", XSD::QName.new(NsTypes, "ReplyAllToItem")]],
        ["acceptItem", ["AcceptItemType[]", XSD::QName.new(NsTypes, "AcceptItem")]],
        ["tentativelyAcceptItem", ["TentativelyAcceptItemType[]", XSD::QName.new(NsTypes, "TentativelyAcceptItem")]],
        ["declineItem", ["DeclineItemType[]", XSD::QName.new(NsTypes, "DeclineItem")]],
        ["cancelCalendarItem", ["CancelCalendarItemType[]", XSD::QName.new(NsTypes, "CancelCalendarItem")]],
        ["removeItem", ["RemoveItemType[]", XSD::QName.new(NsTypes, "RemoveItem")]],
        ["suppressReadReceipt", ["SuppressReadReceiptType[]", XSD::QName.new(NsTypes, "SuppressReadReceipt")]],
        ["postReplyItem", ["PostReplyItemType[]", XSD::QName.new(NsTypes, "PostReplyItem")]]
      ]
    ]
  )

  LiteralRegistry.register(
    :class => AcceptItemType,
    :schema_type => XSD::QName.new(NsTypes, "AcceptItemType"),
    :schema_basetype => XSD::QName.new(NsTypes, "WellKnownResponseObjectType"),
    :schema_element => [
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["sender", ["SingleRecipientType", XSD::QName.new(NsTypes, "Sender")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["referenceItemId", ["ItemIdType", XSD::QName.new(NsTypes, "ReferenceItemId")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ObjectName") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => TentativelyAcceptItemType,
    :schema_type => XSD::QName.new(NsTypes, "TentativelyAcceptItemType"),
    :schema_basetype => XSD::QName.new(NsTypes, "WellKnownResponseObjectType"),
    :schema_element => [
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["sender", ["SingleRecipientType", XSD::QName.new(NsTypes, "Sender")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["referenceItemId", ["ItemIdType", XSD::QName.new(NsTypes, "ReferenceItemId")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ObjectName") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => DeclineItemType,
    :schema_type => XSD::QName.new(NsTypes, "DeclineItemType"),
    :schema_basetype => XSD::QName.new(NsTypes, "WellKnownResponseObjectType"),
    :schema_element => [
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["sender", ["SingleRecipientType", XSD::QName.new(NsTypes, "Sender")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["referenceItemId", ["ItemIdType", XSD::QName.new(NsTypes, "ReferenceItemId")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ObjectName") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => RemoveItemType,
    :schema_type => XSD::QName.new(NsTypes, "RemoveItemType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ResponseObjectType"),
    :schema_element => [
      ["mimeContent", ["MimeContentType", XSD::QName.new(NsTypes, "MimeContent")], [0, 1]],
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["dateTimeReceived", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeReceived")], [0, 1]],
      ["size", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Size")], [0, 1]],
      ["categories", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Categories")], [0, 1]],
      ["importance", ["ImportanceChoicesType", XSD::QName.new(NsTypes, "Importance")], [0, 1]],
      ["inReplyTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InReplyTo")], [0, 1]],
      ["isSubmitted", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsSubmitted")], [0, 1]],
      ["isDraft", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDraft")], [0, 1]],
      ["isFromMe", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFromMe")], [0, 1]],
      ["isResend", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResend")], [0, 1]],
      ["isUnmodified", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsUnmodified")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["dateTimeSent", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeSent")], [0, 1]],
      ["dateTimeCreated", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeCreated")], [0, 1]],
      ["responseObjects", ["NonEmptyArrayOfResponseObjectsType", XSD::QName.new(NsTypes, "ResponseObjects")], [0, 1]],
      ["reminderDueBy", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "ReminderDueBy")], [0, 1]],
      ["reminderIsSet", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "ReminderIsSet")], [0, 1]],
      ["reminderMinutesBeforeStart", [nil, XSD::QName.new(NsTypes, "ReminderMinutesBeforeStart")], [0, 1]],
      ["displayCc", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayCc")], [0, 1]],
      ["displayTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayTo")], [0, 1]],
      ["hasAttachments", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasAttachments")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["culture", ["SOAP::SOAPLanguage", XSD::QName.new(NsTypes, "Culture")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["lastModifiedName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "LastModifiedName")], [0, 1]],
      ["lastModifiedTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "LastModifiedTime")], [0, 1]],
      ["sender", ["SingleRecipientType", XSD::QName.new(NsTypes, "Sender")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["conversationIndex", ["SOAP::SOAPBase64", XSD::QName.new(NsTypes, "ConversationIndex")], [0, 1]],
      ["conversationTopic", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ConversationTopic")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["internetMessageId", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InternetMessageId")], [0, 1]],
      ["isRead", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsRead")], [0, 1]],
      ["isResponseRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResponseRequested")], [0, 1]],
      ["references", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "References")], [0, 1]],
      ["replyTo", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ReplyTo")], [0, 1]],
      ["receivedBy", ["SingleRecipientType", XSD::QName.new(NsTypes, "ReceivedBy")], [0, 1]],
      ["receivedRepresenting", ["SingleRecipientType", XSD::QName.new(NsTypes, "ReceivedRepresenting")], [0, 1]],
      ["referenceItemId", ["ItemIdType", XSD::QName.new(NsTypes, "ReferenceItemId")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ObjectName") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => PostReplyItemBaseType,
    :schema_type => XSD::QName.new(NsTypes, "PostReplyItemBaseType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ResponseObjectType"),
    :schema_element => [
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["referenceItemId", ["ItemIdType", XSD::QName.new(NsTypes, "ReferenceItemId")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ObjectName") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => PostReplyItemType,
    :schema_type => XSD::QName.new(NsTypes, "PostReplyItemType"),
    :schema_basetype => XSD::QName.new(NsTypes, "PostReplyItemBaseType"),
    :schema_element => [
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["referenceItemId", ["ItemIdType", XSD::QName.new(NsTypes, "ReferenceItemId")], [0, 1]],
      ["newBodyContent", ["BodyType", XSD::QName.new(NsTypes, "NewBodyContent")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ObjectName") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => MimeContentType,
    :schema_type => XSD::QName.new(NsTypes, "MimeContentType"),
    :schema_attribute => {
      XSD::QName.new(nil, "CharacterSet") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => MessageType,
    :schema_type => XSD::QName.new(NsTypes, "MessageType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ItemType"),
    :schema_element => [
      ["mimeContent", ["MimeContentType", XSD::QName.new(NsTypes, "MimeContent")], [0, 1]],
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["dateTimeReceived", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeReceived")], [0, 1]],
      ["size", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Size")], [0, 1]],
      ["categories", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Categories")], [0, 1]],
      ["importance", ["ImportanceChoicesType", XSD::QName.new(NsTypes, "Importance")], [0, 1]],
      ["inReplyTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InReplyTo")], [0, 1]],
      ["isSubmitted", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsSubmitted")], [0, 1]],
      ["isDraft", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDraft")], [0, 1]],
      ["isFromMe", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFromMe")], [0, 1]],
      ["isResend", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResend")], [0, 1]],
      ["isUnmodified", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsUnmodified")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["dateTimeSent", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeSent")], [0, 1]],
      ["dateTimeCreated", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeCreated")], [0, 1]],
      ["responseObjects", ["NonEmptyArrayOfResponseObjectsType", XSD::QName.new(NsTypes, "ResponseObjects")], [0, 1]],
      ["reminderDueBy", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "ReminderDueBy")], [0, 1]],
      ["reminderIsSet", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "ReminderIsSet")], [0, 1]],
      ["reminderMinutesBeforeStart", [nil, XSD::QName.new(NsTypes, "ReminderMinutesBeforeStart")], [0, 1]],
      ["displayCc", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayCc")], [0, 1]],
      ["displayTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayTo")], [0, 1]],
      ["hasAttachments", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasAttachments")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["culture", ["SOAP::SOAPLanguage", XSD::QName.new(NsTypes, "Culture")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["lastModifiedName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "LastModifiedName")], [0, 1]],
      ["lastModifiedTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "LastModifiedTime")], [0, 1]],
      ["sender", ["SingleRecipientType", XSD::QName.new(NsTypes, "Sender")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["conversationIndex", ["SOAP::SOAPBase64", XSD::QName.new(NsTypes, "ConversationIndex")], [0, 1]],
      ["conversationTopic", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ConversationTopic")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["internetMessageId", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InternetMessageId")], [0, 1]],
      ["isRead", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsRead")], [0, 1]],
      ["isResponseRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResponseRequested")], [0, 1]],
      ["references", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "References")], [0, 1]],
      ["replyTo", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ReplyTo")], [0, 1]],
      ["receivedBy", ["SingleRecipientType", XSD::QName.new(NsTypes, "ReceivedBy")], [0, 1]],
      ["receivedRepresenting", ["SingleRecipientType", XSD::QName.new(NsTypes, "ReceivedRepresenting")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => TaskType,
    :schema_type => XSD::QName.new(NsTypes, "TaskType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ItemType"),
    :schema_element => [
      ["mimeContent", ["MimeContentType", XSD::QName.new(NsTypes, "MimeContent")], [0, 1]],
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["dateTimeReceived", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeReceived")], [0, 1]],
      ["size", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Size")], [0, 1]],
      ["categories", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Categories")], [0, 1]],
      ["importance", ["ImportanceChoicesType", XSD::QName.new(NsTypes, "Importance")], [0, 1]],
      ["inReplyTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InReplyTo")], [0, 1]],
      ["isSubmitted", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsSubmitted")], [0, 1]],
      ["isDraft", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDraft")], [0, 1]],
      ["isFromMe", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFromMe")], [0, 1]],
      ["isResend", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResend")], [0, 1]],
      ["isUnmodified", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsUnmodified")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["dateTimeSent", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeSent")], [0, 1]],
      ["dateTimeCreated", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeCreated")], [0, 1]],
      ["responseObjects", ["NonEmptyArrayOfResponseObjectsType", XSD::QName.new(NsTypes, "ResponseObjects")], [0, 1]],
      ["reminderDueBy", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "ReminderDueBy")], [0, 1]],
      ["reminderIsSet", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "ReminderIsSet")], [0, 1]],
      ["reminderMinutesBeforeStart", [nil, XSD::QName.new(NsTypes, "ReminderMinutesBeforeStart")], [0, 1]],
      ["displayCc", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayCc")], [0, 1]],
      ["displayTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayTo")], [0, 1]],
      ["hasAttachments", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasAttachments")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["culture", ["SOAP::SOAPLanguage", XSD::QName.new(NsTypes, "Culture")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["lastModifiedName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "LastModifiedName")], [0, 1]],
      ["lastModifiedTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "LastModifiedTime")], [0, 1]],
      ["actualWork", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "ActualWork")], [0, 1]],
      ["assignedTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "AssignedTime")], [0, 1]],
      ["billingInformation", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "BillingInformation")], [0, 1]],
      ["changeCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "ChangeCount")], [0, 1]],
      ["companies", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Companies")], [0, 1]],
      ["completeDate", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "CompleteDate")], [0, 1]],
      ["contacts", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Contacts")], [0, 1]],
      ["delegationState", ["TaskDelegateStateType", XSD::QName.new(NsTypes, "DelegationState")], [0, 1]],
      ["delegator", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Delegator")], [0, 1]],
      ["dueDate", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DueDate")], [0, 1]],
      ["isAssignmentEditable", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "IsAssignmentEditable")], [0, 1]],
      ["isComplete", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsComplete")], [0, 1]],
      ["isRecurring", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsRecurring")], [0, 1]],
      ["isTeamTask", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsTeamTask")], [0, 1]],
      ["mileage", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Mileage")], [0, 1]],
      ["owner", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Owner")], [0, 1]],
      ["percentComplete", ["SOAP::SOAPDouble", XSD::QName.new(NsTypes, "PercentComplete")], [0, 1]],
      ["recurrence", ["TaskRecurrenceType", XSD::QName.new(NsTypes, "Recurrence")], [0, 1]],
      ["startDate", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "StartDate")], [0, 1]],
      ["status", ["TaskStatusType", XSD::QName.new(NsTypes, "Status")], [0, 1]],
      ["statusDescription", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "StatusDescription")], [0, 1]],
      ["totalWork", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "TotalWork")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => PostItemType,
    :schema_type => XSD::QName.new(NsTypes, "PostItemType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ItemType"),
    :schema_element => [
      ["mimeContent", ["MimeContentType", XSD::QName.new(NsTypes, "MimeContent")], [0, 1]],
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["dateTimeReceived", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeReceived")], [0, 1]],
      ["size", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Size")], [0, 1]],
      ["categories", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Categories")], [0, 1]],
      ["importance", ["ImportanceChoicesType", XSD::QName.new(NsTypes, "Importance")], [0, 1]],
      ["inReplyTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InReplyTo")], [0, 1]],
      ["isSubmitted", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsSubmitted")], [0, 1]],
      ["isDraft", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDraft")], [0, 1]],
      ["isFromMe", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFromMe")], [0, 1]],
      ["isResend", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResend")], [0, 1]],
      ["isUnmodified", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsUnmodified")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["dateTimeSent", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeSent")], [0, 1]],
      ["dateTimeCreated", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeCreated")], [0, 1]],
      ["responseObjects", ["NonEmptyArrayOfResponseObjectsType", XSD::QName.new(NsTypes, "ResponseObjects")], [0, 1]],
      ["reminderDueBy", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "ReminderDueBy")], [0, 1]],
      ["reminderIsSet", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "ReminderIsSet")], [0, 1]],
      ["reminderMinutesBeforeStart", [nil, XSD::QName.new(NsTypes, "ReminderMinutesBeforeStart")], [0, 1]],
      ["displayCc", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayCc")], [0, 1]],
      ["displayTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayTo")], [0, 1]],
      ["hasAttachments", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasAttachments")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["culture", ["SOAP::SOAPLanguage", XSD::QName.new(NsTypes, "Culture")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["lastModifiedName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "LastModifiedName")], [0, 1]],
      ["lastModifiedTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "LastModifiedTime")], [0, 1]],
      ["conversationIndex", ["SOAP::SOAPBase64", XSD::QName.new(NsTypes, "ConversationIndex")], [0, 1]],
      ["conversationTopic", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ConversationTopic")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["internetMessageId", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InternetMessageId")], [0, 1]],
      ["isRead", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsRead")], [0, 1]],
      ["postedTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "PostedTime")], [0, 1]],
      ["references", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "References")], [0, 1]],
      ["sender", ["SingleRecipientType", XSD::QName.new(NsTypes, "Sender")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => IndexedPageViewType,
    :schema_type => XSD::QName.new(NsTypes, "IndexedPageViewType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BasePagingType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "MaxEntriesReturned") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "Offset") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "BasePoint") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => FractionalPageViewType,
    :schema_type => XSD::QName.new(NsTypes, "FractionalPageViewType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BasePagingType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "MaxEntriesReturned") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "Numerator") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "Denominator") => "SOAP::SOAPInt"
    }
  )

  LiteralRegistry.register(
    :class => CalendarViewType,
    :schema_type => XSD::QName.new(NsTypes, "CalendarViewType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BasePagingType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "MaxEntriesReturned") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "StartDate") => "SOAP::SOAPDateTime",
      XSD::QName.new(nil, "EndDate") => "SOAP::SOAPDateTime"
    }
  )

  LiteralRegistry.register(
    :class => ContactsViewType,
    :schema_type => XSD::QName.new(NsTypes, "ContactsViewType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BasePagingType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "MaxEntriesReturned") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "InitialName") => "SOAP::SOAPString",
      XSD::QName.new(nil, "FinalName") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => ResolutionType,
    :schema_type => XSD::QName.new(NsTypes, "ResolutionType"),
    :schema_element => [
      ["mailbox", ["EmailAddressType", XSD::QName.new(NsTypes, "Mailbox")]],
      ["contact", ["ContactItemType", XSD::QName.new(NsTypes, "Contact")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => ArrayOfResolutionType,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfResolutionType"),
    :schema_element => [
      ["resolution", ["ResolutionType[]", XSD::QName.new(NsTypes, "Resolution")], [0, 100]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "IndexedPagingOffset") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "NumeratorOffset") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "AbsoluteDenominator") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "IncludesLastItemInRange") => "SOAP::SOAPBoolean",
      XSD::QName.new(nil, "TotalItemsInView") => "SOAP::SOAPInt"
    }
  )

  LiteralRegistry.register(
    :class => ArrayOfDLExpansionType,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfDLExpansionType"),
    :schema_element => [
      ["mailbox", ["EmailAddressType[]", XSD::QName.new(NsTypes, "Mailbox")], [0, nil]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "IndexedPagingOffset") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "NumeratorOffset") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "AbsoluteDenominator") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "IncludesLastItemInRange") => "SOAP::SOAPBoolean",
      XSD::QName.new(nil, "TotalItemsInView") => "SOAP::SOAPInt"
    }
  )

  LiteralRegistry.register(
    :class => AttendeeType,
    :schema_type => XSD::QName.new(NsTypes, "AttendeeType"),
    :schema_element => [
      ["mailbox", ["EmailAddressType", XSD::QName.new(NsTypes, "Mailbox")]],
      ["responseType", ["ResponseTypeType", XSD::QName.new(NsTypes, "ResponseType")], [0, 1]],
      ["lastResponseTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "LastResponseTime")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => NonEmptyArrayOfAttendeesType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfAttendeesType"),
    :schema_element => [
      ["attendee", ["AttendeeType[]", XSD::QName.new(NsTypes, "Attendee")], [1, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => OccurrenceItemIdType,
    :schema_type => XSD::QName.new(NsTypes, "OccurrenceItemIdType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseItemIdType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "RecurringMasterId") => "SOAP::SOAPString",
      XSD::QName.new(nil, "ChangeKey") => "SOAP::SOAPString",
      XSD::QName.new(nil, "InstanceIndex") => "SOAP::SOAPInt"
    }
  )

  LiteralRegistry.register(
    :class => RecurringMasterItemIdType,
    :schema_type => XSD::QName.new(NsTypes, "RecurringMasterItemIdType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseItemIdType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "OccurrenceId") => "SOAP::SOAPString",
      XSD::QName.new(nil, "ChangeKey") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => DailyRegeneratingPatternType,
    :schema_type => XSD::QName.new(NsTypes, "DailyRegeneratingPatternType"),
    :schema_basetype => XSD::QName.new(NsTypes, "RegeneratingPatternBaseType"),
    :schema_element => [
      ["interval", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Interval")]]
    ]
  )

  LiteralRegistry.register(
    :class => WeeklyRegeneratingPatternType,
    :schema_type => XSD::QName.new(NsTypes, "WeeklyRegeneratingPatternType"),
    :schema_basetype => XSD::QName.new(NsTypes, "RegeneratingPatternBaseType"),
    :schema_element => [
      ["interval", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Interval")]]
    ]
  )

  LiteralRegistry.register(
    :class => MonthlyRegeneratingPatternType,
    :schema_type => XSD::QName.new(NsTypes, "MonthlyRegeneratingPatternType"),
    :schema_basetype => XSD::QName.new(NsTypes, "RegeneratingPatternBaseType"),
    :schema_element => [
      ["interval", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Interval")]]
    ]
  )

  LiteralRegistry.register(
    :class => YearlyRegeneratingPatternType,
    :schema_type => XSD::QName.new(NsTypes, "YearlyRegeneratingPatternType"),
    :schema_basetype => XSD::QName.new(NsTypes, "RegeneratingPatternBaseType"),
    :schema_element => [
      ["interval", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Interval")]]
    ]
  )

  LiteralRegistry.register(
    :class => RelativeYearlyRecurrencePatternType,
    :schema_type => XSD::QName.new(NsTypes, "RelativeYearlyRecurrencePatternType"),
    :schema_basetype => XSD::QName.new(NsTypes, "RecurrencePatternBaseType"),
    :schema_element => [
      ["daysOfWeek", ["DayOfWeekType", XSD::QName.new(NsTypes, "DaysOfWeek")]],
      ["dayOfWeekIndex", ["DayOfWeekIndexType", XSD::QName.new(NsTypes, "DayOfWeekIndex")]],
      ["month", ["MonthNamesType", XSD::QName.new(NsTypes, "Month")]]
    ]
  )

  LiteralRegistry.register(
    :class => AbsoluteYearlyRecurrencePatternType,
    :schema_type => XSD::QName.new(NsTypes, "AbsoluteYearlyRecurrencePatternType"),
    :schema_basetype => XSD::QName.new(NsTypes, "RecurrencePatternBaseType"),
    :schema_element => [
      ["dayOfMonth", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "DayOfMonth")]],
      ["month", ["MonthNamesType", XSD::QName.new(NsTypes, "Month")]]
    ]
  )

  LiteralRegistry.register(
    :class => RelativeMonthlyRecurrencePatternType,
    :schema_type => XSD::QName.new(NsTypes, "RelativeMonthlyRecurrencePatternType"),
    :schema_basetype => XSD::QName.new(NsTypes, "IntervalRecurrencePatternBaseType"),
    :schema_element => [
      ["interval", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Interval")]],
      ["daysOfWeek", ["DayOfWeekType", XSD::QName.new(NsTypes, "DaysOfWeek")]],
      ["dayOfWeekIndex", ["DayOfWeekIndexType", XSD::QName.new(NsTypes, "DayOfWeekIndex")]]
    ]
  )

  LiteralRegistry.register(
    :class => AbsoluteMonthlyRecurrencePatternType,
    :schema_type => XSD::QName.new(NsTypes, "AbsoluteMonthlyRecurrencePatternType"),
    :schema_basetype => XSD::QName.new(NsTypes, "IntervalRecurrencePatternBaseType"),
    :schema_element => [
      ["interval", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Interval")]],
      ["dayOfMonth", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "DayOfMonth")]]
    ]
  )

  LiteralRegistry.register(
    :class => WeeklyRecurrencePatternType,
    :schema_type => XSD::QName.new(NsTypes, "WeeklyRecurrencePatternType"),
    :schema_basetype => XSD::QName.new(NsTypes, "IntervalRecurrencePatternBaseType"),
    :schema_element => [
      ["interval", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Interval")]],
      ["daysOfWeek", [nil, XSD::QName.new(NsTypes, "DaysOfWeek")]]
    ]
  )

  LiteralRegistry.register(
    :class => DailyRecurrencePatternType,
    :schema_type => XSD::QName.new(NsTypes, "DailyRecurrencePatternType"),
    :schema_basetype => XSD::QName.new(NsTypes, "IntervalRecurrencePatternBaseType"),
    :schema_element => [
      ["interval", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Interval")]]
    ]
  )

  LiteralRegistry.register(
    :class => TimeChangeType,
    :schema_type => XSD::QName.new(NsTypes, "TimeChangeType"),
    :schema_element => [
      ["offset", ["SOAP::SOAPDuration", XSD::QName.new(NsTypes, "Offset")]],
      [ :choice,
        ["relativeYearlyRecurrence", ["RelativeYearlyRecurrencePatternType", XSD::QName.new(NsTypes, "RelativeYearlyRecurrence")]],
        ["absoluteDate", ["SOAP::SOAPDate", XSD::QName.new(NsTypes, "AbsoluteDate")]]
      ],
      ["time", ["SOAP::SOAPTime", XSD::QName.new(NsTypes, "Time")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "TimeZoneName") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => TimeZoneType,
    :schema_type => XSD::QName.new(NsTypes, "TimeZoneType"),
    :schema_element => [
      ["baseOffset", ["SOAP::SOAPDuration", XSD::QName.new(NsTypes, "BaseOffset")]],
      [
        ["standard", ["TimeChangeType", XSD::QName.new(NsTypes, "Standard")]],
        ["daylight", ["TimeChangeType", XSD::QName.new(NsTypes, "Daylight")]]
      ]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "TimeZoneName") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => NoEndRecurrenceRangeType,
    :schema_type => XSD::QName.new(NsTypes, "NoEndRecurrenceRangeType"),
    :schema_basetype => XSD::QName.new(NsTypes, "RecurrenceRangeBaseType"),
    :schema_element => [
      ["startDate", ["SOAP::SOAPDate", XSD::QName.new(NsTypes, "StartDate")]]
    ]
  )

  LiteralRegistry.register(
    :class => EndDateRecurrenceRangeType,
    :schema_type => XSD::QName.new(NsTypes, "EndDateRecurrenceRangeType"),
    :schema_basetype => XSD::QName.new(NsTypes, "RecurrenceRangeBaseType"),
    :schema_element => [
      ["startDate", ["SOAP::SOAPDate", XSD::QName.new(NsTypes, "StartDate")]],
      ["endDate", ["SOAP::SOAPDate", XSD::QName.new(NsTypes, "EndDate")]]
    ]
  )

  LiteralRegistry.register(
    :class => NumberedRecurrenceRangeType,
    :schema_type => XSD::QName.new(NsTypes, "NumberedRecurrenceRangeType"),
    :schema_basetype => XSD::QName.new(NsTypes, "RecurrenceRangeBaseType"),
    :schema_element => [
      ["startDate", ["SOAP::SOAPDate", XSD::QName.new(NsTypes, "StartDate")]],
      ["numberOfOccurrences", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "NumberOfOccurrences")]]
    ]
  )

  LiteralRegistry.register(
    :class => RecurrenceType,
    :schema_type => XSD::QName.new(NsTypes, "RecurrenceType"),
    :schema_element => [
      [ :choice,
        ["relativeYearlyRecurrence", ["RelativeYearlyRecurrencePatternType", XSD::QName.new(NsTypes, "RelativeYearlyRecurrence")]],
        ["absoluteYearlyRecurrence", ["AbsoluteYearlyRecurrencePatternType", XSD::QName.new(NsTypes, "AbsoluteYearlyRecurrence")]],
        ["relativeMonthlyRecurrence", ["RelativeMonthlyRecurrencePatternType", XSD::QName.new(NsTypes, "RelativeMonthlyRecurrence")]],
        ["absoluteMonthlyRecurrence", ["AbsoluteMonthlyRecurrencePatternType", XSD::QName.new(NsTypes, "AbsoluteMonthlyRecurrence")]],
        ["weeklyRecurrence", ["WeeklyRecurrencePatternType", XSD::QName.new(NsTypes, "WeeklyRecurrence")]],
        ["dailyRecurrence", ["DailyRecurrencePatternType", XSD::QName.new(NsTypes, "DailyRecurrence")]]
      ],
      [ :choice,
        ["noEndRecurrence", ["NoEndRecurrenceRangeType", XSD::QName.new(NsTypes, "NoEndRecurrence")]],
        ["endDateRecurrence", ["EndDateRecurrenceRangeType", XSD::QName.new(NsTypes, "EndDateRecurrence")]],
        ["numberedRecurrence", ["NumberedRecurrenceRangeType", XSD::QName.new(NsTypes, "NumberedRecurrence")]]
      ]
    ]
  )

  LiteralRegistry.register(
    :class => TaskRecurrenceType,
    :schema_type => XSD::QName.new(NsTypes, "TaskRecurrenceType"),
    :schema_element => [
      [ :choice,
        ["relativeYearlyRecurrence", ["RelativeYearlyRecurrencePatternType", XSD::QName.new(NsTypes, "RelativeYearlyRecurrence")]],
        ["absoluteYearlyRecurrence", ["AbsoluteYearlyRecurrencePatternType", XSD::QName.new(NsTypes, "AbsoluteYearlyRecurrence")]],
        ["relativeMonthlyRecurrence", ["RelativeMonthlyRecurrencePatternType", XSD::QName.new(NsTypes, "RelativeMonthlyRecurrence")]],
        ["absoluteMonthlyRecurrence", ["AbsoluteMonthlyRecurrencePatternType", XSD::QName.new(NsTypes, "AbsoluteMonthlyRecurrence")]],
        ["weeklyRecurrence", ["WeeklyRecurrencePatternType", XSD::QName.new(NsTypes, "WeeklyRecurrence")]],
        ["dailyRecurrence", ["DailyRecurrencePatternType", XSD::QName.new(NsTypes, "DailyRecurrence")]],
        ["dailyRegeneration", ["DailyRegeneratingPatternType", XSD::QName.new(NsTypes, "DailyRegeneration")]],
        ["weeklyRegeneration", ["WeeklyRegeneratingPatternType", XSD::QName.new(NsTypes, "WeeklyRegeneration")]],
        ["monthlyRegeneration", ["MonthlyRegeneratingPatternType", XSD::QName.new(NsTypes, "MonthlyRegeneration")]],
        ["yearlyRegeneration", ["YearlyRegeneratingPatternType", XSD::QName.new(NsTypes, "YearlyRegeneration")]]
      ],
      [ :choice,
        ["noEndRecurrence", ["NoEndRecurrenceRangeType", XSD::QName.new(NsTypes, "NoEndRecurrence")]],
        ["endDateRecurrence", ["EndDateRecurrenceRangeType", XSD::QName.new(NsTypes, "EndDateRecurrence")]],
        ["numberedRecurrence", ["NumberedRecurrenceRangeType", XSD::QName.new(NsTypes, "NumberedRecurrence")]]
      ]
    ]
  )

  LiteralRegistry.register(
    :class => OccurrenceInfoType,
    :schema_type => XSD::QName.new(NsTypes, "OccurrenceInfoType"),
    :schema_element => [
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")]],
      ["start", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "Start")]],
      ["v_end", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "End")]],
      ["originalStart", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "OriginalStart")]]
    ]
  )

  LiteralRegistry.register(
    :class => NonEmptyArrayOfOccurrenceInfoType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfOccurrenceInfoType"),
    :schema_element => [
      ["occurrence", ["OccurrenceInfoType[]", XSD::QName.new(NsTypes, "Occurrence")], [1, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => DeletedOccurrenceInfoType,
    :schema_type => XSD::QName.new(NsTypes, "DeletedOccurrenceInfoType"),
    :schema_element => [
      ["start", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "Start")]]
    ]
  )

  LiteralRegistry.register(
    :class => NonEmptyArrayOfDeletedOccurrencesType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfDeletedOccurrencesType"),
    :schema_element => [
      ["deletedOccurrence", ["DeletedOccurrenceInfoType[]", XSD::QName.new(NsTypes, "DeletedOccurrence")], [1, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => CalendarItemType,
    :schema_type => XSD::QName.new(NsTypes, "CalendarItemType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ItemType"),
    :schema_element => [
      ["mimeContent", ["MimeContentType", XSD::QName.new(NsTypes, "MimeContent")], [0, 1]],
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["dateTimeReceived", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeReceived")], [0, 1]],
      ["size", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Size")], [0, 1]],
      ["categories", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Categories")], [0, 1]],
      ["importance", ["ImportanceChoicesType", XSD::QName.new(NsTypes, "Importance")], [0, 1]],
      ["inReplyTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InReplyTo")], [0, 1]],
      ["isSubmitted", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsSubmitted")], [0, 1]],
      ["isDraft", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDraft")], [0, 1]],
      ["isFromMe", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFromMe")], [0, 1]],
      ["isResend", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResend")], [0, 1]],
      ["isUnmodified", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsUnmodified")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["dateTimeSent", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeSent")], [0, 1]],
      ["dateTimeCreated", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeCreated")], [0, 1]],
      ["responseObjects", ["NonEmptyArrayOfResponseObjectsType", XSD::QName.new(NsTypes, "ResponseObjects")], [0, 1]],
      ["reminderDueBy", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "ReminderDueBy")], [0, 1]],
      ["reminderIsSet", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "ReminderIsSet")], [0, 1]],
      ["reminderMinutesBeforeStart", [nil, XSD::QName.new(NsTypes, "ReminderMinutesBeforeStart")], [0, 1]],
      ["displayCc", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayCc")], [0, 1]],
      ["displayTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayTo")], [0, 1]],
      ["hasAttachments", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasAttachments")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["culture", ["SOAP::SOAPLanguage", XSD::QName.new(NsTypes, "Culture")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["lastModifiedName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "LastModifiedName")], [0, 1]],
      ["lastModifiedTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "LastModifiedTime")], [0, 1]],
      ["uID", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "UID")], [0, 1]],
      ["recurrenceId", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "RecurrenceId")], [0, 1]],
      ["dateTimeStamp", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeStamp")], [0, 1]],
      ["start", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "Start")], [0, 1]],
      ["v_end", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "End")], [0, 1]],
      ["originalStart", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "OriginalStart")], [0, 1]],
      ["isAllDayEvent", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsAllDayEvent")], [0, 1]],
      ["legacyFreeBusyStatus", ["LegacyFreeBusyType", XSD::QName.new(NsTypes, "LegacyFreeBusyStatus")], [0, 1]],
      ["location", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Location")], [0, 1]],
      ["v_when", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "When")], [0, 1]],
      ["isMeeting", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsMeeting")], [0, 1]],
      ["isCancelled", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsCancelled")], [0, 1]],
      ["isRecurring", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsRecurring")], [0, 1]],
      ["meetingRequestWasSent", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "MeetingRequestWasSent")], [0, 1]],
      ["isResponseRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResponseRequested")], [0, 1]],
      ["calendarItemType", ["CalendarItemTypeType", XSD::QName.new(NsTypes, "CalendarItemType")], [0, 1]],
      ["myResponseType", ["ResponseTypeType", XSD::QName.new(NsTypes, "MyResponseType")], [0, 1]],
      ["organizer", ["SingleRecipientType", XSD::QName.new(NsTypes, "Organizer")], [0, 1]],
      ["requiredAttendees", ["NonEmptyArrayOfAttendeesType", XSD::QName.new(NsTypes, "RequiredAttendees")], [0, 1]],
      ["optionalAttendees", ["NonEmptyArrayOfAttendeesType", XSD::QName.new(NsTypes, "OptionalAttendees")], [0, 1]],
      ["resources", ["NonEmptyArrayOfAttendeesType", XSD::QName.new(NsTypes, "Resources")], [0, 1]],
      ["conflictingMeetingCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "ConflictingMeetingCount")], [0, 1]],
      ["adjacentMeetingCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "AdjacentMeetingCount")], [0, 1]],
      ["conflictingMeetings", ["NonEmptyArrayOfAllItemsType", XSD::QName.new(NsTypes, "ConflictingMeetings")], [0, 1]],
      ["adjacentMeetings", ["NonEmptyArrayOfAllItemsType", XSD::QName.new(NsTypes, "AdjacentMeetings")], [0, 1]],
      ["duration", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Duration")], [0, 1]],
      ["timeZone", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "TimeZone")], [0, 1]],
      ["appointmentReplyTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "AppointmentReplyTime")], [0, 1]],
      ["appointmentSequenceNumber", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "AppointmentSequenceNumber")], [0, 1]],
      ["appointmentState", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "AppointmentState")], [0, 1]],
      ["recurrence", ["RecurrenceType", XSD::QName.new(NsTypes, "Recurrence")], [0, 1]],
      ["firstOccurrence", ["OccurrenceInfoType", XSD::QName.new(NsTypes, "FirstOccurrence")], [0, 1]],
      ["lastOccurrence", ["OccurrenceInfoType", XSD::QName.new(NsTypes, "LastOccurrence")], [0, 1]],
      ["modifiedOccurrences", ["NonEmptyArrayOfOccurrenceInfoType", XSD::QName.new(NsTypes, "ModifiedOccurrences")], [0, 1]],
      ["deletedOccurrences", ["NonEmptyArrayOfDeletedOccurrencesType", XSD::QName.new(NsTypes, "DeletedOccurrences")], [0, 1]],
      ["meetingTimeZone", ["TimeZoneType", XSD::QName.new(NsTypes, "MeetingTimeZone")], [0, 1]],
      ["conferenceType", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "ConferenceType")], [0, 1]],
      ["allowNewTimeProposal", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "AllowNewTimeProposal")], [0, 1]],
      ["isOnlineMeeting", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsOnlineMeeting")], [0, 1]],
      ["meetingWorkspaceUrl", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "MeetingWorkspaceUrl")], [0, 1]],
      ["netShowUrl", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "NetShowUrl")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => MeetingMessageType,
    :schema_type => XSD::QName.new(NsTypes, "MeetingMessageType"),
    :schema_basetype => XSD::QName.new(NsTypes, "MessageType"),
    :schema_element => [
      ["mimeContent", ["MimeContentType", XSD::QName.new(NsTypes, "MimeContent")], [0, 1]],
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["dateTimeReceived", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeReceived")], [0, 1]],
      ["size", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Size")], [0, 1]],
      ["categories", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Categories")], [0, 1]],
      ["importance", ["ImportanceChoicesType", XSD::QName.new(NsTypes, "Importance")], [0, 1]],
      ["inReplyTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InReplyTo")], [0, 1]],
      ["isSubmitted", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsSubmitted")], [0, 1]],
      ["isDraft", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDraft")], [0, 1]],
      ["isFromMe", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFromMe")], [0, 1]],
      ["isResend", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResend")], [0, 1]],
      ["isUnmodified", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsUnmodified")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["dateTimeSent", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeSent")], [0, 1]],
      ["dateTimeCreated", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeCreated")], [0, 1]],
      ["responseObjects", ["NonEmptyArrayOfResponseObjectsType", XSD::QName.new(NsTypes, "ResponseObjects")], [0, 1]],
      ["reminderDueBy", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "ReminderDueBy")], [0, 1]],
      ["reminderIsSet", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "ReminderIsSet")], [0, 1]],
      ["reminderMinutesBeforeStart", [nil, XSD::QName.new(NsTypes, "ReminderMinutesBeforeStart")], [0, 1]],
      ["displayCc", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayCc")], [0, 1]],
      ["displayTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayTo")], [0, 1]],
      ["hasAttachments", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasAttachments")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["culture", ["SOAP::SOAPLanguage", XSD::QName.new(NsTypes, "Culture")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["lastModifiedName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "LastModifiedName")], [0, 1]],
      ["lastModifiedTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "LastModifiedTime")], [0, 1]],
      ["sender", ["SingleRecipientType", XSD::QName.new(NsTypes, "Sender")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["conversationIndex", ["SOAP::SOAPBase64", XSD::QName.new(NsTypes, "ConversationIndex")], [0, 1]],
      ["conversationTopic", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ConversationTopic")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["internetMessageId", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InternetMessageId")], [0, 1]],
      ["isRead", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsRead")], [0, 1]],
      ["isResponseRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResponseRequested")], [0, 1]],
      ["references", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "References")], [0, 1]],
      ["replyTo", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ReplyTo")], [0, 1]],
      ["receivedBy", ["SingleRecipientType", XSD::QName.new(NsTypes, "ReceivedBy")], [0, 1]],
      ["receivedRepresenting", ["SingleRecipientType", XSD::QName.new(NsTypes, "ReceivedRepresenting")], [0, 1]],
      ["associatedCalendarItemId", ["ItemIdType", XSD::QName.new(NsTypes, "AssociatedCalendarItemId")], [0, 1]],
      ["isDelegated", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDelegated")], [0, 1]],
      ["isOutOfDate", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsOutOfDate")], [0, 1]],
      ["hasBeenProcessed", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasBeenProcessed")], [0, 1]],
      ["responseType", ["ResponseTypeType", XSD::QName.new(NsTypes, "ResponseType")], [0, 1]],
      ["uID", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "UID")], [0, 1]],
      ["recurrenceId", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "RecurrenceId")], [0, 1]],
      ["dateTimeStamp", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeStamp")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => MeetingRequestMessageType,
    :schema_type => XSD::QName.new(NsTypes, "MeetingRequestMessageType"),
    :schema_basetype => XSD::QName.new(NsTypes, "MeetingMessageType"),
    :schema_element => [
      ["mimeContent", ["MimeContentType", XSD::QName.new(NsTypes, "MimeContent")], [0, 1]],
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["dateTimeReceived", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeReceived")], [0, 1]],
      ["size", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Size")], [0, 1]],
      ["categories", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Categories")], [0, 1]],
      ["importance", ["ImportanceChoicesType", XSD::QName.new(NsTypes, "Importance")], [0, 1]],
      ["inReplyTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InReplyTo")], [0, 1]],
      ["isSubmitted", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsSubmitted")], [0, 1]],
      ["isDraft", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDraft")], [0, 1]],
      ["isFromMe", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFromMe")], [0, 1]],
      ["isResend", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResend")], [0, 1]],
      ["isUnmodified", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsUnmodified")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["dateTimeSent", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeSent")], [0, 1]],
      ["dateTimeCreated", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeCreated")], [0, 1]],
      ["responseObjects", ["NonEmptyArrayOfResponseObjectsType", XSD::QName.new(NsTypes, "ResponseObjects")], [0, 1]],
      ["reminderDueBy", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "ReminderDueBy")], [0, 1]],
      ["reminderIsSet", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "ReminderIsSet")], [0, 1]],
      ["reminderMinutesBeforeStart", [nil, XSD::QName.new(NsTypes, "ReminderMinutesBeforeStart")], [0, 1]],
      ["displayCc", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayCc")], [0, 1]],
      ["displayTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayTo")], [0, 1]],
      ["hasAttachments", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasAttachments")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["culture", ["SOAP::SOAPLanguage", XSD::QName.new(NsTypes, "Culture")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["lastModifiedName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "LastModifiedName")], [0, 1]],
      ["lastModifiedTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "LastModifiedTime")], [0, 1]],
      ["sender", ["SingleRecipientType", XSD::QName.new(NsTypes, "Sender")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["conversationIndex", ["SOAP::SOAPBase64", XSD::QName.new(NsTypes, "ConversationIndex")], [0, 1]],
      ["conversationTopic", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ConversationTopic")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["internetMessageId", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InternetMessageId")], [0, 1]],
      ["isRead", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsRead")], [0, 1]],
      ["isResponseRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResponseRequested")], [0, 1]],
      ["references", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "References")], [0, 1]],
      ["replyTo", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ReplyTo")], [0, 1]],
      ["receivedBy", ["SingleRecipientType", XSD::QName.new(NsTypes, "ReceivedBy")], [0, 1]],
      ["receivedRepresenting", ["SingleRecipientType", XSD::QName.new(NsTypes, "ReceivedRepresenting")], [0, 1]],
      ["associatedCalendarItemId", ["ItemIdType", XSD::QName.new(NsTypes, "AssociatedCalendarItemId")], [0, 1]],
      ["isDelegated", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDelegated")], [0, 1]],
      ["isOutOfDate", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsOutOfDate")], [0, 1]],
      ["hasBeenProcessed", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasBeenProcessed")], [0, 1]],
      ["responseType", ["ResponseTypeType", XSD::QName.new(NsTypes, "ResponseType")], [0, 1]],
      ["uID", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "UID")], [0, 1]],
      ["recurrenceId", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "RecurrenceId")], [0, 1]],
      ["dateTimeStamp", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeStamp")], [0, 1]],
      ["meetingRequestType", ["MeetingRequestTypeType", XSD::QName.new(NsTypes, "MeetingRequestType")], [0, 1]],
      ["intendedFreeBusyStatus", ["LegacyFreeBusyType", XSD::QName.new(NsTypes, "IntendedFreeBusyStatus")], [0, 1]],
      ["start", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "Start")], [0, 1]],
      ["v_end", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "End")], [0, 1]],
      ["originalStart", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "OriginalStart")], [0, 1]],
      ["isAllDayEvent", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsAllDayEvent")], [0, 1]],
      ["legacyFreeBusyStatus", ["LegacyFreeBusyType", XSD::QName.new(NsTypes, "LegacyFreeBusyStatus")], [0, 1]],
      ["location", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Location")], [0, 1]],
      ["v_when", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "When")], [0, 1]],
      ["isMeeting", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsMeeting")], [0, 1]],
      ["isCancelled", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsCancelled")], [0, 1]],
      ["isRecurring", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsRecurring")], [0, 1]],
      ["meetingRequestWasSent", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "MeetingRequestWasSent")], [0, 1]],
      ["calendarItemType", ["CalendarItemTypeType", XSD::QName.new(NsTypes, "CalendarItemType")], [0, 1]],
      ["myResponseType", ["ResponseTypeType", XSD::QName.new(NsTypes, "MyResponseType")], [0, 1]],
      ["organizer", ["SingleRecipientType", XSD::QName.new(NsTypes, "Organizer")], [0, 1]],
      ["requiredAttendees", ["NonEmptyArrayOfAttendeesType", XSD::QName.new(NsTypes, "RequiredAttendees")], [0, 1]],
      ["optionalAttendees", ["NonEmptyArrayOfAttendeesType", XSD::QName.new(NsTypes, "OptionalAttendees")], [0, 1]],
      ["resources", ["NonEmptyArrayOfAttendeesType", XSD::QName.new(NsTypes, "Resources")], [0, 1]],
      ["conflictingMeetingCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "ConflictingMeetingCount")], [0, 1]],
      ["adjacentMeetingCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "AdjacentMeetingCount")], [0, 1]],
      ["conflictingMeetings", ["NonEmptyArrayOfAllItemsType", XSD::QName.new(NsTypes, "ConflictingMeetings")], [0, 1]],
      ["adjacentMeetings", ["NonEmptyArrayOfAllItemsType", XSD::QName.new(NsTypes, "AdjacentMeetings")], [0, 1]],
      ["duration", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Duration")], [0, 1]],
      ["timeZone", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "TimeZone")], [0, 1]],
      ["appointmentReplyTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "AppointmentReplyTime")], [0, 1]],
      ["appointmentSequenceNumber", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "AppointmentSequenceNumber")], [0, 1]],
      ["appointmentState", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "AppointmentState")], [0, 1]],
      ["recurrence", ["RecurrenceType", XSD::QName.new(NsTypes, "Recurrence")], [0, 1]],
      ["firstOccurrence", ["OccurrenceInfoType", XSD::QName.new(NsTypes, "FirstOccurrence")], [0, 1]],
      ["lastOccurrence", ["OccurrenceInfoType", XSD::QName.new(NsTypes, "LastOccurrence")], [0, 1]],
      ["modifiedOccurrences", ["NonEmptyArrayOfOccurrenceInfoType", XSD::QName.new(NsTypes, "ModifiedOccurrences")], [0, 1]],
      ["deletedOccurrences", ["NonEmptyArrayOfDeletedOccurrencesType", XSD::QName.new(NsTypes, "DeletedOccurrences")], [0, 1]],
      ["meetingTimeZone", ["TimeZoneType", XSD::QName.new(NsTypes, "MeetingTimeZone")], [0, 1]],
      ["conferenceType", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "ConferenceType")], [0, 1]],
      ["allowNewTimeProposal", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "AllowNewTimeProposal")], [0, 1]],
      ["isOnlineMeeting", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsOnlineMeeting")], [0, 1]],
      ["meetingWorkspaceUrl", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "MeetingWorkspaceUrl")], [0, 1]],
      ["netShowUrl", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "NetShowUrl")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => MeetingResponseMessageType,
    :schema_type => XSD::QName.new(NsTypes, "MeetingResponseMessageType"),
    :schema_basetype => XSD::QName.new(NsTypes, "MeetingMessageType"),
    :schema_element => [
      ["mimeContent", ["MimeContentType", XSD::QName.new(NsTypes, "MimeContent")], [0, 1]],
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["dateTimeReceived", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeReceived")], [0, 1]],
      ["size", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Size")], [0, 1]],
      ["categories", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Categories")], [0, 1]],
      ["importance", ["ImportanceChoicesType", XSD::QName.new(NsTypes, "Importance")], [0, 1]],
      ["inReplyTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InReplyTo")], [0, 1]],
      ["isSubmitted", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsSubmitted")], [0, 1]],
      ["isDraft", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDraft")], [0, 1]],
      ["isFromMe", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFromMe")], [0, 1]],
      ["isResend", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResend")], [0, 1]],
      ["isUnmodified", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsUnmodified")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["dateTimeSent", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeSent")], [0, 1]],
      ["dateTimeCreated", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeCreated")], [0, 1]],
      ["responseObjects", ["NonEmptyArrayOfResponseObjectsType", XSD::QName.new(NsTypes, "ResponseObjects")], [0, 1]],
      ["reminderDueBy", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "ReminderDueBy")], [0, 1]],
      ["reminderIsSet", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "ReminderIsSet")], [0, 1]],
      ["reminderMinutesBeforeStart", [nil, XSD::QName.new(NsTypes, "ReminderMinutesBeforeStart")], [0, 1]],
      ["displayCc", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayCc")], [0, 1]],
      ["displayTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayTo")], [0, 1]],
      ["hasAttachments", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasAttachments")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["culture", ["SOAP::SOAPLanguage", XSD::QName.new(NsTypes, "Culture")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["lastModifiedName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "LastModifiedName")], [0, 1]],
      ["lastModifiedTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "LastModifiedTime")], [0, 1]],
      ["sender", ["SingleRecipientType", XSD::QName.new(NsTypes, "Sender")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["conversationIndex", ["SOAP::SOAPBase64", XSD::QName.new(NsTypes, "ConversationIndex")], [0, 1]],
      ["conversationTopic", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ConversationTopic")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["internetMessageId", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InternetMessageId")], [0, 1]],
      ["isRead", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsRead")], [0, 1]],
      ["isResponseRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResponseRequested")], [0, 1]],
      ["references", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "References")], [0, 1]],
      ["replyTo", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ReplyTo")], [0, 1]],
      ["receivedBy", ["SingleRecipientType", XSD::QName.new(NsTypes, "ReceivedBy")], [0, 1]],
      ["receivedRepresenting", ["SingleRecipientType", XSD::QName.new(NsTypes, "ReceivedRepresenting")], [0, 1]],
      ["associatedCalendarItemId", ["ItemIdType", XSD::QName.new(NsTypes, "AssociatedCalendarItemId")], [0, 1]],
      ["isDelegated", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDelegated")], [0, 1]],
      ["isOutOfDate", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsOutOfDate")], [0, 1]],
      ["hasBeenProcessed", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasBeenProcessed")], [0, 1]],
      ["responseType", ["ResponseTypeType", XSD::QName.new(NsTypes, "ResponseType")], [0, 1]],
      ["uID", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "UID")], [0, 1]],
      ["recurrenceId", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "RecurrenceId")], [0, 1]],
      ["dateTimeStamp", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeStamp")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => MeetingCancellationMessageType,
    :schema_type => XSD::QName.new(NsTypes, "MeetingCancellationMessageType"),
    :schema_basetype => XSD::QName.new(NsTypes, "MeetingMessageType"),
    :schema_element => [
      ["mimeContent", ["MimeContentType", XSD::QName.new(NsTypes, "MimeContent")], [0, 1]],
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["dateTimeReceived", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeReceived")], [0, 1]],
      ["size", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Size")], [0, 1]],
      ["categories", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Categories")], [0, 1]],
      ["importance", ["ImportanceChoicesType", XSD::QName.new(NsTypes, "Importance")], [0, 1]],
      ["inReplyTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InReplyTo")], [0, 1]],
      ["isSubmitted", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsSubmitted")], [0, 1]],
      ["isDraft", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDraft")], [0, 1]],
      ["isFromMe", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFromMe")], [0, 1]],
      ["isResend", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResend")], [0, 1]],
      ["isUnmodified", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsUnmodified")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["dateTimeSent", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeSent")], [0, 1]],
      ["dateTimeCreated", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeCreated")], [0, 1]],
      ["responseObjects", ["NonEmptyArrayOfResponseObjectsType", XSD::QName.new(NsTypes, "ResponseObjects")], [0, 1]],
      ["reminderDueBy", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "ReminderDueBy")], [0, 1]],
      ["reminderIsSet", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "ReminderIsSet")], [0, 1]],
      ["reminderMinutesBeforeStart", [nil, XSD::QName.new(NsTypes, "ReminderMinutesBeforeStart")], [0, 1]],
      ["displayCc", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayCc")], [0, 1]],
      ["displayTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayTo")], [0, 1]],
      ["hasAttachments", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasAttachments")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["culture", ["SOAP::SOAPLanguage", XSD::QName.new(NsTypes, "Culture")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["lastModifiedName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "LastModifiedName")], [0, 1]],
      ["lastModifiedTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "LastModifiedTime")], [0, 1]],
      ["sender", ["SingleRecipientType", XSD::QName.new(NsTypes, "Sender")], [0, 1]],
      ["toRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ToRecipients")], [0, 1]],
      ["ccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "CcRecipients")], [0, 1]],
      ["bccRecipients", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "BccRecipients")], [0, 1]],
      ["isReadReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReadReceiptRequested")], [0, 1]],
      ["isDeliveryReceiptRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDeliveryReceiptRequested")], [0, 1]],
      ["conversationIndex", ["SOAP::SOAPBase64", XSD::QName.new(NsTypes, "ConversationIndex")], [0, 1]],
      ["conversationTopic", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ConversationTopic")], [0, 1]],
      ["from", ["SingleRecipientType", XSD::QName.new(NsTypes, "From")], [0, 1]],
      ["internetMessageId", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InternetMessageId")], [0, 1]],
      ["isRead", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsRead")], [0, 1]],
      ["isResponseRequested", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResponseRequested")], [0, 1]],
      ["references", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "References")], [0, 1]],
      ["replyTo", ["ArrayOfRecipientsType", XSD::QName.new(NsTypes, "ReplyTo")], [0, 1]],
      ["receivedBy", ["SingleRecipientType", XSD::QName.new(NsTypes, "ReceivedBy")], [0, 1]],
      ["receivedRepresenting", ["SingleRecipientType", XSD::QName.new(NsTypes, "ReceivedRepresenting")], [0, 1]],
      ["associatedCalendarItemId", ["ItemIdType", XSD::QName.new(NsTypes, "AssociatedCalendarItemId")], [0, 1]],
      ["isDelegated", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDelegated")], [0, 1]],
      ["isOutOfDate", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsOutOfDate")], [0, 1]],
      ["hasBeenProcessed", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasBeenProcessed")], [0, 1]],
      ["responseType", ["ResponseTypeType", XSD::QName.new(NsTypes, "ResponseType")], [0, 1]],
      ["uID", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "UID")], [0, 1]],
      ["recurrenceId", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "RecurrenceId")], [0, 1]],
      ["dateTimeStamp", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeStamp")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => CompleteNameType,
    :schema_type => XSD::QName.new(NsTypes, "CompleteNameType"),
    :schema_element => [
      ["title", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Title")], [0, 1]],
      ["firstName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "FirstName")], [0, 1]],
      ["middleName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "MiddleName")], [0, 1]],
      ["lastName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "LastName")], [0, 1]],
      ["suffix", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Suffix")], [0, 1]],
      ["initials", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Initials")], [0, 1]],
      ["fullName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "FullName")], [0, 1]],
      ["nickname", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Nickname")], [0, 1]],
      ["yomiFirstName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "YomiFirstName")], [0, 1]],
      ["yomiLastName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "YomiLastName")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => ImAddressDictionaryEntryType,
    :schema_type => XSD::QName.new(NsTypes, "ImAddressDictionaryEntryType"),
    :schema_attribute => {
      XSD::QName.new(nil, "Key") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => EmailAddressDictionaryEntryType,
    :schema_type => XSD::QName.new(NsTypes, "EmailAddressDictionaryEntryType"),
    :schema_attribute => {
      XSD::QName.new(nil, "Key") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => PhoneNumberDictionaryEntryType,
    :schema_type => XSD::QName.new(NsTypes, "PhoneNumberDictionaryEntryType"),
    :schema_attribute => {
      XSD::QName.new(nil, "Key") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => PhysicalAddressDictionaryEntryType,
    :schema_type => XSD::QName.new(NsTypes, "PhysicalAddressDictionaryEntryType"),
    :schema_element => [
      ["street", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Street")], [0, 1]],
      ["city", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "City")], [0, 1]],
      ["state", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "State")], [0, 1]],
      ["countryOrRegion", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "CountryOrRegion")], [0, 1]],
      ["postalCode", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "PostalCode")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "Key") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => ImAddressDictionaryType,
    :schema_type => XSD::QName.new(NsTypes, "ImAddressDictionaryType"),
    :schema_element => [
      ["entry", ["ImAddressDictionaryEntryType[]", XSD::QName.new(NsTypes, "Entry")], [1, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => EmailAddressDictionaryType,
    :schema_type => XSD::QName.new(NsTypes, "EmailAddressDictionaryType"),
    :schema_element => [
      ["entry", ["EmailAddressDictionaryEntryType[]", XSD::QName.new(NsTypes, "Entry")], [1, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => PhoneNumberDictionaryType,
    :schema_type => XSD::QName.new(NsTypes, "PhoneNumberDictionaryType"),
    :schema_element => [
      ["entry", ["PhoneNumberDictionaryEntryType[]", XSD::QName.new(NsTypes, "Entry")], [1, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => PhysicalAddressDictionaryType,
    :schema_type => XSD::QName.new(NsTypes, "PhysicalAddressDictionaryType"),
    :schema_element => [
      ["entry", ["PhysicalAddressDictionaryEntryType[]", XSD::QName.new(NsTypes, "Entry")], [1, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => ContactItemType,
    :schema_type => XSD::QName.new(NsTypes, "ContactItemType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ItemType"),
    :schema_element => [
      ["mimeContent", ["MimeContentType", XSD::QName.new(NsTypes, "MimeContent")], [0, 1]],
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["dateTimeReceived", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeReceived")], [0, 1]],
      ["size", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Size")], [0, 1]],
      ["categories", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Categories")], [0, 1]],
      ["importance", ["ImportanceChoicesType", XSD::QName.new(NsTypes, "Importance")], [0, 1]],
      ["inReplyTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InReplyTo")], [0, 1]],
      ["isSubmitted", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsSubmitted")], [0, 1]],
      ["isDraft", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDraft")], [0, 1]],
      ["isFromMe", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFromMe")], [0, 1]],
      ["isResend", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResend")], [0, 1]],
      ["isUnmodified", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsUnmodified")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["dateTimeSent", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeSent")], [0, 1]],
      ["dateTimeCreated", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeCreated")], [0, 1]],
      ["responseObjects", ["NonEmptyArrayOfResponseObjectsType", XSD::QName.new(NsTypes, "ResponseObjects")], [0, 1]],
      ["reminderDueBy", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "ReminderDueBy")], [0, 1]],
      ["reminderIsSet", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "ReminderIsSet")], [0, 1]],
      ["reminderMinutesBeforeStart", [nil, XSD::QName.new(NsTypes, "ReminderMinutesBeforeStart")], [0, 1]],
      ["displayCc", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayCc")], [0, 1]],
      ["displayTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayTo")], [0, 1]],
      ["hasAttachments", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasAttachments")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["culture", ["SOAP::SOAPLanguage", XSD::QName.new(NsTypes, "Culture")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["lastModifiedName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "LastModifiedName")], [0, 1]],
      ["lastModifiedTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "LastModifiedTime")], [0, 1]],
      ["fileAs", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "FileAs")], [0, 1]],
      ["fileAsMapping", ["FileAsMappingType", XSD::QName.new(NsTypes, "FileAsMapping")], [0, 1]],
      ["displayName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayName")], [0, 1]],
      ["givenName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "GivenName")], [0, 1]],
      ["initials", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Initials")], [0, 1]],
      ["middleName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "MiddleName")], [0, 1]],
      ["nickname", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Nickname")], [0, 1]],
      ["completeName", ["CompleteNameType", XSD::QName.new(NsTypes, "CompleteName")], [0, 1]],
      ["companyName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "CompanyName")], [0, 1]],
      ["emailAddresses", ["EmailAddressDictionaryType", XSD::QName.new(NsTypes, "EmailAddresses")], [0, 1]],
      ["physicalAddresses", ["PhysicalAddressDictionaryType", XSD::QName.new(NsTypes, "PhysicalAddresses")], [0, 1]],
      ["phoneNumbers", ["PhoneNumberDictionaryType", XSD::QName.new(NsTypes, "PhoneNumbers")], [0, 1]],
      ["assistantName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "AssistantName")], [0, 1]],
      ["birthday", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "Birthday")], [0, 1]],
      ["businessHomePage", ["SOAP::SOAPAnyURI", XSD::QName.new(NsTypes, "BusinessHomePage")], [0, 1]],
      ["children", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Children")], [0, 1]],
      ["companies", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Companies")], [0, 1]],
      ["contactSource", ["ContactSourceType", XSD::QName.new(NsTypes, "ContactSource")], [0, 1]],
      ["department", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Department")], [0, 1]],
      ["generation", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Generation")], [0, 1]],
      ["imAddresses", ["ImAddressDictionaryType", XSD::QName.new(NsTypes, "ImAddresses")], [0, 1]],
      ["jobTitle", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "JobTitle")], [0, 1]],
      ["manager", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Manager")], [0, 1]],
      ["mileage", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Mileage")], [0, 1]],
      ["officeLocation", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "OfficeLocation")], [0, 1]],
      ["postalAddressIndex", ["PhysicalAddressIndexType", XSD::QName.new(NsTypes, "PostalAddressIndex")], [0, 1]],
      ["profession", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Profession")], [0, 1]],
      ["spouseName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "SpouseName")], [0, 1]],
      ["surname", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Surname")], [0, 1]],
      ["weddingAnniversary", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "WeddingAnniversary")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => DistributionListType,
    :schema_type => XSD::QName.new(NsTypes, "DistributionListType"),
    :schema_basetype => XSD::QName.new(NsTypes, "ItemType"),
    :schema_element => [
      ["mimeContent", ["MimeContentType", XSD::QName.new(NsTypes, "MimeContent")], [0, 1]],
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")], [0, 1]],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")], [0, 1]],
      ["itemClass", [nil, XSD::QName.new(NsTypes, "ItemClass")], [0, 1]],
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["sensitivity", ["SensitivityChoicesType", XSD::QName.new(NsTypes, "Sensitivity")], [0, 1]],
      ["body", ["BodyType", XSD::QName.new(NsTypes, "Body")], [0, 1]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsTypes, "Attachments")], [0, 1]],
      ["dateTimeReceived", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeReceived")], [0, 1]],
      ["size", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Size")], [0, 1]],
      ["categories", ["ArrayOfStringsType", XSD::QName.new(NsTypes, "Categories")], [0, 1]],
      ["importance", ["ImportanceChoicesType", XSD::QName.new(NsTypes, "Importance")], [0, 1]],
      ["inReplyTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "InReplyTo")], [0, 1]],
      ["isSubmitted", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsSubmitted")], [0, 1]],
      ["isDraft", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsDraft")], [0, 1]],
      ["isFromMe", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFromMe")], [0, 1]],
      ["isResend", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsResend")], [0, 1]],
      ["isUnmodified", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsUnmodified")], [0, 1]],
      ["internetMessageHeaders", ["NonEmptyArrayOfInternetHeadersType", XSD::QName.new(NsTypes, "InternetMessageHeaders")], [0, 1]],
      ["dateTimeSent", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeSent")], [0, 1]],
      ["dateTimeCreated", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "DateTimeCreated")], [0, 1]],
      ["responseObjects", ["NonEmptyArrayOfResponseObjectsType", XSD::QName.new(NsTypes, "ResponseObjects")], [0, 1]],
      ["reminderDueBy", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "ReminderDueBy")], [0, 1]],
      ["reminderIsSet", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "ReminderIsSet")], [0, 1]],
      ["reminderMinutesBeforeStart", [nil, XSD::QName.new(NsTypes, "ReminderMinutesBeforeStart")], [0, 1]],
      ["displayCc", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayCc")], [0, 1]],
      ["displayTo", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayTo")], [0, 1]],
      ["hasAttachments", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "HasAttachments")], [0, 1]],
      ["extendedProperty", ["ExtendedPropertyType[]", XSD::QName.new(NsTypes, "ExtendedProperty")], [0, nil]],
      ["culture", ["SOAP::SOAPLanguage", XSD::QName.new(NsTypes, "Culture")], [0, 1]],
      ["effectiveRights", ["EffectiveRightsType", XSD::QName.new(NsTypes, "EffectiveRights")], [0, 1]],
      ["lastModifiedName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "LastModifiedName")], [0, 1]],
      ["lastModifiedTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "LastModifiedTime")], [0, 1]],
      ["displayName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayName")], [0, 1]],
      ["fileAs", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "FileAs")], [0, 1]],
      ["contactSource", ["ContactSourceType", XSD::QName.new(NsTypes, "ContactSource")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => SearchParametersType,
    :schema_type => XSD::QName.new(NsTypes, "SearchParametersType"),
    :schema_element => [
      ["restriction", ["RestrictionType", XSD::QName.new(NsTypes, "Restriction")]],
      ["baseFolderIds", ["NonEmptyArrayOfBaseFolderIdsType", XSD::QName.new(NsTypes, "BaseFolderIds")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "Traversal") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => ConstantValueType,
    :schema_type => XSD::QName.new(NsTypes, "ConstantValueType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "Value") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => AggregateOnType,
    :schema_type => XSD::QName.new(NsTypes, "AggregateOnType"),
    :schema_element => [ :choice,
      ["fieldURI", ["PathToUnindexedFieldType", XSD::QName.new(NsTypes, "FieldURI")]],
      ["indexedFieldURI", ["PathToIndexedFieldType", XSD::QName.new(NsTypes, "IndexedFieldURI")]],
      ["extendedFieldURI", ["PathToExtendedFieldType", XSD::QName.new(NsTypes, "ExtendedFieldURI")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "Aggregate") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => GroupByType,
    :schema_type => XSD::QName.new(NsTypes, "GroupByType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseGroupByType"),
    :schema_element => [
      [ :choice,
        ["fieldURI", ["PathToUnindexedFieldType", XSD::QName.new(NsTypes, "FieldURI")]],
        ["indexedFieldURI", ["PathToIndexedFieldType", XSD::QName.new(NsTypes, "IndexedFieldURI")]],
        ["extendedFieldURI", ["PathToExtendedFieldType", XSD::QName.new(NsTypes, "ExtendedFieldURI")]]
      ],
      ["aggregateOn", ["AggregateOnType", XSD::QName.new(NsTypes, "AggregateOn")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "Order") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => DistinguishedGroupByType,
    :schema_type => XSD::QName.new(NsTypes, "DistinguishedGroupByType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseGroupByType"),
    :schema_element => [
      ["standardGroupBy", ["StandardGroupByType", XSD::QName.new(NsTypes, "StandardGroupBy")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "Order") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => GroupedItemsType,
    :schema_type => XSD::QName.new(NsTypes, "GroupedItemsType"),
    :schema_element => [
      ["groupIndex", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "GroupIndex")]],
      ["items", ["ArrayOfRealItemsType", XSD::QName.new(NsTypes, "Items")]]
    ]
  )

  LiteralRegistry.register(
    :class => ArrayOfGroupedItemsType,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfGroupedItemsType"),
    :schema_element => [
      ["groupedItems", ["GroupedItemsType[]", XSD::QName.new(NsTypes, "GroupedItems")], [0, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => ExistsType,
    :schema_type => XSD::QName.new(NsTypes, "ExistsType"),
    :schema_basetype => XSD::QName.new(NsTypes, "SearchExpressionType"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "FieldURI")]]
    ]
  )

  LiteralRegistry.register(
    :class => FieldURIOrConstantType,
    :schema_type => XSD::QName.new(NsTypes, "FieldURIOrConstantType"),
    :schema_element => [ :choice,
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["constant", ["ConstantValueType", XSD::QName.new(NsTypes, "Constant")]]
    ]
  )

  LiteralRegistry.register(
    :class => ExcludesValueType,
    :schema_type => XSD::QName.new(NsTypes, "ExcludesValueType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "Value") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => ExcludesType,
    :schema_type => XSD::QName.new(NsTypes, "ExcludesType"),
    :schema_basetype => XSD::QName.new(NsTypes, "SearchExpressionType"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["bitmask", ["ExcludesValueType", XSD::QName.new(NsTypes, "Bitmask")]]
    ]
  )

  LiteralRegistry.register(
    :class => IsEqualToType,
    :schema_type => XSD::QName.new(NsTypes, "IsEqualToType"),
    :schema_basetype => XSD::QName.new(NsTypes, "TwoOperandExpressionType"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["fieldURIOrConstant", ["FieldURIOrConstantType", XSD::QName.new(NsTypes, "FieldURIOrConstant")]]
    ]
  )

  LiteralRegistry.register(
    :class => IsNotEqualToType,
    :schema_type => XSD::QName.new(NsTypes, "IsNotEqualToType"),
    :schema_basetype => XSD::QName.new(NsTypes, "TwoOperandExpressionType"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["fieldURIOrConstant", ["FieldURIOrConstantType", XSD::QName.new(NsTypes, "FieldURIOrConstant")]]
    ]
  )

  LiteralRegistry.register(
    :class => IsGreaterThanType,
    :schema_type => XSD::QName.new(NsTypes, "IsGreaterThanType"),
    :schema_basetype => XSD::QName.new(NsTypes, "TwoOperandExpressionType"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["fieldURIOrConstant", ["FieldURIOrConstantType", XSD::QName.new(NsTypes, "FieldURIOrConstant")]]
    ]
  )

  LiteralRegistry.register(
    :class => IsGreaterThanOrEqualToType,
    :schema_type => XSD::QName.new(NsTypes, "IsGreaterThanOrEqualToType"),
    :schema_basetype => XSD::QName.new(NsTypes, "TwoOperandExpressionType"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["fieldURIOrConstant", ["FieldURIOrConstantType", XSD::QName.new(NsTypes, "FieldURIOrConstant")]]
    ]
  )

  LiteralRegistry.register(
    :class => IsLessThanType,
    :schema_type => XSD::QName.new(NsTypes, "IsLessThanType"),
    :schema_basetype => XSD::QName.new(NsTypes, "TwoOperandExpressionType"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["fieldURIOrConstant", ["FieldURIOrConstantType", XSD::QName.new(NsTypes, "FieldURIOrConstant")]]
    ]
  )

  LiteralRegistry.register(
    :class => IsLessThanOrEqualToType,
    :schema_type => XSD::QName.new(NsTypes, "IsLessThanOrEqualToType"),
    :schema_basetype => XSD::QName.new(NsTypes, "TwoOperandExpressionType"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["fieldURIOrConstant", ["FieldURIOrConstantType", XSD::QName.new(NsTypes, "FieldURIOrConstant")]]
    ]
  )

  LiteralRegistry.register(
    :class => ContainsExpressionType,
    :schema_type => XSD::QName.new(NsTypes, "ContainsExpressionType"),
    :schema_basetype => XSD::QName.new(NsTypes, "SearchExpressionType"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["constant", ["ConstantValueType", XSD::QName.new(NsTypes, "Constant")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ContainmentMode") => "SOAP::SOAPString",
      XSD::QName.new(nil, "ContainmentComparison") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => NotType,
    :schema_type => XSD::QName.new(NsTypes, "NotType"),
    :schema_basetype => XSD::QName.new(NsTypes, "SearchExpressionType"),
    :schema_element => [
      ["searchExpression", ["SearchExpressionType", XSD::QName.new(NsTypes, "SearchExpression")]]
    ]
  )

  LiteralRegistry.register(
    :class => AndType,
    :schema_type => XSD::QName.new(NsTypes, "AndType"),
    :schema_basetype => XSD::QName.new(NsTypes, "MultipleOperandBooleanExpressionType"),
    :schema_element => [
      ["searchExpression", ["SearchExpressionType[]", XSD::QName.new(NsTypes, "SearchExpression")], [2, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => OrType,
    :schema_type => XSD::QName.new(NsTypes, "OrType"),
    :schema_basetype => XSD::QName.new(NsTypes, "MultipleOperandBooleanExpressionType"),
    :schema_element => [
      ["searchExpression", ["SearchExpressionType[]", XSD::QName.new(NsTypes, "SearchExpression")], [2, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => RestrictionType,
    :schema_type => XSD::QName.new(NsTypes, "RestrictionType"),
    :schema_element => [ :choice,
        ["isEqualTo", ["IsEqualToType", XSD::QName.new(NsTypes, "IsEqualTo")]],
        ["exists", ["ExistsType", XSD::QName.new(NsTypes, "Exists")]],
        ["searchExpression", ["SearchExpressionType", XSD::QName.new(NsTypes, "SearchExpression")]]
      ]
  )

  LiteralRegistry.register(
    :class => FieldOrderType,
    :schema_type => XSD::QName.new(NsTypes, "FieldOrderType"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "Order") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => NonEmptyArrayOfFieldOrdersType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfFieldOrdersType"),
    :schema_element => [
      ["fieldOrder", ["FieldOrderType[]", XSD::QName.new(NsTypes, "FieldOrder")], [1, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => NonEmptyArrayOfFolderNamesType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfFolderNamesType"),
    :schema_element => [
      ["folderName", ["SOAP::SOAPString[]", XSD::QName.new(NsTypes, "FolderName")], [1, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => BaseNotificationEventType,
    :schema_type => XSD::QName.new(NsTypes, "BaseNotificationEventType"),
    :schema_element => [
      ["watermark", [nil, XSD::QName.new(NsTypes, "Watermark")]]
    ]
  )

  LiteralRegistry.register(
    :class => BaseObjectChangedEventType,
    :schema_type => XSD::QName.new(NsTypes, "BaseObjectChangedEventType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseNotificationEventType"),
    :schema_element => [
      ["watermark", [nil, XSD::QName.new(NsTypes, "Watermark")]],
      ["timeStamp", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "TimeStamp")]],
      [ :choice,
        ["folderId", ["FolderIdType", XSD::QName.new(NsTypes, "FolderId")]],
        ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")]]
      ],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")]]
    ]
  )

  LiteralRegistry.register(
    :class => ModifiedEventType,
    :schema_type => XSD::QName.new(NsTypes, "ModifiedEventType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseObjectChangedEventType"),
    :schema_element => [
      ["watermark", [nil, XSD::QName.new(NsTypes, "Watermark")]],
      ["timeStamp", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "TimeStamp")]],
      [ :choice,
        ["folderId", ["FolderIdType", XSD::QName.new(NsTypes, "FolderId")]],
        ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")]]
      ],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")]],
      ["unreadCount", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "UnreadCount")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => MovedCopiedEventType,
    :schema_type => XSD::QName.new(NsTypes, "MovedCopiedEventType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseObjectChangedEventType"),
    :schema_element => [
      ["watermark", [nil, XSD::QName.new(NsTypes, "Watermark")]],
      ["timeStamp", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "TimeStamp")]],
      [ :choice,
        ["folderId", ["FolderIdType", XSD::QName.new(NsTypes, "FolderId")]],
        ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")]]
      ],
      ["parentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "ParentFolderId")]],
      [ :choice,
        ["oldFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "OldFolderId")]],
        ["oldItemId", ["ItemIdType", XSD::QName.new(NsTypes, "OldItemId")]]
      ],
      ["oldParentFolderId", ["FolderIdType", XSD::QName.new(NsTypes, "OldParentFolderId")]]
    ]
  )

  LiteralRegistry.register(
    :class => NotificationType,
    :schema_type => XSD::QName.new(NsTypes, "NotificationType"),
    :schema_element => [
      ["subscriptionId", [nil, XSD::QName.new(NsTypes, "SubscriptionId")]],
      ["previousWatermark", [nil, XSD::QName.new(NsTypes, "PreviousWatermark")]],
      ["moreEvents", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "MoreEvents")]],
      [
        ["copiedEvent", ["MovedCopiedEventType[]", XSD::QName.new(NsTypes, "CopiedEvent")]],
        ["createdEvent", ["BaseObjectChangedEventType[]", XSD::QName.new(NsTypes, "CreatedEvent")]],
        ["deletedEvent", ["BaseObjectChangedEventType[]", XSD::QName.new(NsTypes, "DeletedEvent")]],
        ["modifiedEvent", ["ModifiedEventType[]", XSD::QName.new(NsTypes, "ModifiedEvent")]],
        ["movedEvent", ["MovedCopiedEventType[]", XSD::QName.new(NsTypes, "MovedEvent")]],
        ["newMailEvent", ["BaseObjectChangedEventType[]", XSD::QName.new(NsTypes, "NewMailEvent")]],
        ["statusEvent", ["BaseNotificationEventType[]", XSD::QName.new(NsTypes, "StatusEvent")]]
      ]
    ]
  )

  LiteralRegistry.register(
    :class => NonEmptyArrayOfNotificationEventTypesType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfNotificationEventTypesType"),
    :schema_element => [
      ["eventType", ["NotificationEventTypeType[]", XSD::QName.new(NsTypes, "EventType")]]
    ]
  )

  LiteralRegistry.register(
    :class => PushSubscriptionRequestType,
    :schema_type => XSD::QName.new(NsTypes, "PushSubscriptionRequestType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseSubscriptionRequestType"),
    :schema_element => [
      ["folderIds", ["NonEmptyArrayOfBaseFolderIdsType", XSD::QName.new(NsTypes, "FolderIds")]],
      ["eventTypes", ["NonEmptyArrayOfNotificationEventTypesType", XSD::QName.new(NsTypes, "EventTypes")]],
      ["watermark", [nil, XSD::QName.new(NsTypes, "Watermark")], [0, 1]],
      ["statusFrequency", [nil, XSD::QName.new(NsTypes, "StatusFrequency")]],
      ["uRL", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "URL")]]
    ]
  )

  LiteralRegistry.register(
    :class => PullSubscriptionRequestType,
    :schema_type => XSD::QName.new(NsTypes, "PullSubscriptionRequestType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BaseSubscriptionRequestType"),
    :schema_element => [
      ["folderIds", ["NonEmptyArrayOfBaseFolderIdsType", XSD::QName.new(NsTypes, "FolderIds")]],
      ["eventTypes", ["NonEmptyArrayOfNotificationEventTypesType", XSD::QName.new(NsTypes, "EventTypes")]],
      ["watermark", [nil, XSD::QName.new(NsTypes, "Watermark")], [0, 1]],
      ["timeout", [nil, XSD::QName.new(NsTypes, "Timeout")]]
    ]
  )

  LiteralRegistry.register(
    :class => SyncFolderItemsDeleteType,
    :schema_type => XSD::QName.new(NsTypes, "SyncFolderItemsDeleteType"),
    :schema_element => [
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")]]
    ]
  )

  LiteralRegistry.register(
    :class => SyncFolderItemsReadFlagType,
    :schema_type => XSD::QName.new(NsTypes, "SyncFolderItemsReadFlagType"),
    :schema_element => [
      ["itemId", ["ItemIdType", XSD::QName.new(NsTypes, "ItemId")]],
      ["isRead", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsRead")]]
    ]
  )

  LiteralRegistry.register(
    :class => SyncFolderItemsChangesType,
    :schema_type => XSD::QName.new(NsTypes, "SyncFolderItemsChangesType"),
    :schema_element => [
      [
        ["create", ["SyncFolderItemsCreateOrUpdateType[]", XSD::QName.new(NsTypes, "Create")]],
        ["update", ["SyncFolderItemsCreateOrUpdateType[]", XSD::QName.new(NsTypes, "Update")]],
        ["delete", ["SyncFolderItemsDeleteType[]", XSD::QName.new(NsTypes, "Delete")]],
        ["readFlagChange", ["SyncFolderItemsReadFlagType[]", XSD::QName.new(NsTypes, "ReadFlagChange")]]
      ]
    ]
  )

  LiteralRegistry.register(
    :class => SyncFolderHierarchyCreateOrUpdateType,
    :schema_type => XSD::QName.new(NsTypes, "SyncFolderHierarchyCreateOrUpdateType"),
    :schema_element => [ :choice,
      ["folder", ["FolderType", XSD::QName.new(NsTypes, "Folder")]],
      ["calendarFolder", ["CalendarFolderType", XSD::QName.new(NsTypes, "CalendarFolder")]],
      ["contactsFolder", ["ContactsFolderType", XSD::QName.new(NsTypes, "ContactsFolder")]],
      ["searchFolder", ["SearchFolderType", XSD::QName.new(NsTypes, "SearchFolder")]],
      ["tasksFolder", ["TasksFolderType", XSD::QName.new(NsTypes, "TasksFolder")]]
    ]
  )

  LiteralRegistry.register(
    :class => SyncFolderHierarchyDeleteType,
    :schema_type => XSD::QName.new(NsTypes, "SyncFolderHierarchyDeleteType"),
    :schema_element => [
      ["folderId", ["FolderIdType", XSD::QName.new(NsTypes, "FolderId")]]
    ]
  )

  LiteralRegistry.register(
    :class => SyncFolderHierarchyChangesType,
    :schema_type => XSD::QName.new(NsTypes, "SyncFolderHierarchyChangesType"),
    :schema_element => [
      [
        ["create", ["SyncFolderHierarchyCreateOrUpdateType[]", XSD::QName.new(NsTypes, "Create")]],
        ["update", ["SyncFolderHierarchyCreateOrUpdateType[]", XSD::QName.new(NsTypes, "Update")]],
        ["delete", ["SyncFolderHierarchyDeleteType[]", XSD::QName.new(NsTypes, "Delete")]]
      ]
    ]
  )

  LiteralRegistry.register(
    :class => CalendarEventDetails,
    :schema_type => XSD::QName.new(NsTypes, "CalendarEventDetails"),
    :schema_element => [
      ["iD", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "ID")], [0, 1]],
      ["subject", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Subject")], [0, 1]],
      ["location", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Location")], [0, 1]],
      ["isMeeting", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsMeeting")]],
      ["isRecurring", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsRecurring")]],
      ["isException", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsException")]],
      ["isReminderSet", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsReminderSet")]],
      ["isPrivate", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsPrivate")]]
    ]
  )

  LiteralRegistry.register(
    :class => CalendarEvent,
    :schema_type => XSD::QName.new(NsTypes, "CalendarEvent"),
    :schema_element => [
      ["startTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "StartTime")]],
      ["endTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "EndTime")]],
      ["busyType", ["LegacyFreeBusyType", XSD::QName.new(NsTypes, "BusyType")]],
      ["calendarEventDetails", ["CalendarEventDetails", XSD::QName.new(NsTypes, "CalendarEventDetails")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => ArrayOfCalendarEvent,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfCalendarEvent"),
    :schema_element => [
      ["calendarEvent", ["CalendarEvent[]", XSD::QName.new(NsTypes, "CalendarEvent")], [0, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => Duration,
    :schema_type => XSD::QName.new(NsTypes, "Duration"),
    :schema_element => [
      ["startTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "StartTime")]],
      ["endTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "EndTime")]]
    ]
  )

  LiteralRegistry.register(
    :class => EmailAddress,
    :schema_type => XSD::QName.new(NsTypes, "EmailAddress"),
    :schema_element => [
      ["name", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Name")], [0, 1]],
      ["address", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Address")]],
      ["routingType", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "RoutingType")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => FreeBusyViewOptionsType,
    :schema_type => XSD::QName.new(NsTypes, "FreeBusyViewOptionsType"),
    :schema_element => [
      ["timeWindow", ["Duration", XSD::QName.new(NsTypes, "TimeWindow")]],
      ["mergedFreeBusyIntervalInMinutes", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "MergedFreeBusyIntervalInMinutes")], [0, 1]],
      ["requestedView", [nil, XSD::QName.new(NsTypes, "RequestedView")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => WorkingPeriod,
    :schema_type => XSD::QName.new(NsTypes, "WorkingPeriod"),
    :schema_element => [
      ["dayOfWeek", [nil, XSD::QName.new(NsTypes, "DayOfWeek")]],
      ["startTimeInMinutes", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "StartTimeInMinutes")]],
      ["endTimeInMinutes", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "EndTimeInMinutes")]]
    ]
  )

  LiteralRegistry.register(
    :class => ArrayOfWorkingPeriod,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfWorkingPeriod"),
    :schema_element => [
      ["workingPeriod", ["WorkingPeriod[]", XSD::QName.new(NsTypes, "WorkingPeriod")], [0, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => SerializableTimeZoneTime,
    :schema_type => XSD::QName.new(NsTypes, "SerializableTimeZoneTime"),
    :schema_element => [
      ["bias", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Bias")]],
      ["time", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Time")]],
      ["dayOrder", ["SOAP::SOAPShort", XSD::QName.new(NsTypes, "DayOrder")]],
      ["month", ["SOAP::SOAPShort", XSD::QName.new(NsTypes, "Month")]],
      ["dayOfWeek", ["DayOfWeekType", XSD::QName.new(NsTypes, "DayOfWeek")]],
      ["year", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Year")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => SerializableTimeZone,
    :schema_type => XSD::QName.new(NsTypes, "SerializableTimeZone"),
    :schema_element => [
      ["bias", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Bias")]],
      ["standardTime", ["SerializableTimeZoneTime", XSD::QName.new(NsTypes, "StandardTime")]],
      ["daylightTime", ["SerializableTimeZoneTime", XSD::QName.new(NsTypes, "DaylightTime")]]
    ]
  )

  LiteralRegistry.register(
    :class => WorkingHours,
    :schema_type => XSD::QName.new(NsTypes, "WorkingHours"),
    :schema_element => [
      ["timeZone", ["SerializableTimeZone", XSD::QName.new(NsTypes, "TimeZone")]],
      ["workingPeriodArray", ["ArrayOfWorkingPeriod", XSD::QName.new(NsTypes, "WorkingPeriodArray")]]
    ]
  )

  LiteralRegistry.register(
    :class => FreeBusyView,
    :schema_type => XSD::QName.new(NsTypes, "FreeBusyView"),
    :schema_element => [
      ["freeBusyViewType", [nil, XSD::QName.new(NsTypes, "FreeBusyViewType")]],
      ["mergedFreeBusy", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "MergedFreeBusy")], [0, 1]],
      ["calendarEventArray", ["ArrayOfCalendarEvent", XSD::QName.new(NsTypes, "CalendarEventArray")], [0, 1]],
      ["workingHours", ["WorkingHours", XSD::QName.new(NsTypes, "WorkingHours")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => MailboxData,
    :schema_type => XSD::QName.new(NsTypes, "MailboxData"),
    :schema_element => [
      ["email", ["EmailAddress", XSD::QName.new(NsTypes, "Email")]],
      ["attendeeType", ["MeetingAttendeeType", XSD::QName.new(NsTypes, "AttendeeType")]],
      ["excludeConflicts", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "ExcludeConflicts")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => ArrayOfMailboxData,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfMailboxData"),
    :schema_element => [
      ["mailboxData", ["MailboxData[]", XSD::QName.new(NsTypes, "MailboxData")], [0, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => SuggestionsViewOptionsType,
    :schema_type => XSD::QName.new(NsTypes, "SuggestionsViewOptionsType"),
    :schema_element => [
      ["goodThreshold", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "GoodThreshold")], [0, 1]],
      ["maximumResultsByDay", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "MaximumResultsByDay")], [0, 1]],
      ["maximumNonWorkHourResultsByDay", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "MaximumNonWorkHourResultsByDay")], [0, 1]],
      ["meetingDurationInMinutes", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "MeetingDurationInMinutes")], [0, 1]],
      ["minimumSuggestionQuality", ["SuggestionQuality", XSD::QName.new(NsTypes, "MinimumSuggestionQuality")], [0, 1]],
      ["detailedSuggestionsWindow", ["Duration", XSD::QName.new(NsTypes, "DetailedSuggestionsWindow")]],
      ["currentMeetingTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "CurrentMeetingTime")], [0, 1]],
      ["globalObjectId", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "GlobalObjectId")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => ArrayOfAttendeeConflictData,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfAttendeeConflictData"),
    :schema_element => [ :choice,
      ["unknownAttendeeConflictData", ["UnknownAttendeeConflictData[]", XSD::QName.new(NsTypes, "UnknownAttendeeConflictData")]],
      ["individualAttendeeConflictData", ["IndividualAttendeeConflictData[]", XSD::QName.new(NsTypes, "IndividualAttendeeConflictData")]],
      ["tooBigGroupAttendeeConflictData", ["TooBigGroupAttendeeConflictData[]", XSD::QName.new(NsTypes, "TooBigGroupAttendeeConflictData")]],
      ["groupAttendeeConflictData", ["GroupAttendeeConflictData[]", XSD::QName.new(NsTypes, "GroupAttendeeConflictData")]]
    ]
  )

  LiteralRegistry.register(
    :class => UnknownAttendeeConflictData,
    :schema_type => XSD::QName.new(NsTypes, "UnknownAttendeeConflictData"),
    :schema_basetype => XSD::QName.new(NsTypes, "AttendeeConflictData"),
    :schema_element => []
  )

  LiteralRegistry.register(
    :class => TooBigGroupAttendeeConflictData,
    :schema_type => XSD::QName.new(NsTypes, "TooBigGroupAttendeeConflictData"),
    :schema_basetype => XSD::QName.new(NsTypes, "AttendeeConflictData"),
    :schema_element => []
  )

  LiteralRegistry.register(
    :class => IndividualAttendeeConflictData,
    :schema_type => XSD::QName.new(NsTypes, "IndividualAttendeeConflictData"),
    :schema_basetype => XSD::QName.new(NsTypes, "AttendeeConflictData"),
    :schema_element => [
      ["busyType", ["LegacyFreeBusyType", XSD::QName.new(NsTypes, "BusyType")]]
    ]
  )

  LiteralRegistry.register(
    :class => GroupAttendeeConflictData,
    :schema_type => XSD::QName.new(NsTypes, "GroupAttendeeConflictData"),
    :schema_basetype => XSD::QName.new(NsTypes, "AttendeeConflictData"),
    :schema_element => [
      ["numberOfMembers", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "NumberOfMembers")]],
      ["numberOfMembersAvailable", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "NumberOfMembersAvailable")]],
      ["numberOfMembersWithConflict", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "NumberOfMembersWithConflict")]],
      ["numberOfMembersWithNoData", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "NumberOfMembersWithNoData")]]
    ]
  )

  LiteralRegistry.register(
    :class => Suggestion,
    :schema_type => XSD::QName.new(NsTypes, "Suggestion"),
    :schema_element => [
      ["meetingTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "MeetingTime")]],
      ["isWorkTime", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsWorkTime")]],
      ["suggestionQuality", ["SuggestionQuality", XSD::QName.new(NsTypes, "SuggestionQuality")]],
      ["attendeeConflictDataArray", ["ArrayOfAttendeeConflictData", XSD::QName.new(NsTypes, "AttendeeConflictDataArray")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => ArrayOfSuggestion,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfSuggestion"),
    :schema_element => [
      ["suggestion", ["Suggestion[]", XSD::QName.new(NsTypes, "Suggestion")], [0, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => SuggestionDayResult,
    :schema_type => XSD::QName.new(NsTypes, "SuggestionDayResult"),
    :schema_element => [
      ["date", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "Date")]],
      ["dayQuality", ["SuggestionQuality", XSD::QName.new(NsTypes, "DayQuality")]],
      ["suggestionArray", ["ArrayOfSuggestion", XSD::QName.new(NsTypes, "SuggestionArray")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => ArrayOfSuggestionDayResult,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfSuggestionDayResult"),
    :schema_element => [
      ["suggestionDayResult", ["SuggestionDayResult[]", XSD::QName.new(NsTypes, "SuggestionDayResult")], [0, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => ReplyBody,
    :schema_type => XSD::QName.new(NsTypes, "ReplyBody"),
    :schema_element => [
      ["message", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Message")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(NsNamespace, "lang") => nil
    }
  )

  LiteralRegistry.register(
    :class => UserOofSettings,
    :schema_type => XSD::QName.new(NsTypes, "UserOofSettings"),
    :schema_element => [
      ["oofState", ["OofState", XSD::QName.new(NsTypes, "OofState")]],
      ["externalAudience", ["ExternalAudience", XSD::QName.new(NsTypes, "ExternalAudience")]],
      ["duration", ["Duration", XSD::QName.new(NsTypes, "Duration")], [0, 1]],
      ["internalReply", ["ReplyBody", XSD::QName.new(NsTypes, "InternalReply")], [0, 1]],
      ["externalReply", ["ReplyBody", XSD::QName.new(NsTypes, "ExternalReply")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => Value,
    :schema_type => XSD::QName.new(NsTypes, "Value"),
    :schema_attribute => {
      XSD::QName.new(nil, "Name") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => AlternateIdType,
    :schema_type => XSD::QName.new(NsTypes, "AlternateIdType"),
    :schema_basetype => XSD::QName.new(NsTypes, "AlternateIdBaseType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "Format") => "SOAP::SOAPString",
      XSD::QName.new(nil, "Id") => "SOAP::SOAPString",
      XSD::QName.new(nil, "Mailbox") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => AlternatePublicFolderIdType,
    :schema_type => XSD::QName.new(NsTypes, "AlternatePublicFolderIdType"),
    :schema_basetype => XSD::QName.new(NsTypes, "AlternateIdBaseType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "Format") => "SOAP::SOAPString",
      XSD::QName.new(nil, "FolderId") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => AlternatePublicFolderItemIdType,
    :schema_type => XSD::QName.new(NsTypes, "AlternatePublicFolderItemIdType"),
    :schema_basetype => XSD::QName.new(NsTypes, "AlternatePublicFolderIdType"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "Format") => "SOAP::SOAPString",
      XSD::QName.new(nil, "FolderId") => "SOAP::SOAPString",
      XSD::QName.new(nil, "ItemId") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => NonEmptyArrayOfAlternateIdsType,
    :schema_type => XSD::QName.new(NsTypes, "NonEmptyArrayOfAlternateIdsType"),
    :schema_element => [ :choice,
      ["alternateId", ["AlternateIdType[]", XSD::QName.new(NsTypes, "AlternateId")]],
      ["alternatePublicFolderId", ["AlternatePublicFolderIdType[]", XSD::QName.new(NsTypes, "AlternatePublicFolderId")]],
      ["alternatePublicFolderItemId", ["AlternatePublicFolderItemIdType[]", XSD::QName.new(NsTypes, "AlternatePublicFolderItemId")]]
    ]
  )

  LiteralRegistry.register(
    :class => UserIdType,
    :schema_type => XSD::QName.new(NsTypes, "UserIdType"),
    :schema_element => [
      ["sID", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "SID")], [0, 1]],
      ["primarySmtpAddress", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "PrimarySmtpAddress")], [0, 1]],
      ["displayName", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "DisplayName")], [0, 1]],
      ["distinguishedUser", ["DistinguishedUserType", XSD::QName.new(NsTypes, "DistinguishedUser")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => ArrayOfPermissionsType,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfPermissionsType"),
    :schema_element => [
      ["permission", ["PermissionType[]", XSD::QName.new(NsTypes, "Permission")]]
    ]
  )

  LiteralRegistry.register(
    :class => ArrayOfCalendarPermissionsType,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfCalendarPermissionsType"),
    :schema_element => [
      ["calendarPermission", ["CalendarPermissionType[]", XSD::QName.new(NsTypes, "CalendarPermission")]]
    ]
  )

  LiteralRegistry.register(
    :class => ArrayOfUnknownEntriesType,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfUnknownEntriesType"),
    :schema_element => [
      ["unknownEntry", ["SOAP::SOAPString[]", XSD::QName.new(NsTypes, "UnknownEntry")]]
    ]
  )

  LiteralRegistry.register(
    :class => PermissionType,
    :schema_type => XSD::QName.new(NsTypes, "PermissionType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BasePermissionType"),
    :schema_element => [
      ["userId", ["UserIdType", XSD::QName.new(NsTypes, "UserId")]],
      ["canCreateItems", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "CanCreateItems")], [0, 1]],
      ["canCreateSubFolders", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "CanCreateSubFolders")], [0, 1]],
      ["isFolderOwner", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFolderOwner")], [0, 1]],
      ["isFolderVisible", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFolderVisible")], [0, 1]],
      ["isFolderContact", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFolderContact")], [0, 1]],
      ["editItems", ["PermissionActionType", XSD::QName.new(NsTypes, "EditItems")], [0, 1]],
      ["deleteItems", ["PermissionActionType", XSD::QName.new(NsTypes, "DeleteItems")], [0, 1]],
      ["readItems", ["PermissionReadAccessType", XSD::QName.new(NsTypes, "ReadItems")], [0, 1]],
      ["permissionLevel", ["PermissionLevelType", XSD::QName.new(NsTypes, "PermissionLevel")]]
    ]
  )

  LiteralRegistry.register(
    :class => CalendarPermissionType,
    :schema_type => XSD::QName.new(NsTypes, "CalendarPermissionType"),
    :schema_basetype => XSD::QName.new(NsTypes, "BasePermissionType"),
    :schema_element => [
      ["userId", ["UserIdType", XSD::QName.new(NsTypes, "UserId")]],
      ["canCreateItems", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "CanCreateItems")], [0, 1]],
      ["canCreateSubFolders", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "CanCreateSubFolders")], [0, 1]],
      ["isFolderOwner", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFolderOwner")], [0, 1]],
      ["isFolderVisible", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFolderVisible")], [0, 1]],
      ["isFolderContact", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "IsFolderContact")], [0, 1]],
      ["editItems", ["PermissionActionType", XSD::QName.new(NsTypes, "EditItems")], [0, 1]],
      ["deleteItems", ["PermissionActionType", XSD::QName.new(NsTypes, "DeleteItems")], [0, 1]],
      ["readItems", ["CalendarPermissionReadAccessType", XSD::QName.new(NsTypes, "ReadItems")], [0, 1]],
      ["calendarPermissionLevel", ["CalendarPermissionLevelType", XSD::QName.new(NsTypes, "CalendarPermissionLevel")]]
    ]
  )

  LiteralRegistry.register(
    :class => PermissionSetType,
    :schema_type => XSD::QName.new(NsTypes, "PermissionSetType"),
    :schema_element => [
      ["permissions", ["ArrayOfPermissionsType", XSD::QName.new(NsTypes, "Permissions")]],
      ["unknownEntries", ["ArrayOfUnknownEntriesType", XSD::QName.new(NsTypes, "UnknownEntries")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => CalendarPermissionSetType,
    :schema_type => XSD::QName.new(NsTypes, "CalendarPermissionSetType"),
    :schema_element => [
      ["calendarPermissions", ["ArrayOfCalendarPermissionsType", XSD::QName.new(NsTypes, "CalendarPermissions")]],
      ["unknownEntries", ["ArrayOfUnknownEntriesType", XSD::QName.new(NsTypes, "UnknownEntries")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => EffectiveRightsType,
    :schema_type => XSD::QName.new(NsTypes, "EffectiveRightsType"),
    :schema_element => [
      ["createAssociated", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "CreateAssociated")]],
      ["createContents", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "CreateContents")]],
      ["createHierarchy", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "CreateHierarchy")]],
      ["delete", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "Delete")]],
      ["modify", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "Modify")]],
      ["read", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "Read")]]
    ]
  )

  LiteralRegistry.register(
    :class => ArrayOfDelegateUserType,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfDelegateUserType"),
    :schema_element => [
      ["delegateUser", ["DelegateUserType[]", XSD::QName.new(NsTypes, "DelegateUser")], [1, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => ArrayOfUserIdType,
    :schema_type => XSD::QName.new(NsTypes, "ArrayOfUserIdType"),
    :schema_element => [
      ["userId", ["UserIdType[]", XSD::QName.new(NsTypes, "UserId")], [1, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => DelegateUserType,
    :schema_type => XSD::QName.new(NsTypes, "DelegateUserType"),
    :schema_element => [
      ["userId", ["UserIdType", XSD::QName.new(NsTypes, "UserId")]],
      ["delegatePermissions", ["DelegatePermissionsType", XSD::QName.new(NsTypes, "DelegatePermissions")], [0, 1]],
      ["receiveCopiesOfMeetingMessages", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "ReceiveCopiesOfMeetingMessages")], [0, 1]],
      ["viewPrivateItems", ["SOAP::SOAPBoolean", XSD::QName.new(NsTypes, "ViewPrivateItems")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => DelegatePermissionsType,
    :schema_type => XSD::QName.new(NsTypes, "DelegatePermissionsType"),
    :schema_element => [
      ["calendarFolderPermissionLevel", ["DelegateFolderPermissionLevelType", XSD::QName.new(NsTypes, "CalendarFolderPermissionLevel")], [0, 1]],
      ["tasksFolderPermissionLevel", ["DelegateFolderPermissionLevelType", XSD::QName.new(NsTypes, "TasksFolderPermissionLevel")], [0, 1]],
      ["inboxFolderPermissionLevel", ["DelegateFolderPermissionLevelType", XSD::QName.new(NsTypes, "InboxFolderPermissionLevel")], [0, 1]],
      ["contactsFolderPermissionLevel", ["DelegateFolderPermissionLevelType", XSD::QName.new(NsTypes, "ContactsFolderPermissionLevel")], [0, 1]],
      ["notesFolderPermissionLevel", ["DelegateFolderPermissionLevelType", XSD::QName.new(NsTypes, "NotesFolderPermissionLevel")], [0, 1]],
      ["journalFolderPermissionLevel", ["DelegateFolderPermissionLevelType", XSD::QName.new(NsTypes, "JournalFolderPermissionLevel")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => ConflictResultsType,
    :schema_type => XSD::QName.new(NsTypes, "ConflictResultsType"),
    :schema_element => [
      ["count", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Count")]]
    ]
  )

  LiteralRegistry.register(
    :class => ResponseCodeType,
    :schema_type => XSD::QName.new(NsMessages, "ResponseCodeType")
  )

  LiteralRegistry.register(
    :class => ExchangeVersionType,
    :schema_type => XSD::QName.new(NsTypes, "ExchangeVersionType")
  )

  LiteralRegistry.register(
    :class => MailboxTypeType,
    :schema_type => XSD::QName.new(NsTypes, "MailboxTypeType")
  )

  LiteralRegistry.register(
    :class => UnindexedFieldURIType,
    :schema_type => XSD::QName.new(NsTypes, "UnindexedFieldURIType")
  )

  LiteralRegistry.register(
    :class => DictionaryURIType,
    :schema_type => XSD::QName.new(NsTypes, "DictionaryURIType")
  )

  LiteralRegistry.register(
    :class => ExceptionPropertyURIType,
    :schema_type => XSD::QName.new(NsTypes, "ExceptionPropertyURIType")
  )

  LiteralRegistry.register(
    :class => DistinguishedPropertySetType,
    :schema_type => XSD::QName.new(NsTypes, "DistinguishedPropertySetType")
  )

  LiteralRegistry.register(
    :class => MapiPropertyTypeType,
    :schema_type => XSD::QName.new(NsTypes, "MapiPropertyTypeType")
  )

  LiteralRegistry.register(
    :class => FolderQueryTraversalType,
    :schema_type => XSD::QName.new(NsTypes, "FolderQueryTraversalType")
  )

  LiteralRegistry.register(
    :class => SearchFolderTraversalType,
    :schema_type => XSD::QName.new(NsTypes, "SearchFolderTraversalType")
  )

  LiteralRegistry.register(
    :class => ItemQueryTraversalType,
    :schema_type => XSD::QName.new(NsTypes, "ItemQueryTraversalType")
  )

  LiteralRegistry.register(
    :class => DefaultShapeNamesType,
    :schema_type => XSD::QName.new(NsTypes, "DefaultShapeNamesType")
  )

  LiteralRegistry.register(
    :class => BodyTypeResponseType,
    :schema_type => XSD::QName.new(NsTypes, "BodyTypeResponseType")
  )

  LiteralRegistry.register(
    :class => DisposalType,
    :schema_type => XSD::QName.new(NsTypes, "DisposalType")
  )

  LiteralRegistry.register(
    :class => ConflictResolutionType,
    :schema_type => XSD::QName.new(NsTypes, "ConflictResolutionType")
  )

  LiteralRegistry.register(
    :class => ResponseClassType,
    :schema_type => XSD::QName.new(NsTypes, "ResponseClassType")
  )

  LiteralRegistry.register(
    :class => SensitivityChoicesType,
    :schema_type => XSD::QName.new(NsTypes, "SensitivityChoicesType")
  )

  LiteralRegistry.register(
    :class => ImportanceChoicesType,
    :schema_type => XSD::QName.new(NsTypes, "ImportanceChoicesType")
  )

  LiteralRegistry.register(
    :class => BodyTypeType,
    :schema_type => XSD::QName.new(NsTypes, "BodyTypeType")
  )

  LiteralRegistry.register(
    :class => DistinguishedFolderIdNameType,
    :schema_type => XSD::QName.new(NsTypes, "DistinguishedFolderIdNameType")
  )

  LiteralRegistry.register(
    :class => MessageDispositionType,
    :schema_type => XSD::QName.new(NsTypes, "MessageDispositionType")
  )

  LiteralRegistry.register(
    :class => CalendarItemCreateOrDeleteOperationType,
    :schema_type => XSD::QName.new(NsTypes, "CalendarItemCreateOrDeleteOperationType")
  )

  LiteralRegistry.register(
    :class => CalendarItemUpdateOperationType,
    :schema_type => XSD::QName.new(NsTypes, "CalendarItemUpdateOperationType")
  )

  LiteralRegistry.register(
    :class => AffectedTaskOccurrencesType,
    :schema_type => XSD::QName.new(NsTypes, "AffectedTaskOccurrencesType")
  )

  LiteralRegistry.register(
    :class => TaskStatusType,
    :schema_type => XSD::QName.new(NsTypes, "TaskStatusType")
  )

  LiteralRegistry.register(
    :class => TaskDelegateStateType,
    :schema_type => XSD::QName.new(NsTypes, "TaskDelegateStateType")
  )

  LiteralRegistry.register(
    :class => IndexBasePointType,
    :schema_type => XSD::QName.new(NsTypes, "IndexBasePointType")
  )

  LiteralRegistry.register(
    :class => ResolveNamesSearchScopeType,
    :schema_type => XSD::QName.new(NsTypes, "ResolveNamesSearchScopeType")
  )

  LiteralRegistry.register(
    :class => MeetingRequestTypeType,
    :schema_type => XSD::QName.new(NsTypes, "MeetingRequestTypeType")
  )

  LiteralRegistry.register(
    :class => LegacyFreeBusyType,
    :schema_type => XSD::QName.new(NsTypes, "LegacyFreeBusyType")
  )

  LiteralRegistry.register(
    :class => CalendarItemTypeType,
    :schema_type => XSD::QName.new(NsTypes, "CalendarItemTypeType")
  )

  LiteralRegistry.register(
    :class => ResponseTypeType,
    :schema_type => XSD::QName.new(NsTypes, "ResponseTypeType")
  )

  LiteralRegistry.register(
    :class => DayOfWeekType,
    :schema_type => XSD::QName.new(NsTypes, "DayOfWeekType")
  )

  LiteralRegistry.register(
    :class => DayOfWeekIndexType,
    :schema_type => XSD::QName.new(NsTypes, "DayOfWeekIndexType")
  )

  LiteralRegistry.register(
    :class => MonthNamesType,
    :schema_type => XSD::QName.new(NsTypes, "MonthNamesType")
  )

  LiteralRegistry.register(
    :class => ImAddressKeyType,
    :schema_type => XSD::QName.new(NsTypes, "ImAddressKeyType")
  )

  LiteralRegistry.register(
    :class => EmailAddressKeyType,
    :schema_type => XSD::QName.new(NsTypes, "EmailAddressKeyType")
  )

  LiteralRegistry.register(
    :class => PhoneNumberKeyType,
    :schema_type => XSD::QName.new(NsTypes, "PhoneNumberKeyType")
  )

  LiteralRegistry.register(
    :class => PhysicalAddressIndexType,
    :schema_type => XSD::QName.new(NsTypes, "PhysicalAddressIndexType")
  )

  LiteralRegistry.register(
    :class => PhysicalAddressKeyType,
    :schema_type => XSD::QName.new(NsTypes, "PhysicalAddressKeyType")
  )

  LiteralRegistry.register(
    :class => FileAsMappingType,
    :schema_type => XSD::QName.new(NsTypes, "FileAsMappingType")
  )

  LiteralRegistry.register(
    :class => ContactSourceType,
    :schema_type => XSD::QName.new(NsTypes, "ContactSourceType")
  )

  LiteralRegistry.register(
    :class => AggregateType,
    :schema_type => XSD::QName.new(NsTypes, "AggregateType")
  )

  LiteralRegistry.register(
    :class => StandardGroupByType,
    :schema_type => XSD::QName.new(NsTypes, "StandardGroupByType")
  )

  LiteralRegistry.register(
    :class => ContainmentModeType,
    :schema_type => XSD::QName.new(NsTypes, "ContainmentModeType")
  )

  LiteralRegistry.register(
    :class => ContainmentComparisonType,
    :schema_type => XSD::QName.new(NsTypes, "ContainmentComparisonType")
  )

  LiteralRegistry.register(
    :class => SortDirectionType,
    :schema_type => XSD::QName.new(NsTypes, "SortDirectionType")
  )

  LiteralRegistry.register(
    :class => NotificationEventTypeType,
    :schema_type => XSD::QName.new(NsTypes, "NotificationEventTypeType")
  )

  LiteralRegistry.register(
    :class => SubscriptionStatusType,
    :schema_type => XSD::QName.new(NsTypes, "SubscriptionStatusType")
  )

  LiteralRegistry.register(
    :class => AvailabilityProxyRequestType,
    :schema_type => XSD::QName.new(NsTypes, "AvailabilityProxyRequestType")
  )

  LiteralRegistry.register(
    :class => MeetingAttendeeType,
    :schema_type => XSD::QName.new(NsTypes, "MeetingAttendeeType")
  )

  LiteralRegistry.register(
    :class => SuggestionQuality,
    :schema_type => XSD::QName.new(NsTypes, "SuggestionQuality")
  )

  LiteralRegistry.register(
    :class => OofState,
    :schema_type => XSD::QName.new(NsTypes, "OofState")
  )

  LiteralRegistry.register(
    :class => ExternalAudience,
    :schema_type => XSD::QName.new(NsTypes, "ExternalAudience")
  )

  LiteralRegistry.register(
    :class => IdFormatType,
    :schema_type => XSD::QName.new(NsTypes, "IdFormatType")
  )

  LiteralRegistry.register(
    :class => DistinguishedUserType,
    :schema_type => XSD::QName.new(NsTypes, "DistinguishedUserType")
  )

  LiteralRegistry.register(
    :class => PermissionReadAccessType,
    :schema_type => XSD::QName.new(NsTypes, "PermissionReadAccessType")
  )

  LiteralRegistry.register(
    :class => CalendarPermissionReadAccessType,
    :schema_type => XSD::QName.new(NsTypes, "CalendarPermissionReadAccessType")
  )

  LiteralRegistry.register(
    :class => PermissionActionType,
    :schema_type => XSD::QName.new(NsTypes, "PermissionActionType")
  )

  LiteralRegistry.register(
    :class => PermissionLevelType,
    :schema_type => XSD::QName.new(NsTypes, "PermissionLevelType")
  )

  LiteralRegistry.register(
    :class => CalendarPermissionLevelType,
    :schema_type => XSD::QName.new(NsTypes, "CalendarPermissionLevelType")
  )

  LiteralRegistry.register(
    :class => DeliverMeetingRequestsType,
    :schema_type => XSD::QName.new(NsTypes, "DeliverMeetingRequestsType")
  )

  LiteralRegistry.register(
    :class => DelegateFolderPermissionLevelType,
    :schema_type => XSD::QName.new(NsTypes, "DelegateFolderPermissionLevelType")
  )

  LiteralRegistry.register(
    :class => GetFolderType,
    :schema_name => XSD::QName.new(NsMessages, "GetFolder"),
    :schema_element => [
      ["folderShape", ["FolderResponseShapeType", XSD::QName.new(NsMessages, "FolderShape")]],
      ["folderIds", ["NonEmptyArrayOfBaseFolderIdsType", XSD::QName.new(NsMessages, "FolderIds")]]
    ]
  )

  LiteralRegistry.register(
    :class => CreateFolderType,
    :schema_name => XSD::QName.new(NsMessages, "CreateFolder"),
    :schema_element => [
      ["parentFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "ParentFolderId")]],
      ["folders", ["NonEmptyArrayOfFoldersType", XSD::QName.new(NsMessages, "Folders")]]
    ]
  )

  LiteralRegistry.register(
    :class => FindFolderType,
    :schema_name => XSD::QName.new(NsMessages, "FindFolder"),
    :schema_element => [
      ["folderShape", ["FolderResponseShapeType", XSD::QName.new(NsMessages, "FolderShape")]],
      [ :choice,
        ["indexedPageFolderView", ["IndexedPageViewType", XSD::QName.new(NsMessages, "IndexedPageFolderView")]],
        ["fractionalPageFolderView", ["FractionalPageViewType", XSD::QName.new(NsMessages, "FractionalPageFolderView")]]
      ],
      ["restriction", ["RestrictionType", XSD::QName.new(NsMessages, "Restriction")], [0, 1]],
      ["parentFolderIds", ["NonEmptyArrayOfBaseFolderIdsType", XSD::QName.new(NsMessages, "ParentFolderIds")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "Traversal") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => FindFolderResponseType,
    :schema_name => XSD::QName.new(NsMessages, "FindFolderResponse"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => DeleteFolderType,
    :schema_name => XSD::QName.new(NsMessages, "DeleteFolder"),
    :schema_element => [
      ["folderIds", ["NonEmptyArrayOfBaseFolderIdsType", XSD::QName.new(NsMessages, "FolderIds")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "DeleteType") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => DeleteFolderResponseType,
    :schema_name => XSD::QName.new(NsMessages, "DeleteFolderResponse"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => MoveFolderType,
    :schema_name => XSD::QName.new(NsMessages, "MoveFolder"),
    :schema_element => [
      ["toFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "ToFolderId")]],
      ["folderIds", ["NonEmptyArrayOfBaseFolderIdsType", XSD::QName.new(NsMessages, "FolderIds")]]
    ]
  )

  LiteralRegistry.register(
    :class => CopyFolderType,
    :schema_name => XSD::QName.new(NsMessages, "CopyFolder"),
    :schema_element => [
      ["toFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "ToFolderId")]],
      ["folderIds", ["NonEmptyArrayOfBaseFolderIdsType", XSD::QName.new(NsMessages, "FolderIds")]]
    ]
  )

  LiteralRegistry.register(
    :class => UpdateFolderType,
    :schema_name => XSD::QName.new(NsMessages, "UpdateFolder"),
    :schema_element => [
      ["folderChanges", ["NonEmptyArrayOfFolderChangesType", XSD::QName.new(NsMessages, "FolderChanges")]]
    ]
  )

  LiteralRegistry.register(
    :class => CreateFolderResponseType,
    :schema_name => XSD::QName.new(NsMessages, "CreateFolderResponse"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => GetFolderResponseType,
    :schema_name => XSD::QName.new(NsMessages, "GetFolderResponse"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => UpdateFolderResponseType,
    :schema_name => XSD::QName.new(NsMessages, "UpdateFolderResponse"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => MoveFolderResponseType,
    :schema_name => XSD::QName.new(NsMessages, "MoveFolderResponse"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => CopyFolderResponseType,
    :schema_name => XSD::QName.new(NsMessages, "CopyFolderResponse"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => GetItemType,
    :schema_name => XSD::QName.new(NsMessages, "GetItem"),
    :schema_element => [
      ["itemShape", ["ItemResponseShapeType", XSD::QName.new(NsMessages, "ItemShape")]],
      ["itemIds", ["NonEmptyArrayOfBaseItemIdsType", XSD::QName.new(NsMessages, "ItemIds")]]
    ]
  )

  LiteralRegistry.register(
    :class => CreateItemType,
    :schema_name => XSD::QName.new(NsMessages, "CreateItem"),
    :schema_element => [
      ["savedItemFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "SavedItemFolderId")], [0, 1]],
      ["items", ["NonEmptyArrayOfAllItemsType", XSD::QName.new(NsMessages, "Items")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "MessageDisposition") => "SOAP::SOAPString",
      XSD::QName.new(nil, "SendMeetingInvitations") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => UpdateItemType,
    :schema_name => XSD::QName.new(NsMessages, "UpdateItem"),
    :schema_element => [
      ["savedItemFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "SavedItemFolderId")], [0, 1]],
      ["itemChanges", ["NonEmptyArrayOfItemChangesType", XSD::QName.new(NsMessages, "ItemChanges")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ConflictResolution") => "SOAP::SOAPString",
      XSD::QName.new(nil, "MessageDisposition") => "SOAP::SOAPString",
      XSD::QName.new(nil, "SendMeetingInvitationsOrCancellations") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => DeleteItemType,
    :schema_name => XSD::QName.new(NsMessages, "DeleteItem"),
    :schema_element => [
      ["itemIds", ["NonEmptyArrayOfBaseItemIdsType", XSD::QName.new(NsMessages, "ItemIds")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "DeleteType") => "SOAP::SOAPString",
      XSD::QName.new(nil, "SendMeetingCancellations") => "SOAP::SOAPString",
      XSD::QName.new(nil, "AffectedTaskOccurrences") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => MoveItemType,
    :schema_name => XSD::QName.new(NsMessages, "MoveItem"),
    :schema_element => [
      ["toFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "ToFolderId")]],
      ["itemIds", ["NonEmptyArrayOfBaseItemIdsType", XSD::QName.new(NsMessages, "ItemIds")]]
    ]
  )

  LiteralRegistry.register(
    :class => CopyItemType,
    :schema_name => XSD::QName.new(NsMessages, "CopyItem"),
    :schema_element => [
      ["toFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "ToFolderId")]],
      ["itemIds", ["NonEmptyArrayOfBaseItemIdsType", XSD::QName.new(NsMessages, "ItemIds")]]
    ]
  )

  LiteralRegistry.register(
    :class => SendItemType,
    :schema_name => XSD::QName.new(NsMessages, "SendItem"),
    :schema_element => [
      ["itemIds", ["NonEmptyArrayOfBaseItemIdsType", XSD::QName.new(NsMessages, "ItemIds")]],
      ["savedItemFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "SavedItemFolderId")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "SaveItemToFolder") => "SOAP::SOAPBoolean"
    }
  )

  LiteralRegistry.register(
    :class => SendItemResponseType,
    :schema_name => XSD::QName.new(NsMessages, "SendItemResponse"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => FindItemType,
    :schema_name => XSD::QName.new(NsMessages, "FindItem"),
    :schema_element => [
      ["itemShape", ["ItemResponseShapeType", XSD::QName.new(NsMessages, "ItemShape")]],
      [ :choice,
        ["indexedPageItemView", ["IndexedPageViewType", XSD::QName.new(NsMessages, "IndexedPageItemView")]],
        ["fractionalPageItemView", ["FractionalPageViewType", XSD::QName.new(NsMessages, "FractionalPageItemView")]],
        ["calendarView", ["CalendarViewType", XSD::QName.new(NsMessages, "CalendarView")]],
        ["contactsView", ["ContactsViewType", XSD::QName.new(NsMessages, "ContactsView")]]
      ],
      [ :choice,
        ["groupBy", ["GroupByType", XSD::QName.new(NsMessages, "GroupBy")]],
        ["distinguishedGroupBy", ["DistinguishedGroupByType", XSD::QName.new(NsMessages, "DistinguishedGroupBy")]]
      ],
      ["restriction", ["RestrictionType", XSD::QName.new(NsMessages, "Restriction")], [0, 1]],
      ["sortOrder", ["NonEmptyArrayOfFieldOrdersType", XSD::QName.new(NsMessages, "SortOrder")], [0, 1]],
      ["parentFolderIds", ["NonEmptyArrayOfBaseFolderIdsType", XSD::QName.new(NsMessages, "ParentFolderIds")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "Traversal") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => CreateAttachmentType,
    :schema_name => XSD::QName.new(NsMessages, "CreateAttachment"),
    :schema_element => [
      ["parentItemId", ["ItemIdType", XSD::QName.new(NsMessages, "ParentItemId")]],
      ["attachments", ["NonEmptyArrayOfAttachmentsType", XSD::QName.new(NsMessages, "Attachments")]]
    ]
  )

  LiteralRegistry.register(
    :class => CreateAttachmentResponseType,
    :schema_name => XSD::QName.new(NsMessages, "CreateAttachmentResponse"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => DeleteAttachmentType,
    :schema_name => XSD::QName.new(NsMessages, "DeleteAttachment"),
    :schema_element => [
      ["attachmentIds", ["NonEmptyArrayOfRequestAttachmentIdsType", XSD::QName.new(NsMessages, "AttachmentIds")]]
    ]
  )

  LiteralRegistry.register(
    :class => DeleteAttachmentResponseType,
    :schema_name => XSD::QName.new(NsMessages, "DeleteAttachmentResponse"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => GetAttachmentType,
    :schema_name => XSD::QName.new(NsMessages, "GetAttachment"),
    :schema_element => [
      ["attachmentShape", ["AttachmentResponseShapeType", XSD::QName.new(NsMessages, "AttachmentShape")], [0, 1]],
      ["attachmentIds", ["NonEmptyArrayOfRequestAttachmentIdsType", XSD::QName.new(NsMessages, "AttachmentIds")]]
    ]
  )

  LiteralRegistry.register(
    :class => GetAttachmentResponseType,
    :schema_name => XSD::QName.new(NsMessages, "GetAttachmentResponse"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => CreateItemResponseType,
    :schema_name => XSD::QName.new(NsMessages, "CreateItemResponse"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => UpdateItemResponseType,
    :schema_name => XSD::QName.new(NsMessages, "UpdateItemResponse"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => GetItemResponseType,
    :schema_name => XSD::QName.new(NsMessages, "GetItemResponse"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => MoveItemResponseType,
    :schema_name => XSD::QName.new(NsMessages, "MoveItemResponse"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => CopyItemResponseType,
    :schema_name => XSD::QName.new(NsMessages, "CopyItemResponse"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => DeleteItemResponseType,
    :schema_name => XSD::QName.new(NsMessages, "DeleteItemResponse"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => FindItemResponseType,
    :schema_name => XSD::QName.new(NsMessages, "FindItemResponse"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => ResolveNamesType,
    :schema_name => XSD::QName.new(NsMessages, "ResolveNames"),
    :schema_element => [
      ["parentFolderIds", ["NonEmptyArrayOfBaseFolderIdsType", XSD::QName.new(NsMessages, "ParentFolderIds")], [0, 1]],
      ["unresolvedEntry", [nil, XSD::QName.new(NsMessages, "UnresolvedEntry")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ReturnFullContactData") => "SOAP::SOAPBoolean",
      XSD::QName.new(nil, "SearchScope") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => ResolveNamesResponseType,
    :schema_name => XSD::QName.new(NsMessages, "ResolveNamesResponse"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => ExpandDLType,
    :schema_name => XSD::QName.new(NsMessages, "ExpandDL"),
    :schema_element => [
      ["mailbox", ["EmailAddressType", XSD::QName.new(NsMessages, "Mailbox")]]
    ]
  )

  LiteralRegistry.register(
    :class => ExpandDLResponseType,
    :schema_name => XSD::QName.new(NsMessages, "ExpandDLResponse"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => CreateManagedFolderRequestType,
    :schema_name => XSD::QName.new(NsMessages, "CreateManagedFolder"),
    :schema_element => [
      ["folderNames", ["NonEmptyArrayOfFolderNamesType", XSD::QName.new(NsMessages, "FolderNames")]],
      ["mailbox", ["EmailAddressType", XSD::QName.new(NsMessages, "Mailbox")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => CreateManagedFolderResponseType,
    :schema_name => XSD::QName.new(NsMessages, "CreateManagedFolderResponse"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => SubscribeType,
    :schema_name => XSD::QName.new(NsMessages, "Subscribe"),
    :schema_element => [ :choice,
      ["pullSubscriptionRequest", ["PullSubscriptionRequestType", XSD::QName.new(NsMessages, "PullSubscriptionRequest")]],
      ["pushSubscriptionRequest", ["PushSubscriptionRequestType", XSD::QName.new(NsMessages, "PushSubscriptionRequest")]]
    ]
  )

  LiteralRegistry.register(
    :class => SubscribeResponseType,
    :schema_name => XSD::QName.new(NsMessages, "SubscribeResponse"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => UnsubscribeType,
    :schema_name => XSD::QName.new(NsMessages, "Unsubscribe"),
    :schema_element => [
      ["subscriptionId", [nil, XSD::QName.new(NsMessages, "SubscriptionId")]]
    ]
  )

  LiteralRegistry.register(
    :class => UnsubscribeResponseType,
    :schema_name => XSD::QName.new(NsMessages, "UnsubscribeResponse"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => GetEventsType,
    :schema_name => XSD::QName.new(NsMessages, "GetEvents"),
    :schema_element => [
      ["subscriptionId", [nil, XSD::QName.new(NsMessages, "SubscriptionId")]],
      ["watermark", [nil, XSD::QName.new(NsMessages, "Watermark")]]
    ]
  )

  LiteralRegistry.register(
    :class => GetEventsResponseType,
    :schema_name => XSD::QName.new(NsMessages, "GetEventsResponse"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => SendNotificationResponseType,
    :schema_name => XSD::QName.new(NsMessages, "SendNotification"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => SendNotificationResultType,
    :schema_name => XSD::QName.new(NsMessages, "SendNotificationResult"),
    :schema_element => [
      ["subscriptionStatus", ["SubscriptionStatusType", XSD::QName.new(NsMessages, "SubscriptionStatus")]]
    ]
  )

  LiteralRegistry.register(
    :class => SyncFolderHierarchyType,
    :schema_name => XSD::QName.new(NsMessages, "SyncFolderHierarchy"),
    :schema_element => [
      ["folderShape", ["FolderResponseShapeType", XSD::QName.new(NsMessages, "FolderShape")]],
      ["syncFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "SyncFolderId")], [0, 1]],
      ["syncState", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "SyncState")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => SyncFolderHierarchyResponseType,
    :schema_name => XSD::QName.new(NsMessages, "SyncFolderHierarchyResponse"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => SyncFolderItemsType,
    :schema_name => XSD::QName.new(NsMessages, "SyncFolderItems"),
    :schema_element => [
      ["itemShape", ["ItemResponseShapeType", XSD::QName.new(NsMessages, "ItemShape")]],
      ["syncFolderId", ["TargetFolderIdType", XSD::QName.new(NsMessages, "SyncFolderId")]],
      ["syncState", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "SyncState")], [0, 1]],
      ["ignore", ["ArrayOfBaseItemIdsType", XSD::QName.new(NsMessages, "Ignore")], [0, 1]],
      ["maxChangesReturned", [nil, XSD::QName.new(NsMessages, "MaxChangesReturned")]]
    ]
  )

  LiteralRegistry.register(
    :class => SyncFolderItemsResponseType,
    :schema_name => XSD::QName.new(NsMessages, "SyncFolderItemsResponse"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => GetUserAvailabilityRequestType,
    :schema_name => XSD::QName.new(NsMessages, "GetUserAvailabilityRequest"),
    :schema_element => [
      ["timeZone", ["SerializableTimeZone", XSD::QName.new(NsTypes, "TimeZone")]],
      ["mailboxDataArray", ["ArrayOfMailboxData", XSD::QName.new(NsMessages, "MailboxDataArray")]],
      ["freeBusyViewOptions", ["FreeBusyViewOptionsType", XSD::QName.new(NsTypes, "FreeBusyViewOptions")], [0, 1]],
      ["suggestionsViewOptions", ["SuggestionsViewOptionsType", XSD::QName.new(NsTypes, "SuggestionsViewOptions")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => GetUserAvailabilityResponseType,
    :schema_name => XSD::QName.new(NsMessages, "GetUserAvailabilityResponse"),
    :schema_element => [
      ["freeBusyResponseArray", ["ArrayOfFreeBusyResponse", XSD::QName.new(NsMessages, "FreeBusyResponseArray")], [0, 1]],
      ["suggestionsResponse", ["SuggestionsResponseType", XSD::QName.new(NsMessages, "SuggestionsResponse")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => GetUserOofSettingsRequest,
    :schema_name => XSD::QName.new(NsMessages, "GetUserOofSettingsRequest"),
    :schema_element => [
      ["mailbox", ["EmailAddress", XSD::QName.new(NsTypes, "Mailbox")]]
    ]
  )

  LiteralRegistry.register(
    :class => GetUserOofSettingsResponse,
    :schema_name => XSD::QName.new(NsMessages, "GetUserOofSettingsResponse"),
    :schema_element => [
      ["responseMessage", ["ResponseMessageType", XSD::QName.new(NsMessages, "ResponseMessage")]],
      ["oofSettings", ["UserOofSettings", XSD::QName.new(NsTypes, "OofSettings")], [0, 1]],
      ["allowExternalOof", ["ExternalAudience", XSD::QName.new(NsMessages, "AllowExternalOof")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => SetUserOofSettingsRequest,
    :schema_name => XSD::QName.new(NsMessages, "SetUserOofSettingsRequest"),
    :schema_element => [
      ["mailbox", ["EmailAddress", XSD::QName.new(NsTypes, "Mailbox")]],
      ["userOofSettings", ["UserOofSettings", XSD::QName.new(NsTypes, "UserOofSettings")]]
    ]
  )

  LiteralRegistry.register(
    :class => SetUserOofSettingsResponse,
    :schema_name => XSD::QName.new(NsMessages, "SetUserOofSettingsResponse"),
    :schema_element => [
      ["responseMessage", ["ResponseMessageType", XSD::QName.new(NsMessages, "ResponseMessage")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => ConvertIdType,
    :schema_name => XSD::QName.new(NsMessages, "ConvertId"),
    :schema_element => [
      ["sourceIds", ["NonEmptyArrayOfAlternateIdsType", XSD::QName.new(NsMessages, "SourceIds")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "DestinationFormat") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => ConvertIdResponseType,
    :schema_name => XSD::QName.new(NsMessages, "ConvertIdResponse"),
    :schema_element => [
      ["responseMessages", ["ArrayOfResponseMessagesType", XSD::QName.new(NsMessages, "ResponseMessages")]]
    ]
  )

  LiteralRegistry.register(
    :class => GetDelegateType,
    :schema_name => XSD::QName.new(NsMessages, "GetDelegate"),
    :schema_element => [
      ["mailbox", ["EmailAddressType", XSD::QName.new(NsMessages, "Mailbox")]],
      ["userIds", ["ArrayOfUserIdType", XSD::QName.new(NsMessages, "UserIds")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "IncludePermissions") => "SOAP::SOAPBoolean"
    }
  )

  LiteralRegistry.register(
    :class => GetDelegateResponseMessageType,
    :schema_name => XSD::QName.new(NsMessages, "GetDelegateResponse"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["GetDelegateResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["responseMessages", ["ArrayOfDelegateUserResponseMessageType", XSD::QName.new(NsMessages, "ResponseMessages")], [0, 1]],
      ["deliverMeetingRequests", ["DeliverMeetingRequestsType", XSD::QName.new(NsMessages, "DeliverMeetingRequests")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => GetDelegateResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  LiteralRegistry.register(
    :class => AddDelegateType,
    :schema_name => XSD::QName.new(NsMessages, "AddDelegate"),
    :schema_element => [
      ["mailbox", ["EmailAddressType", XSD::QName.new(NsMessages, "Mailbox")]],
      ["delegateUsers", ["ArrayOfDelegateUserType", XSD::QName.new(NsMessages, "DelegateUsers")]],
      ["deliverMeetingRequests", ["DeliverMeetingRequestsType", XSD::QName.new(NsMessages, "DeliverMeetingRequests")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => AddDelegateResponseMessageType,
    :schema_name => XSD::QName.new(NsMessages, "AddDelegateResponse"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["AddDelegateResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["responseMessages", ["ArrayOfDelegateUserResponseMessageType", XSD::QName.new(NsMessages, "ResponseMessages")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => AddDelegateResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  LiteralRegistry.register(
    :class => RemoveDelegateType,
    :schema_name => XSD::QName.new(NsMessages, "RemoveDelegate"),
    :schema_element => [
      ["mailbox", ["EmailAddressType", XSD::QName.new(NsMessages, "Mailbox")]],
      ["userIds", ["ArrayOfUserIdType", XSD::QName.new(NsMessages, "UserIds")]]
    ]
  )

  LiteralRegistry.register(
    :class => RemoveDelegateResponseMessageType,
    :schema_name => XSD::QName.new(NsMessages, "RemoveDelegateResponse"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["RemoveDelegateResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["responseMessages", ["ArrayOfDelegateUserResponseMessageType", XSD::QName.new(NsMessages, "ResponseMessages")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => RemoveDelegateResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  LiteralRegistry.register(
    :class => UpdateDelegateType,
    :schema_name => XSD::QName.new(NsMessages, "UpdateDelegate"),
    :schema_element => [
      ["mailbox", ["EmailAddressType", XSD::QName.new(NsMessages, "Mailbox")]],
      ["delegateUsers", ["ArrayOfDelegateUserType", XSD::QName.new(NsMessages, "DelegateUsers")], [0, 1]],
      ["deliverMeetingRequests", ["DeliverMeetingRequestsType", XSD::QName.new(NsMessages, "DeliverMeetingRequests")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => UpdateDelegateResponseMessageType,
    :schema_name => XSD::QName.new(NsMessages, "UpdateDelegateResponse"),
    :schema_element => [
      ["messageText", ["SOAP::SOAPString", XSD::QName.new(NsMessages, "MessageText")], [0, 1]],
      ["responseCode", ["ResponseCodeType", XSD::QName.new(NsMessages, "ResponseCode")], [0, 1]],
      ["descriptiveLinkKey", ["SOAP::SOAPInt", XSD::QName.new(NsMessages, "DescriptiveLinkKey")], [0, 1]],
      ["messageXml", ["UpdateDelegateResponseMessageType::MessageXml", XSD::QName.new(NsMessages, "MessageXml")], [0, 1]],
      ["responseMessages", ["ArrayOfDelegateUserResponseMessageType", XSD::QName.new(NsMessages, "ResponseMessages")], [0, 1]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ResponseClass") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => UpdateDelegateResponseMessageType::MessageXml,
    :schema_name => XSD::QName.new(NsMessages, "MessageXml"),
    :is_anonymous => true,
    :schema_qualified => true,
    :schema_element => [
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  LiteralRegistry.register(
    :class => SerializedSecurityContextType,
    :schema_name => XSD::QName.new(NsTypes, "SerializedSecurityContext"),
    :schema_element => [
      ["userSid", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "UserSid")]],
      ["groupSids", ["NonEmptyArrayOfGroupIdentifiersType", XSD::QName.new(NsTypes, "GroupSids")], [0, 1]],
      ["restrictedGroupSids", ["NonEmptyArrayOfRestrictedGroupIdentifiersType", XSD::QName.new(NsTypes, "RestrictedGroupSids")], [0, 1]],
      ["primarySmtpAddress", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "PrimarySmtpAddress")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => ExchangeImpersonationType,
    :schema_name => XSD::QName.new(NsTypes, "ExchangeImpersonation"),
    :schema_element => [
      ["connectingSID", ["ConnectingSIDType", XSD::QName.new(NsTypes, "ConnectingSID")]]
    ]
  )

  LiteralRegistry.register(
    :class => ProxySecurityContextType,
    :schema_name => XSD::QName.new(NsTypes, "ProxySecurityContext")
  )

  LiteralRegistry.register(
    :class => ProxySecurityContextType,
    :schema_name => XSD::QName.new(NsTypes, "ProxySuggesterSid")
  )

  LiteralRegistry.register(
    :class => ServerVersionInfo,
    :schema_name => XSD::QName.new(NsTypes, "ServerVersionInfo"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "MajorVersion") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "MinorVersion") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "MajorBuildNumber") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "MinorBuildNumber") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "Version") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => RequestServerVersion,
    :schema_name => XSD::QName.new(NsTypes, "RequestServerVersion"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "Version") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => BasePathToElementType,
    :schema_name => XSD::QName.new(NsTypes, "Path"),
    :schema_element => []
  )

  LiteralRegistry.register(
    :class => PathToUnindexedFieldType,
    :schema_name => XSD::QName.new(NsTypes, "FieldURI"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "FieldURI") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => PathToIndexedFieldType,
    :schema_name => XSD::QName.new(NsTypes, "IndexedFieldURI"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "FieldURI") => "SOAP::SOAPString",
      XSD::QName.new(nil, "FieldIndex") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => PathToExtendedFieldType,
    :schema_name => XSD::QName.new(NsTypes, "ExtendedFieldURI"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "DistinguishedPropertySetId") => "SOAP::SOAPString",
      XSD::QName.new(nil, "PropertySetId") => "SOAP::SOAPString",
      XSD::QName.new(nil, "PropertyTag") => nil,
      XSD::QName.new(nil, "PropertyName") => "SOAP::SOAPString",
      XSD::QName.new(nil, "PropertyId") => "SOAP::SOAPInt",
      XSD::QName.new(nil, "PropertyType") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => PathToExceptionFieldType,
    :schema_name => XSD::QName.new(NsTypes, "ExceptionFieldURI"),
    :schema_element => [],
    :schema_attribute => {
      XSD::QName.new(nil, "FieldURI") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => BaseItemIdType,
    :schema_name => XSD::QName.new(NsTypes, "BaseItemId"),
    :schema_element => []
  )

  LiteralRegistry.register(
    :class => SearchExpressionType,
    :schema_name => XSD::QName.new(NsTypes, "SearchExpression"),
    :schema_element => []
  )

  LiteralRegistry.register(
    :class => ExistsType,
    :schema_name => XSD::QName.new(NsTypes, "Exists"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "FieldURI")]]
    ]
  )

  LiteralRegistry.register(
    :class => ExcludesType,
    :schema_name => XSD::QName.new(NsTypes, "Excludes"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["bitmask", ["ExcludesValueType", XSD::QName.new(NsTypes, "Bitmask")]]
    ]
  )

  LiteralRegistry.register(
    :class => IsEqualToType,
    :schema_name => XSD::QName.new(NsTypes, "IsEqualTo"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["fieldURIOrConstant", ["FieldURIOrConstantType", XSD::QName.new(NsTypes, "FieldURIOrConstant")]]
    ]
  )

  LiteralRegistry.register(
    :class => IsNotEqualToType,
    :schema_name => XSD::QName.new(NsTypes, "IsNotEqualTo"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["fieldURIOrConstant", ["FieldURIOrConstantType", XSD::QName.new(NsTypes, "FieldURIOrConstant")]]
    ]
  )

  LiteralRegistry.register(
    :class => IsGreaterThanType,
    :schema_name => XSD::QName.new(NsTypes, "IsGreaterThan"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["fieldURIOrConstant", ["FieldURIOrConstantType", XSD::QName.new(NsTypes, "FieldURIOrConstant")]]
    ]
  )

  LiteralRegistry.register(
    :class => IsGreaterThanOrEqualToType,
    :schema_name => XSD::QName.new(NsTypes, "IsGreaterThanOrEqualTo"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["fieldURIOrConstant", ["FieldURIOrConstantType", XSD::QName.new(NsTypes, "FieldURIOrConstant")]]
    ]
  )

  LiteralRegistry.register(
    :class => IsLessThanType,
    :schema_name => XSD::QName.new(NsTypes, "IsLessThan"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["fieldURIOrConstant", ["FieldURIOrConstantType", XSD::QName.new(NsTypes, "FieldURIOrConstant")]]
    ]
  )

  LiteralRegistry.register(
    :class => IsLessThanOrEqualToType,
    :schema_name => XSD::QName.new(NsTypes, "IsLessThanOrEqualTo"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["fieldURIOrConstant", ["FieldURIOrConstantType", XSD::QName.new(NsTypes, "FieldURIOrConstant")]]
    ]
  )

  LiteralRegistry.register(
    :class => ContainsExpressionType,
    :schema_name => XSD::QName.new(NsTypes, "Contains"),
    :schema_element => [
      ["path", ["BasePathToElementType", XSD::QName.new(NsTypes, "Path")]],
      ["constant", ["ConstantValueType", XSD::QName.new(NsTypes, "Constant")]]
    ],
    :schema_attribute => {
      XSD::QName.new(nil, "ContainmentMode") => "SOAP::SOAPString",
      XSD::QName.new(nil, "ContainmentComparison") => "SOAP::SOAPString"
    }
  )

  LiteralRegistry.register(
    :class => NotType,
    :schema_name => XSD::QName.new(NsTypes, "Not"),
    :schema_element => [
      ["searchExpression", ["SearchExpressionType", XSD::QName.new(NsTypes, "SearchExpression")]]
    ]
  )

  LiteralRegistry.register(
    :class => AndType,
    :schema_name => XSD::QName.new(NsTypes, "And"),
    :schema_element => [
      ["searchExpression", ["SearchExpressionType[]", XSD::QName.new(NsTypes, "SearchExpression")], [2, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => OrType,
    :schema_name => XSD::QName.new(NsTypes, "Or"),
    :schema_element => [
      ["searchExpression", ["SearchExpressionType[]", XSD::QName.new(NsTypes, "SearchExpression")], [2, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => AvailabilityProxyRequestType,
    :schema_name => XSD::QName.new(NsTypes, "ProxyRequestTypeHeader")
  )

  LiteralRegistry.register(
    :class => EmailAddress,
    :schema_name => XSD::QName.new(NsTypes, "Mailbox"),
    :schema_element => [
      ["name", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Name")], [0, 1]],
      ["address", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "Address")]],
      ["routingType", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "RoutingType")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => FreeBusyViewOptionsType,
    :schema_name => XSD::QName.new(NsTypes, "FreeBusyViewOptions"),
    :schema_element => [
      ["timeWindow", ["Duration", XSD::QName.new(NsTypes, "TimeWindow")]],
      ["mergedFreeBusyIntervalInMinutes", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "MergedFreeBusyIntervalInMinutes")], [0, 1]],
      ["requestedView", [nil, XSD::QName.new(NsTypes, "RequestedView")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => SerializableTimeZone,
    :schema_name => XSD::QName.new(NsTypes, "TimeZone"),
    :schema_element => [
      ["bias", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "Bias")]],
      ["standardTime", ["SerializableTimeZoneTime", XSD::QName.new(NsTypes, "StandardTime")]],
      ["daylightTime", ["SerializableTimeZoneTime", XSD::QName.new(NsTypes, "DaylightTime")]]
    ]
  )

  LiteralRegistry.register(
    :class => SuggestionsViewOptionsType,
    :schema_name => XSD::QName.new(NsTypes, "SuggestionsViewOptions"),
    :schema_element => [
      ["goodThreshold", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "GoodThreshold")], [0, 1]],
      ["maximumResultsByDay", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "MaximumResultsByDay")], [0, 1]],
      ["maximumNonWorkHourResultsByDay", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "MaximumNonWorkHourResultsByDay")], [0, 1]],
      ["meetingDurationInMinutes", ["SOAP::SOAPInt", XSD::QName.new(NsTypes, "MeetingDurationInMinutes")], [0, 1]],
      ["minimumSuggestionQuality", ["SuggestionQuality", XSD::QName.new(NsTypes, "MinimumSuggestionQuality")], [0, 1]],
      ["detailedSuggestionsWindow", ["Duration", XSD::QName.new(NsTypes, "DetailedSuggestionsWindow")]],
      ["currentMeetingTime", ["SOAP::SOAPDateTime", XSD::QName.new(NsTypes, "CurrentMeetingTime")], [0, 1]],
      ["globalObjectId", ["SOAP::SOAPString", XSD::QName.new(NsTypes, "GlobalObjectId")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => UserOofSettings,
    :schema_name => XSD::QName.new(NsTypes, "OofSettings"),
    :schema_element => [
      ["oofState", ["OofState", XSD::QName.new(NsTypes, "OofState")]],
      ["externalAudience", ["ExternalAudience", XSD::QName.new(NsTypes, "ExternalAudience")]],
      ["duration", ["Duration", XSD::QName.new(NsTypes, "Duration")], [0, 1]],
      ["internalReply", ["ReplyBody", XSD::QName.new(NsTypes, "InternalReply")], [0, 1]],
      ["externalReply", ["ReplyBody", XSD::QName.new(NsTypes, "ExternalReply")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => UserOofSettings,
    :schema_name => XSD::QName.new(NsTypes, "UserOofSettings"),
    :schema_element => [
      ["oofState", ["OofState", XSD::QName.new(NsTypes, "OofState")]],
      ["externalAudience", ["ExternalAudience", XSD::QName.new(NsTypes, "ExternalAudience")]],
      ["duration", ["Duration", XSD::QName.new(NsTypes, "Duration")], [0, 1]],
      ["internalReply", ["ReplyBody", XSD::QName.new(NsTypes, "InternalReply")], [0, 1]],
      ["externalReply", ["ReplyBody", XSD::QName.new(NsTypes, "ExternalReply")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => Value,
    :schema_name => XSD::QName.new(NsTypes, "Value"),
    :schema_attribute => {
      XSD::QName.new(nil, "Name") => "SOAP::SOAPString"
    }
  )
end
