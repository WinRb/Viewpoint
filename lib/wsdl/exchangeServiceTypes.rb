require 'rubygems'
gem 'soap4r'
require 'xsd/qname'

# {http://schemas.microsoft.com/exchange/services/2006/messages}ResponseMessageType
#   messageText - SOAP::SOAPString
#   responseCode - ResponseCodeType
#   descriptiveLinkKey - SOAP::SOAPInt
#   messageXml - ResponseMessageType::MessageXml
#   xmlattr_ResponseClass - SOAP::SOAPString
class ResponseMessageType
  AttrResponseClass = XSD::QName.new(nil, "ResponseClass")

  # inner class for member: MessageXml
  # {http://schemas.microsoft.com/exchange/services/2006/messages}MessageXml
  class MessageXml
    attr_reader :__xmlele_any

    def set_any(elements)
      @__xmlele_any = elements
    end

    def initialize
      @__xmlele_any = nil
    end
  end

  attr_accessor :messageText
  attr_accessor :responseCode
  attr_accessor :descriptiveLinkKey
  attr_accessor :messageXml

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ResponseClass
    __xmlattr[AttrResponseClass]
  end

  def xmlattr_ResponseClass=(value)
    __xmlattr[AttrResponseClass] = value
  end

  def initialize(messageText = nil, responseCode = nil, descriptiveLinkKey = nil, messageXml = nil)
    @messageText = messageText
    @responseCode = responseCode
    @descriptiveLinkKey = descriptiveLinkKey
    @messageXml = messageXml
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}FolderInfoResponseMessageType
#   messageText - SOAP::SOAPString
#   responseCode - ResponseCodeType
#   descriptiveLinkKey - SOAP::SOAPInt
#   messageXml - FolderInfoResponseMessageType::MessageXml
#   folders - ArrayOfFoldersType
#   xmlattr_ResponseClass - SOAP::SOAPString
class FolderInfoResponseMessageType < ResponseMessageType
  AttrResponseClass = XSD::QName.new(nil, "ResponseClass")

  # inner class for member: MessageXml
  # {http://schemas.microsoft.com/exchange/services/2006/messages}MessageXml
  class MessageXml
    attr_reader :__xmlele_any

    def set_any(elements)
      @__xmlele_any = elements
    end

    def initialize
      @__xmlele_any = nil
    end
  end

  attr_accessor :messageText
  attr_accessor :responseCode
  attr_accessor :descriptiveLinkKey
  attr_accessor :messageXml
  attr_accessor :folders

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ResponseClass
    __xmlattr[AttrResponseClass]
  end

  def xmlattr_ResponseClass=(value)
    __xmlattr[AttrResponseClass] = value
  end

  def initialize(messageText = nil, responseCode = nil, descriptiveLinkKey = nil, messageXml = nil, folders = nil)
    @messageText = messageText
    @responseCode = responseCode
    @descriptiveLinkKey = descriptiveLinkKey
    @messageXml = messageXml
    @folders = folders
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}FindFolderResponseMessageType
#   messageText - SOAP::SOAPString
#   responseCode - ResponseCodeType
#   descriptiveLinkKey - SOAP::SOAPInt
#   messageXml - FindFolderResponseMessageType::MessageXml
#   rootFolder - FindFolderParentType
#   xmlattr_ResponseClass - SOAP::SOAPString
class FindFolderResponseMessageType < ResponseMessageType
  AttrResponseClass = XSD::QName.new(nil, "ResponseClass")

  # inner class for member: MessageXml
  # {http://schemas.microsoft.com/exchange/services/2006/messages}MessageXml
  class MessageXml
    attr_reader :__xmlele_any

    def set_any(elements)
      @__xmlele_any = elements
    end

    def initialize
      @__xmlele_any = nil
    end
  end

  attr_accessor :messageText
  attr_accessor :responseCode
  attr_accessor :descriptiveLinkKey
  attr_accessor :messageXml
  attr_accessor :rootFolder

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ResponseClass
    __xmlattr[AttrResponseClass]
  end

  def xmlattr_ResponseClass=(value)
    __xmlattr[AttrResponseClass] = value
  end

  def initialize(messageText = nil, responseCode = nil, descriptiveLinkKey = nil, messageXml = nil, rootFolder = nil)
    @messageText = messageText
    @responseCode = responseCode
    @descriptiveLinkKey = descriptiveLinkKey
    @messageXml = messageXml
    @rootFolder = rootFolder
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}ItemInfoResponseMessageType
#   messageText - SOAP::SOAPString
#   responseCode - ResponseCodeType
#   descriptiveLinkKey - SOAP::SOAPInt
#   messageXml - ItemInfoResponseMessageType::MessageXml
#   items - ArrayOfRealItemsType
#   xmlattr_ResponseClass - SOAP::SOAPString
class ItemInfoResponseMessageType < ResponseMessageType
  AttrResponseClass = XSD::QName.new(nil, "ResponseClass")

  # inner class for member: MessageXml
  # {http://schemas.microsoft.com/exchange/services/2006/messages}MessageXml
  class MessageXml
    attr_reader :__xmlele_any

    def set_any(elements)
      @__xmlele_any = elements
    end

    def initialize
      @__xmlele_any = nil
    end
  end

  attr_accessor :messageText
  attr_accessor :responseCode
  attr_accessor :descriptiveLinkKey
  attr_accessor :messageXml
  attr_accessor :items

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ResponseClass
    __xmlattr[AttrResponseClass]
  end

  def xmlattr_ResponseClass=(value)
    __xmlattr[AttrResponseClass] = value
  end

  def initialize(messageText = nil, responseCode = nil, descriptiveLinkKey = nil, messageXml = nil, items = nil)
    @messageText = messageText
    @responseCode = responseCode
    @descriptiveLinkKey = descriptiveLinkKey
    @messageXml = messageXml
    @items = items
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}UpdateItemResponseMessageType
#   messageText - SOAP::SOAPString
#   responseCode - ResponseCodeType
#   descriptiveLinkKey - SOAP::SOAPInt
#   messageXml - UpdateItemResponseMessageType::MessageXml
#   items - ArrayOfRealItemsType
#   conflictResults - ConflictResultsType
#   xmlattr_ResponseClass - SOAP::SOAPString
class UpdateItemResponseMessageType < ItemInfoResponseMessageType
  AttrResponseClass = XSD::QName.new(nil, "ResponseClass")

  # inner class for member: MessageXml
  # {http://schemas.microsoft.com/exchange/services/2006/messages}MessageXml
  class MessageXml
    attr_reader :__xmlele_any

    def set_any(elements)
      @__xmlele_any = elements
    end

    def initialize
      @__xmlele_any = nil
    end
  end

  attr_accessor :messageText
  attr_accessor :responseCode
  attr_accessor :descriptiveLinkKey
  attr_accessor :messageXml
  attr_accessor :items
  attr_accessor :conflictResults

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ResponseClass
    __xmlattr[AttrResponseClass]
  end

  def xmlattr_ResponseClass=(value)
    __xmlattr[AttrResponseClass] = value
  end

  def initialize(messageText = nil, responseCode = nil, descriptiveLinkKey = nil, messageXml = nil, items = nil, conflictResults = nil)
    @messageText = messageText
    @responseCode = responseCode
    @descriptiveLinkKey = descriptiveLinkKey
    @messageXml = messageXml
    @items = items
    @conflictResults = conflictResults
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}AttachmentInfoResponseMessageType
#   messageText - SOAP::SOAPString
#   responseCode - ResponseCodeType
#   descriptiveLinkKey - SOAP::SOAPInt
#   messageXml - AttachmentInfoResponseMessageType::MessageXml
#   attachments - ArrayOfAttachmentsType
#   xmlattr_ResponseClass - SOAP::SOAPString
class AttachmentInfoResponseMessageType < ResponseMessageType
  AttrResponseClass = XSD::QName.new(nil, "ResponseClass")

  # inner class for member: MessageXml
  # {http://schemas.microsoft.com/exchange/services/2006/messages}MessageXml
  class MessageXml
    attr_reader :__xmlele_any

    def set_any(elements)
      @__xmlele_any = elements
    end

    def initialize
      @__xmlele_any = nil
    end
  end

  attr_accessor :messageText
  attr_accessor :responseCode
  attr_accessor :descriptiveLinkKey
  attr_accessor :messageXml
  attr_accessor :attachments

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ResponseClass
    __xmlattr[AttrResponseClass]
  end

  def xmlattr_ResponseClass=(value)
    __xmlattr[AttrResponseClass] = value
  end

  def initialize(messageText = nil, responseCode = nil, descriptiveLinkKey = nil, messageXml = nil, attachments = nil)
    @messageText = messageText
    @responseCode = responseCode
    @descriptiveLinkKey = descriptiveLinkKey
    @messageXml = messageXml
    @attachments = attachments
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}DeleteAttachmentResponseMessageType
#   messageText - SOAP::SOAPString
#   responseCode - ResponseCodeType
#   descriptiveLinkKey - SOAP::SOAPInt
#   messageXml - DeleteAttachmentResponseMessageType::MessageXml
#   rootItemId - RootItemIdType
#   xmlattr_ResponseClass - SOAP::SOAPString
class DeleteAttachmentResponseMessageType < ResponseMessageType
  AttrResponseClass = XSD::QName.new(nil, "ResponseClass")

  # inner class for member: MessageXml
  # {http://schemas.microsoft.com/exchange/services/2006/messages}MessageXml
  class MessageXml
    attr_reader :__xmlele_any

    def set_any(elements)
      @__xmlele_any = elements
    end

    def initialize
      @__xmlele_any = nil
    end
  end

  attr_accessor :messageText
  attr_accessor :responseCode
  attr_accessor :descriptiveLinkKey
  attr_accessor :messageXml
  attr_accessor :rootItemId

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ResponseClass
    __xmlattr[AttrResponseClass]
  end

  def xmlattr_ResponseClass=(value)
    __xmlattr[AttrResponseClass] = value
  end

  def initialize(messageText = nil, responseCode = nil, descriptiveLinkKey = nil, messageXml = nil, rootItemId = nil)
    @messageText = messageText
    @responseCode = responseCode
    @descriptiveLinkKey = descriptiveLinkKey
    @messageXml = messageXml
    @rootItemId = rootItemId
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}FindItemResponseMessageType
#   messageText - SOAP::SOAPString
#   responseCode - ResponseCodeType
#   descriptiveLinkKey - SOAP::SOAPInt
#   messageXml - FindItemResponseMessageType::MessageXml
#   rootFolder - FindItemParentType
#   xmlattr_ResponseClass - SOAP::SOAPString
class FindItemResponseMessageType < ResponseMessageType
  AttrResponseClass = XSD::QName.new(nil, "ResponseClass")

  # inner class for member: MessageXml
  # {http://schemas.microsoft.com/exchange/services/2006/messages}MessageXml
  class MessageXml
    attr_reader :__xmlele_any

    def set_any(elements)
      @__xmlele_any = elements
    end

    def initialize
      @__xmlele_any = nil
    end
  end

  attr_accessor :messageText
  attr_accessor :responseCode
  attr_accessor :descriptiveLinkKey
  attr_accessor :messageXml
  attr_accessor :rootFolder

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ResponseClass
    __xmlattr[AttrResponseClass]
  end

  def xmlattr_ResponseClass=(value)
    __xmlattr[AttrResponseClass] = value
  end

  def initialize(messageText = nil, responseCode = nil, descriptiveLinkKey = nil, messageXml = nil, rootFolder = nil)
    @messageText = messageText
    @responseCode = responseCode
    @descriptiveLinkKey = descriptiveLinkKey
    @messageXml = messageXml
    @rootFolder = rootFolder
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}ResolveNamesResponseMessageType
#   messageText - SOAP::SOAPString
#   responseCode - ResponseCodeType
#   descriptiveLinkKey - SOAP::SOAPInt
#   messageXml - ResolveNamesResponseMessageType::MessageXml
#   resolutionSet - ArrayOfResolutionType
#   xmlattr_ResponseClass - SOAP::SOAPString
class ResolveNamesResponseMessageType < ResponseMessageType
  AttrResponseClass = XSD::QName.new(nil, "ResponseClass")

  # inner class for member: MessageXml
  # {http://schemas.microsoft.com/exchange/services/2006/messages}MessageXml
  class MessageXml
    attr_reader :__xmlele_any

    def set_any(elements)
      @__xmlele_any = elements
    end

    def initialize
      @__xmlele_any = nil
    end
  end

  attr_accessor :messageText
  attr_accessor :responseCode
  attr_accessor :descriptiveLinkKey
  attr_accessor :messageXml
  attr_accessor :resolutionSet

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ResponseClass
    __xmlattr[AttrResponseClass]
  end

  def xmlattr_ResponseClass=(value)
    __xmlattr[AttrResponseClass] = value
  end

  def initialize(messageText = nil, responseCode = nil, descriptiveLinkKey = nil, messageXml = nil, resolutionSet = nil)
    @messageText = messageText
    @responseCode = responseCode
    @descriptiveLinkKey = descriptiveLinkKey
    @messageXml = messageXml
    @resolutionSet = resolutionSet
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}ExpandDLResponseMessageType
#   messageText - SOAP::SOAPString
#   responseCode - ResponseCodeType
#   descriptiveLinkKey - SOAP::SOAPInt
#   messageXml - ExpandDLResponseMessageType::MessageXml
#   dLExpansion - ArrayOfDLExpansionType
#   xmlattr_ResponseClass - SOAP::SOAPString
#   xmlattr_IndexedPagingOffset - SOAP::SOAPInt
#   xmlattr_NumeratorOffset - SOAP::SOAPInt
#   xmlattr_AbsoluteDenominator - SOAP::SOAPInt
#   xmlattr_IncludesLastItemInRange - SOAP::SOAPBoolean
#   xmlattr_TotalItemsInView - SOAP::SOAPInt
class ExpandDLResponseMessageType < ResponseMessageType
  AttrAbsoluteDenominator = XSD::QName.new(nil, "AbsoluteDenominator")
  AttrIncludesLastItemInRange = XSD::QName.new(nil, "IncludesLastItemInRange")
  AttrIndexedPagingOffset = XSD::QName.new(nil, "IndexedPagingOffset")
  AttrNumeratorOffset = XSD::QName.new(nil, "NumeratorOffset")
  AttrResponseClass = XSD::QName.new(nil, "ResponseClass")
  AttrTotalItemsInView = XSD::QName.new(nil, "TotalItemsInView")

  # inner class for member: MessageXml
  # {http://schemas.microsoft.com/exchange/services/2006/messages}MessageXml
  class MessageXml
    attr_reader :__xmlele_any

    def set_any(elements)
      @__xmlele_any = elements
    end

    def initialize
      @__xmlele_any = nil
    end
  end

  attr_accessor :messageText
  attr_accessor :responseCode
  attr_accessor :descriptiveLinkKey
  attr_accessor :messageXml
  attr_accessor :dLExpansion

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ResponseClass
    __xmlattr[AttrResponseClass]
  end

  def xmlattr_ResponseClass=(value)
    __xmlattr[AttrResponseClass] = value
  end

  def xmlattr_IndexedPagingOffset
    __xmlattr[AttrIndexedPagingOffset]
  end

  def xmlattr_IndexedPagingOffset=(value)
    __xmlattr[AttrIndexedPagingOffset] = value
  end

  def xmlattr_NumeratorOffset
    __xmlattr[AttrNumeratorOffset]
  end

  def xmlattr_NumeratorOffset=(value)
    __xmlattr[AttrNumeratorOffset] = value
  end

  def xmlattr_AbsoluteDenominator
    __xmlattr[AttrAbsoluteDenominator]
  end

  def xmlattr_AbsoluteDenominator=(value)
    __xmlattr[AttrAbsoluteDenominator] = value
  end

  def xmlattr_IncludesLastItemInRange
    __xmlattr[AttrIncludesLastItemInRange]
  end

  def xmlattr_IncludesLastItemInRange=(value)
    __xmlattr[AttrIncludesLastItemInRange] = value
  end

  def xmlattr_TotalItemsInView
    __xmlattr[AttrTotalItemsInView]
  end

  def xmlattr_TotalItemsInView=(value)
    __xmlattr[AttrTotalItemsInView] = value
  end

  def initialize(messageText = nil, responseCode = nil, descriptiveLinkKey = nil, messageXml = nil, dLExpansion = nil)
    @messageText = messageText
    @responseCode = responseCode
    @descriptiveLinkKey = descriptiveLinkKey
    @messageXml = messageXml
    @dLExpansion = dLExpansion
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}SubscribeResponseMessageType
#   messageText - SOAP::SOAPString
#   responseCode - ResponseCodeType
#   descriptiveLinkKey - SOAP::SOAPInt
#   messageXml - SubscribeResponseMessageType::MessageXml
#   subscriptionId - (any)
#   watermark - (any)
#   xmlattr_ResponseClass - SOAP::SOAPString
class SubscribeResponseMessageType < ResponseMessageType
  AttrResponseClass = XSD::QName.new(nil, "ResponseClass")

  # inner class for member: MessageXml
  # {http://schemas.microsoft.com/exchange/services/2006/messages}MessageXml
  class MessageXml
    attr_reader :__xmlele_any

    def set_any(elements)
      @__xmlele_any = elements
    end

    def initialize
      @__xmlele_any = nil
    end
  end

  attr_accessor :messageText
  attr_accessor :responseCode
  attr_accessor :descriptiveLinkKey
  attr_accessor :messageXml
  attr_accessor :subscriptionId
  attr_accessor :watermark

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ResponseClass
    __xmlattr[AttrResponseClass]
  end

  def xmlattr_ResponseClass=(value)
    __xmlattr[AttrResponseClass] = value
  end

  def initialize(messageText = nil, responseCode = nil, descriptiveLinkKey = nil, messageXml = nil, subscriptionId = nil, watermark = nil)
    @messageText = messageText
    @responseCode = responseCode
    @descriptiveLinkKey = descriptiveLinkKey
    @messageXml = messageXml
    @subscriptionId = subscriptionId
    @watermark = watermark
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}GetEventsResponseMessageType
#   messageText - SOAP::SOAPString
#   responseCode - ResponseCodeType
#   descriptiveLinkKey - SOAP::SOAPInt
#   messageXml - GetEventsResponseMessageType::MessageXml
#   notification - NotificationType
#   xmlattr_ResponseClass - SOAP::SOAPString
class GetEventsResponseMessageType < ResponseMessageType
  AttrResponseClass = XSD::QName.new(nil, "ResponseClass")

  # inner class for member: MessageXml
  # {http://schemas.microsoft.com/exchange/services/2006/messages}MessageXml
  class MessageXml
    attr_reader :__xmlele_any

    def set_any(elements)
      @__xmlele_any = elements
    end

    def initialize
      @__xmlele_any = nil
    end
  end

  attr_accessor :messageText
  attr_accessor :responseCode
  attr_accessor :descriptiveLinkKey
  attr_accessor :messageXml
  attr_accessor :notification

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ResponseClass
    __xmlattr[AttrResponseClass]
  end

  def xmlattr_ResponseClass=(value)
    __xmlattr[AttrResponseClass] = value
  end

  def initialize(messageText = nil, responseCode = nil, descriptiveLinkKey = nil, messageXml = nil, notification = nil)
    @messageText = messageText
    @responseCode = responseCode
    @descriptiveLinkKey = descriptiveLinkKey
    @messageXml = messageXml
    @notification = notification
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}SendNotificationResponseMessageType
#   messageText - SOAP::SOAPString
#   responseCode - ResponseCodeType
#   descriptiveLinkKey - SOAP::SOAPInt
#   messageXml - SendNotificationResponseMessageType::MessageXml
#   notification - NotificationType
#   xmlattr_ResponseClass - SOAP::SOAPString
class SendNotificationResponseMessageType < ResponseMessageType
  AttrResponseClass = XSD::QName.new(nil, "ResponseClass")

  # inner class for member: MessageXml
  # {http://schemas.microsoft.com/exchange/services/2006/messages}MessageXml
  class MessageXml
    attr_reader :__xmlele_any

    def set_any(elements)
      @__xmlele_any = elements
    end

    def initialize
      @__xmlele_any = nil
    end
  end

  attr_accessor :messageText
  attr_accessor :responseCode
  attr_accessor :descriptiveLinkKey
  attr_accessor :messageXml
  attr_accessor :notification

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ResponseClass
    __xmlattr[AttrResponseClass]
  end

  def xmlattr_ResponseClass=(value)
    __xmlattr[AttrResponseClass] = value
  end

  def initialize(messageText = nil, responseCode = nil, descriptiveLinkKey = nil, messageXml = nil, notification = nil)
    @messageText = messageText
    @responseCode = responseCode
    @descriptiveLinkKey = descriptiveLinkKey
    @messageXml = messageXml
    @notification = notification
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}SyncFolderHierarchyResponseMessageType
#   messageText - SOAP::SOAPString
#   responseCode - ResponseCodeType
#   descriptiveLinkKey - SOAP::SOAPInt
#   messageXml - SyncFolderHierarchyResponseMessageType::MessageXml
#   syncState - SOAP::SOAPString
#   includesLastFolderInRange - SOAP::SOAPBoolean
#   changes - SyncFolderHierarchyChangesType
#   xmlattr_ResponseClass - SOAP::SOAPString
class SyncFolderHierarchyResponseMessageType < ResponseMessageType
  AttrResponseClass = XSD::QName.new(nil, "ResponseClass")

  # inner class for member: MessageXml
  # {http://schemas.microsoft.com/exchange/services/2006/messages}MessageXml
  class MessageXml
    attr_reader :__xmlele_any

    def set_any(elements)
      @__xmlele_any = elements
    end

    def initialize
      @__xmlele_any = nil
    end
  end

  attr_accessor :messageText
  attr_accessor :responseCode
  attr_accessor :descriptiveLinkKey
  attr_accessor :messageXml
  attr_accessor :syncState
  attr_accessor :includesLastFolderInRange
  attr_accessor :changes

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ResponseClass
    __xmlattr[AttrResponseClass]
  end

  def xmlattr_ResponseClass=(value)
    __xmlattr[AttrResponseClass] = value
  end

  def initialize(messageText = nil, responseCode = nil, descriptiveLinkKey = nil, messageXml = nil, syncState = nil, includesLastFolderInRange = nil, changes = nil)
    @messageText = messageText
    @responseCode = responseCode
    @descriptiveLinkKey = descriptiveLinkKey
    @messageXml = messageXml
    @syncState = syncState
    @includesLastFolderInRange = includesLastFolderInRange
    @changes = changes
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}SyncFolderItemsResponseMessageType
#   messageText - SOAP::SOAPString
#   responseCode - ResponseCodeType
#   descriptiveLinkKey - SOAP::SOAPInt
#   messageXml - SyncFolderItemsResponseMessageType::MessageXml
#   syncState - SOAP::SOAPString
#   includesLastItemInRange - SOAP::SOAPBoolean
#   changes - SyncFolderItemsChangesType
#   xmlattr_ResponseClass - SOAP::SOAPString
class SyncFolderItemsResponseMessageType < ResponseMessageType
  AttrResponseClass = XSD::QName.new(nil, "ResponseClass")

  # inner class for member: MessageXml
  # {http://schemas.microsoft.com/exchange/services/2006/messages}MessageXml
  class MessageXml
    attr_reader :__xmlele_any

    def set_any(elements)
      @__xmlele_any = elements
    end

    def initialize
      @__xmlele_any = nil
    end
  end

  attr_accessor :messageText
  attr_accessor :responseCode
  attr_accessor :descriptiveLinkKey
  attr_accessor :messageXml
  attr_accessor :syncState
  attr_accessor :includesLastItemInRange
  attr_accessor :changes

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ResponseClass
    __xmlattr[AttrResponseClass]
  end

  def xmlattr_ResponseClass=(value)
    __xmlattr[AttrResponseClass] = value
  end

  def initialize(messageText = nil, responseCode = nil, descriptiveLinkKey = nil, messageXml = nil, syncState = nil, includesLastItemInRange = nil, changes = nil)
    @messageText = messageText
    @responseCode = responseCode
    @descriptiveLinkKey = descriptiveLinkKey
    @messageXml = messageXml
    @syncState = syncState
    @includesLastItemInRange = includesLastItemInRange
    @changes = changes
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}ConvertIdResponseMessageType
#   messageText - SOAP::SOAPString
#   responseCode - ResponseCodeType
#   descriptiveLinkKey - SOAP::SOAPInt
#   messageXml - ConvertIdResponseMessageType::MessageXml
#   alternateId - AlternateIdBaseType
#   xmlattr_ResponseClass - SOAP::SOAPString
class ConvertIdResponseMessageType < ResponseMessageType
  AttrResponseClass = XSD::QName.new(nil, "ResponseClass")

  # inner class for member: MessageXml
  # {http://schemas.microsoft.com/exchange/services/2006/messages}MessageXml
  class MessageXml
    attr_reader :__xmlele_any

    def set_any(elements)
      @__xmlele_any = elements
    end

    def initialize
      @__xmlele_any = nil
    end
  end

  attr_accessor :messageText
  attr_accessor :responseCode
  attr_accessor :descriptiveLinkKey
  attr_accessor :messageXml
  attr_accessor :alternateId

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ResponseClass
    __xmlattr[AttrResponseClass]
  end

  def xmlattr_ResponseClass=(value)
    __xmlattr[AttrResponseClass] = value
  end

  def initialize(messageText = nil, responseCode = nil, descriptiveLinkKey = nil, messageXml = nil, alternateId = nil)
    @messageText = messageText
    @responseCode = responseCode
    @descriptiveLinkKey = descriptiveLinkKey
    @messageXml = messageXml
    @alternateId = alternateId
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}DelegateUserResponseMessageType
#   messageText - SOAP::SOAPString
#   responseCode - ResponseCodeType
#   descriptiveLinkKey - SOAP::SOAPInt
#   messageXml - DelegateUserResponseMessageType::MessageXml
#   delegateUser - DelegateUserType
#   xmlattr_ResponseClass - SOAP::SOAPString
class DelegateUserResponseMessageType < ResponseMessageType
  AttrResponseClass = XSD::QName.new(nil, "ResponseClass")

  # inner class for member: MessageXml
  # {http://schemas.microsoft.com/exchange/services/2006/messages}MessageXml
  class MessageXml
    attr_reader :__xmlele_any

    def set_any(elements)
      @__xmlele_any = elements
    end

    def initialize
      @__xmlele_any = nil
    end
  end

  attr_accessor :messageText
  attr_accessor :responseCode
  attr_accessor :descriptiveLinkKey
  attr_accessor :messageXml
  attr_accessor :delegateUser

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ResponseClass
    __xmlattr[AttrResponseClass]
  end

  def xmlattr_ResponseClass=(value)
    __xmlattr[AttrResponseClass] = value
  end

  def initialize(messageText = nil, responseCode = nil, descriptiveLinkKey = nil, messageXml = nil, delegateUser = nil)
    @messageText = messageText
    @responseCode = responseCode
    @descriptiveLinkKey = descriptiveLinkKey
    @messageXml = messageXml
    @delegateUser = delegateUser
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}BaseDelegateResponseMessageType
# abstract
#   messageText - SOAP::SOAPString
#   responseCode - ResponseCodeType
#   descriptiveLinkKey - SOAP::SOAPInt
#   messageXml - BaseDelegateResponseMessageType::MessageXml
#   responseMessages - ArrayOfDelegateUserResponseMessageType
#   xmlattr_ResponseClass - SOAP::SOAPString
class BaseDelegateResponseMessageType < ResponseMessageType
  AttrResponseClass = XSD::QName.new(nil, "ResponseClass")

  # inner class for member: MessageXml
  # {http://schemas.microsoft.com/exchange/services/2006/messages}MessageXml
  class MessageXml
    attr_reader :__xmlele_any

    def set_any(elements)
      @__xmlele_any = elements
    end

    def initialize
      @__xmlele_any = nil
    end
  end

  attr_accessor :messageText
  attr_accessor :responseCode
  attr_accessor :descriptiveLinkKey
  attr_accessor :messageXml
  attr_accessor :responseMessages

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ResponseClass
    __xmlattr[AttrResponseClass]
  end

  def xmlattr_ResponseClass=(value)
    __xmlattr[AttrResponseClass] = value
  end

  def initialize(messageText = nil, responseCode = nil, descriptiveLinkKey = nil, messageXml = nil, responseMessages = nil)
    @messageText = messageText
    @responseCode = responseCode
    @descriptiveLinkKey = descriptiveLinkKey
    @messageXml = messageXml
    @responseMessages = responseMessages
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}GetDelegateResponseMessageType
#   messageText - SOAP::SOAPString
#   responseCode - ResponseCodeType
#   descriptiveLinkKey - SOAP::SOAPInt
#   messageXml - GetDelegateResponseMessageType::MessageXml
#   responseMessages - ArrayOfDelegateUserResponseMessageType
#   deliverMeetingRequests - DeliverMeetingRequestsType
#   xmlattr_ResponseClass - SOAP::SOAPString
class GetDelegateResponseMessageType < BaseDelegateResponseMessageType
  AttrResponseClass = XSD::QName.new(nil, "ResponseClass")

  # inner class for member: MessageXml
  # {http://schemas.microsoft.com/exchange/services/2006/messages}MessageXml
  class MessageXml
    attr_reader :__xmlele_any

    def set_any(elements)
      @__xmlele_any = elements
    end

    def initialize
      @__xmlele_any = nil
    end
  end

  attr_accessor :messageText
  attr_accessor :responseCode
  attr_accessor :descriptiveLinkKey
  attr_accessor :messageXml
  attr_accessor :responseMessages
  attr_accessor :deliverMeetingRequests

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ResponseClass
    __xmlattr[AttrResponseClass]
  end

  def xmlattr_ResponseClass=(value)
    __xmlattr[AttrResponseClass] = value
  end

  def initialize(messageText = nil, responseCode = nil, descriptiveLinkKey = nil, messageXml = nil, responseMessages = nil, deliverMeetingRequests = nil)
    @messageText = messageText
    @responseCode = responseCode
    @descriptiveLinkKey = descriptiveLinkKey
    @messageXml = messageXml
    @responseMessages = responseMessages
    @deliverMeetingRequests = deliverMeetingRequests
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}AddDelegateResponseMessageType
#   messageText - SOAP::SOAPString
#   responseCode - ResponseCodeType
#   descriptiveLinkKey - SOAP::SOAPInt
#   messageXml - AddDelegateResponseMessageType::MessageXml
#   responseMessages - ArrayOfDelegateUserResponseMessageType
#   xmlattr_ResponseClass - SOAP::SOAPString
class AddDelegateResponseMessageType < BaseDelegateResponseMessageType
  AttrResponseClass = XSD::QName.new(nil, "ResponseClass")

  # inner class for member: MessageXml
  # {http://schemas.microsoft.com/exchange/services/2006/messages}MessageXml
  class MessageXml
    attr_reader :__xmlele_any

    def set_any(elements)
      @__xmlele_any = elements
    end

    def initialize
      @__xmlele_any = nil
    end
  end

  attr_accessor :messageText
  attr_accessor :responseCode
  attr_accessor :descriptiveLinkKey
  attr_accessor :messageXml
  attr_accessor :responseMessages

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ResponseClass
    __xmlattr[AttrResponseClass]
  end

  def xmlattr_ResponseClass=(value)
    __xmlattr[AttrResponseClass] = value
  end

  def initialize(messageText = nil, responseCode = nil, descriptiveLinkKey = nil, messageXml = nil, responseMessages = nil)
    @messageText = messageText
    @responseCode = responseCode
    @descriptiveLinkKey = descriptiveLinkKey
    @messageXml = messageXml
    @responseMessages = responseMessages
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}RemoveDelegateResponseMessageType
#   messageText - SOAP::SOAPString
#   responseCode - ResponseCodeType
#   descriptiveLinkKey - SOAP::SOAPInt
#   messageXml - RemoveDelegateResponseMessageType::MessageXml
#   responseMessages - ArrayOfDelegateUserResponseMessageType
#   xmlattr_ResponseClass - SOAP::SOAPString
class RemoveDelegateResponseMessageType < BaseDelegateResponseMessageType
  AttrResponseClass = XSD::QName.new(nil, "ResponseClass")

  # inner class for member: MessageXml
  # {http://schemas.microsoft.com/exchange/services/2006/messages}MessageXml
  class MessageXml
    attr_reader :__xmlele_any

    def set_any(elements)
      @__xmlele_any = elements
    end

    def initialize
      @__xmlele_any = nil
    end
  end

  attr_accessor :messageText
  attr_accessor :responseCode
  attr_accessor :descriptiveLinkKey
  attr_accessor :messageXml
  attr_accessor :responseMessages

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ResponseClass
    __xmlattr[AttrResponseClass]
  end

  def xmlattr_ResponseClass=(value)
    __xmlattr[AttrResponseClass] = value
  end

  def initialize(messageText = nil, responseCode = nil, descriptiveLinkKey = nil, messageXml = nil, responseMessages = nil)
    @messageText = messageText
    @responseCode = responseCode
    @descriptiveLinkKey = descriptiveLinkKey
    @messageXml = messageXml
    @responseMessages = responseMessages
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}UpdateDelegateResponseMessageType
#   messageText - SOAP::SOAPString
#   responseCode - ResponseCodeType
#   descriptiveLinkKey - SOAP::SOAPInt
#   messageXml - UpdateDelegateResponseMessageType::MessageXml
#   responseMessages - ArrayOfDelegateUserResponseMessageType
#   xmlattr_ResponseClass - SOAP::SOAPString
class UpdateDelegateResponseMessageType < BaseDelegateResponseMessageType
  AttrResponseClass = XSD::QName.new(nil, "ResponseClass")

  # inner class for member: MessageXml
  # {http://schemas.microsoft.com/exchange/services/2006/messages}MessageXml
  class MessageXml
    attr_reader :__xmlele_any

    def set_any(elements)
      @__xmlele_any = elements
    end

    def initialize
      @__xmlele_any = nil
    end
  end

  attr_accessor :messageText
  attr_accessor :responseCode
  attr_accessor :descriptiveLinkKey
  attr_accessor :messageXml
  attr_accessor :responseMessages

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ResponseClass
    __xmlattr[AttrResponseClass]
  end

  def xmlattr_ResponseClass=(value)
    __xmlattr[AttrResponseClass] = value
  end

  def initialize(messageText = nil, responseCode = nil, descriptiveLinkKey = nil, messageXml = nil, responseMessages = nil)
    @messageText = messageText
    @responseCode = responseCode
    @descriptiveLinkKey = descriptiveLinkKey
    @messageXml = messageXml
    @responseMessages = responseMessages
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}ArrayOfResponseMessagesType
#   createItemResponseMessage - ItemInfoResponseMessageType
#   deleteItemResponseMessage - ResponseMessageType
#   getItemResponseMessage - ItemInfoResponseMessageType
#   updateItemResponseMessage - UpdateItemResponseMessageType
#   sendItemResponseMessage - ResponseMessageType
#   deleteFolderResponseMessage - ResponseMessageType
#   createFolderResponseMessage - FolderInfoResponseMessageType
#   getFolderResponseMessage - FolderInfoResponseMessageType
#   findFolderResponseMessage - FindFolderResponseMessageType
#   updateFolderResponseMessage - FolderInfoResponseMessageType
#   moveFolderResponseMessage - FolderInfoResponseMessageType
#   copyFolderResponseMessage - FolderInfoResponseMessageType
#   createAttachmentResponseMessage - AttachmentInfoResponseMessageType
#   deleteAttachmentResponseMessage - DeleteAttachmentResponseMessageType
#   getAttachmentResponseMessage - AttachmentInfoResponseMessageType
#   findItemResponseMessage - FindItemResponseMessageType
#   moveItemResponseMessage - ItemInfoResponseMessageType
#   copyItemResponseMessage - ItemInfoResponseMessageType
#   resolveNamesResponseMessage - ResolveNamesResponseMessageType
#   expandDLResponseMessage - ExpandDLResponseMessageType
#   getEventsResponseMessage - GetEventsResponseMessageType
#   subscribeResponseMessage - SubscribeResponseMessageType
#   unsubscribeResponseMessage - ResponseMessageType
#   sendNotificationResponseMessage - SendNotificationResponseMessageType
#   syncFolderHierarchyResponseMessage - SyncFolderHierarchyResponseMessageType
#   syncFolderItemsResponseMessage - SyncFolderItemsResponseMessageType
#   createManagedFolderResponseMessage - FolderInfoResponseMessageType
#   convertIdResponseMessage - ConvertIdResponseMessageType
class ArrayOfResponseMessagesType
  attr_accessor :createItemResponseMessage
  attr_accessor :deleteItemResponseMessage
  attr_accessor :getItemResponseMessage
  attr_accessor :updateItemResponseMessage
  attr_accessor :sendItemResponseMessage
  attr_accessor :deleteFolderResponseMessage
  attr_accessor :createFolderResponseMessage
  attr_accessor :getFolderResponseMessage
  attr_accessor :findFolderResponseMessage
  attr_accessor :updateFolderResponseMessage
  attr_accessor :moveFolderResponseMessage
  attr_accessor :copyFolderResponseMessage
  attr_accessor :createAttachmentResponseMessage
  attr_accessor :deleteAttachmentResponseMessage
  attr_accessor :getAttachmentResponseMessage
  attr_accessor :findItemResponseMessage
  attr_accessor :moveItemResponseMessage
  attr_accessor :copyItemResponseMessage
  attr_accessor :resolveNamesResponseMessage
  attr_accessor :expandDLResponseMessage
  attr_accessor :getEventsResponseMessage
  attr_accessor :subscribeResponseMessage
  attr_accessor :unsubscribeResponseMessage
  attr_accessor :sendNotificationResponseMessage
  attr_accessor :syncFolderHierarchyResponseMessage
  attr_accessor :syncFolderItemsResponseMessage
  attr_accessor :createManagedFolderResponseMessage
  attr_accessor :convertIdResponseMessage

  def initialize(createItemResponseMessage = [], deleteItemResponseMessage = [], getItemResponseMessage = [], updateItemResponseMessage = [], sendItemResponseMessage = [], deleteFolderResponseMessage = [], createFolderResponseMessage = [], getFolderResponseMessage = [], findFolderResponseMessage = [], updateFolderResponseMessage = [], moveFolderResponseMessage = [], copyFolderResponseMessage = [], createAttachmentResponseMessage = [], deleteAttachmentResponseMessage = [], getAttachmentResponseMessage = [], findItemResponseMessage = [], moveItemResponseMessage = [], copyItemResponseMessage = [], resolveNamesResponseMessage = [], expandDLResponseMessage = [], getEventsResponseMessage = [], subscribeResponseMessage = [], unsubscribeResponseMessage = [], sendNotificationResponseMessage = [], syncFolderHierarchyResponseMessage = [], syncFolderItemsResponseMessage = [], createManagedFolderResponseMessage = [], convertIdResponseMessage = [])
    @createItemResponseMessage = createItemResponseMessage
    @deleteItemResponseMessage = deleteItemResponseMessage
    @getItemResponseMessage = getItemResponseMessage
    @updateItemResponseMessage = updateItemResponseMessage
    @sendItemResponseMessage = sendItemResponseMessage
    @deleteFolderResponseMessage = deleteFolderResponseMessage
    @createFolderResponseMessage = createFolderResponseMessage
    @getFolderResponseMessage = getFolderResponseMessage
    @findFolderResponseMessage = findFolderResponseMessage
    @updateFolderResponseMessage = updateFolderResponseMessage
    @moveFolderResponseMessage = moveFolderResponseMessage
    @copyFolderResponseMessage = copyFolderResponseMessage
    @createAttachmentResponseMessage = createAttachmentResponseMessage
    @deleteAttachmentResponseMessage = deleteAttachmentResponseMessage
    @getAttachmentResponseMessage = getAttachmentResponseMessage
    @findItemResponseMessage = findItemResponseMessage
    @moveItemResponseMessage = moveItemResponseMessage
    @copyItemResponseMessage = copyItemResponseMessage
    @resolveNamesResponseMessage = resolveNamesResponseMessage
    @expandDLResponseMessage = expandDLResponseMessage
    @getEventsResponseMessage = getEventsResponseMessage
    @subscribeResponseMessage = subscribeResponseMessage
    @unsubscribeResponseMessage = unsubscribeResponseMessage
    @sendNotificationResponseMessage = sendNotificationResponseMessage
    @syncFolderHierarchyResponseMessage = syncFolderHierarchyResponseMessage
    @syncFolderItemsResponseMessage = syncFolderItemsResponseMessage
    @createManagedFolderResponseMessage = createManagedFolderResponseMessage
    @convertIdResponseMessage = convertIdResponseMessage
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}BaseResponseMessageType
#   responseMessages - ArrayOfResponseMessagesType
class BaseResponseMessageType
  attr_accessor :responseMessages

  def initialize(responseMessages = nil)
    @responseMessages = responseMessages
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}FindFolderResponseType
#   responseMessages - ArrayOfResponseMessagesType
class FindFolderResponseType < BaseResponseMessageType
  attr_accessor :responseMessages

  def initialize(responseMessages = nil)
    @responseMessages = responseMessages
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}DeleteFolderResponseType
#   responseMessages - ArrayOfResponseMessagesType
class DeleteFolderResponseType < BaseResponseMessageType
  attr_accessor :responseMessages

  def initialize(responseMessages = nil)
    @responseMessages = responseMessages
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}CreateFolderResponseType
#   responseMessages - ArrayOfResponseMessagesType
class CreateFolderResponseType < BaseResponseMessageType
  attr_accessor :responseMessages

  def initialize(responseMessages = nil)
    @responseMessages = responseMessages
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}GetFolderResponseType
#   responseMessages - ArrayOfResponseMessagesType
class GetFolderResponseType < BaseResponseMessageType
  attr_accessor :responseMessages

  def initialize(responseMessages = nil)
    @responseMessages = responseMessages
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}UpdateFolderResponseType
#   responseMessages - ArrayOfResponseMessagesType
class UpdateFolderResponseType < BaseResponseMessageType
  attr_accessor :responseMessages

  def initialize(responseMessages = nil)
    @responseMessages = responseMessages
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}MoveFolderResponseType
#   responseMessages - ArrayOfResponseMessagesType
class MoveFolderResponseType < BaseResponseMessageType
  attr_accessor :responseMessages

  def initialize(responseMessages = nil)
    @responseMessages = responseMessages
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}CopyFolderResponseType
#   responseMessages - ArrayOfResponseMessagesType
class CopyFolderResponseType < BaseResponseMessageType
  attr_accessor :responseMessages

  def initialize(responseMessages = nil)
    @responseMessages = responseMessages
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}SendItemResponseType
#   responseMessages - ArrayOfResponseMessagesType
class SendItemResponseType < BaseResponseMessageType
  attr_accessor :responseMessages

  def initialize(responseMessages = nil)
    @responseMessages = responseMessages
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}CreateAttachmentResponseType
#   responseMessages - ArrayOfResponseMessagesType
class CreateAttachmentResponseType < BaseResponseMessageType
  attr_accessor :responseMessages

  def initialize(responseMessages = nil)
    @responseMessages = responseMessages
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}DeleteAttachmentResponseType
#   responseMessages - ArrayOfResponseMessagesType
class DeleteAttachmentResponseType < BaseResponseMessageType
  attr_accessor :responseMessages

  def initialize(responseMessages = nil)
    @responseMessages = responseMessages
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}GetAttachmentResponseType
#   responseMessages - ArrayOfResponseMessagesType
class GetAttachmentResponseType < BaseResponseMessageType
  attr_accessor :responseMessages

  def initialize(responseMessages = nil)
    @responseMessages = responseMessages
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}CreateItemResponseType
#   responseMessages - ArrayOfResponseMessagesType
class CreateItemResponseType < BaseResponseMessageType
  attr_accessor :responseMessages

  def initialize(responseMessages = nil)
    @responseMessages = responseMessages
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}UpdateItemResponseType
#   responseMessages - ArrayOfResponseMessagesType
class UpdateItemResponseType < BaseResponseMessageType
  attr_accessor :responseMessages

  def initialize(responseMessages = nil)
    @responseMessages = responseMessages
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}GetItemResponseType
#   responseMessages - ArrayOfResponseMessagesType
class GetItemResponseType < BaseResponseMessageType
  attr_accessor :responseMessages

  def initialize(responseMessages = nil)
    @responseMessages = responseMessages
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}MoveItemResponseType
#   responseMessages - ArrayOfResponseMessagesType
class MoveItemResponseType < BaseResponseMessageType
  attr_accessor :responseMessages

  def initialize(responseMessages = nil)
    @responseMessages = responseMessages
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}CopyItemResponseType
#   responseMessages - ArrayOfResponseMessagesType
class CopyItemResponseType < BaseResponseMessageType
  attr_accessor :responseMessages

  def initialize(responseMessages = nil)
    @responseMessages = responseMessages
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}DeleteItemResponseType
#   responseMessages - ArrayOfResponseMessagesType
class DeleteItemResponseType < BaseResponseMessageType
  attr_accessor :responseMessages

  def initialize(responseMessages = nil)
    @responseMessages = responseMessages
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}FindItemResponseType
#   responseMessages - ArrayOfResponseMessagesType
class FindItemResponseType < BaseResponseMessageType
  attr_accessor :responseMessages

  def initialize(responseMessages = nil)
    @responseMessages = responseMessages
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}ResolveNamesResponseType
#   responseMessages - ArrayOfResponseMessagesType
class ResolveNamesResponseType < BaseResponseMessageType
  attr_accessor :responseMessages

  def initialize(responseMessages = nil)
    @responseMessages = responseMessages
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}ExpandDLResponseType
#   responseMessages - ArrayOfResponseMessagesType
class ExpandDLResponseType < BaseResponseMessageType
  attr_accessor :responseMessages

  def initialize(responseMessages = nil)
    @responseMessages = responseMessages
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}CreateManagedFolderResponseType
#   responseMessages - ArrayOfResponseMessagesType
class CreateManagedFolderResponseType < BaseResponseMessageType
  attr_accessor :responseMessages

  def initialize(responseMessages = nil)
    @responseMessages = responseMessages
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}SubscribeResponseType
#   responseMessages - ArrayOfResponseMessagesType
class SubscribeResponseType < BaseResponseMessageType
  attr_accessor :responseMessages

  def initialize(responseMessages = nil)
    @responseMessages = responseMessages
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}UnsubscribeResponseType
#   responseMessages - ArrayOfResponseMessagesType
class UnsubscribeResponseType < BaseResponseMessageType
  attr_accessor :responseMessages

  def initialize(responseMessages = nil)
    @responseMessages = responseMessages
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}GetEventsResponseType
#   responseMessages - ArrayOfResponseMessagesType
class GetEventsResponseType < BaseResponseMessageType
  attr_accessor :responseMessages

  def initialize(responseMessages = nil)
    @responseMessages = responseMessages
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}SendNotificationResponseType
#   responseMessages - ArrayOfResponseMessagesType
class SendNotificationResponseType < BaseResponseMessageType
  attr_accessor :responseMessages

  def initialize(responseMessages = nil)
    @responseMessages = responseMessages
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}SyncFolderHierarchyResponseType
#   responseMessages - ArrayOfResponseMessagesType
class SyncFolderHierarchyResponseType < BaseResponseMessageType
  attr_accessor :responseMessages

  def initialize(responseMessages = nil)
    @responseMessages = responseMessages
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}SyncFolderItemsResponseType
#   responseMessages - ArrayOfResponseMessagesType
class SyncFolderItemsResponseType < BaseResponseMessageType
  attr_accessor :responseMessages

  def initialize(responseMessages = nil)
    @responseMessages = responseMessages
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}ConvertIdResponseType
#   responseMessages - ArrayOfResponseMessagesType
class ConvertIdResponseType < BaseResponseMessageType
  attr_accessor :responseMessages

  def initialize(responseMessages = nil)
    @responseMessages = responseMessages
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}BaseRequestType
# abstract
class BaseRequestType
  def initialize
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}GetFolderType
#   folderShape - FolderResponseShapeType
#   folderIds - NonEmptyArrayOfBaseFolderIdsType
class GetFolderType < BaseRequestType
  attr_accessor :folderShape
  attr_accessor :folderIds

  def initialize(folderShape = nil, folderIds = nil)
    @folderShape = folderShape
    @folderIds = folderIds
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}CreateFolderType
#   parentFolderId - TargetFolderIdType
#   folders - NonEmptyArrayOfFoldersType
class CreateFolderType < BaseRequestType
  attr_accessor :parentFolderId
  attr_accessor :folders

  def initialize(parentFolderId = nil, folders = nil)
    @parentFolderId = parentFolderId
    @folders = folders
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}FindFolderType
#   folderShape - FolderResponseShapeType
#   indexedPageFolderView - IndexedPageViewType
#   fractionalPageFolderView - FractionalPageViewType
#   restriction - RestrictionType
#   parentFolderIds - NonEmptyArrayOfBaseFolderIdsType
#   xmlattr_Traversal - SOAP::SOAPString
class FindFolderType < BaseRequestType
  AttrTraversal = XSD::QName.new(nil, "Traversal")

  attr_accessor :folderShape
  attr_accessor :indexedPageFolderView
  attr_accessor :fractionalPageFolderView
  attr_accessor :restriction
  attr_accessor :parentFolderIds

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_Traversal
    __xmlattr[AttrTraversal]
  end

  def xmlattr_Traversal=(value)
    __xmlattr[AttrTraversal] = value
  end

  def initialize(folderShape = nil, indexedPageFolderView = nil, fractionalPageFolderView = nil, restriction = nil, parentFolderIds = nil)
    @folderShape = folderShape
    @indexedPageFolderView = indexedPageFolderView
    @fractionalPageFolderView = fractionalPageFolderView
    @restriction = restriction
    @parentFolderIds = parentFolderIds
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}DeleteFolderType
#   folderIds - NonEmptyArrayOfBaseFolderIdsType
#   xmlattr_DeleteType - SOAP::SOAPString
class DeleteFolderType < BaseRequestType
  AttrDeleteType = XSD::QName.new(nil, "DeleteType")

  attr_accessor :folderIds

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_DeleteType
    __xmlattr[AttrDeleteType]
  end

  def xmlattr_DeleteType=(value)
    __xmlattr[AttrDeleteType] = value
  end

  def initialize(folderIds = nil)
    @folderIds = folderIds
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}BaseMoveCopyFolderType
#   toFolderId - TargetFolderIdType
#   folderIds - NonEmptyArrayOfBaseFolderIdsType
class BaseMoveCopyFolderType < BaseRequestType
  attr_accessor :toFolderId
  attr_accessor :folderIds

  def initialize(toFolderId = nil, folderIds = nil)
    @toFolderId = toFolderId
    @folderIds = folderIds
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}MoveFolderType
#   toFolderId - TargetFolderIdType
#   folderIds - NonEmptyArrayOfBaseFolderIdsType
class MoveFolderType < BaseMoveCopyFolderType
  attr_accessor :toFolderId
  attr_accessor :folderIds

  def initialize(toFolderId = nil, folderIds = nil)
    @toFolderId = toFolderId
    @folderIds = folderIds
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}CopyFolderType
#   toFolderId - TargetFolderIdType
#   folderIds - NonEmptyArrayOfBaseFolderIdsType
class CopyFolderType < BaseMoveCopyFolderType
  attr_accessor :toFolderId
  attr_accessor :folderIds

  def initialize(toFolderId = nil, folderIds = nil)
    @toFolderId = toFolderId
    @folderIds = folderIds
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}UpdateFolderType
#   folderChanges - NonEmptyArrayOfFolderChangesType
class UpdateFolderType < BaseRequestType
  attr_accessor :folderChanges

  def initialize(folderChanges = nil)
    @folderChanges = folderChanges
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}GetItemType
#   itemShape - ItemResponseShapeType
#   itemIds - NonEmptyArrayOfBaseItemIdsType
class GetItemType < BaseRequestType
  attr_accessor :itemShape
  attr_accessor :itemIds

  def initialize(itemShape = nil, itemIds = nil)
    @itemShape = itemShape
    @itemIds = itemIds
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}CreateItemType
#   savedItemFolderId - TargetFolderIdType
#   items - NonEmptyArrayOfAllItemsType
#   xmlattr_MessageDisposition - SOAP::SOAPString
#   xmlattr_SendMeetingInvitations - SOAP::SOAPString
class CreateItemType < BaseRequestType
  AttrMessageDisposition = XSD::QName.new(nil, "MessageDisposition")
  AttrSendMeetingInvitations = XSD::QName.new(nil, "SendMeetingInvitations")

  attr_accessor :savedItemFolderId
  attr_accessor :items

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_MessageDisposition
    __xmlattr[AttrMessageDisposition]
  end

  def xmlattr_MessageDisposition=(value)
    __xmlattr[AttrMessageDisposition] = value
  end

  def xmlattr_SendMeetingInvitations
    __xmlattr[AttrSendMeetingInvitations]
  end

  def xmlattr_SendMeetingInvitations=(value)
    __xmlattr[AttrSendMeetingInvitations] = value
  end

  def initialize(savedItemFolderId = nil, items = nil)
    @savedItemFolderId = savedItemFolderId
    @items = items
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}UpdateItemType
#   savedItemFolderId - TargetFolderIdType
#   itemChanges - NonEmptyArrayOfItemChangesType
#   xmlattr_ConflictResolution - SOAP::SOAPString
#   xmlattr_MessageDisposition - SOAP::SOAPString
#   xmlattr_SendMeetingInvitationsOrCancellations - SOAP::SOAPString
class UpdateItemType < BaseRequestType
  AttrConflictResolution = XSD::QName.new(nil, "ConflictResolution")
  AttrMessageDisposition = XSD::QName.new(nil, "MessageDisposition")
  AttrSendMeetingInvitationsOrCancellations = XSD::QName.new(nil, "SendMeetingInvitationsOrCancellations")

  attr_accessor :savedItemFolderId
  attr_accessor :itemChanges

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ConflictResolution
    __xmlattr[AttrConflictResolution]
  end

  def xmlattr_ConflictResolution=(value)
    __xmlattr[AttrConflictResolution] = value
  end

  def xmlattr_MessageDisposition
    __xmlattr[AttrMessageDisposition]
  end

  def xmlattr_MessageDisposition=(value)
    __xmlattr[AttrMessageDisposition] = value
  end

  def xmlattr_SendMeetingInvitationsOrCancellations
    __xmlattr[AttrSendMeetingInvitationsOrCancellations]
  end

  def xmlattr_SendMeetingInvitationsOrCancellations=(value)
    __xmlattr[AttrSendMeetingInvitationsOrCancellations] = value
  end

  def initialize(savedItemFolderId = nil, itemChanges = nil)
    @savedItemFolderId = savedItemFolderId
    @itemChanges = itemChanges
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}DeleteItemType
#   itemIds - NonEmptyArrayOfBaseItemIdsType
#   xmlattr_DeleteType - SOAP::SOAPString
#   xmlattr_SendMeetingCancellations - SOAP::SOAPString
#   xmlattr_AffectedTaskOccurrences - SOAP::SOAPString
class DeleteItemType < BaseRequestType
  AttrAffectedTaskOccurrences = XSD::QName.new(nil, "AffectedTaskOccurrences")
  AttrDeleteType = XSD::QName.new(nil, "DeleteType")
  AttrSendMeetingCancellations = XSD::QName.new(nil, "SendMeetingCancellations")

  attr_accessor :itemIds

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_DeleteType
    __xmlattr[AttrDeleteType]
  end

  def xmlattr_DeleteType=(value)
    __xmlattr[AttrDeleteType] = value
  end

  def xmlattr_SendMeetingCancellations
    __xmlattr[AttrSendMeetingCancellations]
  end

  def xmlattr_SendMeetingCancellations=(value)
    __xmlattr[AttrSendMeetingCancellations] = value
  end

  def xmlattr_AffectedTaskOccurrences
    __xmlattr[AttrAffectedTaskOccurrences]
  end

  def xmlattr_AffectedTaskOccurrences=(value)
    __xmlattr[AttrAffectedTaskOccurrences] = value
  end

  def initialize(itemIds = nil)
    @itemIds = itemIds
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}BaseMoveCopyItemType
#   toFolderId - TargetFolderIdType
#   itemIds - NonEmptyArrayOfBaseItemIdsType
class BaseMoveCopyItemType < BaseRequestType
  attr_accessor :toFolderId
  attr_accessor :itemIds

  def initialize(toFolderId = nil, itemIds = nil)
    @toFolderId = toFolderId
    @itemIds = itemIds
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}MoveItemType
#   toFolderId - TargetFolderIdType
#   itemIds - NonEmptyArrayOfBaseItemIdsType
class MoveItemType < BaseMoveCopyItemType
  attr_accessor :toFolderId
  attr_accessor :itemIds

  def initialize(toFolderId = nil, itemIds = nil)
    @toFolderId = toFolderId
    @itemIds = itemIds
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}CopyItemType
#   toFolderId - TargetFolderIdType
#   itemIds - NonEmptyArrayOfBaseItemIdsType
class CopyItemType < BaseMoveCopyItemType
  attr_accessor :toFolderId
  attr_accessor :itemIds

  def initialize(toFolderId = nil, itemIds = nil)
    @toFolderId = toFolderId
    @itemIds = itemIds
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}SendItemType
#   itemIds - NonEmptyArrayOfBaseItemIdsType
#   savedItemFolderId - TargetFolderIdType
#   xmlattr_SaveItemToFolder - SOAP::SOAPBoolean
class SendItemType < BaseRequestType
  AttrSaveItemToFolder = XSD::QName.new(nil, "SaveItemToFolder")

  attr_accessor :itemIds
  attr_accessor :savedItemFolderId

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_SaveItemToFolder
    __xmlattr[AttrSaveItemToFolder]
  end

  def xmlattr_SaveItemToFolder=(value)
    __xmlattr[AttrSaveItemToFolder] = value
  end

  def initialize(itemIds = nil, savedItemFolderId = nil)
    @itemIds = itemIds
    @savedItemFolderId = savedItemFolderId
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}FindItemType
#   itemShape - ItemResponseShapeType
#   indexedPageItemView - IndexedPageViewType
#   fractionalPageItemView - FractionalPageViewType
#   calendarView - CalendarViewType
#   contactsView - ContactsViewType
#   groupBy - GroupByType
#   distinguishedGroupBy - DistinguishedGroupByType
#   restriction - RestrictionType
#   sortOrder - NonEmptyArrayOfFieldOrdersType
#   parentFolderIds - NonEmptyArrayOfBaseFolderIdsType
#   xmlattr_Traversal - SOAP::SOAPString
class FindItemType < BaseRequestType
  AttrTraversal = XSD::QName.new(nil, "Traversal")

  attr_accessor :itemShape
  attr_accessor :indexedPageItemView
  attr_accessor :fractionalPageItemView
  attr_accessor :calendarView
  attr_accessor :contactsView
  attr_accessor :groupBy
  attr_accessor :distinguishedGroupBy
  attr_accessor :restriction
  attr_accessor :sortOrder
  attr_accessor :parentFolderIds

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_Traversal
    __xmlattr[AttrTraversal]
  end

  def xmlattr_Traversal=(value)
    __xmlattr[AttrTraversal] = value
  end

  def initialize(itemShape = nil, indexedPageItemView = nil, fractionalPageItemView = nil, calendarView = nil, contactsView = nil, groupBy = nil, distinguishedGroupBy = nil, restriction = nil, sortOrder = nil, parentFolderIds = nil)
    @itemShape = itemShape
    @indexedPageItemView = indexedPageItemView
    @fractionalPageItemView = fractionalPageItemView
    @calendarView = calendarView
    @contactsView = contactsView
    @groupBy = groupBy
    @distinguishedGroupBy = distinguishedGroupBy
    @restriction = restriction
    @sortOrder = sortOrder
    @parentFolderIds = parentFolderIds
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}CreateAttachmentType
#   parentItemId - ItemIdType
#   attachments - NonEmptyArrayOfAttachmentsType
class CreateAttachmentType < BaseRequestType
  attr_accessor :parentItemId
  attr_accessor :attachments

  def initialize(parentItemId = nil, attachments = nil)
    @parentItemId = parentItemId
    @attachments = attachments
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}DeleteAttachmentType
#   attachmentIds - NonEmptyArrayOfRequestAttachmentIdsType
class DeleteAttachmentType < BaseRequestType
  attr_accessor :attachmentIds

  def initialize(attachmentIds = nil)
    @attachmentIds = attachmentIds
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}GetAttachmentType
#   attachmentShape - AttachmentResponseShapeType
#   attachmentIds - NonEmptyArrayOfRequestAttachmentIdsType
class GetAttachmentType < BaseRequestType
  attr_accessor :attachmentShape
  attr_accessor :attachmentIds

  def initialize(attachmentShape = nil, attachmentIds = nil)
    @attachmentShape = attachmentShape
    @attachmentIds = attachmentIds
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}ResolveNamesType
#   parentFolderIds - NonEmptyArrayOfBaseFolderIdsType
#   unresolvedEntry - (any)
#   xmlattr_ReturnFullContactData - SOAP::SOAPBoolean
#   xmlattr_SearchScope - SOAP::SOAPString
class ResolveNamesType < BaseRequestType
  AttrReturnFullContactData = XSD::QName.new(nil, "ReturnFullContactData")
  AttrSearchScope = XSD::QName.new(nil, "SearchScope")

  attr_accessor :parentFolderIds
  attr_accessor :unresolvedEntry

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ReturnFullContactData
    __xmlattr[AttrReturnFullContactData]
  end

  def xmlattr_ReturnFullContactData=(value)
    __xmlattr[AttrReturnFullContactData] = value
  end

  def xmlattr_SearchScope
    __xmlattr[AttrSearchScope]
  end

  def xmlattr_SearchScope=(value)
    __xmlattr[AttrSearchScope] = value
  end

  def initialize(parentFolderIds = nil, unresolvedEntry = nil)
    @parentFolderIds = parentFolderIds
    @unresolvedEntry = unresolvedEntry
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}ExpandDLType
#   mailbox - EmailAddressType
class ExpandDLType < BaseRequestType
  attr_accessor :mailbox

  def initialize(mailbox = nil)
    @mailbox = mailbox
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}CreateManagedFolderRequestType
#   folderNames - NonEmptyArrayOfFolderNamesType
#   mailbox - EmailAddressType
class CreateManagedFolderRequestType < BaseRequestType
  attr_accessor :folderNames
  attr_accessor :mailbox

  def initialize(folderNames = nil, mailbox = nil)
    @folderNames = folderNames
    @mailbox = mailbox
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}SubscribeType
#   pullSubscriptionRequest - PullSubscriptionRequestType
#   pushSubscriptionRequest - PushSubscriptionRequestType
class SubscribeType < BaseRequestType
  attr_accessor :pullSubscriptionRequest
  attr_accessor :pushSubscriptionRequest

  def initialize(pullSubscriptionRequest = nil, pushSubscriptionRequest = nil)
    @pullSubscriptionRequest = pullSubscriptionRequest
    @pushSubscriptionRequest = pushSubscriptionRequest
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}UnsubscribeType
#   subscriptionId - (any)
class UnsubscribeType < BaseRequestType
  attr_accessor :subscriptionId

  def initialize(subscriptionId = nil)
    @subscriptionId = subscriptionId
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}GetEventsType
#   subscriptionId - (any)
#   watermark - (any)
class GetEventsType < BaseRequestType
  attr_accessor :subscriptionId
  attr_accessor :watermark

  def initialize(subscriptionId = nil, watermark = nil)
    @subscriptionId = subscriptionId
    @watermark = watermark
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}SyncFolderHierarchyType
#   folderShape - FolderResponseShapeType
#   syncFolderId - TargetFolderIdType
#   syncState - SOAP::SOAPString
class SyncFolderHierarchyType < BaseRequestType
  attr_accessor :folderShape
  attr_accessor :syncFolderId
  attr_accessor :syncState

  def initialize(folderShape = nil, syncFolderId = nil, syncState = nil)
    @folderShape = folderShape
    @syncFolderId = syncFolderId
    @syncState = syncState
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}SyncFolderItemsType
#   itemShape - ItemResponseShapeType
#   syncFolderId - TargetFolderIdType
#   syncState - SOAP::SOAPString
#   ignore - ArrayOfBaseItemIdsType
#   maxChangesReturned - (any)
class SyncFolderItemsType < BaseRequestType
  attr_accessor :itemShape
  attr_accessor :syncFolderId
  attr_accessor :syncState
  attr_accessor :ignore
  attr_accessor :maxChangesReturned

  def initialize(itemShape = nil, syncFolderId = nil, syncState = nil, ignore = nil, maxChangesReturned = nil)
    @itemShape = itemShape
    @syncFolderId = syncFolderId
    @syncState = syncState
    @ignore = ignore
    @maxChangesReturned = maxChangesReturned
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}GetUserAvailabilityRequestType
#   timeZone - SerializableTimeZone
#   mailboxDataArray - ArrayOfMailboxData
#   freeBusyViewOptions - FreeBusyViewOptionsType
#   suggestionsViewOptions - SuggestionsViewOptionsType
class GetUserAvailabilityRequestType < BaseRequestType
  attr_accessor :timeZone
  attr_accessor :mailboxDataArray
  attr_accessor :freeBusyViewOptions
  attr_accessor :suggestionsViewOptions

  def initialize(timeZone = nil, mailboxDataArray = nil, freeBusyViewOptions = nil, suggestionsViewOptions = nil)
    @timeZone = timeZone
    @mailboxDataArray = mailboxDataArray
    @freeBusyViewOptions = freeBusyViewOptions
    @suggestionsViewOptions = suggestionsViewOptions
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}GetUserOofSettingsRequest
#   mailbox - EmailAddress
class GetUserOofSettingsRequest < BaseRequestType
  attr_accessor :mailbox

  def initialize(mailbox = nil)
    @mailbox = mailbox
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}SetUserOofSettingsRequest
#   mailbox - EmailAddress
#   userOofSettings - UserOofSettings
class SetUserOofSettingsRequest < BaseRequestType
  attr_accessor :mailbox
  attr_accessor :userOofSettings

  def initialize(mailbox = nil, userOofSettings = nil)
    @mailbox = mailbox
    @userOofSettings = userOofSettings
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}ConvertIdType
#   sourceIds - NonEmptyArrayOfAlternateIdsType
#   xmlattr_DestinationFormat - SOAP::SOAPString
class ConvertIdType < BaseRequestType
  AttrDestinationFormat = XSD::QName.new(nil, "DestinationFormat")

  attr_accessor :sourceIds

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_DestinationFormat
    __xmlattr[AttrDestinationFormat]
  end

  def xmlattr_DestinationFormat=(value)
    __xmlattr[AttrDestinationFormat] = value
  end

  def initialize(sourceIds = nil)
    @sourceIds = sourceIds
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}BaseDelegateType
# abstract
#   mailbox - EmailAddressType
class BaseDelegateType < BaseRequestType
  attr_accessor :mailbox

  def initialize(mailbox = nil)
    @mailbox = mailbox
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}GetDelegateType
#   mailbox - EmailAddressType
#   userIds - ArrayOfUserIdType
#   xmlattr_IncludePermissions - SOAP::SOAPBoolean
class GetDelegateType < BaseDelegateType
  AttrIncludePermissions = XSD::QName.new(nil, "IncludePermissions")

  attr_accessor :mailbox
  attr_accessor :userIds

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_IncludePermissions
    __xmlattr[AttrIncludePermissions]
  end

  def xmlattr_IncludePermissions=(value)
    __xmlattr[AttrIncludePermissions] = value
  end

  def initialize(mailbox = nil, userIds = nil)
    @mailbox = mailbox
    @userIds = userIds
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}AddDelegateType
#   mailbox - EmailAddressType
#   delegateUsers - ArrayOfDelegateUserType
#   deliverMeetingRequests - DeliverMeetingRequestsType
class AddDelegateType < BaseDelegateType
  attr_accessor :mailbox
  attr_accessor :delegateUsers
  attr_accessor :deliverMeetingRequests

  def initialize(mailbox = nil, delegateUsers = nil, deliverMeetingRequests = nil)
    @mailbox = mailbox
    @delegateUsers = delegateUsers
    @deliverMeetingRequests = deliverMeetingRequests
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}RemoveDelegateType
#   mailbox - EmailAddressType
#   userIds - ArrayOfUserIdType
class RemoveDelegateType < BaseDelegateType
  attr_accessor :mailbox
  attr_accessor :userIds

  def initialize(mailbox = nil, userIds = nil)
    @mailbox = mailbox
    @userIds = userIds
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}UpdateDelegateType
#   mailbox - EmailAddressType
#   delegateUsers - ArrayOfDelegateUserType
#   deliverMeetingRequests - DeliverMeetingRequestsType
class UpdateDelegateType < BaseDelegateType
  attr_accessor :mailbox
  attr_accessor :delegateUsers
  attr_accessor :deliverMeetingRequests

  def initialize(mailbox = nil, delegateUsers = nil, deliverMeetingRequests = nil)
    @mailbox = mailbox
    @delegateUsers = delegateUsers
    @deliverMeetingRequests = deliverMeetingRequests
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}SendNotificationResultType
#   subscriptionStatus - SubscriptionStatusType
class SendNotificationResultType
  attr_accessor :subscriptionStatus

  def initialize(subscriptionStatus = nil)
    @subscriptionStatus = subscriptionStatus
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}FreeBusyResponseType
#   responseMessage - ResponseMessageType
#   freeBusyView - FreeBusyView
class FreeBusyResponseType
  attr_accessor :responseMessage
  attr_accessor :freeBusyView

  def initialize(responseMessage = nil, freeBusyView = nil)
    @responseMessage = responseMessage
    @freeBusyView = freeBusyView
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}ArrayOfFreeBusyResponse
class ArrayOfFreeBusyResponse < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}SuggestionsResponseType
#   responseMessage - ResponseMessageType
#   suggestionDayResultArray - ArrayOfSuggestionDayResult
class SuggestionsResponseType
  attr_accessor :responseMessage
  attr_accessor :suggestionDayResultArray

  def initialize(responseMessage = nil, suggestionDayResultArray = nil)
    @responseMessage = responseMessage
    @suggestionDayResultArray = suggestionDayResultArray
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}GetUserAvailabilityResponseType
#   freeBusyResponseArray - ArrayOfFreeBusyResponse
#   suggestionsResponse - SuggestionsResponseType
class GetUserAvailabilityResponseType
  attr_accessor :freeBusyResponseArray
  attr_accessor :suggestionsResponse

  def initialize(freeBusyResponseArray = nil, suggestionsResponse = nil)
    @freeBusyResponseArray = freeBusyResponseArray
    @suggestionsResponse = suggestionsResponse
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}GetUserOofSettingsResponse
#   responseMessage - ResponseMessageType
#   oofSettings - UserOofSettings
#   allowExternalOof - ExternalAudience
class GetUserOofSettingsResponse
  attr_accessor :responseMessage
  attr_accessor :oofSettings
  attr_accessor :allowExternalOof

  def initialize(responseMessage = nil, oofSettings = nil, allowExternalOof = nil)
    @responseMessage = responseMessage
    @oofSettings = oofSettings
    @allowExternalOof = allowExternalOof
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}SetUserOofSettingsResponse
#   responseMessage - ResponseMessageType
class SetUserOofSettingsResponse
  attr_accessor :responseMessage

  def initialize(responseMessage = nil)
    @responseMessage = responseMessage
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}ArrayOfDelegateUserResponseMessageType
class ArrayOfDelegateUserResponseMessageType < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}SidAndAttributesType
#   securityIdentifier - SOAP::SOAPString
#   xmlattr_Attributes - SOAP::SOAPUnsignedInt
class SidAndAttributesType
  AttrAttributes = XSD::QName.new(nil, "Attributes")

  attr_accessor :securityIdentifier

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_Attributes
    __xmlattr[AttrAttributes]
  end

  def xmlattr_Attributes=(value)
    __xmlattr[AttrAttributes] = value
  end

  def initialize(securityIdentifier = nil)
    @securityIdentifier = securityIdentifier
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}NonEmptyArrayOfGroupIdentifiersType
class NonEmptyArrayOfGroupIdentifiersType < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}NonEmptyArrayOfRestrictedGroupIdentifiersType
class NonEmptyArrayOfRestrictedGroupIdentifiersType < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}SerializedSecurityContextType
#   userSid - SOAP::SOAPString
#   groupSids - NonEmptyArrayOfGroupIdentifiersType
#   restrictedGroupSids - NonEmptyArrayOfRestrictedGroupIdentifiersType
#   primarySmtpAddress - SOAP::SOAPString
class SerializedSecurityContextType
  attr_accessor :userSid
  attr_accessor :groupSids
  attr_accessor :restrictedGroupSids
  attr_accessor :primarySmtpAddress

  def initialize(userSid = nil, groupSids = nil, restrictedGroupSids = nil, primarySmtpAddress = nil)
    @userSid = userSid
    @groupSids = groupSids
    @restrictedGroupSids = restrictedGroupSids
    @primarySmtpAddress = primarySmtpAddress
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ConnectingSIDType
#   principalName - SOAP::SOAPString
#   sID - SOAP::SOAPString
#   primarySmtpAddress - SOAP::SOAPString
class ConnectingSIDType
  attr_accessor :principalName
  attr_accessor :sID
  attr_accessor :primarySmtpAddress

  def initialize(principalName = nil, sID = nil, primarySmtpAddress = nil)
    @principalName = principalName
    @sID = sID
    @primarySmtpAddress = primarySmtpAddress
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ExchangeImpersonationType
#   connectingSID - ConnectingSIDType
class ExchangeImpersonationType
  attr_accessor :connectingSID

  def initialize(connectingSID = nil)
    @connectingSID = connectingSID
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ProxySecurityContextType
class ProxySecurityContextType < ::String
  def initialize(*arg)
    super
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}BaseEmailAddressType
class BaseEmailAddressType
  def initialize
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}EmailAddressType
#   name - SOAP::SOAPString
#   emailAddress - (any)
#   routingType - (any)
#   mailboxType - MailboxTypeType
#   itemId - ItemIdType
class EmailAddressType < BaseEmailAddressType
  attr_accessor :name
  attr_accessor :emailAddress
  attr_accessor :routingType
  attr_accessor :mailboxType
  attr_accessor :itemId

  def initialize(name = nil, emailAddress = nil, routingType = nil, mailboxType = nil, itemId = nil)
    @name = name
    @emailAddress = emailAddress
    @routingType = routingType
    @mailboxType = mailboxType
    @itemId = itemId
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ArrayOfRecipientsType
class ArrayOfRecipientsType < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}SingleRecipientType
#   mailbox - EmailAddressType
class SingleRecipientType
  attr_accessor :mailbox

  def initialize(mailbox = nil)
    @mailbox = mailbox
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}BasePathToElementType
# abstract
class BasePathToElementType
  def initialize
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}PathToUnindexedFieldType
#   xmlattr_FieldURI - SOAP::SOAPString
class PathToUnindexedFieldType < BasePathToElementType
  AttrFieldURI = XSD::QName.new(nil, "FieldURI")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_FieldURI
    __xmlattr[AttrFieldURI]
  end

  def xmlattr_FieldURI=(value)
    __xmlattr[AttrFieldURI] = value
  end

  def initialize
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}PathToIndexedFieldType
#   xmlattr_FieldURI - SOAP::SOAPString
#   xmlattr_FieldIndex - SOAP::SOAPString
class PathToIndexedFieldType < BasePathToElementType
  AttrFieldIndex = XSD::QName.new(nil, "FieldIndex")
  AttrFieldURI = XSD::QName.new(nil, "FieldURI")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_FieldURI
    __xmlattr[AttrFieldURI]
  end

  def xmlattr_FieldURI=(value)
    __xmlattr[AttrFieldURI] = value
  end

  def xmlattr_FieldIndex
    __xmlattr[AttrFieldIndex]
  end

  def xmlattr_FieldIndex=(value)
    __xmlattr[AttrFieldIndex] = value
  end

  def initialize
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}PathToExceptionFieldType
#   xmlattr_FieldURI - SOAP::SOAPString
class PathToExceptionFieldType < BasePathToElementType
  AttrFieldURI = XSD::QName.new(nil, "FieldURI")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_FieldURI
    __xmlattr[AttrFieldURI]
  end

  def xmlattr_FieldURI=(value)
    __xmlattr[AttrFieldURI] = value
  end

  def initialize
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}PathToExtendedFieldType
#   xmlattr_DistinguishedPropertySetId - SOAP::SOAPString
#   xmlattr_PropertySetId - SOAP::SOAPString
#   xmlattr_PropertyTag - (any)
#   xmlattr_PropertyName - SOAP::SOAPString
#   xmlattr_PropertyId - SOAP::SOAPInt
#   xmlattr_PropertyType - SOAP::SOAPString
class PathToExtendedFieldType < BasePathToElementType
  AttrDistinguishedPropertySetId = XSD::QName.new(nil, "DistinguishedPropertySetId")
  AttrPropertyId = XSD::QName.new(nil, "PropertyId")
  AttrPropertyName = XSD::QName.new(nil, "PropertyName")
  AttrPropertySetId = XSD::QName.new(nil, "PropertySetId")
  AttrPropertyTag = XSD::QName.new(nil, "PropertyTag")
  AttrPropertyType = XSD::QName.new(nil, "PropertyType")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_DistinguishedPropertySetId
    __xmlattr[AttrDistinguishedPropertySetId]
  end

  def xmlattr_DistinguishedPropertySetId=(value)
    __xmlattr[AttrDistinguishedPropertySetId] = value
  end

  def xmlattr_PropertySetId
    __xmlattr[AttrPropertySetId]
  end

  def xmlattr_PropertySetId=(value)
    __xmlattr[AttrPropertySetId] = value
  end

  def xmlattr_PropertyTag
    __xmlattr[AttrPropertyTag]
  end

  def xmlattr_PropertyTag=(value)
    __xmlattr[AttrPropertyTag] = value
  end

  def xmlattr_PropertyName
    __xmlattr[AttrPropertyName]
  end

  def xmlattr_PropertyName=(value)
    __xmlattr[AttrPropertyName] = value
  end

  def xmlattr_PropertyId
    __xmlattr[AttrPropertyId]
  end

  def xmlattr_PropertyId=(value)
    __xmlattr[AttrPropertyId] = value
  end

  def xmlattr_PropertyType
    __xmlattr[AttrPropertyType]
  end

  def xmlattr_PropertyType=(value)
    __xmlattr[AttrPropertyType] = value
  end

  def initialize
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}NonEmptyArrayOfPathsToElementType
class NonEmptyArrayOfPathsToElementType < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}NonEmptyArrayOfPropertyValuesType
class NonEmptyArrayOfPropertyValuesType < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ExtendedPropertyType
#   extendedFieldURI - PathToExtendedFieldType
#   value - SOAP::SOAPString
#   values - NonEmptyArrayOfPropertyValuesType
class ExtendedPropertyType
  attr_accessor :extendedFieldURI
  attr_accessor :value
  attr_accessor :values

  def initialize(extendedFieldURI = nil, value = nil, values = nil)
    @extendedFieldURI = extendedFieldURI
    @value = value
    @values = values
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}FolderResponseShapeType
#   baseShape - DefaultShapeNamesType
#   additionalProperties - NonEmptyArrayOfPathsToElementType
class FolderResponseShapeType
  attr_accessor :baseShape
  attr_accessor :additionalProperties

  def initialize(baseShape = nil, additionalProperties = nil)
    @baseShape = baseShape
    @additionalProperties = additionalProperties
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ItemResponseShapeType
#   baseShape - DefaultShapeNamesType
#   includeMimeContent - SOAP::SOAPBoolean
#   bodyType - BodyTypeResponseType
#   additionalProperties - NonEmptyArrayOfPathsToElementType
class ItemResponseShapeType
  attr_accessor :baseShape
  attr_accessor :includeMimeContent
  attr_accessor :bodyType
  attr_accessor :additionalProperties

  def initialize(baseShape = nil, includeMimeContent = nil, bodyType = nil, additionalProperties = nil)
    @baseShape = baseShape
    @includeMimeContent = includeMimeContent
    @bodyType = bodyType
    @additionalProperties = additionalProperties
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}AttachmentResponseShapeType
#   includeMimeContent - SOAP::SOAPBoolean
#   bodyType - BodyTypeResponseType
#   additionalProperties - NonEmptyArrayOfPathsToElementType
class AttachmentResponseShapeType
  attr_accessor :includeMimeContent
  attr_accessor :bodyType
  attr_accessor :additionalProperties

  def initialize(includeMimeContent = nil, bodyType = nil, additionalProperties = nil)
    @includeMimeContent = includeMimeContent
    @bodyType = bodyType
    @additionalProperties = additionalProperties
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ChangeDescriptionType
# abstract
#   path - BasePathToElementType
class ChangeDescriptionType
  attr_accessor :path

  def initialize(path = nil)
    @path = path
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ItemChangeDescriptionType
#   path - BasePathToElementType
class ItemChangeDescriptionType < ChangeDescriptionType
  attr_accessor :path

  def initialize(path = nil)
    @path = path
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}SetItemFieldType
#   path - BasePathToElementType
#   item - ItemType
#   message - MessageType
#   calendarItem - CalendarItemType
#   contact - ContactItemType
#   distributionList - DistributionListType
#   meetingMessage - MeetingMessageType
#   meetingRequest - MeetingRequestMessageType
#   meetingResponse - MeetingResponseMessageType
#   meetingCancellation - MeetingCancellationMessageType
#   task - TaskType
#   postItem - PostItemType
class SetItemFieldType < ItemChangeDescriptionType
  attr_accessor :path
  attr_accessor :item
  attr_accessor :message
  attr_accessor :calendarItem
  attr_accessor :contact
  attr_accessor :distributionList
  attr_accessor :meetingMessage
  attr_accessor :meetingRequest
  attr_accessor :meetingResponse
  attr_accessor :meetingCancellation
  attr_accessor :task
  attr_accessor :postItem

  def initialize(path = nil, item = nil, message = nil, calendarItem = nil, contact = nil, distributionList = nil, meetingMessage = nil, meetingRequest = nil, meetingResponse = nil, meetingCancellation = nil, task = nil, postItem = nil)
    @path = path
    @item = item
    @message = message
    @calendarItem = calendarItem
    @contact = contact
    @distributionList = distributionList
    @meetingMessage = meetingMessage
    @meetingRequest = meetingRequest
    @meetingResponse = meetingResponse
    @meetingCancellation = meetingCancellation
    @task = task
    @postItem = postItem
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}DeleteItemFieldType
#   path - BasePathToElementType
class DeleteItemFieldType < ItemChangeDescriptionType
  attr_accessor :path

  def initialize(path = nil)
    @path = path
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}AppendToItemFieldType
#   path - BasePathToElementType
#   item - ItemType
#   message - MessageType
#   calendarItem - CalendarItemType
#   contact - ContactItemType
#   distributionList - DistributionListType
#   meetingMessage - MeetingMessageType
#   meetingRequest - MeetingRequestMessageType
#   meetingResponse - MeetingResponseMessageType
#   meetingCancellation - MeetingCancellationMessageType
#   task - TaskType
#   postItem - PostItemType
class AppendToItemFieldType < ItemChangeDescriptionType
  attr_accessor :path
  attr_accessor :item
  attr_accessor :message
  attr_accessor :calendarItem
  attr_accessor :contact
  attr_accessor :distributionList
  attr_accessor :meetingMessage
  attr_accessor :meetingRequest
  attr_accessor :meetingResponse
  attr_accessor :meetingCancellation
  attr_accessor :task
  attr_accessor :postItem

  def initialize(path = nil, item = nil, message = nil, calendarItem = nil, contact = nil, distributionList = nil, meetingMessage = nil, meetingRequest = nil, meetingResponse = nil, meetingCancellation = nil, task = nil, postItem = nil)
    @path = path
    @item = item
    @message = message
    @calendarItem = calendarItem
    @contact = contact
    @distributionList = distributionList
    @meetingMessage = meetingMessage
    @meetingRequest = meetingRequest
    @meetingResponse = meetingResponse
    @meetingCancellation = meetingCancellation
    @task = task
    @postItem = postItem
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}FolderChangeDescriptionType
#   path - BasePathToElementType
class FolderChangeDescriptionType < ChangeDescriptionType
  attr_accessor :path

  def initialize(path = nil)
    @path = path
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}SetFolderFieldType
#   path - BasePathToElementType
#   folder - FolderType
#   calendarFolder - CalendarFolderType
#   contactsFolder - ContactsFolderType
#   searchFolder - SearchFolderType
#   tasksFolder - TasksFolderType
class SetFolderFieldType < FolderChangeDescriptionType
  attr_accessor :path
  attr_accessor :folder
  attr_accessor :calendarFolder
  attr_accessor :contactsFolder
  attr_accessor :searchFolder
  attr_accessor :tasksFolder

  def initialize(path = nil, folder = nil, calendarFolder = nil, contactsFolder = nil, searchFolder = nil, tasksFolder = nil)
    @path = path
    @folder = folder
    @calendarFolder = calendarFolder
    @contactsFolder = contactsFolder
    @searchFolder = searchFolder
    @tasksFolder = tasksFolder
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}DeleteFolderFieldType
#   path - BasePathToElementType
class DeleteFolderFieldType < FolderChangeDescriptionType
  attr_accessor :path

  def initialize(path = nil)
    @path = path
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}AppendToFolderFieldType
#   path - BasePathToElementType
#   folder - FolderType
#   calendarFolder - CalendarFolderType
#   contactsFolder - ContactsFolderType
#   searchFolder - SearchFolderType
#   tasksFolder - TasksFolderType
class AppendToFolderFieldType < FolderChangeDescriptionType
  attr_accessor :path
  attr_accessor :folder
  attr_accessor :calendarFolder
  attr_accessor :contactsFolder
  attr_accessor :searchFolder
  attr_accessor :tasksFolder

  def initialize(path = nil, folder = nil, calendarFolder = nil, contactsFolder = nil, searchFolder = nil, tasksFolder = nil)
    @path = path
    @folder = folder
    @calendarFolder = calendarFolder
    @contactsFolder = contactsFolder
    @searchFolder = searchFolder
    @tasksFolder = tasksFolder
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}NonEmptyArrayOfItemChangeDescriptionsType
#   appendToItemField - AppendToItemFieldType
#   setItemField - SetItemFieldType
#   deleteItemField - DeleteItemFieldType
class NonEmptyArrayOfItemChangeDescriptionsType
  attr_accessor :appendToItemField
  attr_accessor :setItemField
  attr_accessor :deleteItemField

  def initialize(appendToItemField = [], setItemField = [], deleteItemField = [])
    @appendToItemField = appendToItemField
    @setItemField = setItemField
    @deleteItemField = deleteItemField
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}NonEmptyArrayOfFolderChangeDescriptionsType
#   appendToFolderField - AppendToFolderFieldType
#   setFolderField - SetFolderFieldType
#   deleteFolderField - DeleteFolderFieldType
class NonEmptyArrayOfFolderChangeDescriptionsType
  attr_accessor :appendToFolderField
  attr_accessor :setFolderField
  attr_accessor :deleteFolderField

  def initialize(appendToFolderField = [], setFolderField = [], deleteFolderField = [])
    @appendToFolderField = appendToFolderField
    @setFolderField = setFolderField
    @deleteFolderField = deleteFolderField
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ItemChangeType
#   itemId - ItemIdType
#   occurrenceItemId - OccurrenceItemIdType
#   recurringMasterItemId - RecurringMasterItemIdType
#   updates - NonEmptyArrayOfItemChangeDescriptionsType
class ItemChangeType
  attr_accessor :itemId
  attr_accessor :occurrenceItemId
  attr_accessor :recurringMasterItemId
  attr_accessor :updates

  def initialize(itemId = nil, occurrenceItemId = nil, recurringMasterItemId = nil, updates = nil)
    @itemId = itemId
    @occurrenceItemId = occurrenceItemId
    @recurringMasterItemId = recurringMasterItemId
    @updates = updates
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}NonEmptyArrayOfItemChangesType
class NonEmptyArrayOfItemChangesType < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}InternetHeaderType
#   xmlattr_HeaderName - SOAP::SOAPString
class InternetHeaderType < ::String
  AttrHeaderName = XSD::QName.new(nil, "HeaderName")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_HeaderName
    __xmlattr[AttrHeaderName]
  end

  def xmlattr_HeaderName=(value)
    __xmlattr[AttrHeaderName] = value
  end

  def initialize(*arg)
    super
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}NonEmptyArrayOfInternetHeadersType
class NonEmptyArrayOfInternetHeadersType < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}NonEmptyArrayOfRequestAttachmentIdsType
class NonEmptyArrayOfRequestAttachmentIdsType < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}AttachmentType
#   attachmentId - AttachmentIdType
#   name - SOAP::SOAPString
#   contentType - SOAP::SOAPString
#   contentId - SOAP::SOAPString
#   contentLocation - SOAP::SOAPString
class AttachmentType
  attr_accessor :attachmentId
  attr_accessor :name
  attr_accessor :contentType
  attr_accessor :contentId
  attr_accessor :contentLocation

  def initialize(attachmentId = nil, name = nil, contentType = nil, contentId = nil, contentLocation = nil)
    @attachmentId = attachmentId
    @name = name
    @contentType = contentType
    @contentId = contentId
    @contentLocation = contentLocation
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ItemAttachmentType
#   attachmentId - AttachmentIdType
#   name - SOAP::SOAPString
#   contentType - SOAP::SOAPString
#   contentId - SOAP::SOAPString
#   contentLocation - SOAP::SOAPString
#   item - ItemType
#   message - MessageType
#   calendarItem - CalendarItemType
#   contact - ContactItemType
#   meetingMessage - MeetingMessageType
#   meetingRequest - MeetingRequestMessageType
#   meetingResponse - MeetingResponseMessageType
#   meetingCancellation - MeetingCancellationMessageType
#   task - TaskType
#   postItem - PostItemType
class ItemAttachmentType < AttachmentType
  attr_accessor :attachmentId
  attr_accessor :name
  attr_accessor :contentType
  attr_accessor :contentId
  attr_accessor :contentLocation
  attr_accessor :item
  attr_accessor :message
  attr_accessor :calendarItem
  attr_accessor :contact
  attr_accessor :meetingMessage
  attr_accessor :meetingRequest
  attr_accessor :meetingResponse
  attr_accessor :meetingCancellation
  attr_accessor :task
  attr_accessor :postItem

  def initialize(attachmentId = nil, name = nil, contentType = nil, contentId = nil, contentLocation = nil, item = nil, message = nil, calendarItem = nil, contact = nil, meetingMessage = nil, meetingRequest = nil, meetingResponse = nil, meetingCancellation = nil, task = nil, postItem = nil)
    @attachmentId = attachmentId
    @name = name
    @contentType = contentType
    @contentId = contentId
    @contentLocation = contentLocation
    @item = item
    @message = message
    @calendarItem = calendarItem
    @contact = contact
    @meetingMessage = meetingMessage
    @meetingRequest = meetingRequest
    @meetingResponse = meetingResponse
    @meetingCancellation = meetingCancellation
    @task = task
    @postItem = postItem
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}FileAttachmentType
#   attachmentId - AttachmentIdType
#   name - SOAP::SOAPString
#   contentType - SOAP::SOAPString
#   contentId - SOAP::SOAPString
#   contentLocation - SOAP::SOAPString
#   content - SOAP::SOAPBase64
class FileAttachmentType < AttachmentType
  attr_accessor :attachmentId
  attr_accessor :name
  attr_accessor :contentType
  attr_accessor :contentId
  attr_accessor :contentLocation
  attr_accessor :content

  def initialize(attachmentId = nil, name = nil, contentType = nil, contentId = nil, contentLocation = nil, content = nil)
    @attachmentId = attachmentId
    @name = name
    @contentType = contentType
    @contentId = contentId
    @contentLocation = contentLocation
    @content = content
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}SyncFolderItemsCreateOrUpdateType
#   item - ItemType
#   message - MessageType
#   calendarItem - CalendarItemType
#   contact - ContactItemType
#   distributionList - DistributionListType
#   meetingMessage - MeetingMessageType
#   meetingRequest - MeetingRequestMessageType
#   meetingResponse - MeetingResponseMessageType
#   meetingCancellation - MeetingCancellationMessageType
#   task - TaskType
#   postItem - PostItemType
class SyncFolderItemsCreateOrUpdateType
  attr_accessor :item
  attr_accessor :message
  attr_accessor :calendarItem
  attr_accessor :contact
  attr_accessor :distributionList
  attr_accessor :meetingMessage
  attr_accessor :meetingRequest
  attr_accessor :meetingResponse
  attr_accessor :meetingCancellation
  attr_accessor :task
  attr_accessor :postItem

  def initialize(item = nil, message = nil, calendarItem = nil, contact = nil, distributionList = nil, meetingMessage = nil, meetingRequest = nil, meetingResponse = nil, meetingCancellation = nil, task = nil, postItem = nil)
    @item = item
    @message = message
    @calendarItem = calendarItem
    @contact = contact
    @distributionList = distributionList
    @meetingMessage = meetingMessage
    @meetingRequest = meetingRequest
    @meetingResponse = meetingResponse
    @meetingCancellation = meetingCancellation
    @task = task
    @postItem = postItem
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ArrayOfAttachmentsType
#   itemAttachment - ItemAttachmentType
#   fileAttachment - FileAttachmentType
class ArrayOfAttachmentsType
  attr_accessor :itemAttachment
  attr_accessor :fileAttachment

  def initialize(itemAttachment = [], fileAttachment = [])
    @itemAttachment = itemAttachment
    @fileAttachment = fileAttachment
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}NonEmptyArrayOfAttachmentsType
#   itemAttachment - ItemAttachmentType
#   fileAttachment - FileAttachmentType
class NonEmptyArrayOfAttachmentsType
  attr_accessor :itemAttachment
  attr_accessor :fileAttachment

  def initialize(itemAttachment = [], fileAttachment = [])
    @itemAttachment = itemAttachment
    @fileAttachment = fileAttachment
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}BodyType
#   xmlattr_BodyType - SOAP::SOAPString
class BodyType < ::String
  AttrBodyType = XSD::QName.new(nil, "BodyType")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_BodyType
    __xmlattr[AttrBodyType]
  end

  def xmlattr_BodyType=(value)
    __xmlattr[AttrBodyType] = value
  end

  def initialize(*arg)
    super
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}BaseFolderIdType
# abstract
class BaseFolderIdType
  def initialize
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}DistinguishedFolderIdType
#   mailbox - EmailAddressType
#   xmlattr_Id - SOAP::SOAPString
#   xmlattr_ChangeKey - SOAP::SOAPString
class DistinguishedFolderIdType < BaseFolderIdType
  AttrChangeKey = XSD::QName.new(nil, "ChangeKey")
  AttrId = XSD::QName.new(nil, "Id")

  attr_accessor :mailbox

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_Id
    __xmlattr[AttrId]
  end

  def xmlattr_Id=(value)
    __xmlattr[AttrId] = value
  end

  def xmlattr_ChangeKey
    __xmlattr[AttrChangeKey]
  end

  def xmlattr_ChangeKey=(value)
    __xmlattr[AttrChangeKey] = value
  end

  def initialize(mailbox = nil)
    @mailbox = mailbox
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}FolderIdType
#   xmlattr_Id - SOAP::SOAPString
#   xmlattr_ChangeKey - SOAP::SOAPString
class FolderIdType < BaseFolderIdType
  AttrChangeKey = XSD::QName.new(nil, "ChangeKey")
  AttrId = XSD::QName.new(nil, "Id")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_Id
    __xmlattr[AttrId]
  end

  def xmlattr_Id=(value)
    __xmlattr[AttrId] = value
  end

  def xmlattr_ChangeKey
    __xmlattr[AttrChangeKey]
  end

  def xmlattr_ChangeKey=(value)
    __xmlattr[AttrChangeKey] = value
  end

  def initialize
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}NonEmptyArrayOfBaseFolderIdsType
#   folderId - FolderIdType
#   distinguishedFolderId - DistinguishedFolderIdType
class NonEmptyArrayOfBaseFolderIdsType
  attr_accessor :folderId
  attr_accessor :distinguishedFolderId

  def initialize(folderId = [], distinguishedFolderId = [])
    @folderId = folderId
    @distinguishedFolderId = distinguishedFolderId
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}TargetFolderIdType
#   folderId - FolderIdType
#   distinguishedFolderId - DistinguishedFolderIdType
class TargetFolderIdType
  attr_accessor :folderId
  attr_accessor :distinguishedFolderId

  def initialize(folderId = nil, distinguishedFolderId = nil)
    @folderId = folderId
    @distinguishedFolderId = distinguishedFolderId
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}FindFolderParentType
#   folders - ArrayOfFoldersType
#   xmlattr_IndexedPagingOffset - SOAP::SOAPInt
#   xmlattr_NumeratorOffset - SOAP::SOAPInt
#   xmlattr_AbsoluteDenominator - SOAP::SOAPInt
#   xmlattr_IncludesLastItemInRange - SOAP::SOAPBoolean
#   xmlattr_TotalItemsInView - SOAP::SOAPInt
class FindFolderParentType
  AttrAbsoluteDenominator = XSD::QName.new(nil, "AbsoluteDenominator")
  AttrIncludesLastItemInRange = XSD::QName.new(nil, "IncludesLastItemInRange")
  AttrIndexedPagingOffset = XSD::QName.new(nil, "IndexedPagingOffset")
  AttrNumeratorOffset = XSD::QName.new(nil, "NumeratorOffset")
  AttrTotalItemsInView = XSD::QName.new(nil, "TotalItemsInView")

  attr_accessor :folders

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_IndexedPagingOffset
    __xmlattr[AttrIndexedPagingOffset]
  end

  def xmlattr_IndexedPagingOffset=(value)
    __xmlattr[AttrIndexedPagingOffset] = value
  end

  def xmlattr_NumeratorOffset
    __xmlattr[AttrNumeratorOffset]
  end

  def xmlattr_NumeratorOffset=(value)
    __xmlattr[AttrNumeratorOffset] = value
  end

  def xmlattr_AbsoluteDenominator
    __xmlattr[AttrAbsoluteDenominator]
  end

  def xmlattr_AbsoluteDenominator=(value)
    __xmlattr[AttrAbsoluteDenominator] = value
  end

  def xmlattr_IncludesLastItemInRange
    __xmlattr[AttrIncludesLastItemInRange]
  end

  def xmlattr_IncludesLastItemInRange=(value)
    __xmlattr[AttrIncludesLastItemInRange] = value
  end

  def xmlattr_TotalItemsInView
    __xmlattr[AttrTotalItemsInView]
  end

  def xmlattr_TotalItemsInView=(value)
    __xmlattr[AttrTotalItemsInView] = value
  end

  def initialize(folders = nil)
    @folders = folders
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}BaseFolderType
# abstract
#   folderId - FolderIdType
#   parentFolderId - FolderIdType
#   folderClass - SOAP::SOAPString
#   displayName - SOAP::SOAPString
#   totalCount - SOAP::SOAPInt
#   childFolderCount - SOAP::SOAPInt
#   extendedProperty - ExtendedPropertyType
#   managedFolderInformation - ManagedFolderInformationType
#   effectiveRights - EffectiveRightsType
class BaseFolderType
  attr_accessor :folderId
  attr_accessor :parentFolderId
  attr_accessor :folderClass
  attr_accessor :displayName
  attr_accessor :totalCount
  attr_accessor :childFolderCount
  attr_accessor :extendedProperty
  attr_accessor :managedFolderInformation
  attr_accessor :effectiveRights

  def initialize(folderId = nil, parentFolderId = nil, folderClass = nil, displayName = nil, totalCount = nil, childFolderCount = nil, extendedProperty = [], managedFolderInformation = nil, effectiveRights = nil)
    @folderId = folderId
    @parentFolderId = parentFolderId
    @folderClass = folderClass
    @displayName = displayName
    @totalCount = totalCount
    @childFolderCount = childFolderCount
    @extendedProperty = extendedProperty
    @managedFolderInformation = managedFolderInformation
    @effectiveRights = effectiveRights
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}FolderType
#   folderId - FolderIdType
#   parentFolderId - FolderIdType
#   folderClass - SOAP::SOAPString
#   displayName - SOAP::SOAPString
#   totalCount - SOAP::SOAPInt
#   childFolderCount - SOAP::SOAPInt
#   extendedProperty - ExtendedPropertyType
#   managedFolderInformation - ManagedFolderInformationType
#   effectiveRights - EffectiveRightsType
#   permissionSet - PermissionSetType
#   unreadCount - SOAP::SOAPInt
class FolderType < BaseFolderType
  attr_accessor :folderId
  attr_accessor :parentFolderId
  attr_accessor :folderClass
  attr_accessor :displayName
  attr_accessor :totalCount
  attr_accessor :childFolderCount
  attr_accessor :extendedProperty
  attr_accessor :managedFolderInformation
  attr_accessor :effectiveRights
  attr_accessor :permissionSet
  attr_accessor :unreadCount

  def initialize(folderId = nil, parentFolderId = nil, folderClass = nil, displayName = nil, totalCount = nil, childFolderCount = nil, extendedProperty = [], managedFolderInformation = nil, effectiveRights = nil, permissionSet = nil, unreadCount = nil)
    @folderId = folderId
    @parentFolderId = parentFolderId
    @folderClass = folderClass
    @displayName = displayName
    @totalCount = totalCount
    @childFolderCount = childFolderCount
    @extendedProperty = extendedProperty
    @managedFolderInformation = managedFolderInformation
    @effectiveRights = effectiveRights
    @permissionSet = permissionSet
    @unreadCount = unreadCount
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}SearchFolderType
#   folderId - FolderIdType
#   parentFolderId - FolderIdType
#   folderClass - SOAP::SOAPString
#   displayName - SOAP::SOAPString
#   totalCount - SOAP::SOAPInt
#   childFolderCount - SOAP::SOAPInt
#   extendedProperty - ExtendedPropertyType
#   managedFolderInformation - ManagedFolderInformationType
#   effectiveRights - EffectiveRightsType
#   permissionSet - PermissionSetType
#   unreadCount - SOAP::SOAPInt
#   searchParameters - SearchParametersType
class SearchFolderType < FolderType
  attr_accessor :folderId
  attr_accessor :parentFolderId
  attr_accessor :folderClass
  attr_accessor :displayName
  attr_accessor :totalCount
  attr_accessor :childFolderCount
  attr_accessor :extendedProperty
  attr_accessor :managedFolderInformation
  attr_accessor :effectiveRights
  attr_accessor :permissionSet
  attr_accessor :unreadCount
  attr_accessor :searchParameters

  def initialize(folderId = nil, parentFolderId = nil, folderClass = nil, displayName = nil, totalCount = nil, childFolderCount = nil, extendedProperty = [], managedFolderInformation = nil, effectiveRights = nil, permissionSet = nil, unreadCount = nil, searchParameters = nil)
    @folderId = folderId
    @parentFolderId = parentFolderId
    @folderClass = folderClass
    @displayName = displayName
    @totalCount = totalCount
    @childFolderCount = childFolderCount
    @extendedProperty = extendedProperty
    @managedFolderInformation = managedFolderInformation
    @effectiveRights = effectiveRights
    @permissionSet = permissionSet
    @unreadCount = unreadCount
    @searchParameters = searchParameters
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}TasksFolderType
#   folderId - FolderIdType
#   parentFolderId - FolderIdType
#   folderClass - SOAP::SOAPString
#   displayName - SOAP::SOAPString
#   totalCount - SOAP::SOAPInt
#   childFolderCount - SOAP::SOAPInt
#   extendedProperty - ExtendedPropertyType
#   managedFolderInformation - ManagedFolderInformationType
#   effectiveRights - EffectiveRightsType
#   permissionSet - PermissionSetType
#   unreadCount - SOAP::SOAPInt
class TasksFolderType < FolderType
  attr_accessor :folderId
  attr_accessor :parentFolderId
  attr_accessor :folderClass
  attr_accessor :displayName
  attr_accessor :totalCount
  attr_accessor :childFolderCount
  attr_accessor :extendedProperty
  attr_accessor :managedFolderInformation
  attr_accessor :effectiveRights
  attr_accessor :permissionSet
  attr_accessor :unreadCount

  def initialize(folderId = nil, parentFolderId = nil, folderClass = nil, displayName = nil, totalCount = nil, childFolderCount = nil, extendedProperty = [], managedFolderInformation = nil, effectiveRights = nil, permissionSet = nil, unreadCount = nil)
    @folderId = folderId
    @parentFolderId = parentFolderId
    @folderClass = folderClass
    @displayName = displayName
    @totalCount = totalCount
    @childFolderCount = childFolderCount
    @extendedProperty = extendedProperty
    @managedFolderInformation = managedFolderInformation
    @effectiveRights = effectiveRights
    @permissionSet = permissionSet
    @unreadCount = unreadCount
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}CalendarFolderType
#   folderId - FolderIdType
#   parentFolderId - FolderIdType
#   folderClass - SOAP::SOAPString
#   displayName - SOAP::SOAPString
#   totalCount - SOAP::SOAPInt
#   childFolderCount - SOAP::SOAPInt
#   extendedProperty - ExtendedPropertyType
#   managedFolderInformation - ManagedFolderInformationType
#   effectiveRights - EffectiveRightsType
#   permissionSet - CalendarPermissionSetType
class CalendarFolderType < BaseFolderType
  attr_accessor :folderId
  attr_accessor :parentFolderId
  attr_accessor :folderClass
  attr_accessor :displayName
  attr_accessor :totalCount
  attr_accessor :childFolderCount
  attr_accessor :extendedProperty
  attr_accessor :managedFolderInformation
  attr_accessor :effectiveRights
  attr_accessor :permissionSet

  def initialize(folderId = nil, parentFolderId = nil, folderClass = nil, displayName = nil, totalCount = nil, childFolderCount = nil, extendedProperty = [], managedFolderInformation = nil, effectiveRights = nil, permissionSet = nil)
    @folderId = folderId
    @parentFolderId = parentFolderId
    @folderClass = folderClass
    @displayName = displayName
    @totalCount = totalCount
    @childFolderCount = childFolderCount
    @extendedProperty = extendedProperty
    @managedFolderInformation = managedFolderInformation
    @effectiveRights = effectiveRights
    @permissionSet = permissionSet
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ContactsFolderType
#   folderId - FolderIdType
#   parentFolderId - FolderIdType
#   folderClass - SOAP::SOAPString
#   displayName - SOAP::SOAPString
#   totalCount - SOAP::SOAPInt
#   childFolderCount - SOAP::SOAPInt
#   extendedProperty - ExtendedPropertyType
#   managedFolderInformation - ManagedFolderInformationType
#   effectiveRights - EffectiveRightsType
#   permissionSet - PermissionSetType
class ContactsFolderType < BaseFolderType
  attr_accessor :folderId
  attr_accessor :parentFolderId
  attr_accessor :folderClass
  attr_accessor :displayName
  attr_accessor :totalCount
  attr_accessor :childFolderCount
  attr_accessor :extendedProperty
  attr_accessor :managedFolderInformation
  attr_accessor :effectiveRights
  attr_accessor :permissionSet

  def initialize(folderId = nil, parentFolderId = nil, folderClass = nil, displayName = nil, totalCount = nil, childFolderCount = nil, extendedProperty = [], managedFolderInformation = nil, effectiveRights = nil, permissionSet = nil)
    @folderId = folderId
    @parentFolderId = parentFolderId
    @folderClass = folderClass
    @displayName = displayName
    @totalCount = totalCount
    @childFolderCount = childFolderCount
    @extendedProperty = extendedProperty
    @managedFolderInformation = managedFolderInformation
    @effectiveRights = effectiveRights
    @permissionSet = permissionSet
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ManagedFolderInformationType
#   canDelete - SOAP::SOAPBoolean
#   canRenameOrMove - SOAP::SOAPBoolean
#   mustDisplayComment - SOAP::SOAPBoolean
#   hasQuota - SOAP::SOAPBoolean
#   isManagedFoldersRoot - SOAP::SOAPBoolean
#   managedFolderId - SOAP::SOAPString
#   comment - SOAP::SOAPString
#   storageQuota - SOAP::SOAPInt
#   folderSize - SOAP::SOAPInt
#   homePage - SOAP::SOAPString
class ManagedFolderInformationType
  attr_accessor :canDelete
  attr_accessor :canRenameOrMove
  attr_accessor :mustDisplayComment
  attr_accessor :hasQuota
  attr_accessor :isManagedFoldersRoot
  attr_accessor :managedFolderId
  attr_accessor :comment
  attr_accessor :storageQuota
  attr_accessor :folderSize
  attr_accessor :homePage

  def initialize(canDelete = nil, canRenameOrMove = nil, mustDisplayComment = nil, hasQuota = nil, isManagedFoldersRoot = nil, managedFolderId = nil, comment = nil, storageQuota = nil, folderSize = nil, homePage = nil)
    @canDelete = canDelete
    @canRenameOrMove = canRenameOrMove
    @mustDisplayComment = mustDisplayComment
    @hasQuota = hasQuota
    @isManagedFoldersRoot = isManagedFoldersRoot
    @managedFolderId = managedFolderId
    @comment = comment
    @storageQuota = storageQuota
    @folderSize = folderSize
    @homePage = homePage
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}NonEmptyArrayOfFoldersType
#   folder - FolderType
#   calendarFolder - CalendarFolderType
#   contactsFolder - ContactsFolderType
#   searchFolder - SearchFolderType
#   tasksFolder - TasksFolderType
class NonEmptyArrayOfFoldersType
  attr_accessor :folder
  attr_accessor :calendarFolder
  attr_accessor :contactsFolder
  attr_accessor :searchFolder
  attr_accessor :tasksFolder

  def initialize(folder = [], calendarFolder = [], contactsFolder = [], searchFolder = [], tasksFolder = [])
    @folder = folder
    @calendarFolder = calendarFolder
    @contactsFolder = contactsFolder
    @searchFolder = searchFolder
    @tasksFolder = tasksFolder
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ArrayOfFoldersType
#   folder - FolderType
#   calendarFolder - CalendarFolderType
#   contactsFolder - ContactsFolderType
#   searchFolder - SearchFolderType
#   tasksFolder - TasksFolderType
class ArrayOfFoldersType
  attr_accessor :folder
  attr_accessor :calendarFolder
  attr_accessor :contactsFolder
  attr_accessor :searchFolder
  attr_accessor :tasksFolder

  def initialize(folder = [], calendarFolder = [], contactsFolder = [], searchFolder = [], tasksFolder = [])
    @folder = folder
    @calendarFolder = calendarFolder
    @contactsFolder = contactsFolder
    @searchFolder = searchFolder
    @tasksFolder = tasksFolder
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}BaseItemIdType
# abstract
class BaseItemIdType
  def initialize
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}RequestAttachmentIdType
#   xmlattr_Id - SOAP::SOAPString
class RequestAttachmentIdType < BaseItemIdType
  AttrId = XSD::QName.new(nil, "Id")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_Id
    __xmlattr[AttrId]
  end

  def xmlattr_Id=(value)
    __xmlattr[AttrId] = value
  end

  def initialize
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}AttachmentIdType
#   xmlattr_Id - SOAP::SOAPString
#   xmlattr_RootItemId - SOAP::SOAPString
#   xmlattr_RootItemChangeKey - SOAP::SOAPString
class AttachmentIdType < RequestAttachmentIdType
  AttrId = XSD::QName.new(nil, "Id")
  AttrRootItemChangeKey = XSD::QName.new(nil, "RootItemChangeKey")
  AttrRootItemId = XSD::QName.new(nil, "RootItemId")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_Id
    __xmlattr[AttrId]
  end

  def xmlattr_Id=(value)
    __xmlattr[AttrId] = value
  end

  def xmlattr_RootItemId
    __xmlattr[AttrRootItemId]
  end

  def xmlattr_RootItemId=(value)
    __xmlattr[AttrRootItemId] = value
  end

  def xmlattr_RootItemChangeKey
    __xmlattr[AttrRootItemChangeKey]
  end

  def xmlattr_RootItemChangeKey=(value)
    __xmlattr[AttrRootItemChangeKey] = value
  end

  def initialize
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}RootItemIdType
#   xmlattr_RootItemId - SOAP::SOAPString
#   xmlattr_RootItemChangeKey - SOAP::SOAPString
class RootItemIdType < BaseItemIdType
  AttrRootItemChangeKey = XSD::QName.new(nil, "RootItemChangeKey")
  AttrRootItemId = XSD::QName.new(nil, "RootItemId")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_RootItemId
    __xmlattr[AttrRootItemId]
  end

  def xmlattr_RootItemId=(value)
    __xmlattr[AttrRootItemId] = value
  end

  def xmlattr_RootItemChangeKey
    __xmlattr[AttrRootItemChangeKey]
  end

  def xmlattr_RootItemChangeKey=(value)
    __xmlattr[AttrRootItemChangeKey] = value
  end

  def initialize
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ItemIdType
#   xmlattr_Id - SOAP::SOAPString
#   xmlattr_ChangeKey - SOAP::SOAPString
class ItemIdType < BaseItemIdType
  AttrChangeKey = XSD::QName.new(nil, "ChangeKey")
  AttrId = XSD::QName.new(nil, "Id")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_Id
    __xmlattr[AttrId]
  end

  def xmlattr_Id=(value)
    __xmlattr[AttrId] = value
  end

  def xmlattr_ChangeKey
    __xmlattr[AttrChangeKey]
  end

  def xmlattr_ChangeKey=(value)
    __xmlattr[AttrChangeKey] = value
  end

  def initialize
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}OccurrenceItemIdType
#   xmlattr_RecurringMasterId - SOAP::SOAPString
#   xmlattr_ChangeKey - SOAP::SOAPString
#   xmlattr_InstanceIndex - SOAP::SOAPInt
class OccurrenceItemIdType < BaseItemIdType
  AttrChangeKey = XSD::QName.new(nil, "ChangeKey")
  AttrInstanceIndex = XSD::QName.new(nil, "InstanceIndex")
  AttrRecurringMasterId = XSD::QName.new(nil, "RecurringMasterId")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_RecurringMasterId
    __xmlattr[AttrRecurringMasterId]
  end

  def xmlattr_RecurringMasterId=(value)
    __xmlattr[AttrRecurringMasterId] = value
  end

  def xmlattr_ChangeKey
    __xmlattr[AttrChangeKey]
  end

  def xmlattr_ChangeKey=(value)
    __xmlattr[AttrChangeKey] = value
  end

  def xmlattr_InstanceIndex
    __xmlattr[AttrInstanceIndex]
  end

  def xmlattr_InstanceIndex=(value)
    __xmlattr[AttrInstanceIndex] = value
  end

  def initialize
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}RecurringMasterItemIdType
#   xmlattr_OccurrenceId - SOAP::SOAPString
#   xmlattr_ChangeKey - SOAP::SOAPString
class RecurringMasterItemIdType < BaseItemIdType
  AttrChangeKey = XSD::QName.new(nil, "ChangeKey")
  AttrOccurrenceId = XSD::QName.new(nil, "OccurrenceId")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_OccurrenceId
    __xmlattr[AttrOccurrenceId]
  end

  def xmlattr_OccurrenceId=(value)
    __xmlattr[AttrOccurrenceId] = value
  end

  def xmlattr_ChangeKey
    __xmlattr[AttrChangeKey]
  end

  def xmlattr_ChangeKey=(value)
    __xmlattr[AttrChangeKey] = value
  end

  def initialize
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}NonEmptyArrayOfBaseItemIdsType
#   itemId - ItemIdType
#   occurrenceItemId - OccurrenceItemIdType
#   recurringMasterItemId - RecurringMasterItemIdType
class NonEmptyArrayOfBaseItemIdsType
  attr_accessor :itemId
  attr_accessor :occurrenceItemId
  attr_accessor :recurringMasterItemId

  def initialize(itemId = [], occurrenceItemId = [], recurringMasterItemId = [])
    @itemId = itemId
    @occurrenceItemId = occurrenceItemId
    @recurringMasterItemId = recurringMasterItemId
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ArrayOfBaseItemIdsType
class ArrayOfBaseItemIdsType < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}NonEmptyArrayOfResponseObjectsType
#   acceptItem - AcceptItemType
#   tentativelyAcceptItem - TentativelyAcceptItemType
#   declineItem - DeclineItemType
#   replyToItem - ReplyToItemType
#   forwardItem - ForwardItemType
#   replyAllToItem - ReplyAllToItemType
#   cancelCalendarItem - CancelCalendarItemType
#   removeItem - RemoveItemType
#   suppressReadReceipt - SuppressReadReceiptType
#   postReplyItem - PostReplyItemType
class NonEmptyArrayOfResponseObjectsType
  attr_accessor :acceptItem
  attr_accessor :tentativelyAcceptItem
  attr_accessor :declineItem
  attr_accessor :replyToItem
  attr_accessor :forwardItem
  attr_accessor :replyAllToItem
  attr_accessor :cancelCalendarItem
  attr_accessor :removeItem
  attr_accessor :suppressReadReceipt
  attr_accessor :postReplyItem

  def initialize(acceptItem = [], tentativelyAcceptItem = [], declineItem = [], replyToItem = [], forwardItem = [], replyAllToItem = [], cancelCalendarItem = [], removeItem = [], suppressReadReceipt = [], postReplyItem = [])
    @acceptItem = acceptItem
    @tentativelyAcceptItem = tentativelyAcceptItem
    @declineItem = declineItem
    @replyToItem = replyToItem
    @forwardItem = forwardItem
    @replyAllToItem = replyAllToItem
    @cancelCalendarItem = cancelCalendarItem
    @removeItem = removeItem
    @suppressReadReceipt = suppressReadReceipt
    @postReplyItem = postReplyItem
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}FolderChangeType
#   folderId - FolderIdType
#   distinguishedFolderId - DistinguishedFolderIdType
#   updates - NonEmptyArrayOfFolderChangeDescriptionsType
class FolderChangeType
  attr_accessor :folderId
  attr_accessor :distinguishedFolderId
  attr_accessor :updates

  def initialize(folderId = nil, distinguishedFolderId = nil, updates = nil)
    @folderId = folderId
    @distinguishedFolderId = distinguishedFolderId
    @updates = updates
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}NonEmptyArrayOfFolderChangesType
class NonEmptyArrayOfFolderChangesType < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}FindItemParentType
#   items - ArrayOfRealItemsType
#   groups - ArrayOfGroupedItemsType
#   xmlattr_IndexedPagingOffset - SOAP::SOAPInt
#   xmlattr_NumeratorOffset - SOAP::SOAPInt
#   xmlattr_AbsoluteDenominator - SOAP::SOAPInt
#   xmlattr_IncludesLastItemInRange - SOAP::SOAPBoolean
#   xmlattr_TotalItemsInView - SOAP::SOAPInt
class FindItemParentType
  AttrAbsoluteDenominator = XSD::QName.new(nil, "AbsoluteDenominator")
  AttrIncludesLastItemInRange = XSD::QName.new(nil, "IncludesLastItemInRange")
  AttrIndexedPagingOffset = XSD::QName.new(nil, "IndexedPagingOffset")
  AttrNumeratorOffset = XSD::QName.new(nil, "NumeratorOffset")
  AttrTotalItemsInView = XSD::QName.new(nil, "TotalItemsInView")

  attr_accessor :items
  attr_accessor :groups

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_IndexedPagingOffset
    __xmlattr[AttrIndexedPagingOffset]
  end

  def xmlattr_IndexedPagingOffset=(value)
    __xmlattr[AttrIndexedPagingOffset] = value
  end

  def xmlattr_NumeratorOffset
    __xmlattr[AttrNumeratorOffset]
  end

  def xmlattr_NumeratorOffset=(value)
    __xmlattr[AttrNumeratorOffset] = value
  end

  def xmlattr_AbsoluteDenominator
    __xmlattr[AttrAbsoluteDenominator]
  end

  def xmlattr_AbsoluteDenominator=(value)
    __xmlattr[AttrAbsoluteDenominator] = value
  end

  def xmlattr_IncludesLastItemInRange
    __xmlattr[AttrIncludesLastItemInRange]
  end

  def xmlattr_IncludesLastItemInRange=(value)
    __xmlattr[AttrIncludesLastItemInRange] = value
  end

  def xmlattr_TotalItemsInView
    __xmlattr[AttrTotalItemsInView]
  end

  def xmlattr_TotalItemsInView=(value)
    __xmlattr[AttrTotalItemsInView] = value
  end

  def initialize(items = nil, groups = nil)
    @items = items
    @groups = groups
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ItemType
#   mimeContent - MimeContentType
#   itemId - ItemIdType
#   parentFolderId - FolderIdType
#   itemClass - (any)
#   subject - SOAP::SOAPString
#   sensitivity - SensitivityChoicesType
#   body - BodyType
#   attachments - NonEmptyArrayOfAttachmentsType
#   dateTimeReceived - SOAP::SOAPDateTime
#   size - SOAP::SOAPInt
#   categories - ArrayOfStringsType
#   importance - ImportanceChoicesType
#   inReplyTo - SOAP::SOAPString
#   isSubmitted - SOAP::SOAPBoolean
#   isDraft - SOAP::SOAPBoolean
#   isFromMe - SOAP::SOAPBoolean
#   isResend - SOAP::SOAPBoolean
#   isUnmodified - SOAP::SOAPBoolean
#   internetMessageHeaders - NonEmptyArrayOfInternetHeadersType
#   dateTimeSent - SOAP::SOAPDateTime
#   dateTimeCreated - SOAP::SOAPDateTime
#   responseObjects - NonEmptyArrayOfResponseObjectsType
#   reminderDueBy - SOAP::SOAPDateTime
#   reminderIsSet - SOAP::SOAPBoolean
#   reminderMinutesBeforeStart - (any)
#   displayCc - SOAP::SOAPString
#   displayTo - SOAP::SOAPString
#   hasAttachments - SOAP::SOAPBoolean
#   extendedProperty - ExtendedPropertyType
#   culture - SOAP::SOAPLanguage
#   effectiveRights - EffectiveRightsType
#   lastModifiedName - SOAP::SOAPString
#   lastModifiedTime - SOAP::SOAPDateTime
class ItemType
  attr_accessor :mimeContent
  attr_accessor :itemId
  attr_accessor :parentFolderId
  attr_accessor :itemClass
  attr_accessor :subject
  attr_accessor :sensitivity
  attr_accessor :body
  attr_accessor :attachments
  attr_accessor :dateTimeReceived
  attr_accessor :size
  attr_accessor :categories
  attr_accessor :importance
  attr_accessor :inReplyTo
  attr_accessor :isSubmitted
  attr_accessor :isDraft
  attr_accessor :isFromMe
  attr_accessor :isResend
  attr_accessor :isUnmodified
  attr_accessor :internetMessageHeaders
  attr_accessor :dateTimeSent
  attr_accessor :dateTimeCreated
  attr_accessor :responseObjects
  attr_accessor :reminderDueBy
  attr_accessor :reminderIsSet
  attr_accessor :reminderMinutesBeforeStart
  attr_accessor :displayCc
  attr_accessor :displayTo
  attr_accessor :hasAttachments
  attr_accessor :extendedProperty
  attr_accessor :culture
  attr_accessor :effectiveRights
  attr_accessor :lastModifiedName
  attr_accessor :lastModifiedTime

  def initialize(mimeContent = nil, itemId = nil, parentFolderId = nil, itemClass = nil, subject = nil, sensitivity = nil, body = nil, attachments = nil, dateTimeReceived = nil, size = nil, categories = nil, importance = nil, inReplyTo = nil, isSubmitted = nil, isDraft = nil, isFromMe = nil, isResend = nil, isUnmodified = nil, internetMessageHeaders = nil, dateTimeSent = nil, dateTimeCreated = nil, responseObjects = nil, reminderDueBy = nil, reminderIsSet = nil, reminderMinutesBeforeStart = nil, displayCc = nil, displayTo = nil, hasAttachments = nil, extendedProperty = [], culture = nil, effectiveRights = nil, lastModifiedName = nil, lastModifiedTime = nil)
    @mimeContent = mimeContent
    @itemId = itemId
    @parentFolderId = parentFolderId
    @itemClass = itemClass
    @subject = subject
    @sensitivity = sensitivity
    @body = body
    @attachments = attachments
    @dateTimeReceived = dateTimeReceived
    @size = size
    @categories = categories
    @importance = importance
    @inReplyTo = inReplyTo
    @isSubmitted = isSubmitted
    @isDraft = isDraft
    @isFromMe = isFromMe
    @isResend = isResend
    @isUnmodified = isUnmodified
    @internetMessageHeaders = internetMessageHeaders
    @dateTimeSent = dateTimeSent
    @dateTimeCreated = dateTimeCreated
    @responseObjects = responseObjects
    @reminderDueBy = reminderDueBy
    @reminderIsSet = reminderIsSet
    @reminderMinutesBeforeStart = reminderMinutesBeforeStart
    @displayCc = displayCc
    @displayTo = displayTo
    @hasAttachments = hasAttachments
    @extendedProperty = extendedProperty
    @culture = culture
    @effectiveRights = effectiveRights
    @lastModifiedName = lastModifiedName
    @lastModifiedTime = lastModifiedTime
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}MessageType
#   mimeContent - MimeContentType
#   itemId - ItemIdType
#   parentFolderId - FolderIdType
#   itemClass - (any)
#   subject - SOAP::SOAPString
#   sensitivity - SensitivityChoicesType
#   body - BodyType
#   attachments - NonEmptyArrayOfAttachmentsType
#   dateTimeReceived - SOAP::SOAPDateTime
#   size - SOAP::SOAPInt
#   categories - ArrayOfStringsType
#   importance - ImportanceChoicesType
#   inReplyTo - SOAP::SOAPString
#   isSubmitted - SOAP::SOAPBoolean
#   isDraft - SOAP::SOAPBoolean
#   isFromMe - SOAP::SOAPBoolean
#   isResend - SOAP::SOAPBoolean
#   isUnmodified - SOAP::SOAPBoolean
#   internetMessageHeaders - NonEmptyArrayOfInternetHeadersType
#   dateTimeSent - SOAP::SOAPDateTime
#   dateTimeCreated - SOAP::SOAPDateTime
#   responseObjects - NonEmptyArrayOfResponseObjectsType
#   reminderDueBy - SOAP::SOAPDateTime
#   reminderIsSet - SOAP::SOAPBoolean
#   reminderMinutesBeforeStart - (any)
#   displayCc - SOAP::SOAPString
#   displayTo - SOAP::SOAPString
#   hasAttachments - SOAP::SOAPBoolean
#   extendedProperty - ExtendedPropertyType
#   culture - SOAP::SOAPLanguage
#   effectiveRights - EffectiveRightsType
#   lastModifiedName - SOAP::SOAPString
#   lastModifiedTime - SOAP::SOAPDateTime
#   sender - SingleRecipientType
#   toRecipients - ArrayOfRecipientsType
#   ccRecipients - ArrayOfRecipientsType
#   bccRecipients - ArrayOfRecipientsType
#   isReadReceiptRequested - SOAP::SOAPBoolean
#   isDeliveryReceiptRequested - SOAP::SOAPBoolean
#   conversationIndex - SOAP::SOAPBase64
#   conversationTopic - SOAP::SOAPString
#   from - SingleRecipientType
#   internetMessageId - SOAP::SOAPString
#   isRead - SOAP::SOAPBoolean
#   isResponseRequested - SOAP::SOAPBoolean
#   references - SOAP::SOAPString
#   replyTo - ArrayOfRecipientsType
#   receivedBy - SingleRecipientType
#   receivedRepresenting - SingleRecipientType
class MessageType < ItemType
  attr_accessor :mimeContent
  attr_accessor :itemId
  attr_accessor :parentFolderId
  attr_accessor :itemClass
  attr_accessor :subject
  attr_accessor :sensitivity
  attr_accessor :body
  attr_accessor :attachments
  attr_accessor :dateTimeReceived
  attr_accessor :size
  attr_accessor :categories
  attr_accessor :importance
  attr_accessor :inReplyTo
  attr_accessor :isSubmitted
  attr_accessor :isDraft
  attr_accessor :isFromMe
  attr_accessor :isResend
  attr_accessor :isUnmodified
  attr_accessor :internetMessageHeaders
  attr_accessor :dateTimeSent
  attr_accessor :dateTimeCreated
  attr_accessor :responseObjects
  attr_accessor :reminderDueBy
  attr_accessor :reminderIsSet
  attr_accessor :reminderMinutesBeforeStart
  attr_accessor :displayCc
  attr_accessor :displayTo
  attr_accessor :hasAttachments
  attr_accessor :extendedProperty
  attr_accessor :culture
  attr_accessor :effectiveRights
  attr_accessor :lastModifiedName
  attr_accessor :lastModifiedTime
  attr_accessor :sender
  attr_accessor :toRecipients
  attr_accessor :ccRecipients
  attr_accessor :bccRecipients
  attr_accessor :isReadReceiptRequested
  attr_accessor :isDeliveryReceiptRequested
  attr_accessor :conversationIndex
  attr_accessor :conversationTopic
  attr_accessor :from
  attr_accessor :internetMessageId
  attr_accessor :isRead
  attr_accessor :isResponseRequested
  attr_accessor :references
  attr_accessor :replyTo
  attr_accessor :receivedBy
  attr_accessor :receivedRepresenting

  def initialize(mimeContent = nil, itemId = nil, parentFolderId = nil, itemClass = nil, subject = nil, sensitivity = nil, body = nil, attachments = nil, dateTimeReceived = nil, size = nil, categories = nil, importance = nil, inReplyTo = nil, isSubmitted = nil, isDraft = nil, isFromMe = nil, isResend = nil, isUnmodified = nil, internetMessageHeaders = nil, dateTimeSent = nil, dateTimeCreated = nil, responseObjects = nil, reminderDueBy = nil, reminderIsSet = nil, reminderMinutesBeforeStart = nil, displayCc = nil, displayTo = nil, hasAttachments = nil, extendedProperty = [], culture = nil, effectiveRights = nil, lastModifiedName = nil, lastModifiedTime = nil, sender = nil, toRecipients = nil, ccRecipients = nil, bccRecipients = nil, isReadReceiptRequested = nil, isDeliveryReceiptRequested = nil, conversationIndex = nil, conversationTopic = nil, from = nil, internetMessageId = nil, isRead = nil, isResponseRequested = nil, references = nil, replyTo = nil, receivedBy = nil, receivedRepresenting = nil)
    @mimeContent = mimeContent
    @itemId = itemId
    @parentFolderId = parentFolderId
    @itemClass = itemClass
    @subject = subject
    @sensitivity = sensitivity
    @body = body
    @attachments = attachments
    @dateTimeReceived = dateTimeReceived
    @size = size
    @categories = categories
    @importance = importance
    @inReplyTo = inReplyTo
    @isSubmitted = isSubmitted
    @isDraft = isDraft
    @isFromMe = isFromMe
    @isResend = isResend
    @isUnmodified = isUnmodified
    @internetMessageHeaders = internetMessageHeaders
    @dateTimeSent = dateTimeSent
    @dateTimeCreated = dateTimeCreated
    @responseObjects = responseObjects
    @reminderDueBy = reminderDueBy
    @reminderIsSet = reminderIsSet
    @reminderMinutesBeforeStart = reminderMinutesBeforeStart
    @displayCc = displayCc
    @displayTo = displayTo
    @hasAttachments = hasAttachments
    @extendedProperty = extendedProperty
    @culture = culture
    @effectiveRights = effectiveRights
    @lastModifiedName = lastModifiedName
    @lastModifiedTime = lastModifiedTime
    @sender = sender
    @toRecipients = toRecipients
    @ccRecipients = ccRecipients
    @bccRecipients = bccRecipients
    @isReadReceiptRequested = isReadReceiptRequested
    @isDeliveryReceiptRequested = isDeliveryReceiptRequested
    @conversationIndex = conversationIndex
    @conversationTopic = conversationTopic
    @from = from
    @internetMessageId = internetMessageId
    @isRead = isRead
    @isResponseRequested = isResponseRequested
    @references = references
    @replyTo = replyTo
    @receivedBy = receivedBy
    @receivedRepresenting = receivedRepresenting
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ResponseObjectCoreType
# abstract
#   mimeContent - MimeContentType
#   itemId - ItemIdType
#   parentFolderId - FolderIdType
#   itemClass - (any)
#   subject - SOAP::SOAPString
#   sensitivity - SensitivityChoicesType
#   body - BodyType
#   attachments - NonEmptyArrayOfAttachmentsType
#   dateTimeReceived - SOAP::SOAPDateTime
#   size - SOAP::SOAPInt
#   categories - ArrayOfStringsType
#   importance - ImportanceChoicesType
#   inReplyTo - SOAP::SOAPString
#   isSubmitted - SOAP::SOAPBoolean
#   isDraft - SOAP::SOAPBoolean
#   isFromMe - SOAP::SOAPBoolean
#   isResend - SOAP::SOAPBoolean
#   isUnmodified - SOAP::SOAPBoolean
#   internetMessageHeaders - NonEmptyArrayOfInternetHeadersType
#   dateTimeSent - SOAP::SOAPDateTime
#   dateTimeCreated - SOAP::SOAPDateTime
#   responseObjects - NonEmptyArrayOfResponseObjectsType
#   reminderDueBy - SOAP::SOAPDateTime
#   reminderIsSet - SOAP::SOAPBoolean
#   reminderMinutesBeforeStart - (any)
#   displayCc - SOAP::SOAPString
#   displayTo - SOAP::SOAPString
#   hasAttachments - SOAP::SOAPBoolean
#   extendedProperty - ExtendedPropertyType
#   culture - SOAP::SOAPLanguage
#   effectiveRights - EffectiveRightsType
#   lastModifiedName - SOAP::SOAPString
#   lastModifiedTime - SOAP::SOAPDateTime
#   sender - SingleRecipientType
#   toRecipients - ArrayOfRecipientsType
#   ccRecipients - ArrayOfRecipientsType
#   bccRecipients - ArrayOfRecipientsType
#   isReadReceiptRequested - SOAP::SOAPBoolean
#   isDeliveryReceiptRequested - SOAP::SOAPBoolean
#   conversationIndex - SOAP::SOAPBase64
#   conversationTopic - SOAP::SOAPString
#   from - SingleRecipientType
#   internetMessageId - SOAP::SOAPString
#   isRead - SOAP::SOAPBoolean
#   isResponseRequested - SOAP::SOAPBoolean
#   references - SOAP::SOAPString
#   replyTo - ArrayOfRecipientsType
#   receivedBy - SingleRecipientType
#   receivedRepresenting - SingleRecipientType
#   referenceItemId - ItemIdType
class ResponseObjectCoreType < MessageType
  attr_accessor :mimeContent
  attr_accessor :itemId
  attr_accessor :parentFolderId
  attr_accessor :itemClass
  attr_accessor :subject
  attr_accessor :sensitivity
  attr_accessor :body
  attr_accessor :attachments
  attr_accessor :dateTimeReceived
  attr_accessor :size
  attr_accessor :categories
  attr_accessor :importance
  attr_accessor :inReplyTo
  attr_accessor :isSubmitted
  attr_accessor :isDraft
  attr_accessor :isFromMe
  attr_accessor :isResend
  attr_accessor :isUnmodified
  attr_accessor :internetMessageHeaders
  attr_accessor :dateTimeSent
  attr_accessor :dateTimeCreated
  attr_accessor :responseObjects
  attr_accessor :reminderDueBy
  attr_accessor :reminderIsSet
  attr_accessor :reminderMinutesBeforeStart
  attr_accessor :displayCc
  attr_accessor :displayTo
  attr_accessor :hasAttachments
  attr_accessor :extendedProperty
  attr_accessor :culture
  attr_accessor :effectiveRights
  attr_accessor :lastModifiedName
  attr_accessor :lastModifiedTime
  attr_accessor :sender
  attr_accessor :toRecipients
  attr_accessor :ccRecipients
  attr_accessor :bccRecipients
  attr_accessor :isReadReceiptRequested
  attr_accessor :isDeliveryReceiptRequested
  attr_accessor :conversationIndex
  attr_accessor :conversationTopic
  attr_accessor :from
  attr_accessor :internetMessageId
  attr_accessor :isRead
  attr_accessor :isResponseRequested
  attr_accessor :references
  attr_accessor :replyTo
  attr_accessor :receivedBy
  attr_accessor :receivedRepresenting
  attr_accessor :referenceItemId

  def initialize(mimeContent = nil, itemId = nil, parentFolderId = nil, itemClass = nil, subject = nil, sensitivity = nil, body = nil, attachments = nil, dateTimeReceived = nil, size = nil, categories = nil, importance = nil, inReplyTo = nil, isSubmitted = nil, isDraft = nil, isFromMe = nil, isResend = nil, isUnmodified = nil, internetMessageHeaders = nil, dateTimeSent = nil, dateTimeCreated = nil, responseObjects = nil, reminderDueBy = nil, reminderIsSet = nil, reminderMinutesBeforeStart = nil, displayCc = nil, displayTo = nil, hasAttachments = nil, extendedProperty = [], culture = nil, effectiveRights = nil, lastModifiedName = nil, lastModifiedTime = nil, sender = nil, toRecipients = nil, ccRecipients = nil, bccRecipients = nil, isReadReceiptRequested = nil, isDeliveryReceiptRequested = nil, conversationIndex = nil, conversationTopic = nil, from = nil, internetMessageId = nil, isRead = nil, isResponseRequested = nil, references = nil, replyTo = nil, receivedBy = nil, receivedRepresenting = nil, referenceItemId = nil)
    @mimeContent = mimeContent
    @itemId = itemId
    @parentFolderId = parentFolderId
    @itemClass = itemClass
    @subject = subject
    @sensitivity = sensitivity
    @body = body
    @attachments = attachments
    @dateTimeReceived = dateTimeReceived
    @size = size
    @categories = categories
    @importance = importance
    @inReplyTo = inReplyTo
    @isSubmitted = isSubmitted
    @isDraft = isDraft
    @isFromMe = isFromMe
    @isResend = isResend
    @isUnmodified = isUnmodified
    @internetMessageHeaders = internetMessageHeaders
    @dateTimeSent = dateTimeSent
    @dateTimeCreated = dateTimeCreated
    @responseObjects = responseObjects
    @reminderDueBy = reminderDueBy
    @reminderIsSet = reminderIsSet
    @reminderMinutesBeforeStart = reminderMinutesBeforeStart
    @displayCc = displayCc
    @displayTo = displayTo
    @hasAttachments = hasAttachments
    @extendedProperty = extendedProperty
    @culture = culture
    @effectiveRights = effectiveRights
    @lastModifiedName = lastModifiedName
    @lastModifiedTime = lastModifiedTime
    @sender = sender
    @toRecipients = toRecipients
    @ccRecipients = ccRecipients
    @bccRecipients = bccRecipients
    @isReadReceiptRequested = isReadReceiptRequested
    @isDeliveryReceiptRequested = isDeliveryReceiptRequested
    @conversationIndex = conversationIndex
    @conversationTopic = conversationTopic
    @from = from
    @internetMessageId = internetMessageId
    @isRead = isRead
    @isResponseRequested = isResponseRequested
    @references = references
    @replyTo = replyTo
    @receivedBy = receivedBy
    @receivedRepresenting = receivedRepresenting
    @referenceItemId = referenceItemId
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ResponseObjectType
# abstract
#   mimeContent - MimeContentType
#   itemId - ItemIdType
#   parentFolderId - FolderIdType
#   itemClass - (any)
#   subject - SOAP::SOAPString
#   sensitivity - SensitivityChoicesType
#   body - BodyType
#   attachments - NonEmptyArrayOfAttachmentsType
#   dateTimeReceived - SOAP::SOAPDateTime
#   size - SOAP::SOAPInt
#   categories - ArrayOfStringsType
#   importance - ImportanceChoicesType
#   inReplyTo - SOAP::SOAPString
#   isSubmitted - SOAP::SOAPBoolean
#   isDraft - SOAP::SOAPBoolean
#   isFromMe - SOAP::SOAPBoolean
#   isResend - SOAP::SOAPBoolean
#   isUnmodified - SOAP::SOAPBoolean
#   internetMessageHeaders - NonEmptyArrayOfInternetHeadersType
#   dateTimeSent - SOAP::SOAPDateTime
#   dateTimeCreated - SOAP::SOAPDateTime
#   responseObjects - NonEmptyArrayOfResponseObjectsType
#   reminderDueBy - SOAP::SOAPDateTime
#   reminderIsSet - SOAP::SOAPBoolean
#   reminderMinutesBeforeStart - (any)
#   displayCc - SOAP::SOAPString
#   displayTo - SOAP::SOAPString
#   hasAttachments - SOAP::SOAPBoolean
#   extendedProperty - ExtendedPropertyType
#   culture - SOAP::SOAPLanguage
#   effectiveRights - EffectiveRightsType
#   lastModifiedName - SOAP::SOAPString
#   lastModifiedTime - SOAP::SOAPDateTime
#   sender - SingleRecipientType
#   toRecipients - ArrayOfRecipientsType
#   ccRecipients - ArrayOfRecipientsType
#   bccRecipients - ArrayOfRecipientsType
#   isReadReceiptRequested - SOAP::SOAPBoolean
#   isDeliveryReceiptRequested - SOAP::SOAPBoolean
#   conversationIndex - SOAP::SOAPBase64
#   conversationTopic - SOAP::SOAPString
#   from - SingleRecipientType
#   internetMessageId - SOAP::SOAPString
#   isRead - SOAP::SOAPBoolean
#   isResponseRequested - SOAP::SOAPBoolean
#   references - SOAP::SOAPString
#   replyTo - ArrayOfRecipientsType
#   receivedBy - SingleRecipientType
#   receivedRepresenting - SingleRecipientType
#   referenceItemId - ItemIdType
#   xmlattr_ObjectName - SOAP::SOAPString
class ResponseObjectType < ResponseObjectCoreType
  AttrObjectName = XSD::QName.new(nil, "ObjectName")

  attr_accessor :mimeContent
  attr_accessor :itemId
  attr_accessor :parentFolderId
  attr_accessor :itemClass
  attr_accessor :subject
  attr_accessor :sensitivity
  attr_accessor :body
  attr_accessor :attachments
  attr_accessor :dateTimeReceived
  attr_accessor :size
  attr_accessor :categories
  attr_accessor :importance
  attr_accessor :inReplyTo
  attr_accessor :isSubmitted
  attr_accessor :isDraft
  attr_accessor :isFromMe
  attr_accessor :isResend
  attr_accessor :isUnmodified
  attr_accessor :internetMessageHeaders
  attr_accessor :dateTimeSent
  attr_accessor :dateTimeCreated
  attr_accessor :responseObjects
  attr_accessor :reminderDueBy
  attr_accessor :reminderIsSet
  attr_accessor :reminderMinutesBeforeStart
  attr_accessor :displayCc
  attr_accessor :displayTo
  attr_accessor :hasAttachments
  attr_accessor :extendedProperty
  attr_accessor :culture
  attr_accessor :effectiveRights
  attr_accessor :lastModifiedName
  attr_accessor :lastModifiedTime
  attr_accessor :sender
  attr_accessor :toRecipients
  attr_accessor :ccRecipients
  attr_accessor :bccRecipients
  attr_accessor :isReadReceiptRequested
  attr_accessor :isDeliveryReceiptRequested
  attr_accessor :conversationIndex
  attr_accessor :conversationTopic
  attr_accessor :from
  attr_accessor :internetMessageId
  attr_accessor :isRead
  attr_accessor :isResponseRequested
  attr_accessor :references
  attr_accessor :replyTo
  attr_accessor :receivedBy
  attr_accessor :receivedRepresenting
  attr_accessor :referenceItemId

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ObjectName
    __xmlattr[AttrObjectName]
  end

  def xmlattr_ObjectName=(value)
    __xmlattr[AttrObjectName] = value
  end

  def initialize(mimeContent = nil, itemId = nil, parentFolderId = nil, itemClass = nil, subject = nil, sensitivity = nil, body = nil, attachments = nil, dateTimeReceived = nil, size = nil, categories = nil, importance = nil, inReplyTo = nil, isSubmitted = nil, isDraft = nil, isFromMe = nil, isResend = nil, isUnmodified = nil, internetMessageHeaders = nil, dateTimeSent = nil, dateTimeCreated = nil, responseObjects = nil, reminderDueBy = nil, reminderIsSet = nil, reminderMinutesBeforeStart = nil, displayCc = nil, displayTo = nil, hasAttachments = nil, extendedProperty = [], culture = nil, effectiveRights = nil, lastModifiedName = nil, lastModifiedTime = nil, sender = nil, toRecipients = nil, ccRecipients = nil, bccRecipients = nil, isReadReceiptRequested = nil, isDeliveryReceiptRequested = nil, conversationIndex = nil, conversationTopic = nil, from = nil, internetMessageId = nil, isRead = nil, isResponseRequested = nil, references = nil, replyTo = nil, receivedBy = nil, receivedRepresenting = nil, referenceItemId = nil)
    @mimeContent = mimeContent
    @itemId = itemId
    @parentFolderId = parentFolderId
    @itemClass = itemClass
    @subject = subject
    @sensitivity = sensitivity
    @body = body
    @attachments = attachments
    @dateTimeReceived = dateTimeReceived
    @size = size
    @categories = categories
    @importance = importance
    @inReplyTo = inReplyTo
    @isSubmitted = isSubmitted
    @isDraft = isDraft
    @isFromMe = isFromMe
    @isResend = isResend
    @isUnmodified = isUnmodified
    @internetMessageHeaders = internetMessageHeaders
    @dateTimeSent = dateTimeSent
    @dateTimeCreated = dateTimeCreated
    @responseObjects = responseObjects
    @reminderDueBy = reminderDueBy
    @reminderIsSet = reminderIsSet
    @reminderMinutesBeforeStart = reminderMinutesBeforeStart
    @displayCc = displayCc
    @displayTo = displayTo
    @hasAttachments = hasAttachments
    @extendedProperty = extendedProperty
    @culture = culture
    @effectiveRights = effectiveRights
    @lastModifiedName = lastModifiedName
    @lastModifiedTime = lastModifiedTime
    @sender = sender
    @toRecipients = toRecipients
    @ccRecipients = ccRecipients
    @bccRecipients = bccRecipients
    @isReadReceiptRequested = isReadReceiptRequested
    @isDeliveryReceiptRequested = isDeliveryReceiptRequested
    @conversationIndex = conversationIndex
    @conversationTopic = conversationTopic
    @from = from
    @internetMessageId = internetMessageId
    @isRead = isRead
    @isResponseRequested = isResponseRequested
    @references = references
    @replyTo = replyTo
    @receivedBy = receivedBy
    @receivedRepresenting = receivedRepresenting
    @referenceItemId = referenceItemId
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}WellKnownResponseObjectType
#   itemClass - (any)
#   sensitivity - SensitivityChoicesType
#   body - BodyType
#   attachments - NonEmptyArrayOfAttachmentsType
#   internetMessageHeaders - NonEmptyArrayOfInternetHeadersType
#   sender - SingleRecipientType
#   toRecipients - ArrayOfRecipientsType
#   ccRecipients - ArrayOfRecipientsType
#   bccRecipients - ArrayOfRecipientsType
#   isReadReceiptRequested - SOAP::SOAPBoolean
#   isDeliveryReceiptRequested - SOAP::SOAPBoolean
#   from - SingleRecipientType
#   referenceItemId - ItemIdType
#   xmlattr_ObjectName - SOAP::SOAPString
class WellKnownResponseObjectType < ResponseObjectType
  AttrObjectName = XSD::QName.new(nil, "ObjectName")

  attr_accessor :itemClass
  attr_accessor :sensitivity
  attr_accessor :body
  attr_accessor :attachments
  attr_accessor :internetMessageHeaders
  attr_accessor :sender
  attr_accessor :toRecipients
  attr_accessor :ccRecipients
  attr_accessor :bccRecipients
  attr_accessor :isReadReceiptRequested
  attr_accessor :isDeliveryReceiptRequested
  attr_accessor :from
  attr_accessor :referenceItemId

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ObjectName
    __xmlattr[AttrObjectName]
  end

  def xmlattr_ObjectName=(value)
    __xmlattr[AttrObjectName] = value
  end

  def initialize(itemClass = nil, sensitivity = nil, body = nil, attachments = nil, internetMessageHeaders = nil, sender = nil, toRecipients = nil, ccRecipients = nil, bccRecipients = nil, isReadReceiptRequested = nil, isDeliveryReceiptRequested = nil, from = nil, referenceItemId = nil)
    @itemClass = itemClass
    @sensitivity = sensitivity
    @body = body
    @attachments = attachments
    @internetMessageHeaders = internetMessageHeaders
    @sender = sender
    @toRecipients = toRecipients
    @ccRecipients = ccRecipients
    @bccRecipients = bccRecipients
    @isReadReceiptRequested = isReadReceiptRequested
    @isDeliveryReceiptRequested = isDeliveryReceiptRequested
    @from = from
    @referenceItemId = referenceItemId
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}AcceptItemType
#   itemClass - (any)
#   sensitivity - SensitivityChoicesType
#   body - BodyType
#   attachments - NonEmptyArrayOfAttachmentsType
#   internetMessageHeaders - NonEmptyArrayOfInternetHeadersType
#   sender - SingleRecipientType
#   toRecipients - ArrayOfRecipientsType
#   ccRecipients - ArrayOfRecipientsType
#   bccRecipients - ArrayOfRecipientsType
#   isReadReceiptRequested - SOAP::SOAPBoolean
#   isDeliveryReceiptRequested - SOAP::SOAPBoolean
#   from - SingleRecipientType
#   referenceItemId - ItemIdType
#   xmlattr_ObjectName - SOAP::SOAPString
class AcceptItemType < WellKnownResponseObjectType
  AttrObjectName = XSD::QName.new(nil, "ObjectName")

  attr_accessor :itemClass
  attr_accessor :sensitivity
  attr_accessor :body
  attr_accessor :attachments
  attr_accessor :internetMessageHeaders
  attr_accessor :sender
  attr_accessor :toRecipients
  attr_accessor :ccRecipients
  attr_accessor :bccRecipients
  attr_accessor :isReadReceiptRequested
  attr_accessor :isDeliveryReceiptRequested
  attr_accessor :from
  attr_accessor :referenceItemId

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ObjectName
    __xmlattr[AttrObjectName]
  end

  def xmlattr_ObjectName=(value)
    __xmlattr[AttrObjectName] = value
  end

  def initialize(itemClass = nil, sensitivity = nil, body = nil, attachments = nil, internetMessageHeaders = nil, sender = nil, toRecipients = nil, ccRecipients = nil, bccRecipients = nil, isReadReceiptRequested = nil, isDeliveryReceiptRequested = nil, from = nil, referenceItemId = nil)
    @itemClass = itemClass
    @sensitivity = sensitivity
    @body = body
    @attachments = attachments
    @internetMessageHeaders = internetMessageHeaders
    @sender = sender
    @toRecipients = toRecipients
    @ccRecipients = ccRecipients
    @bccRecipients = bccRecipients
    @isReadReceiptRequested = isReadReceiptRequested
    @isDeliveryReceiptRequested = isDeliveryReceiptRequested
    @from = from
    @referenceItemId = referenceItemId
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}TentativelyAcceptItemType
#   itemClass - (any)
#   sensitivity - SensitivityChoicesType
#   body - BodyType
#   attachments - NonEmptyArrayOfAttachmentsType
#   internetMessageHeaders - NonEmptyArrayOfInternetHeadersType
#   sender - SingleRecipientType
#   toRecipients - ArrayOfRecipientsType
#   ccRecipients - ArrayOfRecipientsType
#   bccRecipients - ArrayOfRecipientsType
#   isReadReceiptRequested - SOAP::SOAPBoolean
#   isDeliveryReceiptRequested - SOAP::SOAPBoolean
#   from - SingleRecipientType
#   referenceItemId - ItemIdType
#   xmlattr_ObjectName - SOAP::SOAPString
class TentativelyAcceptItemType < WellKnownResponseObjectType
  AttrObjectName = XSD::QName.new(nil, "ObjectName")

  attr_accessor :itemClass
  attr_accessor :sensitivity
  attr_accessor :body
  attr_accessor :attachments
  attr_accessor :internetMessageHeaders
  attr_accessor :sender
  attr_accessor :toRecipients
  attr_accessor :ccRecipients
  attr_accessor :bccRecipients
  attr_accessor :isReadReceiptRequested
  attr_accessor :isDeliveryReceiptRequested
  attr_accessor :from
  attr_accessor :referenceItemId

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ObjectName
    __xmlattr[AttrObjectName]
  end

  def xmlattr_ObjectName=(value)
    __xmlattr[AttrObjectName] = value
  end

  def initialize(itemClass = nil, sensitivity = nil, body = nil, attachments = nil, internetMessageHeaders = nil, sender = nil, toRecipients = nil, ccRecipients = nil, bccRecipients = nil, isReadReceiptRequested = nil, isDeliveryReceiptRequested = nil, from = nil, referenceItemId = nil)
    @itemClass = itemClass
    @sensitivity = sensitivity
    @body = body
    @attachments = attachments
    @internetMessageHeaders = internetMessageHeaders
    @sender = sender
    @toRecipients = toRecipients
    @ccRecipients = ccRecipients
    @bccRecipients = bccRecipients
    @isReadReceiptRequested = isReadReceiptRequested
    @isDeliveryReceiptRequested = isDeliveryReceiptRequested
    @from = from
    @referenceItemId = referenceItemId
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}DeclineItemType
#   itemClass - (any)
#   sensitivity - SensitivityChoicesType
#   body - BodyType
#   attachments - NonEmptyArrayOfAttachmentsType
#   internetMessageHeaders - NonEmptyArrayOfInternetHeadersType
#   sender - SingleRecipientType
#   toRecipients - ArrayOfRecipientsType
#   ccRecipients - ArrayOfRecipientsType
#   bccRecipients - ArrayOfRecipientsType
#   isReadReceiptRequested - SOAP::SOAPBoolean
#   isDeliveryReceiptRequested - SOAP::SOAPBoolean
#   from - SingleRecipientType
#   referenceItemId - ItemIdType
#   xmlattr_ObjectName - SOAP::SOAPString
class DeclineItemType < WellKnownResponseObjectType
  AttrObjectName = XSD::QName.new(nil, "ObjectName")

  attr_accessor :itemClass
  attr_accessor :sensitivity
  attr_accessor :body
  attr_accessor :attachments
  attr_accessor :internetMessageHeaders
  attr_accessor :sender
  attr_accessor :toRecipients
  attr_accessor :ccRecipients
  attr_accessor :bccRecipients
  attr_accessor :isReadReceiptRequested
  attr_accessor :isDeliveryReceiptRequested
  attr_accessor :from
  attr_accessor :referenceItemId

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ObjectName
    __xmlattr[AttrObjectName]
  end

  def xmlattr_ObjectName=(value)
    __xmlattr[AttrObjectName] = value
  end

  def initialize(itemClass = nil, sensitivity = nil, body = nil, attachments = nil, internetMessageHeaders = nil, sender = nil, toRecipients = nil, ccRecipients = nil, bccRecipients = nil, isReadReceiptRequested = nil, isDeliveryReceiptRequested = nil, from = nil, referenceItemId = nil)
    @itemClass = itemClass
    @sensitivity = sensitivity
    @body = body
    @attachments = attachments
    @internetMessageHeaders = internetMessageHeaders
    @sender = sender
    @toRecipients = toRecipients
    @ccRecipients = ccRecipients
    @bccRecipients = bccRecipients
    @isReadReceiptRequested = isReadReceiptRequested
    @isDeliveryReceiptRequested = isDeliveryReceiptRequested
    @from = from
    @referenceItemId = referenceItemId
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}SmartResponseBaseType
#   subject - SOAP::SOAPString
#   body - BodyType
#   toRecipients - ArrayOfRecipientsType
#   ccRecipients - ArrayOfRecipientsType
#   bccRecipients - ArrayOfRecipientsType
#   isReadReceiptRequested - SOAP::SOAPBoolean
#   isDeliveryReceiptRequested - SOAP::SOAPBoolean
#   from - SingleRecipientType
#   referenceItemId - ItemIdType
#   xmlattr_ObjectName - SOAP::SOAPString
class SmartResponseBaseType < ResponseObjectType
  AttrObjectName = XSD::QName.new(nil, "ObjectName")

  attr_accessor :subject
  attr_accessor :body
  attr_accessor :toRecipients
  attr_accessor :ccRecipients
  attr_accessor :bccRecipients
  attr_accessor :isReadReceiptRequested
  attr_accessor :isDeliveryReceiptRequested
  attr_accessor :from
  attr_accessor :referenceItemId

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ObjectName
    __xmlattr[AttrObjectName]
  end

  def xmlattr_ObjectName=(value)
    __xmlattr[AttrObjectName] = value
  end

  def initialize(subject = nil, body = nil, toRecipients = nil, ccRecipients = nil, bccRecipients = nil, isReadReceiptRequested = nil, isDeliveryReceiptRequested = nil, from = nil, referenceItemId = nil)
    @subject = subject
    @body = body
    @toRecipients = toRecipients
    @ccRecipients = ccRecipients
    @bccRecipients = bccRecipients
    @isReadReceiptRequested = isReadReceiptRequested
    @isDeliveryReceiptRequested = isDeliveryReceiptRequested
    @from = from
    @referenceItemId = referenceItemId
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}SmartResponseType
#   subject - SOAP::SOAPString
#   body - BodyType
#   toRecipients - ArrayOfRecipientsType
#   ccRecipients - ArrayOfRecipientsType
#   bccRecipients - ArrayOfRecipientsType
#   isReadReceiptRequested - SOAP::SOAPBoolean
#   isDeliveryReceiptRequested - SOAP::SOAPBoolean
#   from - SingleRecipientType
#   referenceItemId - ItemIdType
#   newBodyContent - BodyType
#   xmlattr_ObjectName - SOAP::SOAPString
class SmartResponseType < SmartResponseBaseType
  AttrObjectName = XSD::QName.new(nil, "ObjectName")

  attr_accessor :subject
  attr_accessor :body
  attr_accessor :toRecipients
  attr_accessor :ccRecipients
  attr_accessor :bccRecipients
  attr_accessor :isReadReceiptRequested
  attr_accessor :isDeliveryReceiptRequested
  attr_accessor :from
  attr_accessor :referenceItemId
  attr_accessor :newBodyContent

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ObjectName
    __xmlattr[AttrObjectName]
  end

  def xmlattr_ObjectName=(value)
    __xmlattr[AttrObjectName] = value
  end

  def initialize(subject = nil, body = nil, toRecipients = nil, ccRecipients = nil, bccRecipients = nil, isReadReceiptRequested = nil, isDeliveryReceiptRequested = nil, from = nil, referenceItemId = nil, newBodyContent = nil)
    @subject = subject
    @body = body
    @toRecipients = toRecipients
    @ccRecipients = ccRecipients
    @bccRecipients = bccRecipients
    @isReadReceiptRequested = isReadReceiptRequested
    @isDeliveryReceiptRequested = isDeliveryReceiptRequested
    @from = from
    @referenceItemId = referenceItemId
    @newBodyContent = newBodyContent
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ReplyToItemType
#   subject - SOAP::SOAPString
#   body - BodyType
#   toRecipients - ArrayOfRecipientsType
#   ccRecipients - ArrayOfRecipientsType
#   bccRecipients - ArrayOfRecipientsType
#   isReadReceiptRequested - SOAP::SOAPBoolean
#   isDeliveryReceiptRequested - SOAP::SOAPBoolean
#   from - SingleRecipientType
#   referenceItemId - ItemIdType
#   newBodyContent - BodyType
#   xmlattr_ObjectName - SOAP::SOAPString
class ReplyToItemType < SmartResponseType
  AttrObjectName = XSD::QName.new(nil, "ObjectName")

  attr_accessor :subject
  attr_accessor :body
  attr_accessor :toRecipients
  attr_accessor :ccRecipients
  attr_accessor :bccRecipients
  attr_accessor :isReadReceiptRequested
  attr_accessor :isDeliveryReceiptRequested
  attr_accessor :from
  attr_accessor :referenceItemId
  attr_accessor :newBodyContent

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ObjectName
    __xmlattr[AttrObjectName]
  end

  def xmlattr_ObjectName=(value)
    __xmlattr[AttrObjectName] = value
  end

  def initialize(subject = nil, body = nil, toRecipients = nil, ccRecipients = nil, bccRecipients = nil, isReadReceiptRequested = nil, isDeliveryReceiptRequested = nil, from = nil, referenceItemId = nil, newBodyContent = nil)
    @subject = subject
    @body = body
    @toRecipients = toRecipients
    @ccRecipients = ccRecipients
    @bccRecipients = bccRecipients
    @isReadReceiptRequested = isReadReceiptRequested
    @isDeliveryReceiptRequested = isDeliveryReceiptRequested
    @from = from
    @referenceItemId = referenceItemId
    @newBodyContent = newBodyContent
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ReplyAllToItemType
#   subject - SOAP::SOAPString
#   body - BodyType
#   toRecipients - ArrayOfRecipientsType
#   ccRecipients - ArrayOfRecipientsType
#   bccRecipients - ArrayOfRecipientsType
#   isReadReceiptRequested - SOAP::SOAPBoolean
#   isDeliveryReceiptRequested - SOAP::SOAPBoolean
#   from - SingleRecipientType
#   referenceItemId - ItemIdType
#   newBodyContent - BodyType
#   xmlattr_ObjectName - SOAP::SOAPString
class ReplyAllToItemType < SmartResponseType
  AttrObjectName = XSD::QName.new(nil, "ObjectName")

  attr_accessor :subject
  attr_accessor :body
  attr_accessor :toRecipients
  attr_accessor :ccRecipients
  attr_accessor :bccRecipients
  attr_accessor :isReadReceiptRequested
  attr_accessor :isDeliveryReceiptRequested
  attr_accessor :from
  attr_accessor :referenceItemId
  attr_accessor :newBodyContent

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ObjectName
    __xmlattr[AttrObjectName]
  end

  def xmlattr_ObjectName=(value)
    __xmlattr[AttrObjectName] = value
  end

  def initialize(subject = nil, body = nil, toRecipients = nil, ccRecipients = nil, bccRecipients = nil, isReadReceiptRequested = nil, isDeliveryReceiptRequested = nil, from = nil, referenceItemId = nil, newBodyContent = nil)
    @subject = subject
    @body = body
    @toRecipients = toRecipients
    @ccRecipients = ccRecipients
    @bccRecipients = bccRecipients
    @isReadReceiptRequested = isReadReceiptRequested
    @isDeliveryReceiptRequested = isDeliveryReceiptRequested
    @from = from
    @referenceItemId = referenceItemId
    @newBodyContent = newBodyContent
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ForwardItemType
#   subject - SOAP::SOAPString
#   body - BodyType
#   toRecipients - ArrayOfRecipientsType
#   ccRecipients - ArrayOfRecipientsType
#   bccRecipients - ArrayOfRecipientsType
#   isReadReceiptRequested - SOAP::SOAPBoolean
#   isDeliveryReceiptRequested - SOAP::SOAPBoolean
#   from - SingleRecipientType
#   referenceItemId - ItemIdType
#   newBodyContent - BodyType
#   xmlattr_ObjectName - SOAP::SOAPString
class ForwardItemType < SmartResponseType
  AttrObjectName = XSD::QName.new(nil, "ObjectName")

  attr_accessor :subject
  attr_accessor :body
  attr_accessor :toRecipients
  attr_accessor :ccRecipients
  attr_accessor :bccRecipients
  attr_accessor :isReadReceiptRequested
  attr_accessor :isDeliveryReceiptRequested
  attr_accessor :from
  attr_accessor :referenceItemId
  attr_accessor :newBodyContent

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ObjectName
    __xmlattr[AttrObjectName]
  end

  def xmlattr_ObjectName=(value)
    __xmlattr[AttrObjectName] = value
  end

  def initialize(subject = nil, body = nil, toRecipients = nil, ccRecipients = nil, bccRecipients = nil, isReadReceiptRequested = nil, isDeliveryReceiptRequested = nil, from = nil, referenceItemId = nil, newBodyContent = nil)
    @subject = subject
    @body = body
    @toRecipients = toRecipients
    @ccRecipients = ccRecipients
    @bccRecipients = bccRecipients
    @isReadReceiptRequested = isReadReceiptRequested
    @isDeliveryReceiptRequested = isDeliveryReceiptRequested
    @from = from
    @referenceItemId = referenceItemId
    @newBodyContent = newBodyContent
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}CancelCalendarItemType
#   subject - SOAP::SOAPString
#   body - BodyType
#   toRecipients - ArrayOfRecipientsType
#   ccRecipients - ArrayOfRecipientsType
#   bccRecipients - ArrayOfRecipientsType
#   isReadReceiptRequested - SOAP::SOAPBoolean
#   isDeliveryReceiptRequested - SOAP::SOAPBoolean
#   from - SingleRecipientType
#   referenceItemId - ItemIdType
#   newBodyContent - BodyType
#   xmlattr_ObjectName - SOAP::SOAPString
class CancelCalendarItemType < SmartResponseType
  AttrObjectName = XSD::QName.new(nil, "ObjectName")

  attr_accessor :subject
  attr_accessor :body
  attr_accessor :toRecipients
  attr_accessor :ccRecipients
  attr_accessor :bccRecipients
  attr_accessor :isReadReceiptRequested
  attr_accessor :isDeliveryReceiptRequested
  attr_accessor :from
  attr_accessor :referenceItemId
  attr_accessor :newBodyContent

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ObjectName
    __xmlattr[AttrObjectName]
  end

  def xmlattr_ObjectName=(value)
    __xmlattr[AttrObjectName] = value
  end

  def initialize(subject = nil, body = nil, toRecipients = nil, ccRecipients = nil, bccRecipients = nil, isReadReceiptRequested = nil, isDeliveryReceiptRequested = nil, from = nil, referenceItemId = nil, newBodyContent = nil)
    @subject = subject
    @body = body
    @toRecipients = toRecipients
    @ccRecipients = ccRecipients
    @bccRecipients = bccRecipients
    @isReadReceiptRequested = isReadReceiptRequested
    @isDeliveryReceiptRequested = isDeliveryReceiptRequested
    @from = from
    @referenceItemId = referenceItemId
    @newBodyContent = newBodyContent
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ReferenceItemResponseType
#   referenceItemId - ItemIdType
#   xmlattr_ObjectName - SOAP::SOAPString
class ReferenceItemResponseType < ResponseObjectType
  AttrObjectName = XSD::QName.new(nil, "ObjectName")

  attr_accessor :referenceItemId

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ObjectName
    __xmlattr[AttrObjectName]
  end

  def xmlattr_ObjectName=(value)
    __xmlattr[AttrObjectName] = value
  end

  def initialize(referenceItemId = nil)
    @referenceItemId = referenceItemId
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}SuppressReadReceiptType
#   referenceItemId - ItemIdType
#   xmlattr_ObjectName - SOAP::SOAPString
class SuppressReadReceiptType < ReferenceItemResponseType
  AttrObjectName = XSD::QName.new(nil, "ObjectName")

  attr_accessor :referenceItemId

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ObjectName
    __xmlattr[AttrObjectName]
  end

  def xmlattr_ObjectName=(value)
    __xmlattr[AttrObjectName] = value
  end

  def initialize(referenceItemId = nil)
    @referenceItemId = referenceItemId
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}RemoveItemType
#   mimeContent - MimeContentType
#   itemId - ItemIdType
#   parentFolderId - FolderIdType
#   itemClass - (any)
#   subject - SOAP::SOAPString
#   sensitivity - SensitivityChoicesType
#   body - BodyType
#   attachments - NonEmptyArrayOfAttachmentsType
#   dateTimeReceived - SOAP::SOAPDateTime
#   size - SOAP::SOAPInt
#   categories - ArrayOfStringsType
#   importance - ImportanceChoicesType
#   inReplyTo - SOAP::SOAPString
#   isSubmitted - SOAP::SOAPBoolean
#   isDraft - SOAP::SOAPBoolean
#   isFromMe - SOAP::SOAPBoolean
#   isResend - SOAP::SOAPBoolean
#   isUnmodified - SOAP::SOAPBoolean
#   internetMessageHeaders - NonEmptyArrayOfInternetHeadersType
#   dateTimeSent - SOAP::SOAPDateTime
#   dateTimeCreated - SOAP::SOAPDateTime
#   responseObjects - NonEmptyArrayOfResponseObjectsType
#   reminderDueBy - SOAP::SOAPDateTime
#   reminderIsSet - SOAP::SOAPBoolean
#   reminderMinutesBeforeStart - (any)
#   displayCc - SOAP::SOAPString
#   displayTo - SOAP::SOAPString
#   hasAttachments - SOAP::SOAPBoolean
#   extendedProperty - ExtendedPropertyType
#   culture - SOAP::SOAPLanguage
#   effectiveRights - EffectiveRightsType
#   lastModifiedName - SOAP::SOAPString
#   lastModifiedTime - SOAP::SOAPDateTime
#   sender - SingleRecipientType
#   toRecipients - ArrayOfRecipientsType
#   ccRecipients - ArrayOfRecipientsType
#   bccRecipients - ArrayOfRecipientsType
#   isReadReceiptRequested - SOAP::SOAPBoolean
#   isDeliveryReceiptRequested - SOAP::SOAPBoolean
#   conversationIndex - SOAP::SOAPBase64
#   conversationTopic - SOAP::SOAPString
#   from - SingleRecipientType
#   internetMessageId - SOAP::SOAPString
#   isRead - SOAP::SOAPBoolean
#   isResponseRequested - SOAP::SOAPBoolean
#   references - SOAP::SOAPString
#   replyTo - ArrayOfRecipientsType
#   receivedBy - SingleRecipientType
#   receivedRepresenting - SingleRecipientType
#   referenceItemId - ItemIdType
#   xmlattr_ObjectName - SOAP::SOAPString
class RemoveItemType < ResponseObjectType
  AttrObjectName = XSD::QName.new(nil, "ObjectName")

  attr_accessor :mimeContent
  attr_accessor :itemId
  attr_accessor :parentFolderId
  attr_accessor :itemClass
  attr_accessor :subject
  attr_accessor :sensitivity
  attr_accessor :body
  attr_accessor :attachments
  attr_accessor :dateTimeReceived
  attr_accessor :size
  attr_accessor :categories
  attr_accessor :importance
  attr_accessor :inReplyTo
  attr_accessor :isSubmitted
  attr_accessor :isDraft
  attr_accessor :isFromMe
  attr_accessor :isResend
  attr_accessor :isUnmodified
  attr_accessor :internetMessageHeaders
  attr_accessor :dateTimeSent
  attr_accessor :dateTimeCreated
  attr_accessor :responseObjects
  attr_accessor :reminderDueBy
  attr_accessor :reminderIsSet
  attr_accessor :reminderMinutesBeforeStart
  attr_accessor :displayCc
  attr_accessor :displayTo
  attr_accessor :hasAttachments
  attr_accessor :extendedProperty
  attr_accessor :culture
  attr_accessor :effectiveRights
  attr_accessor :lastModifiedName
  attr_accessor :lastModifiedTime
  attr_accessor :sender
  attr_accessor :toRecipients
  attr_accessor :ccRecipients
  attr_accessor :bccRecipients
  attr_accessor :isReadReceiptRequested
  attr_accessor :isDeliveryReceiptRequested
  attr_accessor :conversationIndex
  attr_accessor :conversationTopic
  attr_accessor :from
  attr_accessor :internetMessageId
  attr_accessor :isRead
  attr_accessor :isResponseRequested
  attr_accessor :references
  attr_accessor :replyTo
  attr_accessor :receivedBy
  attr_accessor :receivedRepresenting
  attr_accessor :referenceItemId

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ObjectName
    __xmlattr[AttrObjectName]
  end

  def xmlattr_ObjectName=(value)
    __xmlattr[AttrObjectName] = value
  end

  def initialize(mimeContent = nil, itemId = nil, parentFolderId = nil, itemClass = nil, subject = nil, sensitivity = nil, body = nil, attachments = nil, dateTimeReceived = nil, size = nil, categories = nil, importance = nil, inReplyTo = nil, isSubmitted = nil, isDraft = nil, isFromMe = nil, isResend = nil, isUnmodified = nil, internetMessageHeaders = nil, dateTimeSent = nil, dateTimeCreated = nil, responseObjects = nil, reminderDueBy = nil, reminderIsSet = nil, reminderMinutesBeforeStart = nil, displayCc = nil, displayTo = nil, hasAttachments = nil, extendedProperty = [], culture = nil, effectiveRights = nil, lastModifiedName = nil, lastModifiedTime = nil, sender = nil, toRecipients = nil, ccRecipients = nil, bccRecipients = nil, isReadReceiptRequested = nil, isDeliveryReceiptRequested = nil, conversationIndex = nil, conversationTopic = nil, from = nil, internetMessageId = nil, isRead = nil, isResponseRequested = nil, references = nil, replyTo = nil, receivedBy = nil, receivedRepresenting = nil, referenceItemId = nil)
    @mimeContent = mimeContent
    @itemId = itemId
    @parentFolderId = parentFolderId
    @itemClass = itemClass
    @subject = subject
    @sensitivity = sensitivity
    @body = body
    @attachments = attachments
    @dateTimeReceived = dateTimeReceived
    @size = size
    @categories = categories
    @importance = importance
    @inReplyTo = inReplyTo
    @isSubmitted = isSubmitted
    @isDraft = isDraft
    @isFromMe = isFromMe
    @isResend = isResend
    @isUnmodified = isUnmodified
    @internetMessageHeaders = internetMessageHeaders
    @dateTimeSent = dateTimeSent
    @dateTimeCreated = dateTimeCreated
    @responseObjects = responseObjects
    @reminderDueBy = reminderDueBy
    @reminderIsSet = reminderIsSet
    @reminderMinutesBeforeStart = reminderMinutesBeforeStart
    @displayCc = displayCc
    @displayTo = displayTo
    @hasAttachments = hasAttachments
    @extendedProperty = extendedProperty
    @culture = culture
    @effectiveRights = effectiveRights
    @lastModifiedName = lastModifiedName
    @lastModifiedTime = lastModifiedTime
    @sender = sender
    @toRecipients = toRecipients
    @ccRecipients = ccRecipients
    @bccRecipients = bccRecipients
    @isReadReceiptRequested = isReadReceiptRequested
    @isDeliveryReceiptRequested = isDeliveryReceiptRequested
    @conversationIndex = conversationIndex
    @conversationTopic = conversationTopic
    @from = from
    @internetMessageId = internetMessageId
    @isRead = isRead
    @isResponseRequested = isResponseRequested
    @references = references
    @replyTo = replyTo
    @receivedBy = receivedBy
    @receivedRepresenting = receivedRepresenting
    @referenceItemId = referenceItemId
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}PostReplyItemBaseType
#   subject - SOAP::SOAPString
#   body - BodyType
#   referenceItemId - ItemIdType
#   xmlattr_ObjectName - SOAP::SOAPString
class PostReplyItemBaseType < ResponseObjectType
  AttrObjectName = XSD::QName.new(nil, "ObjectName")

  attr_accessor :subject
  attr_accessor :body
  attr_accessor :referenceItemId

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ObjectName
    __xmlattr[AttrObjectName]
  end

  def xmlattr_ObjectName=(value)
    __xmlattr[AttrObjectName] = value
  end

  def initialize(subject = nil, body = nil, referenceItemId = nil)
    @subject = subject
    @body = body
    @referenceItemId = referenceItemId
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}PostReplyItemType
#   subject - SOAP::SOAPString
#   body - BodyType
#   referenceItemId - ItemIdType
#   newBodyContent - BodyType
#   xmlattr_ObjectName - SOAP::SOAPString
class PostReplyItemType < PostReplyItemBaseType
  AttrObjectName = XSD::QName.new(nil, "ObjectName")

  attr_accessor :subject
  attr_accessor :body
  attr_accessor :referenceItemId
  attr_accessor :newBodyContent

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ObjectName
    __xmlattr[AttrObjectName]
  end

  def xmlattr_ObjectName=(value)
    __xmlattr[AttrObjectName] = value
  end

  def initialize(subject = nil, body = nil, referenceItemId = nil, newBodyContent = nil)
    @subject = subject
    @body = body
    @referenceItemId = referenceItemId
    @newBodyContent = newBodyContent
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}MeetingMessageType
#   mimeContent - MimeContentType
#   itemId - ItemIdType
#   parentFolderId - FolderIdType
#   itemClass - (any)
#   subject - SOAP::SOAPString
#   sensitivity - SensitivityChoicesType
#   body - BodyType
#   attachments - NonEmptyArrayOfAttachmentsType
#   dateTimeReceived - SOAP::SOAPDateTime
#   size - SOAP::SOAPInt
#   categories - ArrayOfStringsType
#   importance - ImportanceChoicesType
#   inReplyTo - SOAP::SOAPString
#   isSubmitted - SOAP::SOAPBoolean
#   isDraft - SOAP::SOAPBoolean
#   isFromMe - SOAP::SOAPBoolean
#   isResend - SOAP::SOAPBoolean
#   isUnmodified - SOAP::SOAPBoolean
#   internetMessageHeaders - NonEmptyArrayOfInternetHeadersType
#   dateTimeSent - SOAP::SOAPDateTime
#   dateTimeCreated - SOAP::SOAPDateTime
#   responseObjects - NonEmptyArrayOfResponseObjectsType
#   reminderDueBy - SOAP::SOAPDateTime
#   reminderIsSet - SOAP::SOAPBoolean
#   reminderMinutesBeforeStart - (any)
#   displayCc - SOAP::SOAPString
#   displayTo - SOAP::SOAPString
#   hasAttachments - SOAP::SOAPBoolean
#   extendedProperty - ExtendedPropertyType
#   culture - SOAP::SOAPLanguage
#   effectiveRights - EffectiveRightsType
#   lastModifiedName - SOAP::SOAPString
#   lastModifiedTime - SOAP::SOAPDateTime
#   sender - SingleRecipientType
#   toRecipients - ArrayOfRecipientsType
#   ccRecipients - ArrayOfRecipientsType
#   bccRecipients - ArrayOfRecipientsType
#   isReadReceiptRequested - SOAP::SOAPBoolean
#   isDeliveryReceiptRequested - SOAP::SOAPBoolean
#   conversationIndex - SOAP::SOAPBase64
#   conversationTopic - SOAP::SOAPString
#   from - SingleRecipientType
#   internetMessageId - SOAP::SOAPString
#   isRead - SOAP::SOAPBoolean
#   isResponseRequested - SOAP::SOAPBoolean
#   references - SOAP::SOAPString
#   replyTo - ArrayOfRecipientsType
#   receivedBy - SingleRecipientType
#   receivedRepresenting - SingleRecipientType
#   associatedCalendarItemId - ItemIdType
#   isDelegated - SOAP::SOAPBoolean
#   isOutOfDate - SOAP::SOAPBoolean
#   hasBeenProcessed - SOAP::SOAPBoolean
#   responseType - ResponseTypeType
#   uID - SOAP::SOAPString
#   recurrenceId - SOAP::SOAPDateTime
#   dateTimeStamp - SOAP::SOAPDateTime
class MeetingMessageType < MessageType
  attr_accessor :mimeContent
  attr_accessor :itemId
  attr_accessor :parentFolderId
  attr_accessor :itemClass
  attr_accessor :subject
  attr_accessor :sensitivity
  attr_accessor :body
  attr_accessor :attachments
  attr_accessor :dateTimeReceived
  attr_accessor :size
  attr_accessor :categories
  attr_accessor :importance
  attr_accessor :inReplyTo
  attr_accessor :isSubmitted
  attr_accessor :isDraft
  attr_accessor :isFromMe
  attr_accessor :isResend
  attr_accessor :isUnmodified
  attr_accessor :internetMessageHeaders
  attr_accessor :dateTimeSent
  attr_accessor :dateTimeCreated
  attr_accessor :responseObjects
  attr_accessor :reminderDueBy
  attr_accessor :reminderIsSet
  attr_accessor :reminderMinutesBeforeStart
  attr_accessor :displayCc
  attr_accessor :displayTo
  attr_accessor :hasAttachments
  attr_accessor :extendedProperty
  attr_accessor :culture
  attr_accessor :effectiveRights
  attr_accessor :lastModifiedName
  attr_accessor :lastModifiedTime
  attr_accessor :sender
  attr_accessor :toRecipients
  attr_accessor :ccRecipients
  attr_accessor :bccRecipients
  attr_accessor :isReadReceiptRequested
  attr_accessor :isDeliveryReceiptRequested
  attr_accessor :conversationIndex
  attr_accessor :conversationTopic
  attr_accessor :from
  attr_accessor :internetMessageId
  attr_accessor :isRead
  attr_accessor :isResponseRequested
  attr_accessor :references
  attr_accessor :replyTo
  attr_accessor :receivedBy
  attr_accessor :receivedRepresenting
  attr_accessor :associatedCalendarItemId
  attr_accessor :isDelegated
  attr_accessor :isOutOfDate
  attr_accessor :hasBeenProcessed
  attr_accessor :responseType
  attr_accessor :uID
  attr_accessor :recurrenceId
  attr_accessor :dateTimeStamp

  def initialize(mimeContent = nil, itemId = nil, parentFolderId = nil, itemClass = nil, subject = nil, sensitivity = nil, body = nil, attachments = nil, dateTimeReceived = nil, size = nil, categories = nil, importance = nil, inReplyTo = nil, isSubmitted = nil, isDraft = nil, isFromMe = nil, isResend = nil, isUnmodified = nil, internetMessageHeaders = nil, dateTimeSent = nil, dateTimeCreated = nil, responseObjects = nil, reminderDueBy = nil, reminderIsSet = nil, reminderMinutesBeforeStart = nil, displayCc = nil, displayTo = nil, hasAttachments = nil, extendedProperty = [], culture = nil, effectiveRights = nil, lastModifiedName = nil, lastModifiedTime = nil, sender = nil, toRecipients = nil, ccRecipients = nil, bccRecipients = nil, isReadReceiptRequested = nil, isDeliveryReceiptRequested = nil, conversationIndex = nil, conversationTopic = nil, from = nil, internetMessageId = nil, isRead = nil, isResponseRequested = nil, references = nil, replyTo = nil, receivedBy = nil, receivedRepresenting = nil, associatedCalendarItemId = nil, isDelegated = nil, isOutOfDate = nil, hasBeenProcessed = nil, responseType = nil, uID = nil, recurrenceId = nil, dateTimeStamp = nil)
    @mimeContent = mimeContent
    @itemId = itemId
    @parentFolderId = parentFolderId
    @itemClass = itemClass
    @subject = subject
    @sensitivity = sensitivity
    @body = body
    @attachments = attachments
    @dateTimeReceived = dateTimeReceived
    @size = size
    @categories = categories
    @importance = importance
    @inReplyTo = inReplyTo
    @isSubmitted = isSubmitted
    @isDraft = isDraft
    @isFromMe = isFromMe
    @isResend = isResend
    @isUnmodified = isUnmodified
    @internetMessageHeaders = internetMessageHeaders
    @dateTimeSent = dateTimeSent
    @dateTimeCreated = dateTimeCreated
    @responseObjects = responseObjects
    @reminderDueBy = reminderDueBy
    @reminderIsSet = reminderIsSet
    @reminderMinutesBeforeStart = reminderMinutesBeforeStart
    @displayCc = displayCc
    @displayTo = displayTo
    @hasAttachments = hasAttachments
    @extendedProperty = extendedProperty
    @culture = culture
    @effectiveRights = effectiveRights
    @lastModifiedName = lastModifiedName
    @lastModifiedTime = lastModifiedTime
    @sender = sender
    @toRecipients = toRecipients
    @ccRecipients = ccRecipients
    @bccRecipients = bccRecipients
    @isReadReceiptRequested = isReadReceiptRequested
    @isDeliveryReceiptRequested = isDeliveryReceiptRequested
    @conversationIndex = conversationIndex
    @conversationTopic = conversationTopic
    @from = from
    @internetMessageId = internetMessageId
    @isRead = isRead
    @isResponseRequested = isResponseRequested
    @references = references
    @replyTo = replyTo
    @receivedBy = receivedBy
    @receivedRepresenting = receivedRepresenting
    @associatedCalendarItemId = associatedCalendarItemId
    @isDelegated = isDelegated
    @isOutOfDate = isOutOfDate
    @hasBeenProcessed = hasBeenProcessed
    @responseType = responseType
    @uID = uID
    @recurrenceId = recurrenceId
    @dateTimeStamp = dateTimeStamp
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}MeetingRequestMessageType
#   mimeContent - MimeContentType
#   itemId - ItemIdType
#   parentFolderId - FolderIdType
#   itemClass - (any)
#   subject - SOAP::SOAPString
#   sensitivity - SensitivityChoicesType
#   body - BodyType
#   attachments - NonEmptyArrayOfAttachmentsType
#   dateTimeReceived - SOAP::SOAPDateTime
#   size - SOAP::SOAPInt
#   categories - ArrayOfStringsType
#   importance - ImportanceChoicesType
#   inReplyTo - SOAP::SOAPString
#   isSubmitted - SOAP::SOAPBoolean
#   isDraft - SOAP::SOAPBoolean
#   isFromMe - SOAP::SOAPBoolean
#   isResend - SOAP::SOAPBoolean
#   isUnmodified - SOAP::SOAPBoolean
#   internetMessageHeaders - NonEmptyArrayOfInternetHeadersType
#   dateTimeSent - SOAP::SOAPDateTime
#   dateTimeCreated - SOAP::SOAPDateTime
#   responseObjects - NonEmptyArrayOfResponseObjectsType
#   reminderDueBy - SOAP::SOAPDateTime
#   reminderIsSet - SOAP::SOAPBoolean
#   reminderMinutesBeforeStart - (any)
#   displayCc - SOAP::SOAPString
#   displayTo - SOAP::SOAPString
#   hasAttachments - SOAP::SOAPBoolean
#   extendedProperty - ExtendedPropertyType
#   culture - SOAP::SOAPLanguage
#   effectiveRights - EffectiveRightsType
#   lastModifiedName - SOAP::SOAPString
#   lastModifiedTime - SOAP::SOAPDateTime
#   sender - SingleRecipientType
#   toRecipients - ArrayOfRecipientsType
#   ccRecipients - ArrayOfRecipientsType
#   bccRecipients - ArrayOfRecipientsType
#   isReadReceiptRequested - SOAP::SOAPBoolean
#   isDeliveryReceiptRequested - SOAP::SOAPBoolean
#   conversationIndex - SOAP::SOAPBase64
#   conversationTopic - SOAP::SOAPString
#   from - SingleRecipientType
#   internetMessageId - SOAP::SOAPString
#   isRead - SOAP::SOAPBoolean
#   isResponseRequested - SOAP::SOAPBoolean
#   references - SOAP::SOAPString
#   replyTo - ArrayOfRecipientsType
#   receivedBy - SingleRecipientType
#   receivedRepresenting - SingleRecipientType
#   associatedCalendarItemId - ItemIdType
#   isDelegated - SOAP::SOAPBoolean
#   isOutOfDate - SOAP::SOAPBoolean
#   hasBeenProcessed - SOAP::SOAPBoolean
#   responseType - ResponseTypeType
#   uID - SOAP::SOAPString
#   recurrenceId - SOAP::SOAPDateTime
#   dateTimeStamp - SOAP::SOAPDateTime
#   meetingRequestType - MeetingRequestTypeType
#   intendedFreeBusyStatus - LegacyFreeBusyType
#   start - SOAP::SOAPDateTime
#   m_end - SOAP::SOAPDateTime
#   originalStart - SOAP::SOAPDateTime
#   isAllDayEvent - SOAP::SOAPBoolean
#   legacyFreeBusyStatus - LegacyFreeBusyType
#   location - SOAP::SOAPString
#   m_when - SOAP::SOAPString
#   isMeeting - SOAP::SOAPBoolean
#   isCancelled - SOAP::SOAPBoolean
#   isRecurring - SOAP::SOAPBoolean
#   meetingRequestWasSent - SOAP::SOAPBoolean
#   calendarItemType - CalendarItemTypeType
#   myResponseType - ResponseTypeType
#   organizer - SingleRecipientType
#   requiredAttendees - NonEmptyArrayOfAttendeesType
#   optionalAttendees - NonEmptyArrayOfAttendeesType
#   resources - NonEmptyArrayOfAttendeesType
#   conflictingMeetingCount - SOAP::SOAPInt
#   adjacentMeetingCount - SOAP::SOAPInt
#   conflictingMeetings - NonEmptyArrayOfAllItemsType
#   adjacentMeetings - NonEmptyArrayOfAllItemsType
#   duration - SOAP::SOAPString
#   timeZone - SOAP::SOAPString
#   appointmentReplyTime - SOAP::SOAPDateTime
#   appointmentSequenceNumber - SOAP::SOAPInt
#   appointmentState - SOAP::SOAPInt
#   recurrence - RecurrenceType
#   firstOccurrence - OccurrenceInfoType
#   lastOccurrence - OccurrenceInfoType
#   modifiedOccurrences - NonEmptyArrayOfOccurrenceInfoType
#   deletedOccurrences - NonEmptyArrayOfDeletedOccurrencesType
#   meetingTimeZone - TimeZoneType
#   conferenceType - SOAP::SOAPInt
#   allowNewTimeProposal - SOAP::SOAPBoolean
#   isOnlineMeeting - SOAP::SOAPBoolean
#   meetingWorkspaceUrl - SOAP::SOAPString
#   netShowUrl - SOAP::SOAPString
class MeetingRequestMessageType < MeetingMessageType
  attr_accessor :mimeContent
  attr_accessor :itemId
  attr_accessor :parentFolderId
  attr_accessor :itemClass
  attr_accessor :subject
  attr_accessor :sensitivity
  attr_accessor :body
  attr_accessor :attachments
  attr_accessor :dateTimeReceived
  attr_accessor :size
  attr_accessor :categories
  attr_accessor :importance
  attr_accessor :inReplyTo
  attr_accessor :isSubmitted
  attr_accessor :isDraft
  attr_accessor :isFromMe
  attr_accessor :isResend
  attr_accessor :isUnmodified
  attr_accessor :internetMessageHeaders
  attr_accessor :dateTimeSent
  attr_accessor :dateTimeCreated
  attr_accessor :responseObjects
  attr_accessor :reminderDueBy
  attr_accessor :reminderIsSet
  attr_accessor :reminderMinutesBeforeStart
  attr_accessor :displayCc
  attr_accessor :displayTo
  attr_accessor :hasAttachments
  attr_accessor :extendedProperty
  attr_accessor :culture
  attr_accessor :effectiveRights
  attr_accessor :lastModifiedName
  attr_accessor :lastModifiedTime
  attr_accessor :sender
  attr_accessor :toRecipients
  attr_accessor :ccRecipients
  attr_accessor :bccRecipients
  attr_accessor :isReadReceiptRequested
  attr_accessor :isDeliveryReceiptRequested
  attr_accessor :conversationIndex
  attr_accessor :conversationTopic
  attr_accessor :from
  attr_accessor :internetMessageId
  attr_accessor :isRead
  attr_accessor :isResponseRequested
  attr_accessor :references
  attr_accessor :replyTo
  attr_accessor :receivedBy
  attr_accessor :receivedRepresenting
  attr_accessor :associatedCalendarItemId
  attr_accessor :isDelegated
  attr_accessor :isOutOfDate
  attr_accessor :hasBeenProcessed
  attr_accessor :responseType
  attr_accessor :uID
  attr_accessor :recurrenceId
  attr_accessor :dateTimeStamp
  attr_accessor :meetingRequestType
  attr_accessor :intendedFreeBusyStatus
  attr_accessor :start
  attr_accessor :originalStart
  attr_accessor :isAllDayEvent
  attr_accessor :legacyFreeBusyStatus
  attr_accessor :location
  attr_accessor :isMeeting
  attr_accessor :isCancelled
  attr_accessor :isRecurring
  attr_accessor :meetingRequestWasSent
  attr_accessor :calendarItemType
  attr_accessor :myResponseType
  attr_accessor :organizer
  attr_accessor :requiredAttendees
  attr_accessor :optionalAttendees
  attr_accessor :resources
  attr_accessor :conflictingMeetingCount
  attr_accessor :adjacentMeetingCount
  attr_accessor :conflictingMeetings
  attr_accessor :adjacentMeetings
  attr_accessor :duration
  attr_accessor :timeZone
  attr_accessor :appointmentReplyTime
  attr_accessor :appointmentSequenceNumber
  attr_accessor :appointmentState
  attr_accessor :recurrence
  attr_accessor :firstOccurrence
  attr_accessor :lastOccurrence
  attr_accessor :modifiedOccurrences
  attr_accessor :deletedOccurrences
  attr_accessor :meetingTimeZone
  attr_accessor :conferenceType
  attr_accessor :allowNewTimeProposal
  attr_accessor :isOnlineMeeting
  attr_accessor :meetingWorkspaceUrl
  attr_accessor :netShowUrl

  def m_end
    @v_end
  end

  def m_end=(value)
    @v_end = value
  end

  def m_when
    @v_when
  end

  def m_when=(value)
    @v_when = value
  end

  def initialize(mimeContent = nil, itemId = nil, parentFolderId = nil, itemClass = nil, subject = nil, sensitivity = nil, body = nil, attachments = nil, dateTimeReceived = nil, size = nil, categories = nil, importance = nil, inReplyTo = nil, isSubmitted = nil, isDraft = nil, isFromMe = nil, isResend = nil, isUnmodified = nil, internetMessageHeaders = nil, dateTimeSent = nil, dateTimeCreated = nil, responseObjects = nil, reminderDueBy = nil, reminderIsSet = nil, reminderMinutesBeforeStart = nil, displayCc = nil, displayTo = nil, hasAttachments = nil, extendedProperty = [], culture = nil, effectiveRights = nil, lastModifiedName = nil, lastModifiedTime = nil, sender = nil, toRecipients = nil, ccRecipients = nil, bccRecipients = nil, isReadReceiptRequested = nil, isDeliveryReceiptRequested = nil, conversationIndex = nil, conversationTopic = nil, from = nil, internetMessageId = nil, isRead = nil, isResponseRequested = nil, references = nil, replyTo = nil, receivedBy = nil, receivedRepresenting = nil, associatedCalendarItemId = nil, isDelegated = nil, isOutOfDate = nil, hasBeenProcessed = nil, responseType = nil, uID = nil, recurrenceId = nil, dateTimeStamp = nil, meetingRequestType = nil, intendedFreeBusyStatus = nil, start = nil, v_end = nil, originalStart = nil, isAllDayEvent = nil, legacyFreeBusyStatus = nil, location = nil, v_when = nil, isMeeting = nil, isCancelled = nil, isRecurring = nil, meetingRequestWasSent = nil, calendarItemType = nil, myResponseType = nil, organizer = nil, requiredAttendees = nil, optionalAttendees = nil, resources = nil, conflictingMeetingCount = nil, adjacentMeetingCount = nil, conflictingMeetings = nil, adjacentMeetings = nil, duration = nil, timeZone = nil, appointmentReplyTime = nil, appointmentSequenceNumber = nil, appointmentState = nil, recurrence = nil, firstOccurrence = nil, lastOccurrence = nil, modifiedOccurrences = nil, deletedOccurrences = nil, meetingTimeZone = nil, conferenceType = nil, allowNewTimeProposal = nil, isOnlineMeeting = nil, meetingWorkspaceUrl = nil, netShowUrl = nil)
    @mimeContent = mimeContent
    @itemId = itemId
    @parentFolderId = parentFolderId
    @itemClass = itemClass
    @subject = subject
    @sensitivity = sensitivity
    @body = body
    @attachments = attachments
    @dateTimeReceived = dateTimeReceived
    @size = size
    @categories = categories
    @importance = importance
    @inReplyTo = inReplyTo
    @isSubmitted = isSubmitted
    @isDraft = isDraft
    @isFromMe = isFromMe
    @isResend = isResend
    @isUnmodified = isUnmodified
    @internetMessageHeaders = internetMessageHeaders
    @dateTimeSent = dateTimeSent
    @dateTimeCreated = dateTimeCreated
    @responseObjects = responseObjects
    @reminderDueBy = reminderDueBy
    @reminderIsSet = reminderIsSet
    @reminderMinutesBeforeStart = reminderMinutesBeforeStart
    @displayCc = displayCc
    @displayTo = displayTo
    @hasAttachments = hasAttachments
    @extendedProperty = extendedProperty
    @culture = culture
    @effectiveRights = effectiveRights
    @lastModifiedName = lastModifiedName
    @lastModifiedTime = lastModifiedTime
    @sender = sender
    @toRecipients = toRecipients
    @ccRecipients = ccRecipients
    @bccRecipients = bccRecipients
    @isReadReceiptRequested = isReadReceiptRequested
    @isDeliveryReceiptRequested = isDeliveryReceiptRequested
    @conversationIndex = conversationIndex
    @conversationTopic = conversationTopic
    @from = from
    @internetMessageId = internetMessageId
    @isRead = isRead
    @isResponseRequested = isResponseRequested
    @references = references
    @replyTo = replyTo
    @receivedBy = receivedBy
    @receivedRepresenting = receivedRepresenting
    @associatedCalendarItemId = associatedCalendarItemId
    @isDelegated = isDelegated
    @isOutOfDate = isOutOfDate
    @hasBeenProcessed = hasBeenProcessed
    @responseType = responseType
    @uID = uID
    @recurrenceId = recurrenceId
    @dateTimeStamp = dateTimeStamp
    @meetingRequestType = meetingRequestType
    @intendedFreeBusyStatus = intendedFreeBusyStatus
    @start = start
    @v_end = v_end
    @originalStart = originalStart
    @isAllDayEvent = isAllDayEvent
    @legacyFreeBusyStatus = legacyFreeBusyStatus
    @location = location
    @v_when = v_when
    @isMeeting = isMeeting
    @isCancelled = isCancelled
    @isRecurring = isRecurring
    @meetingRequestWasSent = meetingRequestWasSent
    @calendarItemType = calendarItemType
    @myResponseType = myResponseType
    @organizer = organizer
    @requiredAttendees = requiredAttendees
    @optionalAttendees = optionalAttendees
    @resources = resources
    @conflictingMeetingCount = conflictingMeetingCount
    @adjacentMeetingCount = adjacentMeetingCount
    @conflictingMeetings = conflictingMeetings
    @adjacentMeetings = adjacentMeetings
    @duration = duration
    @timeZone = timeZone
    @appointmentReplyTime = appointmentReplyTime
    @appointmentSequenceNumber = appointmentSequenceNumber
    @appointmentState = appointmentState
    @recurrence = recurrence
    @firstOccurrence = firstOccurrence
    @lastOccurrence = lastOccurrence
    @modifiedOccurrences = modifiedOccurrences
    @deletedOccurrences = deletedOccurrences
    @meetingTimeZone = meetingTimeZone
    @conferenceType = conferenceType
    @allowNewTimeProposal = allowNewTimeProposal
    @isOnlineMeeting = isOnlineMeeting
    @meetingWorkspaceUrl = meetingWorkspaceUrl
    @netShowUrl = netShowUrl
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}MeetingResponseMessageType
#   mimeContent - MimeContentType
#   itemId - ItemIdType
#   parentFolderId - FolderIdType
#   itemClass - (any)
#   subject - SOAP::SOAPString
#   sensitivity - SensitivityChoicesType
#   body - BodyType
#   attachments - NonEmptyArrayOfAttachmentsType
#   dateTimeReceived - SOAP::SOAPDateTime
#   size - SOAP::SOAPInt
#   categories - ArrayOfStringsType
#   importance - ImportanceChoicesType
#   inReplyTo - SOAP::SOAPString
#   isSubmitted - SOAP::SOAPBoolean
#   isDraft - SOAP::SOAPBoolean
#   isFromMe - SOAP::SOAPBoolean
#   isResend - SOAP::SOAPBoolean
#   isUnmodified - SOAP::SOAPBoolean
#   internetMessageHeaders - NonEmptyArrayOfInternetHeadersType
#   dateTimeSent - SOAP::SOAPDateTime
#   dateTimeCreated - SOAP::SOAPDateTime
#   responseObjects - NonEmptyArrayOfResponseObjectsType
#   reminderDueBy - SOAP::SOAPDateTime
#   reminderIsSet - SOAP::SOAPBoolean
#   reminderMinutesBeforeStart - (any)
#   displayCc - SOAP::SOAPString
#   displayTo - SOAP::SOAPString
#   hasAttachments - SOAP::SOAPBoolean
#   extendedProperty - ExtendedPropertyType
#   culture - SOAP::SOAPLanguage
#   effectiveRights - EffectiveRightsType
#   lastModifiedName - SOAP::SOAPString
#   lastModifiedTime - SOAP::SOAPDateTime
#   sender - SingleRecipientType
#   toRecipients - ArrayOfRecipientsType
#   ccRecipients - ArrayOfRecipientsType
#   bccRecipients - ArrayOfRecipientsType
#   isReadReceiptRequested - SOAP::SOAPBoolean
#   isDeliveryReceiptRequested - SOAP::SOAPBoolean
#   conversationIndex - SOAP::SOAPBase64
#   conversationTopic - SOAP::SOAPString
#   from - SingleRecipientType
#   internetMessageId - SOAP::SOAPString
#   isRead - SOAP::SOAPBoolean
#   isResponseRequested - SOAP::SOAPBoolean
#   references - SOAP::SOAPString
#   replyTo - ArrayOfRecipientsType
#   receivedBy - SingleRecipientType
#   receivedRepresenting - SingleRecipientType
#   associatedCalendarItemId - ItemIdType
#   isDelegated - SOAP::SOAPBoolean
#   isOutOfDate - SOAP::SOAPBoolean
#   hasBeenProcessed - SOAP::SOAPBoolean
#   responseType - ResponseTypeType
#   uID - SOAP::SOAPString
#   recurrenceId - SOAP::SOAPDateTime
#   dateTimeStamp - SOAP::SOAPDateTime
class MeetingResponseMessageType < MeetingMessageType
  attr_accessor :mimeContent
  attr_accessor :itemId
  attr_accessor :parentFolderId
  attr_accessor :itemClass
  attr_accessor :subject
  attr_accessor :sensitivity
  attr_accessor :body
  attr_accessor :attachments
  attr_accessor :dateTimeReceived
  attr_accessor :size
  attr_accessor :categories
  attr_accessor :importance
  attr_accessor :inReplyTo
  attr_accessor :isSubmitted
  attr_accessor :isDraft
  attr_accessor :isFromMe
  attr_accessor :isResend
  attr_accessor :isUnmodified
  attr_accessor :internetMessageHeaders
  attr_accessor :dateTimeSent
  attr_accessor :dateTimeCreated
  attr_accessor :responseObjects
  attr_accessor :reminderDueBy
  attr_accessor :reminderIsSet
  attr_accessor :reminderMinutesBeforeStart
  attr_accessor :displayCc
  attr_accessor :displayTo
  attr_accessor :hasAttachments
  attr_accessor :extendedProperty
  attr_accessor :culture
  attr_accessor :effectiveRights
  attr_accessor :lastModifiedName
  attr_accessor :lastModifiedTime
  attr_accessor :sender
  attr_accessor :toRecipients
  attr_accessor :ccRecipients
  attr_accessor :bccRecipients
  attr_accessor :isReadReceiptRequested
  attr_accessor :isDeliveryReceiptRequested
  attr_accessor :conversationIndex
  attr_accessor :conversationTopic
  attr_accessor :from
  attr_accessor :internetMessageId
  attr_accessor :isRead
  attr_accessor :isResponseRequested
  attr_accessor :references
  attr_accessor :replyTo
  attr_accessor :receivedBy
  attr_accessor :receivedRepresenting
  attr_accessor :associatedCalendarItemId
  attr_accessor :isDelegated
  attr_accessor :isOutOfDate
  attr_accessor :hasBeenProcessed
  attr_accessor :responseType
  attr_accessor :uID
  attr_accessor :recurrenceId
  attr_accessor :dateTimeStamp

  def initialize(mimeContent = nil, itemId = nil, parentFolderId = nil, itemClass = nil, subject = nil, sensitivity = nil, body = nil, attachments = nil, dateTimeReceived = nil, size = nil, categories = nil, importance = nil, inReplyTo = nil, isSubmitted = nil, isDraft = nil, isFromMe = nil, isResend = nil, isUnmodified = nil, internetMessageHeaders = nil, dateTimeSent = nil, dateTimeCreated = nil, responseObjects = nil, reminderDueBy = nil, reminderIsSet = nil, reminderMinutesBeforeStart = nil, displayCc = nil, displayTo = nil, hasAttachments = nil, extendedProperty = [], culture = nil, effectiveRights = nil, lastModifiedName = nil, lastModifiedTime = nil, sender = nil, toRecipients = nil, ccRecipients = nil, bccRecipients = nil, isReadReceiptRequested = nil, isDeliveryReceiptRequested = nil, conversationIndex = nil, conversationTopic = nil, from = nil, internetMessageId = nil, isRead = nil, isResponseRequested = nil, references = nil, replyTo = nil, receivedBy = nil, receivedRepresenting = nil, associatedCalendarItemId = nil, isDelegated = nil, isOutOfDate = nil, hasBeenProcessed = nil, responseType = nil, uID = nil, recurrenceId = nil, dateTimeStamp = nil)
    @mimeContent = mimeContent
    @itemId = itemId
    @parentFolderId = parentFolderId
    @itemClass = itemClass
    @subject = subject
    @sensitivity = sensitivity
    @body = body
    @attachments = attachments
    @dateTimeReceived = dateTimeReceived
    @size = size
    @categories = categories
    @importance = importance
    @inReplyTo = inReplyTo
    @isSubmitted = isSubmitted
    @isDraft = isDraft
    @isFromMe = isFromMe
    @isResend = isResend
    @isUnmodified = isUnmodified
    @internetMessageHeaders = internetMessageHeaders
    @dateTimeSent = dateTimeSent
    @dateTimeCreated = dateTimeCreated
    @responseObjects = responseObjects
    @reminderDueBy = reminderDueBy
    @reminderIsSet = reminderIsSet
    @reminderMinutesBeforeStart = reminderMinutesBeforeStart
    @displayCc = displayCc
    @displayTo = displayTo
    @hasAttachments = hasAttachments
    @extendedProperty = extendedProperty
    @culture = culture
    @effectiveRights = effectiveRights
    @lastModifiedName = lastModifiedName
    @lastModifiedTime = lastModifiedTime
    @sender = sender
    @toRecipients = toRecipients
    @ccRecipients = ccRecipients
    @bccRecipients = bccRecipients
    @isReadReceiptRequested = isReadReceiptRequested
    @isDeliveryReceiptRequested = isDeliveryReceiptRequested
    @conversationIndex = conversationIndex
    @conversationTopic = conversationTopic
    @from = from
    @internetMessageId = internetMessageId
    @isRead = isRead
    @isResponseRequested = isResponseRequested
    @references = references
    @replyTo = replyTo
    @receivedBy = receivedBy
    @receivedRepresenting = receivedRepresenting
    @associatedCalendarItemId = associatedCalendarItemId
    @isDelegated = isDelegated
    @isOutOfDate = isOutOfDate
    @hasBeenProcessed = hasBeenProcessed
    @responseType = responseType
    @uID = uID
    @recurrenceId = recurrenceId
    @dateTimeStamp = dateTimeStamp
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}MeetingCancellationMessageType
#   mimeContent - MimeContentType
#   itemId - ItemIdType
#   parentFolderId - FolderIdType
#   itemClass - (any)
#   subject - SOAP::SOAPString
#   sensitivity - SensitivityChoicesType
#   body - BodyType
#   attachments - NonEmptyArrayOfAttachmentsType
#   dateTimeReceived - SOAP::SOAPDateTime
#   size - SOAP::SOAPInt
#   categories - ArrayOfStringsType
#   importance - ImportanceChoicesType
#   inReplyTo - SOAP::SOAPString
#   isSubmitted - SOAP::SOAPBoolean
#   isDraft - SOAP::SOAPBoolean
#   isFromMe - SOAP::SOAPBoolean
#   isResend - SOAP::SOAPBoolean
#   isUnmodified - SOAP::SOAPBoolean
#   internetMessageHeaders - NonEmptyArrayOfInternetHeadersType
#   dateTimeSent - SOAP::SOAPDateTime
#   dateTimeCreated - SOAP::SOAPDateTime
#   responseObjects - NonEmptyArrayOfResponseObjectsType
#   reminderDueBy - SOAP::SOAPDateTime
#   reminderIsSet - SOAP::SOAPBoolean
#   reminderMinutesBeforeStart - (any)
#   displayCc - SOAP::SOAPString
#   displayTo - SOAP::SOAPString
#   hasAttachments - SOAP::SOAPBoolean
#   extendedProperty - ExtendedPropertyType
#   culture - SOAP::SOAPLanguage
#   effectiveRights - EffectiveRightsType
#   lastModifiedName - SOAP::SOAPString
#   lastModifiedTime - SOAP::SOAPDateTime
#   sender - SingleRecipientType
#   toRecipients - ArrayOfRecipientsType
#   ccRecipients - ArrayOfRecipientsType
#   bccRecipients - ArrayOfRecipientsType
#   isReadReceiptRequested - SOAP::SOAPBoolean
#   isDeliveryReceiptRequested - SOAP::SOAPBoolean
#   conversationIndex - SOAP::SOAPBase64
#   conversationTopic - SOAP::SOAPString
#   from - SingleRecipientType
#   internetMessageId - SOAP::SOAPString
#   isRead - SOAP::SOAPBoolean
#   isResponseRequested - SOAP::SOAPBoolean
#   references - SOAP::SOAPString
#   replyTo - ArrayOfRecipientsType
#   receivedBy - SingleRecipientType
#   receivedRepresenting - SingleRecipientType
#   associatedCalendarItemId - ItemIdType
#   isDelegated - SOAP::SOAPBoolean
#   isOutOfDate - SOAP::SOAPBoolean
#   hasBeenProcessed - SOAP::SOAPBoolean
#   responseType - ResponseTypeType
#   uID - SOAP::SOAPString
#   recurrenceId - SOAP::SOAPDateTime
#   dateTimeStamp - SOAP::SOAPDateTime
class MeetingCancellationMessageType < MeetingMessageType
  attr_accessor :mimeContent
  attr_accessor :itemId
  attr_accessor :parentFolderId
  attr_accessor :itemClass
  attr_accessor :subject
  attr_accessor :sensitivity
  attr_accessor :body
  attr_accessor :attachments
  attr_accessor :dateTimeReceived
  attr_accessor :size
  attr_accessor :categories
  attr_accessor :importance
  attr_accessor :inReplyTo
  attr_accessor :isSubmitted
  attr_accessor :isDraft
  attr_accessor :isFromMe
  attr_accessor :isResend
  attr_accessor :isUnmodified
  attr_accessor :internetMessageHeaders
  attr_accessor :dateTimeSent
  attr_accessor :dateTimeCreated
  attr_accessor :responseObjects
  attr_accessor :reminderDueBy
  attr_accessor :reminderIsSet
  attr_accessor :reminderMinutesBeforeStart
  attr_accessor :displayCc
  attr_accessor :displayTo
  attr_accessor :hasAttachments
  attr_accessor :extendedProperty
  attr_accessor :culture
  attr_accessor :effectiveRights
  attr_accessor :lastModifiedName
  attr_accessor :lastModifiedTime
  attr_accessor :sender
  attr_accessor :toRecipients
  attr_accessor :ccRecipients
  attr_accessor :bccRecipients
  attr_accessor :isReadReceiptRequested
  attr_accessor :isDeliveryReceiptRequested
  attr_accessor :conversationIndex
  attr_accessor :conversationTopic
  attr_accessor :from
  attr_accessor :internetMessageId
  attr_accessor :isRead
  attr_accessor :isResponseRequested
  attr_accessor :references
  attr_accessor :replyTo
  attr_accessor :receivedBy
  attr_accessor :receivedRepresenting
  attr_accessor :associatedCalendarItemId
  attr_accessor :isDelegated
  attr_accessor :isOutOfDate
  attr_accessor :hasBeenProcessed
  attr_accessor :responseType
  attr_accessor :uID
  attr_accessor :recurrenceId
  attr_accessor :dateTimeStamp

  def initialize(mimeContent = nil, itemId = nil, parentFolderId = nil, itemClass = nil, subject = nil, sensitivity = nil, body = nil, attachments = nil, dateTimeReceived = nil, size = nil, categories = nil, importance = nil, inReplyTo = nil, isSubmitted = nil, isDraft = nil, isFromMe = nil, isResend = nil, isUnmodified = nil, internetMessageHeaders = nil, dateTimeSent = nil, dateTimeCreated = nil, responseObjects = nil, reminderDueBy = nil, reminderIsSet = nil, reminderMinutesBeforeStart = nil, displayCc = nil, displayTo = nil, hasAttachments = nil, extendedProperty = [], culture = nil, effectiveRights = nil, lastModifiedName = nil, lastModifiedTime = nil, sender = nil, toRecipients = nil, ccRecipients = nil, bccRecipients = nil, isReadReceiptRequested = nil, isDeliveryReceiptRequested = nil, conversationIndex = nil, conversationTopic = nil, from = nil, internetMessageId = nil, isRead = nil, isResponseRequested = nil, references = nil, replyTo = nil, receivedBy = nil, receivedRepresenting = nil, associatedCalendarItemId = nil, isDelegated = nil, isOutOfDate = nil, hasBeenProcessed = nil, responseType = nil, uID = nil, recurrenceId = nil, dateTimeStamp = nil)
    @mimeContent = mimeContent
    @itemId = itemId
    @parentFolderId = parentFolderId
    @itemClass = itemClass
    @subject = subject
    @sensitivity = sensitivity
    @body = body
    @attachments = attachments
    @dateTimeReceived = dateTimeReceived
    @size = size
    @categories = categories
    @importance = importance
    @inReplyTo = inReplyTo
    @isSubmitted = isSubmitted
    @isDraft = isDraft
    @isFromMe = isFromMe
    @isResend = isResend
    @isUnmodified = isUnmodified
    @internetMessageHeaders = internetMessageHeaders
    @dateTimeSent = dateTimeSent
    @dateTimeCreated = dateTimeCreated
    @responseObjects = responseObjects
    @reminderDueBy = reminderDueBy
    @reminderIsSet = reminderIsSet
    @reminderMinutesBeforeStart = reminderMinutesBeforeStart
    @displayCc = displayCc
    @displayTo = displayTo
    @hasAttachments = hasAttachments
    @extendedProperty = extendedProperty
    @culture = culture
    @effectiveRights = effectiveRights
    @lastModifiedName = lastModifiedName
    @lastModifiedTime = lastModifiedTime
    @sender = sender
    @toRecipients = toRecipients
    @ccRecipients = ccRecipients
    @bccRecipients = bccRecipients
    @isReadReceiptRequested = isReadReceiptRequested
    @isDeliveryReceiptRequested = isDeliveryReceiptRequested
    @conversationIndex = conversationIndex
    @conversationTopic = conversationTopic
    @from = from
    @internetMessageId = internetMessageId
    @isRead = isRead
    @isResponseRequested = isResponseRequested
    @references = references
    @replyTo = replyTo
    @receivedBy = receivedBy
    @receivedRepresenting = receivedRepresenting
    @associatedCalendarItemId = associatedCalendarItemId
    @isDelegated = isDelegated
    @isOutOfDate = isOutOfDate
    @hasBeenProcessed = hasBeenProcessed
    @responseType = responseType
    @uID = uID
    @recurrenceId = recurrenceId
    @dateTimeStamp = dateTimeStamp
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}TaskType
#   mimeContent - MimeContentType
#   itemId - ItemIdType
#   parentFolderId - FolderIdType
#   itemClass - (any)
#   subject - SOAP::SOAPString
#   sensitivity - SensitivityChoicesType
#   body - BodyType
#   attachments - NonEmptyArrayOfAttachmentsType
#   dateTimeReceived - SOAP::SOAPDateTime
#   size - SOAP::SOAPInt
#   categories - ArrayOfStringsType
#   importance - ImportanceChoicesType
#   inReplyTo - SOAP::SOAPString
#   isSubmitted - SOAP::SOAPBoolean
#   isDraft - SOAP::SOAPBoolean
#   isFromMe - SOAP::SOAPBoolean
#   isResend - SOAP::SOAPBoolean
#   isUnmodified - SOAP::SOAPBoolean
#   internetMessageHeaders - NonEmptyArrayOfInternetHeadersType
#   dateTimeSent - SOAP::SOAPDateTime
#   dateTimeCreated - SOAP::SOAPDateTime
#   responseObjects - NonEmptyArrayOfResponseObjectsType
#   reminderDueBy - SOAP::SOAPDateTime
#   reminderIsSet - SOAP::SOAPBoolean
#   reminderMinutesBeforeStart - (any)
#   displayCc - SOAP::SOAPString
#   displayTo - SOAP::SOAPString
#   hasAttachments - SOAP::SOAPBoolean
#   extendedProperty - ExtendedPropertyType
#   culture - SOAP::SOAPLanguage
#   effectiveRights - EffectiveRightsType
#   lastModifiedName - SOAP::SOAPString
#   lastModifiedTime - SOAP::SOAPDateTime
#   actualWork - SOAP::SOAPInt
#   assignedTime - SOAP::SOAPDateTime
#   billingInformation - SOAP::SOAPString
#   changeCount - SOAP::SOAPInt
#   companies - ArrayOfStringsType
#   completeDate - SOAP::SOAPDateTime
#   contacts - ArrayOfStringsType
#   delegationState - TaskDelegateStateType
#   delegator - SOAP::SOAPString
#   dueDate - SOAP::SOAPDateTime
#   isAssignmentEditable - SOAP::SOAPInt
#   isComplete - SOAP::SOAPBoolean
#   isRecurring - SOAP::SOAPBoolean
#   isTeamTask - SOAP::SOAPBoolean
#   mileage - SOAP::SOAPString
#   owner - SOAP::SOAPString
#   percentComplete - SOAP::SOAPDouble
#   recurrence - TaskRecurrenceType
#   startDate - SOAP::SOAPDateTime
#   status - TaskStatusType
#   statusDescription - SOAP::SOAPString
#   totalWork - SOAP::SOAPInt
class TaskType < ItemType
  attr_accessor :mimeContent
  attr_accessor :itemId
  attr_accessor :parentFolderId
  attr_accessor :itemClass
  attr_accessor :subject
  attr_accessor :sensitivity
  attr_accessor :body
  attr_accessor :attachments
  attr_accessor :dateTimeReceived
  attr_accessor :size
  attr_accessor :categories
  attr_accessor :importance
  attr_accessor :inReplyTo
  attr_accessor :isSubmitted
  attr_accessor :isDraft
  attr_accessor :isFromMe
  attr_accessor :isResend
  attr_accessor :isUnmodified
  attr_accessor :internetMessageHeaders
  attr_accessor :dateTimeSent
  attr_accessor :dateTimeCreated
  attr_accessor :responseObjects
  attr_accessor :reminderDueBy
  attr_accessor :reminderIsSet
  attr_accessor :reminderMinutesBeforeStart
  attr_accessor :displayCc
  attr_accessor :displayTo
  attr_accessor :hasAttachments
  attr_accessor :extendedProperty
  attr_accessor :culture
  attr_accessor :effectiveRights
  attr_accessor :lastModifiedName
  attr_accessor :lastModifiedTime
  attr_accessor :actualWork
  attr_accessor :assignedTime
  attr_accessor :billingInformation
  attr_accessor :changeCount
  attr_accessor :companies
  attr_accessor :completeDate
  attr_accessor :contacts
  attr_accessor :delegationState
  attr_accessor :delegator
  attr_accessor :dueDate
  attr_accessor :isAssignmentEditable
  attr_accessor :isComplete
  attr_accessor :isRecurring
  attr_accessor :isTeamTask
  attr_accessor :mileage
  attr_accessor :owner
  attr_accessor :percentComplete
  attr_accessor :recurrence
  attr_accessor :startDate
  attr_accessor :status
  attr_accessor :statusDescription
  attr_accessor :totalWork

  def initialize(mimeContent = nil, itemId = nil, parentFolderId = nil, itemClass = nil, subject = nil, sensitivity = nil, body = nil, attachments = nil, dateTimeReceived = nil, size = nil, categories = nil, importance = nil, inReplyTo = nil, isSubmitted = nil, isDraft = nil, isFromMe = nil, isResend = nil, isUnmodified = nil, internetMessageHeaders = nil, dateTimeSent = nil, dateTimeCreated = nil, responseObjects = nil, reminderDueBy = nil, reminderIsSet = nil, reminderMinutesBeforeStart = nil, displayCc = nil, displayTo = nil, hasAttachments = nil, extendedProperty = [], culture = nil, effectiveRights = nil, lastModifiedName = nil, lastModifiedTime = nil, actualWork = nil, assignedTime = nil, billingInformation = nil, changeCount = nil, companies = nil, completeDate = nil, contacts = nil, delegationState = nil, delegator = nil, dueDate = nil, isAssignmentEditable = nil, isComplete = nil, isRecurring = nil, isTeamTask = nil, mileage = nil, owner = nil, percentComplete = nil, recurrence = nil, startDate = nil, status = nil, statusDescription = nil, totalWork = nil)
    @mimeContent = mimeContent
    @itemId = itemId
    @parentFolderId = parentFolderId
    @itemClass = itemClass
    @subject = subject
    @sensitivity = sensitivity
    @body = body
    @attachments = attachments
    @dateTimeReceived = dateTimeReceived
    @size = size
    @categories = categories
    @importance = importance
    @inReplyTo = inReplyTo
    @isSubmitted = isSubmitted
    @isDraft = isDraft
    @isFromMe = isFromMe
    @isResend = isResend
    @isUnmodified = isUnmodified
    @internetMessageHeaders = internetMessageHeaders
    @dateTimeSent = dateTimeSent
    @dateTimeCreated = dateTimeCreated
    @responseObjects = responseObjects
    @reminderDueBy = reminderDueBy
    @reminderIsSet = reminderIsSet
    @reminderMinutesBeforeStart = reminderMinutesBeforeStart
    @displayCc = displayCc
    @displayTo = displayTo
    @hasAttachments = hasAttachments
    @extendedProperty = extendedProperty
    @culture = culture
    @effectiveRights = effectiveRights
    @lastModifiedName = lastModifiedName
    @lastModifiedTime = lastModifiedTime
    @actualWork = actualWork
    @assignedTime = assignedTime
    @billingInformation = billingInformation
    @changeCount = changeCount
    @companies = companies
    @completeDate = completeDate
    @contacts = contacts
    @delegationState = delegationState
    @delegator = delegator
    @dueDate = dueDate
    @isAssignmentEditable = isAssignmentEditable
    @isComplete = isComplete
    @isRecurring = isRecurring
    @isTeamTask = isTeamTask
    @mileage = mileage
    @owner = owner
    @percentComplete = percentComplete
    @recurrence = recurrence
    @startDate = startDate
    @status = status
    @statusDescription = statusDescription
    @totalWork = totalWork
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}PostItemType
#   mimeContent - MimeContentType
#   itemId - ItemIdType
#   parentFolderId - FolderIdType
#   itemClass - (any)
#   subject - SOAP::SOAPString
#   sensitivity - SensitivityChoicesType
#   body - BodyType
#   attachments - NonEmptyArrayOfAttachmentsType
#   dateTimeReceived - SOAP::SOAPDateTime
#   size - SOAP::SOAPInt
#   categories - ArrayOfStringsType
#   importance - ImportanceChoicesType
#   inReplyTo - SOAP::SOAPString
#   isSubmitted - SOAP::SOAPBoolean
#   isDraft - SOAP::SOAPBoolean
#   isFromMe - SOAP::SOAPBoolean
#   isResend - SOAP::SOAPBoolean
#   isUnmodified - SOAP::SOAPBoolean
#   internetMessageHeaders - NonEmptyArrayOfInternetHeadersType
#   dateTimeSent - SOAP::SOAPDateTime
#   dateTimeCreated - SOAP::SOAPDateTime
#   responseObjects - NonEmptyArrayOfResponseObjectsType
#   reminderDueBy - SOAP::SOAPDateTime
#   reminderIsSet - SOAP::SOAPBoolean
#   reminderMinutesBeforeStart - (any)
#   displayCc - SOAP::SOAPString
#   displayTo - SOAP::SOAPString
#   hasAttachments - SOAP::SOAPBoolean
#   extendedProperty - ExtendedPropertyType
#   culture - SOAP::SOAPLanguage
#   effectiveRights - EffectiveRightsType
#   lastModifiedName - SOAP::SOAPString
#   lastModifiedTime - SOAP::SOAPDateTime
#   conversationIndex - SOAP::SOAPBase64
#   conversationTopic - SOAP::SOAPString
#   from - SingleRecipientType
#   internetMessageId - SOAP::SOAPString
#   isRead - SOAP::SOAPBoolean
#   postedTime - SOAP::SOAPDateTime
#   references - SOAP::SOAPString
#   sender - SingleRecipientType
class PostItemType < ItemType
  attr_accessor :mimeContent
  attr_accessor :itemId
  attr_accessor :parentFolderId
  attr_accessor :itemClass
  attr_accessor :subject
  attr_accessor :sensitivity
  attr_accessor :body
  attr_accessor :attachments
  attr_accessor :dateTimeReceived
  attr_accessor :size
  attr_accessor :categories
  attr_accessor :importance
  attr_accessor :inReplyTo
  attr_accessor :isSubmitted
  attr_accessor :isDraft
  attr_accessor :isFromMe
  attr_accessor :isResend
  attr_accessor :isUnmodified
  attr_accessor :internetMessageHeaders
  attr_accessor :dateTimeSent
  attr_accessor :dateTimeCreated
  attr_accessor :responseObjects
  attr_accessor :reminderDueBy
  attr_accessor :reminderIsSet
  attr_accessor :reminderMinutesBeforeStart
  attr_accessor :displayCc
  attr_accessor :displayTo
  attr_accessor :hasAttachments
  attr_accessor :extendedProperty
  attr_accessor :culture
  attr_accessor :effectiveRights
  attr_accessor :lastModifiedName
  attr_accessor :lastModifiedTime
  attr_accessor :conversationIndex
  attr_accessor :conversationTopic
  attr_accessor :from
  attr_accessor :internetMessageId
  attr_accessor :isRead
  attr_accessor :postedTime
  attr_accessor :references
  attr_accessor :sender

  def initialize(mimeContent = nil, itemId = nil, parentFolderId = nil, itemClass = nil, subject = nil, sensitivity = nil, body = nil, attachments = nil, dateTimeReceived = nil, size = nil, categories = nil, importance = nil, inReplyTo = nil, isSubmitted = nil, isDraft = nil, isFromMe = nil, isResend = nil, isUnmodified = nil, internetMessageHeaders = nil, dateTimeSent = nil, dateTimeCreated = nil, responseObjects = nil, reminderDueBy = nil, reminderIsSet = nil, reminderMinutesBeforeStart = nil, displayCc = nil, displayTo = nil, hasAttachments = nil, extendedProperty = [], culture = nil, effectiveRights = nil, lastModifiedName = nil, lastModifiedTime = nil, conversationIndex = nil, conversationTopic = nil, from = nil, internetMessageId = nil, isRead = nil, postedTime = nil, references = nil, sender = nil)
    @mimeContent = mimeContent
    @itemId = itemId
    @parentFolderId = parentFolderId
    @itemClass = itemClass
    @subject = subject
    @sensitivity = sensitivity
    @body = body
    @attachments = attachments
    @dateTimeReceived = dateTimeReceived
    @size = size
    @categories = categories
    @importance = importance
    @inReplyTo = inReplyTo
    @isSubmitted = isSubmitted
    @isDraft = isDraft
    @isFromMe = isFromMe
    @isResend = isResend
    @isUnmodified = isUnmodified
    @internetMessageHeaders = internetMessageHeaders
    @dateTimeSent = dateTimeSent
    @dateTimeCreated = dateTimeCreated
    @responseObjects = responseObjects
    @reminderDueBy = reminderDueBy
    @reminderIsSet = reminderIsSet
    @reminderMinutesBeforeStart = reminderMinutesBeforeStart
    @displayCc = displayCc
    @displayTo = displayTo
    @hasAttachments = hasAttachments
    @extendedProperty = extendedProperty
    @culture = culture
    @effectiveRights = effectiveRights
    @lastModifiedName = lastModifiedName
    @lastModifiedTime = lastModifiedTime
    @conversationIndex = conversationIndex
    @conversationTopic = conversationTopic
    @from = from
    @internetMessageId = internetMessageId
    @isRead = isRead
    @postedTime = postedTime
    @references = references
    @sender = sender
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}CalendarItemType
#   mimeContent - MimeContentType
#   itemId - ItemIdType
#   parentFolderId - FolderIdType
#   itemClass - (any)
#   subject - SOAP::SOAPString
#   sensitivity - SensitivityChoicesType
#   body - BodyType
#   attachments - NonEmptyArrayOfAttachmentsType
#   dateTimeReceived - SOAP::SOAPDateTime
#   size - SOAP::SOAPInt
#   categories - ArrayOfStringsType
#   importance - ImportanceChoicesType
#   inReplyTo - SOAP::SOAPString
#   isSubmitted - SOAP::SOAPBoolean
#   isDraft - SOAP::SOAPBoolean
#   isFromMe - SOAP::SOAPBoolean
#   isResend - SOAP::SOAPBoolean
#   isUnmodified - SOAP::SOAPBoolean
#   internetMessageHeaders - NonEmptyArrayOfInternetHeadersType
#   dateTimeSent - SOAP::SOAPDateTime
#   dateTimeCreated - SOAP::SOAPDateTime
#   responseObjects - NonEmptyArrayOfResponseObjectsType
#   reminderDueBy - SOAP::SOAPDateTime
#   reminderIsSet - SOAP::SOAPBoolean
#   reminderMinutesBeforeStart - (any)
#   displayCc - SOAP::SOAPString
#   displayTo - SOAP::SOAPString
#   hasAttachments - SOAP::SOAPBoolean
#   extendedProperty - ExtendedPropertyType
#   culture - SOAP::SOAPLanguage
#   effectiveRights - EffectiveRightsType
#   lastModifiedName - SOAP::SOAPString
#   lastModifiedTime - SOAP::SOAPDateTime
#   uID - SOAP::SOAPString
#   recurrenceId - SOAP::SOAPDateTime
#   dateTimeStamp - SOAP::SOAPDateTime
#   start - SOAP::SOAPDateTime
#   m_end - SOAP::SOAPDateTime
#   originalStart - SOAP::SOAPDateTime
#   isAllDayEvent - SOAP::SOAPBoolean
#   legacyFreeBusyStatus - LegacyFreeBusyType
#   location - SOAP::SOAPString
#   m_when - SOAP::SOAPString
#   isMeeting - SOAP::SOAPBoolean
#   isCancelled - SOAP::SOAPBoolean
#   isRecurring - SOAP::SOAPBoolean
#   meetingRequestWasSent - SOAP::SOAPBoolean
#   isResponseRequested - SOAP::SOAPBoolean
#   calendarItemType - CalendarItemTypeType
#   myResponseType - ResponseTypeType
#   organizer - SingleRecipientType
#   requiredAttendees - NonEmptyArrayOfAttendeesType
#   optionalAttendees - NonEmptyArrayOfAttendeesType
#   resources - NonEmptyArrayOfAttendeesType
#   conflictingMeetingCount - SOAP::SOAPInt
#   adjacentMeetingCount - SOAP::SOAPInt
#   conflictingMeetings - NonEmptyArrayOfAllItemsType
#   adjacentMeetings - NonEmptyArrayOfAllItemsType
#   duration - SOAP::SOAPString
#   timeZone - SOAP::SOAPString
#   appointmentReplyTime - SOAP::SOAPDateTime
#   appointmentSequenceNumber - SOAP::SOAPInt
#   appointmentState - SOAP::SOAPInt
#   recurrence - RecurrenceType
#   firstOccurrence - OccurrenceInfoType
#   lastOccurrence - OccurrenceInfoType
#   modifiedOccurrences - NonEmptyArrayOfOccurrenceInfoType
#   deletedOccurrences - NonEmptyArrayOfDeletedOccurrencesType
#   meetingTimeZone - TimeZoneType
#   conferenceType - SOAP::SOAPInt
#   allowNewTimeProposal - SOAP::SOAPBoolean
#   isOnlineMeeting - SOAP::SOAPBoolean
#   meetingWorkspaceUrl - SOAP::SOAPString
#   netShowUrl - SOAP::SOAPString
class CalendarItemType < ItemType
  attr_accessor :mimeContent
  attr_accessor :itemId
  attr_accessor :parentFolderId
  attr_accessor :itemClass
  attr_accessor :subject
  attr_accessor :sensitivity
  attr_accessor :body
  attr_accessor :attachments
  attr_accessor :dateTimeReceived
  attr_accessor :size
  attr_accessor :categories
  attr_accessor :importance
  attr_accessor :inReplyTo
  attr_accessor :isSubmitted
  attr_accessor :isDraft
  attr_accessor :isFromMe
  attr_accessor :isResend
  attr_accessor :isUnmodified
  attr_accessor :internetMessageHeaders
  attr_accessor :dateTimeSent
  attr_accessor :dateTimeCreated
  attr_accessor :responseObjects
  attr_accessor :reminderDueBy
  attr_accessor :reminderIsSet
  attr_accessor :reminderMinutesBeforeStart
  attr_accessor :displayCc
  attr_accessor :displayTo
  attr_accessor :hasAttachments
  attr_accessor :extendedProperty
  attr_accessor :culture
  attr_accessor :effectiveRights
  attr_accessor :lastModifiedName
  attr_accessor :lastModifiedTime
  attr_accessor :uID
  attr_accessor :recurrenceId
  attr_accessor :dateTimeStamp
  attr_accessor :start
  attr_accessor :originalStart
  attr_accessor :isAllDayEvent
  attr_accessor :legacyFreeBusyStatus
  attr_accessor :location
  attr_accessor :isMeeting
  attr_accessor :isCancelled
  attr_accessor :isRecurring
  attr_accessor :meetingRequestWasSent
  attr_accessor :isResponseRequested
  attr_accessor :calendarItemType
  attr_accessor :myResponseType
  attr_accessor :organizer
  attr_accessor :requiredAttendees
  attr_accessor :optionalAttendees
  attr_accessor :resources
  attr_accessor :conflictingMeetingCount
  attr_accessor :adjacentMeetingCount
  attr_accessor :conflictingMeetings
  attr_accessor :adjacentMeetings
  attr_accessor :duration
  attr_accessor :timeZone
  attr_accessor :appointmentReplyTime
  attr_accessor :appointmentSequenceNumber
  attr_accessor :appointmentState
  attr_accessor :recurrence
  attr_accessor :firstOccurrence
  attr_accessor :lastOccurrence
  attr_accessor :modifiedOccurrences
  attr_accessor :deletedOccurrences
  attr_accessor :meetingTimeZone
  attr_accessor :conferenceType
  attr_accessor :allowNewTimeProposal
  attr_accessor :isOnlineMeeting
  attr_accessor :meetingWorkspaceUrl
  attr_accessor :netShowUrl

  def m_end
    @v_end
  end

  def m_end=(value)
    @v_end = value
  end

  def m_when
    @v_when
  end

  def m_when=(value)
    @v_when = value
  end

  def initialize(mimeContent = nil, itemId = nil, parentFolderId = nil, itemClass = nil, subject = nil, sensitivity = nil, body = nil, attachments = nil, dateTimeReceived = nil, size = nil, categories = nil, importance = nil, inReplyTo = nil, isSubmitted = nil, isDraft = nil, isFromMe = nil, isResend = nil, isUnmodified = nil, internetMessageHeaders = nil, dateTimeSent = nil, dateTimeCreated = nil, responseObjects = nil, reminderDueBy = nil, reminderIsSet = nil, reminderMinutesBeforeStart = nil, displayCc = nil, displayTo = nil, hasAttachments = nil, extendedProperty = [], culture = nil, effectiveRights = nil, lastModifiedName = nil, lastModifiedTime = nil, uID = nil, recurrenceId = nil, dateTimeStamp = nil, start = nil, v_end = nil, originalStart = nil, isAllDayEvent = nil, legacyFreeBusyStatus = nil, location = nil, v_when = nil, isMeeting = nil, isCancelled = nil, isRecurring = nil, meetingRequestWasSent = nil, isResponseRequested = nil, calendarItemType = nil, myResponseType = nil, organizer = nil, requiredAttendees = nil, optionalAttendees = nil, resources = nil, conflictingMeetingCount = nil, adjacentMeetingCount = nil, conflictingMeetings = nil, adjacentMeetings = nil, duration = nil, timeZone = nil, appointmentReplyTime = nil, appointmentSequenceNumber = nil, appointmentState = nil, recurrence = nil, firstOccurrence = nil, lastOccurrence = nil, modifiedOccurrences = nil, deletedOccurrences = nil, meetingTimeZone = nil, conferenceType = nil, allowNewTimeProposal = nil, isOnlineMeeting = nil, meetingWorkspaceUrl = nil, netShowUrl = nil)
    @mimeContent = mimeContent
    @itemId = itemId
    @parentFolderId = parentFolderId
    @itemClass = itemClass
    @subject = subject
    @sensitivity = sensitivity
    @body = body
    @attachments = attachments
    @dateTimeReceived = dateTimeReceived
    @size = size
    @categories = categories
    @importance = importance
    @inReplyTo = inReplyTo
    @isSubmitted = isSubmitted
    @isDraft = isDraft
    @isFromMe = isFromMe
    @isResend = isResend
    @isUnmodified = isUnmodified
    @internetMessageHeaders = internetMessageHeaders
    @dateTimeSent = dateTimeSent
    @dateTimeCreated = dateTimeCreated
    @responseObjects = responseObjects
    @reminderDueBy = reminderDueBy
    @reminderIsSet = reminderIsSet
    @reminderMinutesBeforeStart = reminderMinutesBeforeStart
    @displayCc = displayCc
    @displayTo = displayTo
    @hasAttachments = hasAttachments
    @extendedProperty = extendedProperty
    @culture = culture
    @effectiveRights = effectiveRights
    @lastModifiedName = lastModifiedName
    @lastModifiedTime = lastModifiedTime
    @uID = uID
    @recurrenceId = recurrenceId
    @dateTimeStamp = dateTimeStamp
    @start = start
    @v_end = v_end
    @originalStart = originalStart
    @isAllDayEvent = isAllDayEvent
    @legacyFreeBusyStatus = legacyFreeBusyStatus
    @location = location
    @v_when = v_when
    @isMeeting = isMeeting
    @isCancelled = isCancelled
    @isRecurring = isRecurring
    @meetingRequestWasSent = meetingRequestWasSent
    @isResponseRequested = isResponseRequested
    @calendarItemType = calendarItemType
    @myResponseType = myResponseType
    @organizer = organizer
    @requiredAttendees = requiredAttendees
    @optionalAttendees = optionalAttendees
    @resources = resources
    @conflictingMeetingCount = conflictingMeetingCount
    @adjacentMeetingCount = adjacentMeetingCount
    @conflictingMeetings = conflictingMeetings
    @adjacentMeetings = adjacentMeetings
    @duration = duration
    @timeZone = timeZone
    @appointmentReplyTime = appointmentReplyTime
    @appointmentSequenceNumber = appointmentSequenceNumber
    @appointmentState = appointmentState
    @recurrence = recurrence
    @firstOccurrence = firstOccurrence
    @lastOccurrence = lastOccurrence
    @modifiedOccurrences = modifiedOccurrences
    @deletedOccurrences = deletedOccurrences
    @meetingTimeZone = meetingTimeZone
    @conferenceType = conferenceType
    @allowNewTimeProposal = allowNewTimeProposal
    @isOnlineMeeting = isOnlineMeeting
    @meetingWorkspaceUrl = meetingWorkspaceUrl
    @netShowUrl = netShowUrl
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ContactItemType
#   mimeContent - MimeContentType
#   itemId - ItemIdType
#   parentFolderId - FolderIdType
#   itemClass - (any)
#   subject - SOAP::SOAPString
#   sensitivity - SensitivityChoicesType
#   body - BodyType
#   attachments - NonEmptyArrayOfAttachmentsType
#   dateTimeReceived - SOAP::SOAPDateTime
#   size - SOAP::SOAPInt
#   categories - ArrayOfStringsType
#   importance - ImportanceChoicesType
#   inReplyTo - SOAP::SOAPString
#   isSubmitted - SOAP::SOAPBoolean
#   isDraft - SOAP::SOAPBoolean
#   isFromMe - SOAP::SOAPBoolean
#   isResend - SOAP::SOAPBoolean
#   isUnmodified - SOAP::SOAPBoolean
#   internetMessageHeaders - NonEmptyArrayOfInternetHeadersType
#   dateTimeSent - SOAP::SOAPDateTime
#   dateTimeCreated - SOAP::SOAPDateTime
#   responseObjects - NonEmptyArrayOfResponseObjectsType
#   reminderDueBy - SOAP::SOAPDateTime
#   reminderIsSet - SOAP::SOAPBoolean
#   reminderMinutesBeforeStart - (any)
#   displayCc - SOAP::SOAPString
#   displayTo - SOAP::SOAPString
#   hasAttachments - SOAP::SOAPBoolean
#   extendedProperty - ExtendedPropertyType
#   culture - SOAP::SOAPLanguage
#   effectiveRights - EffectiveRightsType
#   lastModifiedName - SOAP::SOAPString
#   lastModifiedTime - SOAP::SOAPDateTime
#   fileAs - SOAP::SOAPString
#   fileAsMapping - FileAsMappingType
#   displayName - SOAP::SOAPString
#   givenName - SOAP::SOAPString
#   initials - SOAP::SOAPString
#   middleName - SOAP::SOAPString
#   nickname - SOAP::SOAPString
#   completeName - CompleteNameType
#   companyName - SOAP::SOAPString
#   emailAddresses - EmailAddressDictionaryType
#   physicalAddresses - PhysicalAddressDictionaryType
#   phoneNumbers - PhoneNumberDictionaryType
#   assistantName - SOAP::SOAPString
#   birthday - SOAP::SOAPDateTime
#   businessHomePage - SOAP::SOAPAnyURI
#   children - ArrayOfStringsType
#   companies - ArrayOfStringsType
#   contactSource - ContactSourceType
#   department - SOAP::SOAPString
#   generation - SOAP::SOAPString
#   imAddresses - ImAddressDictionaryType
#   jobTitle - SOAP::SOAPString
#   manager - SOAP::SOAPString
#   mileage - SOAP::SOAPString
#   officeLocation - SOAP::SOAPString
#   postalAddressIndex - PhysicalAddressIndexType
#   profession - SOAP::SOAPString
#   spouseName - SOAP::SOAPString
#   surname - SOAP::SOAPString
#   weddingAnniversary - SOAP::SOAPDateTime
class ContactItemType < ItemType
  attr_accessor :mimeContent
  attr_accessor :itemId
  attr_accessor :parentFolderId
  attr_accessor :itemClass
  attr_accessor :subject
  attr_accessor :sensitivity
  attr_accessor :body
  attr_accessor :attachments
  attr_accessor :dateTimeReceived
  attr_accessor :size
  attr_accessor :categories
  attr_accessor :importance
  attr_accessor :inReplyTo
  attr_accessor :isSubmitted
  attr_accessor :isDraft
  attr_accessor :isFromMe
  attr_accessor :isResend
  attr_accessor :isUnmodified
  attr_accessor :internetMessageHeaders
  attr_accessor :dateTimeSent
  attr_accessor :dateTimeCreated
  attr_accessor :responseObjects
  attr_accessor :reminderDueBy
  attr_accessor :reminderIsSet
  attr_accessor :reminderMinutesBeforeStart
  attr_accessor :displayCc
  attr_accessor :displayTo
  attr_accessor :hasAttachments
  attr_accessor :extendedProperty
  attr_accessor :culture
  attr_accessor :effectiveRights
  attr_accessor :lastModifiedName
  attr_accessor :lastModifiedTime
  attr_accessor :fileAs
  attr_accessor :fileAsMapping
  attr_accessor :displayName
  attr_accessor :givenName
  attr_accessor :initials
  attr_accessor :middleName
  attr_accessor :nickname
  attr_accessor :completeName
  attr_accessor :companyName
  attr_accessor :emailAddresses
  attr_accessor :physicalAddresses
  attr_accessor :phoneNumbers
  attr_accessor :assistantName
  attr_accessor :birthday
  attr_accessor :businessHomePage
  attr_accessor :children
  attr_accessor :companies
  attr_accessor :contactSource
  attr_accessor :department
  attr_accessor :generation
  attr_accessor :imAddresses
  attr_accessor :jobTitle
  attr_accessor :manager
  attr_accessor :mileage
  attr_accessor :officeLocation
  attr_accessor :postalAddressIndex
  attr_accessor :profession
  attr_accessor :spouseName
  attr_accessor :surname
  attr_accessor :weddingAnniversary

  def initialize(mimeContent = nil, itemId = nil, parentFolderId = nil, itemClass = nil, subject = nil, sensitivity = nil, body = nil, attachments = nil, dateTimeReceived = nil, size = nil, categories = nil, importance = nil, inReplyTo = nil, isSubmitted = nil, isDraft = nil, isFromMe = nil, isResend = nil, isUnmodified = nil, internetMessageHeaders = nil, dateTimeSent = nil, dateTimeCreated = nil, responseObjects = nil, reminderDueBy = nil, reminderIsSet = nil, reminderMinutesBeforeStart = nil, displayCc = nil, displayTo = nil, hasAttachments = nil, extendedProperty = [], culture = nil, effectiveRights = nil, lastModifiedName = nil, lastModifiedTime = nil, fileAs = nil, fileAsMapping = nil, displayName = nil, givenName = nil, initials = nil, middleName = nil, nickname = nil, completeName = nil, companyName = nil, emailAddresses = nil, physicalAddresses = nil, phoneNumbers = nil, assistantName = nil, birthday = nil, businessHomePage = nil, children = nil, companies = nil, contactSource = nil, department = nil, generation = nil, imAddresses = nil, jobTitle = nil, manager = nil, mileage = nil, officeLocation = nil, postalAddressIndex = nil, profession = nil, spouseName = nil, surname = nil, weddingAnniversary = nil)
    @mimeContent = mimeContent
    @itemId = itemId
    @parentFolderId = parentFolderId
    @itemClass = itemClass
    @subject = subject
    @sensitivity = sensitivity
    @body = body
    @attachments = attachments
    @dateTimeReceived = dateTimeReceived
    @size = size
    @categories = categories
    @importance = importance
    @inReplyTo = inReplyTo
    @isSubmitted = isSubmitted
    @isDraft = isDraft
    @isFromMe = isFromMe
    @isResend = isResend
    @isUnmodified = isUnmodified
    @internetMessageHeaders = internetMessageHeaders
    @dateTimeSent = dateTimeSent
    @dateTimeCreated = dateTimeCreated
    @responseObjects = responseObjects
    @reminderDueBy = reminderDueBy
    @reminderIsSet = reminderIsSet
    @reminderMinutesBeforeStart = reminderMinutesBeforeStart
    @displayCc = displayCc
    @displayTo = displayTo
    @hasAttachments = hasAttachments
    @extendedProperty = extendedProperty
    @culture = culture
    @effectiveRights = effectiveRights
    @lastModifiedName = lastModifiedName
    @lastModifiedTime = lastModifiedTime
    @fileAs = fileAs
    @fileAsMapping = fileAsMapping
    @displayName = displayName
    @givenName = givenName
    @initials = initials
    @middleName = middleName
    @nickname = nickname
    @completeName = completeName
    @companyName = companyName
    @emailAddresses = emailAddresses
    @physicalAddresses = physicalAddresses
    @phoneNumbers = phoneNumbers
    @assistantName = assistantName
    @birthday = birthday
    @businessHomePage = businessHomePage
    @children = children
    @companies = companies
    @contactSource = contactSource
    @department = department
    @generation = generation
    @imAddresses = imAddresses
    @jobTitle = jobTitle
    @manager = manager
    @mileage = mileage
    @officeLocation = officeLocation
    @postalAddressIndex = postalAddressIndex
    @profession = profession
    @spouseName = spouseName
    @surname = surname
    @weddingAnniversary = weddingAnniversary
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}DistributionListType
#   mimeContent - MimeContentType
#   itemId - ItemIdType
#   parentFolderId - FolderIdType
#   itemClass - (any)
#   subject - SOAP::SOAPString
#   sensitivity - SensitivityChoicesType
#   body - BodyType
#   attachments - NonEmptyArrayOfAttachmentsType
#   dateTimeReceived - SOAP::SOAPDateTime
#   size - SOAP::SOAPInt
#   categories - ArrayOfStringsType
#   importance - ImportanceChoicesType
#   inReplyTo - SOAP::SOAPString
#   isSubmitted - SOAP::SOAPBoolean
#   isDraft - SOAP::SOAPBoolean
#   isFromMe - SOAP::SOAPBoolean
#   isResend - SOAP::SOAPBoolean
#   isUnmodified - SOAP::SOAPBoolean
#   internetMessageHeaders - NonEmptyArrayOfInternetHeadersType
#   dateTimeSent - SOAP::SOAPDateTime
#   dateTimeCreated - SOAP::SOAPDateTime
#   responseObjects - NonEmptyArrayOfResponseObjectsType
#   reminderDueBy - SOAP::SOAPDateTime
#   reminderIsSet - SOAP::SOAPBoolean
#   reminderMinutesBeforeStart - (any)
#   displayCc - SOAP::SOAPString
#   displayTo - SOAP::SOAPString
#   hasAttachments - SOAP::SOAPBoolean
#   extendedProperty - ExtendedPropertyType
#   culture - SOAP::SOAPLanguage
#   effectiveRights - EffectiveRightsType
#   lastModifiedName - SOAP::SOAPString
#   lastModifiedTime - SOAP::SOAPDateTime
#   displayName - SOAP::SOAPString
#   fileAs - SOAP::SOAPString
#   contactSource - ContactSourceType
class DistributionListType < ItemType
  attr_accessor :mimeContent
  attr_accessor :itemId
  attr_accessor :parentFolderId
  attr_accessor :itemClass
  attr_accessor :subject
  attr_accessor :sensitivity
  attr_accessor :body
  attr_accessor :attachments
  attr_accessor :dateTimeReceived
  attr_accessor :size
  attr_accessor :categories
  attr_accessor :importance
  attr_accessor :inReplyTo
  attr_accessor :isSubmitted
  attr_accessor :isDraft
  attr_accessor :isFromMe
  attr_accessor :isResend
  attr_accessor :isUnmodified
  attr_accessor :internetMessageHeaders
  attr_accessor :dateTimeSent
  attr_accessor :dateTimeCreated
  attr_accessor :responseObjects
  attr_accessor :reminderDueBy
  attr_accessor :reminderIsSet
  attr_accessor :reminderMinutesBeforeStart
  attr_accessor :displayCc
  attr_accessor :displayTo
  attr_accessor :hasAttachments
  attr_accessor :extendedProperty
  attr_accessor :culture
  attr_accessor :effectiveRights
  attr_accessor :lastModifiedName
  attr_accessor :lastModifiedTime
  attr_accessor :displayName
  attr_accessor :fileAs
  attr_accessor :contactSource

  def initialize(mimeContent = nil, itemId = nil, parentFolderId = nil, itemClass = nil, subject = nil, sensitivity = nil, body = nil, attachments = nil, dateTimeReceived = nil, size = nil, categories = nil, importance = nil, inReplyTo = nil, isSubmitted = nil, isDraft = nil, isFromMe = nil, isResend = nil, isUnmodified = nil, internetMessageHeaders = nil, dateTimeSent = nil, dateTimeCreated = nil, responseObjects = nil, reminderDueBy = nil, reminderIsSet = nil, reminderMinutesBeforeStart = nil, displayCc = nil, displayTo = nil, hasAttachments = nil, extendedProperty = [], culture = nil, effectiveRights = nil, lastModifiedName = nil, lastModifiedTime = nil, displayName = nil, fileAs = nil, contactSource = nil)
    @mimeContent = mimeContent
    @itemId = itemId
    @parentFolderId = parentFolderId
    @itemClass = itemClass
    @subject = subject
    @sensitivity = sensitivity
    @body = body
    @attachments = attachments
    @dateTimeReceived = dateTimeReceived
    @size = size
    @categories = categories
    @importance = importance
    @inReplyTo = inReplyTo
    @isSubmitted = isSubmitted
    @isDraft = isDraft
    @isFromMe = isFromMe
    @isResend = isResend
    @isUnmodified = isUnmodified
    @internetMessageHeaders = internetMessageHeaders
    @dateTimeSent = dateTimeSent
    @dateTimeCreated = dateTimeCreated
    @responseObjects = responseObjects
    @reminderDueBy = reminderDueBy
    @reminderIsSet = reminderIsSet
    @reminderMinutesBeforeStart = reminderMinutesBeforeStart
    @displayCc = displayCc
    @displayTo = displayTo
    @hasAttachments = hasAttachments
    @extendedProperty = extendedProperty
    @culture = culture
    @effectiveRights = effectiveRights
    @lastModifiedName = lastModifiedName
    @lastModifiedTime = lastModifiedTime
    @displayName = displayName
    @fileAs = fileAs
    @contactSource = contactSource
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ArrayOfStringsType
class ArrayOfStringsType < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ArrayOfRealItemsType
#   item - ItemType
#   message - MessageType
#   calendarItem - CalendarItemType
#   contact - ContactItemType
#   distributionList - DistributionListType
#   meetingMessage - MeetingMessageType
#   meetingRequest - MeetingRequestMessageType
#   meetingResponse - MeetingResponseMessageType
#   meetingCancellation - MeetingCancellationMessageType
#   task - TaskType
#   postItem - PostItemType
class ArrayOfRealItemsType
  attr_accessor :item
  attr_accessor :message
  attr_accessor :calendarItem
  attr_accessor :contact
  attr_accessor :distributionList
  attr_accessor :meetingMessage
  attr_accessor :meetingRequest
  attr_accessor :meetingResponse
  attr_accessor :meetingCancellation
  attr_accessor :task
  attr_accessor :postItem

  def initialize(item = [], message = [], calendarItem = [], contact = [], distributionList = [], meetingMessage = [], meetingRequest = [], meetingResponse = [], meetingCancellation = [], task = [], postItem = [])
    @item = item
    @message = message
    @calendarItem = calendarItem
    @contact = contact
    @distributionList = distributionList
    @meetingMessage = meetingMessage
    @meetingRequest = meetingRequest
    @meetingResponse = meetingResponse
    @meetingCancellation = meetingCancellation
    @task = task
    @postItem = postItem
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}NonEmptyArrayOfAllItemsType
#   item - ItemType
#   message - MessageType
#   calendarItem - CalendarItemType
#   contact - ContactItemType
#   distributionList - DistributionListType
#   meetingMessage - MeetingMessageType
#   meetingRequest - MeetingRequestMessageType
#   meetingResponse - MeetingResponseMessageType
#   meetingCancellation - MeetingCancellationMessageType
#   task - TaskType
#   postItem - PostItemType
#   replyToItem - ReplyToItemType
#   forwardItem - ForwardItemType
#   replyAllToItem - ReplyAllToItemType
#   acceptItem - AcceptItemType
#   tentativelyAcceptItem - TentativelyAcceptItemType
#   declineItem - DeclineItemType
#   cancelCalendarItem - CancelCalendarItemType
#   removeItem - RemoveItemType
#   suppressReadReceipt - SuppressReadReceiptType
#   postReplyItem - PostReplyItemType
class NonEmptyArrayOfAllItemsType
  attr_accessor :item
  attr_accessor :message
  attr_accessor :calendarItem
  attr_accessor :contact
  attr_accessor :distributionList
  attr_accessor :meetingMessage
  attr_accessor :meetingRequest
  attr_accessor :meetingResponse
  attr_accessor :meetingCancellation
  attr_accessor :task
  attr_accessor :postItem
  attr_accessor :replyToItem
  attr_accessor :forwardItem
  attr_accessor :replyAllToItem
  attr_accessor :acceptItem
  attr_accessor :tentativelyAcceptItem
  attr_accessor :declineItem
  attr_accessor :cancelCalendarItem
  attr_accessor :removeItem
  attr_accessor :suppressReadReceipt
  attr_accessor :postReplyItem

  def initialize(item = [], message = [], calendarItem = [], contact = [], distributionList = [], meetingMessage = [], meetingRequest = [], meetingResponse = [], meetingCancellation = [], task = [], postItem = [], replyToItem = [], forwardItem = [], replyAllToItem = [], acceptItem = [], tentativelyAcceptItem = [], declineItem = [], cancelCalendarItem = [], removeItem = [], suppressReadReceipt = [], postReplyItem = [])
    @item = item
    @message = message
    @calendarItem = calendarItem
    @contact = contact
    @distributionList = distributionList
    @meetingMessage = meetingMessage
    @meetingRequest = meetingRequest
    @meetingResponse = meetingResponse
    @meetingCancellation = meetingCancellation
    @task = task
    @postItem = postItem
    @replyToItem = replyToItem
    @forwardItem = forwardItem
    @replyAllToItem = replyAllToItem
    @acceptItem = acceptItem
    @tentativelyAcceptItem = tentativelyAcceptItem
    @declineItem = declineItem
    @cancelCalendarItem = cancelCalendarItem
    @removeItem = removeItem
    @suppressReadReceipt = suppressReadReceipt
    @postReplyItem = postReplyItem
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}MimeContentType
#   xmlattr_CharacterSet - SOAP::SOAPString
class MimeContentType < ::String
  AttrCharacterSet = XSD::QName.new(nil, "CharacterSet")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_CharacterSet
    __xmlattr[AttrCharacterSet]
  end

  def xmlattr_CharacterSet=(value)
    __xmlattr[AttrCharacterSet] = value
  end

  def initialize(*arg)
    super
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}BasePagingType
# abstract
#   xmlattr_MaxEntriesReturned - SOAP::SOAPInt
class BasePagingType
  AttrMaxEntriesReturned = XSD::QName.new(nil, "MaxEntriesReturned")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_MaxEntriesReturned
    __xmlattr[AttrMaxEntriesReturned]
  end

  def xmlattr_MaxEntriesReturned=(value)
    __xmlattr[AttrMaxEntriesReturned] = value
  end

  def initialize
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}IndexedPageViewType
#   xmlattr_MaxEntriesReturned - SOAP::SOAPInt
#   xmlattr_Offset - SOAP::SOAPInt
#   xmlattr_BasePoint - SOAP::SOAPString
class IndexedPageViewType < BasePagingType
  AttrBasePoint = XSD::QName.new(nil, "BasePoint")
  AttrMaxEntriesReturned = XSD::QName.new(nil, "MaxEntriesReturned")
  AttrOffset = XSD::QName.new(nil, "Offset")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_MaxEntriesReturned
    __xmlattr[AttrMaxEntriesReturned]
  end

  def xmlattr_MaxEntriesReturned=(value)
    __xmlattr[AttrMaxEntriesReturned] = value
  end

  def xmlattr_Offset
    __xmlattr[AttrOffset]
  end

  def xmlattr_Offset=(value)
    __xmlattr[AttrOffset] = value
  end

  def xmlattr_BasePoint
    __xmlattr[AttrBasePoint]
  end

  def xmlattr_BasePoint=(value)
    __xmlattr[AttrBasePoint] = value
  end

  def initialize
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}FractionalPageViewType
#   xmlattr_MaxEntriesReturned - SOAP::SOAPInt
#   xmlattr_Numerator - SOAP::SOAPInt
#   xmlattr_Denominator - SOAP::SOAPInt
class FractionalPageViewType < BasePagingType
  AttrDenominator = XSD::QName.new(nil, "Denominator")
  AttrMaxEntriesReturned = XSD::QName.new(nil, "MaxEntriesReturned")
  AttrNumerator = XSD::QName.new(nil, "Numerator")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_MaxEntriesReturned
    __xmlattr[AttrMaxEntriesReturned]
  end

  def xmlattr_MaxEntriesReturned=(value)
    __xmlattr[AttrMaxEntriesReturned] = value
  end

  def xmlattr_Numerator
    __xmlattr[AttrNumerator]
  end

  def xmlattr_Numerator=(value)
    __xmlattr[AttrNumerator] = value
  end

  def xmlattr_Denominator
    __xmlattr[AttrDenominator]
  end

  def xmlattr_Denominator=(value)
    __xmlattr[AttrDenominator] = value
  end

  def initialize
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}CalendarViewType
#   xmlattr_MaxEntriesReturned - SOAP::SOAPInt
#   xmlattr_StartDate - SOAP::SOAPDateTime
#   xmlattr_EndDate - SOAP::SOAPDateTime
class CalendarViewType < BasePagingType
  AttrEndDate = XSD::QName.new(nil, "EndDate")
  AttrMaxEntriesReturned = XSD::QName.new(nil, "MaxEntriesReturned")
  AttrStartDate = XSD::QName.new(nil, "StartDate")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_MaxEntriesReturned
    __xmlattr[AttrMaxEntriesReturned]
  end

  def xmlattr_MaxEntriesReturned=(value)
    __xmlattr[AttrMaxEntriesReturned] = value
  end

  def xmlattr_StartDate
    __xmlattr[AttrStartDate]
  end

  def xmlattr_StartDate=(value)
    __xmlattr[AttrStartDate] = value
  end

  def xmlattr_EndDate
    __xmlattr[AttrEndDate]
  end

  def xmlattr_EndDate=(value)
    __xmlattr[AttrEndDate] = value
  end

  def initialize
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ContactsViewType
#   xmlattr_MaxEntriesReturned - SOAP::SOAPInt
#   xmlattr_InitialName - SOAP::SOAPString
#   xmlattr_FinalName - SOAP::SOAPString
class ContactsViewType < BasePagingType
  AttrFinalName = XSD::QName.new(nil, "FinalName")
  AttrInitialName = XSD::QName.new(nil, "InitialName")
  AttrMaxEntriesReturned = XSD::QName.new(nil, "MaxEntriesReturned")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_MaxEntriesReturned
    __xmlattr[AttrMaxEntriesReturned]
  end

  def xmlattr_MaxEntriesReturned=(value)
    __xmlattr[AttrMaxEntriesReturned] = value
  end

  def xmlattr_InitialName
    __xmlattr[AttrInitialName]
  end

  def xmlattr_InitialName=(value)
    __xmlattr[AttrInitialName] = value
  end

  def xmlattr_FinalName
    __xmlattr[AttrFinalName]
  end

  def xmlattr_FinalName=(value)
    __xmlattr[AttrFinalName] = value
  end

  def initialize
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ResolutionType
#   mailbox - EmailAddressType
#   contact - ContactItemType
class ResolutionType
  attr_accessor :mailbox
  attr_accessor :contact

  def initialize(mailbox = nil, contact = nil)
    @mailbox = mailbox
    @contact = contact
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ArrayOfResolutionType
#   resolution - ResolutionType
#   xmlattr_IndexedPagingOffset - SOAP::SOAPInt
#   xmlattr_NumeratorOffset - SOAP::SOAPInt
#   xmlattr_AbsoluteDenominator - SOAP::SOAPInt
#   xmlattr_IncludesLastItemInRange - SOAP::SOAPBoolean
#   xmlattr_TotalItemsInView - SOAP::SOAPInt
class ArrayOfResolutionType
  AttrAbsoluteDenominator = XSD::QName.new(nil, "AbsoluteDenominator")
  AttrIncludesLastItemInRange = XSD::QName.new(nil, "IncludesLastItemInRange")
  AttrIndexedPagingOffset = XSD::QName.new(nil, "IndexedPagingOffset")
  AttrNumeratorOffset = XSD::QName.new(nil, "NumeratorOffset")
  AttrTotalItemsInView = XSD::QName.new(nil, "TotalItemsInView")

  attr_accessor :resolution

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_IndexedPagingOffset
    __xmlattr[AttrIndexedPagingOffset]
  end

  def xmlattr_IndexedPagingOffset=(value)
    __xmlattr[AttrIndexedPagingOffset] = value
  end

  def xmlattr_NumeratorOffset
    __xmlattr[AttrNumeratorOffset]
  end

  def xmlattr_NumeratorOffset=(value)
    __xmlattr[AttrNumeratorOffset] = value
  end

  def xmlattr_AbsoluteDenominator
    __xmlattr[AttrAbsoluteDenominator]
  end

  def xmlattr_AbsoluteDenominator=(value)
    __xmlattr[AttrAbsoluteDenominator] = value
  end

  def xmlattr_IncludesLastItemInRange
    __xmlattr[AttrIncludesLastItemInRange]
  end

  def xmlattr_IncludesLastItemInRange=(value)
    __xmlattr[AttrIncludesLastItemInRange] = value
  end

  def xmlattr_TotalItemsInView
    __xmlattr[AttrTotalItemsInView]
  end

  def xmlattr_TotalItemsInView=(value)
    __xmlattr[AttrTotalItemsInView] = value
  end

  def initialize(resolution = [])
    @resolution = resolution
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ArrayOfDLExpansionType
#   mailbox - EmailAddressType
#   xmlattr_IndexedPagingOffset - SOAP::SOAPInt
#   xmlattr_NumeratorOffset - SOAP::SOAPInt
#   xmlattr_AbsoluteDenominator - SOAP::SOAPInt
#   xmlattr_IncludesLastItemInRange - SOAP::SOAPBoolean
#   xmlattr_TotalItemsInView - SOAP::SOAPInt
class ArrayOfDLExpansionType
  AttrAbsoluteDenominator = XSD::QName.new(nil, "AbsoluteDenominator")
  AttrIncludesLastItemInRange = XSD::QName.new(nil, "IncludesLastItemInRange")
  AttrIndexedPagingOffset = XSD::QName.new(nil, "IndexedPagingOffset")
  AttrNumeratorOffset = XSD::QName.new(nil, "NumeratorOffset")
  AttrTotalItemsInView = XSD::QName.new(nil, "TotalItemsInView")

  attr_accessor :mailbox

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_IndexedPagingOffset
    __xmlattr[AttrIndexedPagingOffset]
  end

  def xmlattr_IndexedPagingOffset=(value)
    __xmlattr[AttrIndexedPagingOffset] = value
  end

  def xmlattr_NumeratorOffset
    __xmlattr[AttrNumeratorOffset]
  end

  def xmlattr_NumeratorOffset=(value)
    __xmlattr[AttrNumeratorOffset] = value
  end

  def xmlattr_AbsoluteDenominator
    __xmlattr[AttrAbsoluteDenominator]
  end

  def xmlattr_AbsoluteDenominator=(value)
    __xmlattr[AttrAbsoluteDenominator] = value
  end

  def xmlattr_IncludesLastItemInRange
    __xmlattr[AttrIncludesLastItemInRange]
  end

  def xmlattr_IncludesLastItemInRange=(value)
    __xmlattr[AttrIncludesLastItemInRange] = value
  end

  def xmlattr_TotalItemsInView
    __xmlattr[AttrTotalItemsInView]
  end

  def xmlattr_TotalItemsInView=(value)
    __xmlattr[AttrTotalItemsInView] = value
  end

  def initialize(mailbox = [])
    @mailbox = mailbox
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}AttendeeType
#   mailbox - EmailAddressType
#   responseType - ResponseTypeType
#   lastResponseTime - SOAP::SOAPDateTime
class AttendeeType
  attr_accessor :mailbox
  attr_accessor :responseType
  attr_accessor :lastResponseTime

  def initialize(mailbox = nil, responseType = nil, lastResponseTime = nil)
    @mailbox = mailbox
    @responseType = responseType
    @lastResponseTime = lastResponseTime
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}NonEmptyArrayOfAttendeesType
class NonEmptyArrayOfAttendeesType < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}RecurrencePatternBaseType
# abstract
class RecurrencePatternBaseType
  def initialize
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}IntervalRecurrencePatternBaseType
# abstract
#   interval - SOAP::SOAPInt
class IntervalRecurrencePatternBaseType < RecurrencePatternBaseType
  attr_accessor :interval

  def initialize(interval = nil)
    @interval = interval
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}RegeneratingPatternBaseType
# abstract
#   interval - SOAP::SOAPInt
class RegeneratingPatternBaseType < IntervalRecurrencePatternBaseType
  attr_accessor :interval

  def initialize(interval = nil)
    @interval = interval
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}DailyRegeneratingPatternType
#   interval - SOAP::SOAPInt
class DailyRegeneratingPatternType < RegeneratingPatternBaseType
  attr_accessor :interval

  def initialize(interval = nil)
    @interval = interval
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}WeeklyRegeneratingPatternType
#   interval - SOAP::SOAPInt
class WeeklyRegeneratingPatternType < RegeneratingPatternBaseType
  attr_accessor :interval

  def initialize(interval = nil)
    @interval = interval
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}MonthlyRegeneratingPatternType
#   interval - SOAP::SOAPInt
class MonthlyRegeneratingPatternType < RegeneratingPatternBaseType
  attr_accessor :interval

  def initialize(interval = nil)
    @interval = interval
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}YearlyRegeneratingPatternType
#   interval - SOAP::SOAPInt
class YearlyRegeneratingPatternType < RegeneratingPatternBaseType
  attr_accessor :interval

  def initialize(interval = nil)
    @interval = interval
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}RelativeMonthlyRecurrencePatternType
#   interval - SOAP::SOAPInt
#   daysOfWeek - DayOfWeekType
#   dayOfWeekIndex - DayOfWeekIndexType
class RelativeMonthlyRecurrencePatternType < IntervalRecurrencePatternBaseType
  attr_accessor :interval
  attr_accessor :daysOfWeek
  attr_accessor :dayOfWeekIndex

  def initialize(interval = nil, daysOfWeek = nil, dayOfWeekIndex = nil)
    @interval = interval
    @daysOfWeek = daysOfWeek
    @dayOfWeekIndex = dayOfWeekIndex
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}AbsoluteMonthlyRecurrencePatternType
#   interval - SOAP::SOAPInt
#   dayOfMonth - SOAP::SOAPInt
class AbsoluteMonthlyRecurrencePatternType < IntervalRecurrencePatternBaseType
  attr_accessor :interval
  attr_accessor :dayOfMonth

  def initialize(interval = nil, dayOfMonth = nil)
    @interval = interval
    @dayOfMonth = dayOfMonth
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}WeeklyRecurrencePatternType
#   interval - SOAP::SOAPInt
#   daysOfWeek - (any)
class WeeklyRecurrencePatternType < IntervalRecurrencePatternBaseType
  attr_accessor :interval
  attr_accessor :daysOfWeek

  def initialize(interval = nil, daysOfWeek = nil)
    @interval = interval
    @daysOfWeek = daysOfWeek
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}DailyRecurrencePatternType
#   interval - SOAP::SOAPInt
class DailyRecurrencePatternType < IntervalRecurrencePatternBaseType
  attr_accessor :interval

  def initialize(interval = nil)
    @interval = interval
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}RelativeYearlyRecurrencePatternType
#   daysOfWeek - DayOfWeekType
#   dayOfWeekIndex - DayOfWeekIndexType
#   month - MonthNamesType
class RelativeYearlyRecurrencePatternType < RecurrencePatternBaseType
  attr_accessor :daysOfWeek
  attr_accessor :dayOfWeekIndex
  attr_accessor :month

  def initialize(daysOfWeek = nil, dayOfWeekIndex = nil, month = nil)
    @daysOfWeek = daysOfWeek
    @dayOfWeekIndex = dayOfWeekIndex
    @month = month
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}AbsoluteYearlyRecurrencePatternType
#   dayOfMonth - SOAP::SOAPInt
#   month - MonthNamesType
class AbsoluteYearlyRecurrencePatternType < RecurrencePatternBaseType
  attr_accessor :dayOfMonth
  attr_accessor :month

  def initialize(dayOfMonth = nil, month = nil)
    @dayOfMonth = dayOfMonth
    @month = month
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}TimeChangeType
#   offset - SOAP::SOAPDuration
#   relativeYearlyRecurrence - RelativeYearlyRecurrencePatternType
#   absoluteDate - SOAP::SOAPDate
#   time - SOAP::SOAPTime
#   xmlattr_TimeZoneName - SOAP::SOAPString
class TimeChangeType
  AttrTimeZoneName = XSD::QName.new(nil, "TimeZoneName")

  attr_accessor :offset
  attr_accessor :relativeYearlyRecurrence
  attr_accessor :absoluteDate
  attr_accessor :time

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_TimeZoneName
    __xmlattr[AttrTimeZoneName]
  end

  def xmlattr_TimeZoneName=(value)
    __xmlattr[AttrTimeZoneName] = value
  end

  def initialize(offset = nil, relativeYearlyRecurrence = nil, absoluteDate = nil, time = nil)
    @offset = offset
    @relativeYearlyRecurrence = relativeYearlyRecurrence
    @absoluteDate = absoluteDate
    @time = time
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}TimeZoneType
#   baseOffset - SOAP::SOAPDuration
#   standard - TimeChangeType
#   daylight - TimeChangeType
#   xmlattr_TimeZoneName - SOAP::SOAPString
class TimeZoneType
  AttrTimeZoneName = XSD::QName.new(nil, "TimeZoneName")

  attr_accessor :baseOffset
  attr_accessor :standard
  attr_accessor :daylight

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_TimeZoneName
    __xmlattr[AttrTimeZoneName]
  end

  def xmlattr_TimeZoneName=(value)
    __xmlattr[AttrTimeZoneName] = value
  end

  def initialize(baseOffset = nil, standard = nil, daylight = nil)
    @baseOffset = baseOffset
    @standard = standard
    @daylight = daylight
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}RecurrenceRangeBaseType
# abstract
#   startDate - SOAP::SOAPDate
class RecurrenceRangeBaseType
  attr_accessor :startDate

  def initialize(startDate = nil)
    @startDate = startDate
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}NoEndRecurrenceRangeType
#   startDate - SOAP::SOAPDate
class NoEndRecurrenceRangeType < RecurrenceRangeBaseType
  attr_accessor :startDate

  def initialize(startDate = nil)
    @startDate = startDate
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}EndDateRecurrenceRangeType
#   startDate - SOAP::SOAPDate
#   endDate - SOAP::SOAPDate
class EndDateRecurrenceRangeType < RecurrenceRangeBaseType
  attr_accessor :startDate
  attr_accessor :endDate

  def initialize(startDate = nil, endDate = nil)
    @startDate = startDate
    @endDate = endDate
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}NumberedRecurrenceRangeType
#   startDate - SOAP::SOAPDate
#   numberOfOccurrences - SOAP::SOAPInt
class NumberedRecurrenceRangeType < RecurrenceRangeBaseType
  attr_accessor :startDate
  attr_accessor :numberOfOccurrences

  def initialize(startDate = nil, numberOfOccurrences = nil)
    @startDate = startDate
    @numberOfOccurrences = numberOfOccurrences
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}RecurrenceType
#   relativeYearlyRecurrence - RelativeYearlyRecurrencePatternType
#   absoluteYearlyRecurrence - AbsoluteYearlyRecurrencePatternType
#   relativeMonthlyRecurrence - RelativeMonthlyRecurrencePatternType
#   absoluteMonthlyRecurrence - AbsoluteMonthlyRecurrencePatternType
#   weeklyRecurrence - WeeklyRecurrencePatternType
#   dailyRecurrence - DailyRecurrencePatternType
#   noEndRecurrence - NoEndRecurrenceRangeType
#   endDateRecurrence - EndDateRecurrenceRangeType
#   numberedRecurrence - NumberedRecurrenceRangeType
class RecurrenceType
  attr_accessor :relativeYearlyRecurrence
  attr_accessor :absoluteYearlyRecurrence
  attr_accessor :relativeMonthlyRecurrence
  attr_accessor :absoluteMonthlyRecurrence
  attr_accessor :weeklyRecurrence
  attr_accessor :dailyRecurrence
  attr_accessor :noEndRecurrence
  attr_accessor :endDateRecurrence
  attr_accessor :numberedRecurrence

  def initialize(relativeYearlyRecurrence = nil, absoluteYearlyRecurrence = nil, relativeMonthlyRecurrence = nil, absoluteMonthlyRecurrence = nil, weeklyRecurrence = nil, dailyRecurrence = nil, noEndRecurrence = nil, endDateRecurrence = nil, numberedRecurrence = nil)
    @relativeYearlyRecurrence = relativeYearlyRecurrence
    @absoluteYearlyRecurrence = absoluteYearlyRecurrence
    @relativeMonthlyRecurrence = relativeMonthlyRecurrence
    @absoluteMonthlyRecurrence = absoluteMonthlyRecurrence
    @weeklyRecurrence = weeklyRecurrence
    @dailyRecurrence = dailyRecurrence
    @noEndRecurrence = noEndRecurrence
    @endDateRecurrence = endDateRecurrence
    @numberedRecurrence = numberedRecurrence
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}TaskRecurrenceType
#   relativeYearlyRecurrence - RelativeYearlyRecurrencePatternType
#   absoluteYearlyRecurrence - AbsoluteYearlyRecurrencePatternType
#   relativeMonthlyRecurrence - RelativeMonthlyRecurrencePatternType
#   absoluteMonthlyRecurrence - AbsoluteMonthlyRecurrencePatternType
#   weeklyRecurrence - WeeklyRecurrencePatternType
#   dailyRecurrence - DailyRecurrencePatternType
#   dailyRegeneration - DailyRegeneratingPatternType
#   weeklyRegeneration - WeeklyRegeneratingPatternType
#   monthlyRegeneration - MonthlyRegeneratingPatternType
#   yearlyRegeneration - YearlyRegeneratingPatternType
#   noEndRecurrence - NoEndRecurrenceRangeType
#   endDateRecurrence - EndDateRecurrenceRangeType
#   numberedRecurrence - NumberedRecurrenceRangeType
class TaskRecurrenceType
  attr_accessor :relativeYearlyRecurrence
  attr_accessor :absoluteYearlyRecurrence
  attr_accessor :relativeMonthlyRecurrence
  attr_accessor :absoluteMonthlyRecurrence
  attr_accessor :weeklyRecurrence
  attr_accessor :dailyRecurrence
  attr_accessor :dailyRegeneration
  attr_accessor :weeklyRegeneration
  attr_accessor :monthlyRegeneration
  attr_accessor :yearlyRegeneration
  attr_accessor :noEndRecurrence
  attr_accessor :endDateRecurrence
  attr_accessor :numberedRecurrence

  def initialize(relativeYearlyRecurrence = nil, absoluteYearlyRecurrence = nil, relativeMonthlyRecurrence = nil, absoluteMonthlyRecurrence = nil, weeklyRecurrence = nil, dailyRecurrence = nil, dailyRegeneration = nil, weeklyRegeneration = nil, monthlyRegeneration = nil, yearlyRegeneration = nil, noEndRecurrence = nil, endDateRecurrence = nil, numberedRecurrence = nil)
    @relativeYearlyRecurrence = relativeYearlyRecurrence
    @absoluteYearlyRecurrence = absoluteYearlyRecurrence
    @relativeMonthlyRecurrence = relativeMonthlyRecurrence
    @absoluteMonthlyRecurrence = absoluteMonthlyRecurrence
    @weeklyRecurrence = weeklyRecurrence
    @dailyRecurrence = dailyRecurrence
    @dailyRegeneration = dailyRegeneration
    @weeklyRegeneration = weeklyRegeneration
    @monthlyRegeneration = monthlyRegeneration
    @yearlyRegeneration = yearlyRegeneration
    @noEndRecurrence = noEndRecurrence
    @endDateRecurrence = endDateRecurrence
    @numberedRecurrence = numberedRecurrence
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}OccurrenceInfoType
#   itemId - ItemIdType
#   start - SOAP::SOAPDateTime
#   m_end - SOAP::SOAPDateTime
#   originalStart - SOAP::SOAPDateTime
class OccurrenceInfoType
  attr_accessor :itemId
  attr_accessor :start
  attr_accessor :originalStart

  def m_end
    @v_end
  end

  def m_end=(value)
    @v_end = value
  end

  def initialize(itemId = nil, start = nil, v_end = nil, originalStart = nil)
    @itemId = itemId
    @start = start
    @v_end = v_end
    @originalStart = originalStart
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}NonEmptyArrayOfOccurrenceInfoType
class NonEmptyArrayOfOccurrenceInfoType < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}DeletedOccurrenceInfoType
#   start - SOAP::SOAPDateTime
class DeletedOccurrenceInfoType
  attr_accessor :start

  def initialize(start = nil)
    @start = start
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}NonEmptyArrayOfDeletedOccurrencesType
class NonEmptyArrayOfDeletedOccurrencesType < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}CompleteNameType
#   title - SOAP::SOAPString
#   firstName - SOAP::SOAPString
#   middleName - SOAP::SOAPString
#   lastName - SOAP::SOAPString
#   suffix - SOAP::SOAPString
#   initials - SOAP::SOAPString
#   fullName - SOAP::SOAPString
#   nickname - SOAP::SOAPString
#   yomiFirstName - SOAP::SOAPString
#   yomiLastName - SOAP::SOAPString
class CompleteNameType
  attr_accessor :title
  attr_accessor :firstName
  attr_accessor :middleName
  attr_accessor :lastName
  attr_accessor :suffix
  attr_accessor :initials
  attr_accessor :fullName
  attr_accessor :nickname
  attr_accessor :yomiFirstName
  attr_accessor :yomiLastName

  def initialize(title = nil, firstName = nil, middleName = nil, lastName = nil, suffix = nil, initials = nil, fullName = nil, nickname = nil, yomiFirstName = nil, yomiLastName = nil)
    @title = title
    @firstName = firstName
    @middleName = middleName
    @lastName = lastName
    @suffix = suffix
    @initials = initials
    @fullName = fullName
    @nickname = nickname
    @yomiFirstName = yomiFirstName
    @yomiLastName = yomiLastName
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ImAddressDictionaryEntryType
#   xmlattr_Key - SOAP::SOAPString
class ImAddressDictionaryEntryType < ::String
  AttrKey = XSD::QName.new(nil, "Key")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_Key
    __xmlattr[AttrKey]
  end

  def xmlattr_Key=(value)
    __xmlattr[AttrKey] = value
  end

  def initialize(*arg)
    super
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}EmailAddressDictionaryEntryType
#   xmlattr_Key - SOAP::SOAPString
class EmailAddressDictionaryEntryType < ::String
  AttrKey = XSD::QName.new(nil, "Key")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_Key
    __xmlattr[AttrKey]
  end

  def xmlattr_Key=(value)
    __xmlattr[AttrKey] = value
  end

  def initialize(*arg)
    super
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}PhoneNumberDictionaryEntryType
#   xmlattr_Key - SOAP::SOAPString
class PhoneNumberDictionaryEntryType < ::String
  AttrKey = XSD::QName.new(nil, "Key")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_Key
    __xmlattr[AttrKey]
  end

  def xmlattr_Key=(value)
    __xmlattr[AttrKey] = value
  end

  def initialize(*arg)
    super
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}PhysicalAddressDictionaryEntryType
#   street - SOAP::SOAPString
#   city - SOAP::SOAPString
#   state - SOAP::SOAPString
#   countryOrRegion - SOAP::SOAPString
#   postalCode - SOAP::SOAPString
#   xmlattr_Key - SOAP::SOAPString
class PhysicalAddressDictionaryEntryType
  AttrKey = XSD::QName.new(nil, "Key")

  attr_accessor :street
  attr_accessor :city
  attr_accessor :state
  attr_accessor :countryOrRegion
  attr_accessor :postalCode

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_Key
    __xmlattr[AttrKey]
  end

  def xmlattr_Key=(value)
    __xmlattr[AttrKey] = value
  end

  def initialize(street = nil, city = nil, state = nil, countryOrRegion = nil, postalCode = nil)
    @street = street
    @city = city
    @state = state
    @countryOrRegion = countryOrRegion
    @postalCode = postalCode
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ImAddressDictionaryType
class ImAddressDictionaryType < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}EmailAddressDictionaryType
class EmailAddressDictionaryType < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}PhoneNumberDictionaryType
class PhoneNumberDictionaryType < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}PhysicalAddressDictionaryType
class PhysicalAddressDictionaryType < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}SearchParametersType
#   restriction - RestrictionType
#   baseFolderIds - NonEmptyArrayOfBaseFolderIdsType
#   xmlattr_Traversal - SOAP::SOAPString
class SearchParametersType
  AttrTraversal = XSD::QName.new(nil, "Traversal")

  attr_accessor :restriction
  attr_accessor :baseFolderIds

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_Traversal
    __xmlattr[AttrTraversal]
  end

  def xmlattr_Traversal=(value)
    __xmlattr[AttrTraversal] = value
  end

  def initialize(restriction = nil, baseFolderIds = nil)
    @restriction = restriction
    @baseFolderIds = baseFolderIds
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ConstantValueType
#   xmlattr_Value - SOAP::SOAPString
class ConstantValueType
  AttrValue = XSD::QName.new(nil, "Value")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_Value
    __xmlattr[AttrValue]
  end

  def xmlattr_Value=(value)
    __xmlattr[AttrValue] = value
  end

  def initialize
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}SearchExpressionType
# abstract
class SearchExpressionType
  def initialize
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ExistsType
#   path - BasePathToElementType
class ExistsType < SearchExpressionType
  attr_accessor :path

  def initialize(path = nil)
    @path = path
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}TwoOperandExpressionType
# abstract
#   path - BasePathToElementType
#   fieldURIOrConstant - FieldURIOrConstantType
class TwoOperandExpressionType < SearchExpressionType
  attr_accessor :path
  attr_accessor :fieldURIOrConstant

  def initialize(path = nil, fieldURIOrConstant = nil)
    @path = path
    @fieldURIOrConstant = fieldURIOrConstant
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}IsEqualToType
#   path - BasePathToElementType
#   fieldURIOrConstant - FieldURIOrConstantType
class IsEqualToType < TwoOperandExpressionType

  attr_accessor :path
  attr_accessor :fieldURIOrConstant

  def initialize(path = nil, fieldURIOrConstant = nil)
    @path = path
    @fieldURIOrConstant = fieldURIOrConstant
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}IsNotEqualToType
#   path - BasePathToElementType
#   fieldURIOrConstant - FieldURIOrConstantType
class IsNotEqualToType < TwoOperandExpressionType
  attr_accessor :path
  attr_accessor :fieldURIOrConstant

  def initialize(path = nil, fieldURIOrConstant = nil)
    @path = path
    @fieldURIOrConstant = fieldURIOrConstant
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}IsGreaterThanType
#   path - BasePathToElementType
#   fieldURIOrConstant - FieldURIOrConstantType
class IsGreaterThanType < TwoOperandExpressionType
  attr_accessor :path
  attr_accessor :fieldURIOrConstant

  def initialize(path = nil, fieldURIOrConstant = nil)
    @path = path
    @fieldURIOrConstant = fieldURIOrConstant
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}IsGreaterThanOrEqualToType
#   path - BasePathToElementType
#   fieldURIOrConstant - FieldURIOrConstantType
class IsGreaterThanOrEqualToType < TwoOperandExpressionType
  attr_accessor :path
  attr_accessor :fieldURIOrConstant

  def initialize(path = nil, fieldURIOrConstant = nil)
    @path = path
    @fieldURIOrConstant = fieldURIOrConstant
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}IsLessThanType
#   path - BasePathToElementType
#   fieldURIOrConstant - FieldURIOrConstantType
class IsLessThanType < TwoOperandExpressionType
  attr_accessor :path
  attr_accessor :fieldURIOrConstant

  def initialize(path = nil, fieldURIOrConstant = nil)
    @path = path
    @fieldURIOrConstant = fieldURIOrConstant
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}IsLessThanOrEqualToType
#   path - BasePathToElementType
#   fieldURIOrConstant - FieldURIOrConstantType
class IsLessThanOrEqualToType < TwoOperandExpressionType
  attr_accessor :path
  attr_accessor :fieldURIOrConstant

  def initialize(path = nil, fieldURIOrConstant = nil)
    @path = path
    @fieldURIOrConstant = fieldURIOrConstant
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ExcludesType
#   path - BasePathToElementType
#   bitmask - ExcludesValueType
class ExcludesType < SearchExpressionType
  attr_accessor :path
  attr_accessor :bitmask

  def initialize(path = nil, bitmask = nil)
    @path = path
    @bitmask = bitmask
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ContainsExpressionType
#   path - BasePathToElementType
#   constant - ConstantValueType
#   xmlattr_ContainmentMode - SOAP::SOAPString
#   xmlattr_ContainmentComparison - SOAP::SOAPString
class ContainsExpressionType < SearchExpressionType
  AttrContainmentComparison = XSD::QName.new(nil, "ContainmentComparison")
  AttrContainmentMode = XSD::QName.new(nil, "ContainmentMode")

  attr_accessor :path
  attr_accessor :constant

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_ContainmentMode
    __xmlattr[AttrContainmentMode]
  end

  def xmlattr_ContainmentMode=(value)
    __xmlattr[AttrContainmentMode] = value
  end

  def xmlattr_ContainmentComparison
    __xmlattr[AttrContainmentComparison]
  end

  def xmlattr_ContainmentComparison=(value)
    __xmlattr[AttrContainmentComparison] = value
  end

  def initialize(path = nil, constant = nil)
    @path = path
    @constant = constant
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}NotType
#   searchExpression - SearchExpressionType
class NotType < SearchExpressionType
  attr_accessor :searchExpression

  def initialize(searchExpression = nil)
    @searchExpression = searchExpression
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}MultipleOperandBooleanExpressionType
# abstract
#   searchExpression - SearchExpressionType
class MultipleOperandBooleanExpressionType < SearchExpressionType
  attr_accessor :searchExpression

  def initialize(searchExpression = [])
    @searchExpression = searchExpression
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}AndType
#   searchExpression - SearchExpressionType
class AndType < MultipleOperandBooleanExpressionType
  attr_accessor :searchExpression

  def initialize(searchExpression = [])
    @searchExpression = searchExpression
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}OrType
#   searchExpression - SearchExpressionType
class OrType < MultipleOperandBooleanExpressionType
  attr_accessor :searchExpression

  def initialize(searchExpression = [])
    @searchExpression = searchExpression
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}AggregateOnType
#   fieldURI - PathToUnindexedFieldType
#   indexedFieldURI - PathToIndexedFieldType
#   extendedFieldURI - PathToExtendedFieldType
#   xmlattr_Aggregate - SOAP::SOAPString
class AggregateOnType
  AttrAggregate = XSD::QName.new(nil, "Aggregate")

  attr_accessor :fieldURI
  attr_accessor :indexedFieldURI
  attr_accessor :extendedFieldURI

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_Aggregate
    __xmlattr[AttrAggregate]
  end

  def xmlattr_Aggregate=(value)
    __xmlattr[AttrAggregate] = value
  end

  def initialize(fieldURI = nil, indexedFieldURI = nil, extendedFieldURI = nil)
    @fieldURI = fieldURI
    @indexedFieldURI = indexedFieldURI
    @extendedFieldURI = extendedFieldURI
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}BaseGroupByType
# abstract
#   xmlattr_Order - SOAP::SOAPString
class BaseGroupByType
  AttrOrder = XSD::QName.new(nil, "Order")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_Order
    __xmlattr[AttrOrder]
  end

  def xmlattr_Order=(value)
    __xmlattr[AttrOrder] = value
  end

  def initialize
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}GroupByType
#   fieldURI - PathToUnindexedFieldType
#   indexedFieldURI - PathToIndexedFieldType
#   extendedFieldURI - PathToExtendedFieldType
#   aggregateOn - AggregateOnType
#   xmlattr_Order - SOAP::SOAPString
class GroupByType < BaseGroupByType
  AttrOrder = XSD::QName.new(nil, "Order")

  attr_accessor :fieldURI
  attr_accessor :indexedFieldURI
  attr_accessor :extendedFieldURI
  attr_accessor :aggregateOn

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_Order
    __xmlattr[AttrOrder]
  end

  def xmlattr_Order=(value)
    __xmlattr[AttrOrder] = value
  end

  def initialize(fieldURI = nil, indexedFieldURI = nil, extendedFieldURI = nil, aggregateOn = nil)
    @fieldURI = fieldURI
    @indexedFieldURI = indexedFieldURI
    @extendedFieldURI = extendedFieldURI
    @aggregateOn = aggregateOn
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}DistinguishedGroupByType
#   standardGroupBy - StandardGroupByType
#   xmlattr_Order - SOAP::SOAPString
class DistinguishedGroupByType < BaseGroupByType
  AttrOrder = XSD::QName.new(nil, "Order")

  attr_accessor :standardGroupBy

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_Order
    __xmlattr[AttrOrder]
  end

  def xmlattr_Order=(value)
    __xmlattr[AttrOrder] = value
  end

  def initialize(standardGroupBy = nil)
    @standardGroupBy = standardGroupBy
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}GroupedItemsType
#   groupIndex - SOAP::SOAPString
#   items - ArrayOfRealItemsType
class GroupedItemsType
  attr_accessor :groupIndex
  attr_accessor :items

  def initialize(groupIndex = nil, items = nil)
    @groupIndex = groupIndex
    @items = items
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ArrayOfGroupedItemsType
class ArrayOfGroupedItemsType < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}FieldURIOrConstantType
#   path - BasePathToElementType
#   constant - ConstantValueType
class FieldURIOrConstantType
  attr_accessor :path
  attr_accessor :constant

  def initialize(path = nil, constant = nil)
    @path = path
    @constant = constant
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ExcludesValueType
#   xmlattr_Value - SOAP::SOAPString
class ExcludesValueType
  AttrValue = XSD::QName.new(nil, "Value")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_Value
    __xmlattr[AttrValue]
  end

  def xmlattr_Value=(value)
    __xmlattr[AttrValue] = value
  end

  def initialize
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}RestrictionType
#   searchExpression - SearchExpressionType
class RestrictionType
  attr_accessor :searchExpression
  attr_accessor :exists, :excludes, :containsExpression
  attr_accessor :isEqualTo, :isNotEqualTo, :isGreaterThan
  attr_accessor :isGreaterThanOrEqualTo, :isLessThan, :isLessThanOrEqualTo

  def initialize(searchExpression = nil, exists = nil, excludes = nil, containsExpression = nil, isEqualTo = nil, isNotEqualTo = nil, isGreaterThan = nil, isGreaterThanOrEqualTo = nil, isLessThan = nil, isLessThanOrEqualTo = nil)
    @searchExpression = searchExpression
    @exists = exists
    @excludes = excludes
    @containsExpression = containsExpression
    @isEqualTo = isEqualTo
    @isNotEqualTo = isNotEqualTo
    @isGreaterThan = isGreaterThan
    @isGreaterThanOrEqualTo = isGreaterThanOrEqualTo
    @isLessThan = isLessThan
    @isLessThanOrEqualTo = isLessThanOrEqualTo
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}FieldOrderType
#   path - BasePathToElementType
#   xmlattr_Order - SOAP::SOAPString
class FieldOrderType
  AttrOrder = XSD::QName.new(nil, "Order")

  attr_accessor :path

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_Order
    __xmlattr[AttrOrder]
  end

  def xmlattr_Order=(value)
    __xmlattr[AttrOrder] = value
  end

  def initialize(path = nil)
    @path = path
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}NonEmptyArrayOfFieldOrdersType
class NonEmptyArrayOfFieldOrdersType < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}NonEmptyArrayOfFolderNamesType
class NonEmptyArrayOfFolderNamesType < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}BaseNotificationEventType
#   watermark - (any)
class BaseNotificationEventType
  attr_accessor :watermark

  def initialize(watermark = nil)
    @watermark = watermark
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}BaseObjectChangedEventType
#   watermark - (any)
#   timeStamp - SOAP::SOAPDateTime
#   folderId - FolderIdType
#   itemId - ItemIdType
#   parentFolderId - FolderIdType
class BaseObjectChangedEventType < BaseNotificationEventType
  attr_accessor :watermark
  attr_accessor :timeStamp
  attr_accessor :folderId
  attr_accessor :itemId
  attr_accessor :parentFolderId

  def initialize(watermark = nil, timeStamp = nil, folderId = nil, itemId = nil, parentFolderId = nil)
    @watermark = watermark
    @timeStamp = timeStamp
    @folderId = folderId
    @itemId = itemId
    @parentFolderId = parentFolderId
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ModifiedEventType
#   watermark - (any)
#   timeStamp - SOAP::SOAPDateTime
#   folderId - FolderIdType
#   itemId - ItemIdType
#   parentFolderId - FolderIdType
#   unreadCount - SOAP::SOAPInt
class ModifiedEventType < BaseObjectChangedEventType
  attr_accessor :watermark
  attr_accessor :timeStamp
  attr_accessor :folderId
  attr_accessor :itemId
  attr_accessor :parentFolderId
  attr_accessor :unreadCount

  def initialize(watermark = nil, timeStamp = nil, folderId = nil, itemId = nil, parentFolderId = nil, unreadCount = nil)
    @watermark = watermark
    @timeStamp = timeStamp
    @folderId = folderId
    @itemId = itemId
    @parentFolderId = parentFolderId
    @unreadCount = unreadCount
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}MovedCopiedEventType
#   watermark - (any)
#   timeStamp - SOAP::SOAPDateTime
#   folderId - FolderIdType
#   itemId - ItemIdType
#   parentFolderId - FolderIdType
#   oldFolderId - FolderIdType
#   oldItemId - ItemIdType
#   oldParentFolderId - FolderIdType
class MovedCopiedEventType < BaseObjectChangedEventType
  attr_accessor :watermark
  attr_accessor :timeStamp
  attr_accessor :folderId
  attr_accessor :itemId
  attr_accessor :parentFolderId
  attr_accessor :oldFolderId
  attr_accessor :oldItemId
  attr_accessor :oldParentFolderId

  def initialize(watermark = nil, timeStamp = nil, folderId = nil, itemId = nil, parentFolderId = nil, oldFolderId = nil, oldItemId = nil, oldParentFolderId = nil)
    @watermark = watermark
    @timeStamp = timeStamp
    @folderId = folderId
    @itemId = itemId
    @parentFolderId = parentFolderId
    @oldFolderId = oldFolderId
    @oldItemId = oldItemId
    @oldParentFolderId = oldParentFolderId
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}NotificationType
#   subscriptionId - (any)
#   previousWatermark - (any)
#   moreEvents - SOAP::SOAPBoolean
#   copiedEvent - MovedCopiedEventType
#   createdEvent - BaseObjectChangedEventType
#   deletedEvent - BaseObjectChangedEventType
#   modifiedEvent - ModifiedEventType
#   movedEvent - MovedCopiedEventType
#   newMailEvent - BaseObjectChangedEventType
#   statusEvent - BaseNotificationEventType
class NotificationType
  attr_accessor :subscriptionId
  attr_accessor :previousWatermark
  attr_accessor :moreEvents
  attr_accessor :copiedEvent
  attr_accessor :createdEvent
  attr_accessor :deletedEvent
  attr_accessor :modifiedEvent
  attr_accessor :movedEvent
  attr_accessor :newMailEvent
  attr_accessor :statusEvent

  def initialize(subscriptionId = nil, previousWatermark = nil, moreEvents = nil, copiedEvent = [], createdEvent = [], deletedEvent = [], modifiedEvent = [], movedEvent = [], newMailEvent = [], statusEvent = [])
    @subscriptionId = subscriptionId
    @previousWatermark = previousWatermark
    @moreEvents = moreEvents
    @copiedEvent = copiedEvent
    @createdEvent = createdEvent
    @deletedEvent = deletedEvent
    @modifiedEvent = modifiedEvent
    @movedEvent = movedEvent
    @newMailEvent = newMailEvent
    @statusEvent = statusEvent
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}NonEmptyArrayOfNotificationEventTypesType
class NonEmptyArrayOfNotificationEventTypesType < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}BaseSubscriptionRequestType
# abstract
#   folderIds - NonEmptyArrayOfBaseFolderIdsType
#   eventTypes - NonEmptyArrayOfNotificationEventTypesType
#   watermark - (any)
class BaseSubscriptionRequestType
  attr_accessor :folderIds
  attr_accessor :eventTypes
  attr_accessor :watermark

  def initialize(folderIds = nil, eventTypes = nil, watermark = nil)
    @folderIds = folderIds
    @eventTypes = eventTypes
    @watermark = watermark
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}PushSubscriptionRequestType
#   folderIds - NonEmptyArrayOfBaseFolderIdsType
#   eventTypes - NonEmptyArrayOfNotificationEventTypesType
#   watermark - (any)
#   statusFrequency - (any)
#   uRL - SOAP::SOAPString
class PushSubscriptionRequestType < BaseSubscriptionRequestType
  attr_accessor :folderIds
  attr_accessor :eventTypes
  attr_accessor :watermark
  attr_accessor :statusFrequency
  attr_accessor :uRL

  def initialize(folderIds = nil, eventTypes = nil, watermark = nil, statusFrequency = nil, uRL = nil)
    @folderIds = folderIds
    @eventTypes = eventTypes
    @watermark = watermark
    @statusFrequency = statusFrequency
    @uRL = uRL
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}PullSubscriptionRequestType
#   folderIds - NonEmptyArrayOfBaseFolderIdsType
#   eventTypes - NonEmptyArrayOfNotificationEventTypesType
#   watermark - (any)
#   timeout - (any)
class PullSubscriptionRequestType < BaseSubscriptionRequestType
  attr_accessor :folderIds
  attr_accessor :eventTypes
  attr_accessor :watermark
  attr_accessor :timeout

  def initialize(folderIds = nil, eventTypes = nil, watermark = nil, timeout = nil)
    @folderIds = folderIds
    @eventTypes = eventTypes
    @watermark = watermark
    @timeout = timeout
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}SyncFolderItemsDeleteType
#   itemId - ItemIdType
class SyncFolderItemsDeleteType
  attr_accessor :itemId

  def initialize(itemId = nil)
    @itemId = itemId
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}SyncFolderItemsReadFlagType
#   itemId - ItemIdType
#   isRead - SOAP::SOAPBoolean
class SyncFolderItemsReadFlagType
  attr_accessor :itemId
  attr_accessor :isRead

  def initialize(itemId = nil, isRead = nil)
    @itemId = itemId
    @isRead = isRead
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}SyncFolderItemsChangesType
#   create - SyncFolderItemsCreateOrUpdateType
#   update - SyncFolderItemsCreateOrUpdateType
#   delete - SyncFolderItemsDeleteType
#   readFlagChange - SyncFolderItemsReadFlagType
class SyncFolderItemsChangesType
  attr_accessor :create
  attr_accessor :update
  attr_accessor :delete
  attr_accessor :readFlagChange

  def initialize(create = [], update = [], delete = [], readFlagChange = [])
    @create = create
    @update = update
    @delete = delete
    @readFlagChange = readFlagChange
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}SyncFolderHierarchyCreateOrUpdateType
#   folder - FolderType
#   calendarFolder - CalendarFolderType
#   contactsFolder - ContactsFolderType
#   searchFolder - SearchFolderType
#   tasksFolder - TasksFolderType
class SyncFolderHierarchyCreateOrUpdateType
  attr_accessor :folder
  attr_accessor :calendarFolder
  attr_accessor :contactsFolder
  attr_accessor :searchFolder
  attr_accessor :tasksFolder

  def initialize(folder = nil, calendarFolder = nil, contactsFolder = nil, searchFolder = nil, tasksFolder = nil)
    @folder = folder
    @calendarFolder = calendarFolder
    @contactsFolder = contactsFolder
    @searchFolder = searchFolder
    @tasksFolder = tasksFolder
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}SyncFolderHierarchyDeleteType
#   folderId - FolderIdType
class SyncFolderHierarchyDeleteType
  attr_accessor :folderId

  def initialize(folderId = nil)
    @folderId = folderId
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}SyncFolderHierarchyChangesType
#   create - SyncFolderHierarchyCreateOrUpdateType
#   update - SyncFolderHierarchyCreateOrUpdateType
#   delete - SyncFolderHierarchyDeleteType
class SyncFolderHierarchyChangesType
  attr_accessor :create
  attr_accessor :update
  attr_accessor :delete

  def initialize(create = [], update = [], delete = [])
    @create = create
    @update = update
    @delete = delete
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}CalendarEventDetails
#   iD - SOAP::SOAPString
#   subject - SOAP::SOAPString
#   location - SOAP::SOAPString
#   isMeeting - SOAP::SOAPBoolean
#   isRecurring - SOAP::SOAPBoolean
#   isException - SOAP::SOAPBoolean
#   isReminderSet - SOAP::SOAPBoolean
#   isPrivate - SOAP::SOAPBoolean
class CalendarEventDetails
  attr_accessor :iD
  attr_accessor :subject
  attr_accessor :location
  attr_accessor :isMeeting
  attr_accessor :isRecurring
  attr_accessor :isException
  attr_accessor :isReminderSet
  attr_accessor :isPrivate

  def initialize(iD = nil, subject = nil, location = nil, isMeeting = nil, isRecurring = nil, isException = nil, isReminderSet = nil, isPrivate = nil)
    @iD = iD
    @subject = subject
    @location = location
    @isMeeting = isMeeting
    @isRecurring = isRecurring
    @isException = isException
    @isReminderSet = isReminderSet
    @isPrivate = isPrivate
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}CalendarEvent
#   startTime - SOAP::SOAPDateTime
#   endTime - SOAP::SOAPDateTime
#   busyType - LegacyFreeBusyType
#   calendarEventDetails - CalendarEventDetails
class CalendarEvent
  attr_accessor :startTime
  attr_accessor :endTime
  attr_accessor :busyType
  attr_accessor :calendarEventDetails

  def initialize(startTime = nil, endTime = nil, busyType = nil, calendarEventDetails = nil)
    @startTime = startTime
    @endTime = endTime
    @busyType = busyType
    @calendarEventDetails = calendarEventDetails
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ArrayOfCalendarEvent
class ArrayOfCalendarEvent < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}Duration
#   startTime - SOAP::SOAPDateTime
#   endTime - SOAP::SOAPDateTime
class Duration
  attr_accessor :startTime
  attr_accessor :endTime

  def initialize(startTime = nil, endTime = nil)
    @startTime = startTime
    @endTime = endTime
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}EmailAddress
#   name - SOAP::SOAPString
#   address - SOAP::SOAPString
#   routingType - SOAP::SOAPString
class EmailAddress
  attr_accessor :name
  attr_accessor :address
  attr_accessor :routingType

  def initialize(name = nil, address = nil, routingType = nil)
    @name = name
    @address = address
    @routingType = routingType
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}FreeBusyViewOptionsType
#   timeWindow - Duration
#   mergedFreeBusyIntervalInMinutes - SOAP::SOAPInt
#   requestedView - (any)
class FreeBusyViewOptionsType
  attr_accessor :timeWindow
  attr_accessor :mergedFreeBusyIntervalInMinutes
  attr_accessor :requestedView

  def initialize(timeWindow = nil, mergedFreeBusyIntervalInMinutes = nil, requestedView = nil)
    @timeWindow = timeWindow
    @mergedFreeBusyIntervalInMinutes = mergedFreeBusyIntervalInMinutes
    @requestedView = requestedView
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}WorkingPeriod
#   dayOfWeek - (any)
#   startTimeInMinutes - SOAP::SOAPInt
#   endTimeInMinutes - SOAP::SOAPInt
class WorkingPeriod
  attr_accessor :dayOfWeek
  attr_accessor :startTimeInMinutes
  attr_accessor :endTimeInMinutes

  def initialize(dayOfWeek = nil, startTimeInMinutes = nil, endTimeInMinutes = nil)
    @dayOfWeek = dayOfWeek
    @startTimeInMinutes = startTimeInMinutes
    @endTimeInMinutes = endTimeInMinutes
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ArrayOfWorkingPeriod
class ArrayOfWorkingPeriod < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}SerializableTimeZoneTime
#   bias - SOAP::SOAPInt
#   time - SOAP::SOAPString
#   dayOrder - SOAP::SOAPShort
#   month - SOAP::SOAPShort
#   dayOfWeek - DayOfWeekType
#   year - SOAP::SOAPString
class SerializableTimeZoneTime
  attr_accessor :bias
  attr_accessor :time
  attr_accessor :dayOrder
  attr_accessor :month
  attr_accessor :dayOfWeek
  attr_accessor :year

  def initialize(bias = nil, time = nil, dayOrder = nil, month = nil, dayOfWeek = nil, year = nil)
    @bias = bias
    @time = time
    @dayOrder = dayOrder
    @month = month
    @dayOfWeek = dayOfWeek
    @year = year
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}SerializableTimeZone
#   bias - SOAP::SOAPInt
#   standardTime - SerializableTimeZoneTime
#   daylightTime - SerializableTimeZoneTime
class SerializableTimeZone
  attr_accessor :bias
  attr_accessor :standardTime
  attr_accessor :daylightTime

  def initialize(bias = nil, standardTime = nil, daylightTime = nil)
    @bias = bias
    @standardTime = standardTime
    @daylightTime = daylightTime
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}WorkingHours
#   timeZone - SerializableTimeZone
#   workingPeriodArray - ArrayOfWorkingPeriod
class WorkingHours
  attr_accessor :timeZone
  attr_accessor :workingPeriodArray

  def initialize(timeZone = nil, workingPeriodArray = nil)
    @timeZone = timeZone
    @workingPeriodArray = workingPeriodArray
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}FreeBusyView
#   freeBusyViewType - (any)
#   mergedFreeBusy - SOAP::SOAPString
#   calendarEventArray - ArrayOfCalendarEvent
#   workingHours - WorkingHours
class FreeBusyView
  attr_accessor :freeBusyViewType
  attr_accessor :mergedFreeBusy
  attr_accessor :calendarEventArray
  attr_accessor :workingHours

  def initialize(freeBusyViewType = nil, mergedFreeBusy = nil, calendarEventArray = nil, workingHours = nil)
    @freeBusyViewType = freeBusyViewType
    @mergedFreeBusy = mergedFreeBusy
    @calendarEventArray = calendarEventArray
    @workingHours = workingHours
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}MailboxData
#   email - EmailAddress
#   attendeeType - MeetingAttendeeType
#   excludeConflicts - SOAP::SOAPBoolean
class MailboxData
  attr_accessor :email
  attr_accessor :attendeeType
  attr_accessor :excludeConflicts

  def initialize(email = nil, attendeeType = nil, excludeConflicts = nil)
    @email = email
    @attendeeType = attendeeType
    @excludeConflicts = excludeConflicts
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ArrayOfMailboxData
class ArrayOfMailboxData < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}SuggestionsViewOptionsType
#   goodThreshold - SOAP::SOAPInt
#   maximumResultsByDay - SOAP::SOAPInt
#   maximumNonWorkHourResultsByDay - SOAP::SOAPInt
#   meetingDurationInMinutes - SOAP::SOAPInt
#   minimumSuggestionQuality - SuggestionQuality
#   detailedSuggestionsWindow - Duration
#   currentMeetingTime - SOAP::SOAPDateTime
#   globalObjectId - SOAP::SOAPString
class SuggestionsViewOptionsType
  attr_accessor :goodThreshold
  attr_accessor :maximumResultsByDay
  attr_accessor :maximumNonWorkHourResultsByDay
  attr_accessor :meetingDurationInMinutes
  attr_accessor :minimumSuggestionQuality
  attr_accessor :detailedSuggestionsWindow
  attr_accessor :currentMeetingTime
  attr_accessor :globalObjectId

  def initialize(goodThreshold = nil, maximumResultsByDay = nil, maximumNonWorkHourResultsByDay = nil, meetingDurationInMinutes = nil, minimumSuggestionQuality = nil, detailedSuggestionsWindow = nil, currentMeetingTime = nil, globalObjectId = nil)
    @goodThreshold = goodThreshold
    @maximumResultsByDay = maximumResultsByDay
    @maximumNonWorkHourResultsByDay = maximumNonWorkHourResultsByDay
    @meetingDurationInMinutes = meetingDurationInMinutes
    @minimumSuggestionQuality = minimumSuggestionQuality
    @detailedSuggestionsWindow = detailedSuggestionsWindow
    @currentMeetingTime = currentMeetingTime
    @globalObjectId = globalObjectId
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ArrayOfAttendeeConflictData
#   unknownAttendeeConflictData - UnknownAttendeeConflictData
#   individualAttendeeConflictData - IndividualAttendeeConflictData
#   tooBigGroupAttendeeConflictData - TooBigGroupAttendeeConflictData
#   groupAttendeeConflictData - GroupAttendeeConflictData
class ArrayOfAttendeeConflictData
  attr_accessor :unknownAttendeeConflictData
  attr_accessor :individualAttendeeConflictData
  attr_accessor :tooBigGroupAttendeeConflictData
  attr_accessor :groupAttendeeConflictData

  def initialize(unknownAttendeeConflictData = [], individualAttendeeConflictData = [], tooBigGroupAttendeeConflictData = [], groupAttendeeConflictData = [])
    @unknownAttendeeConflictData = unknownAttendeeConflictData
    @individualAttendeeConflictData = individualAttendeeConflictData
    @tooBigGroupAttendeeConflictData = tooBigGroupAttendeeConflictData
    @groupAttendeeConflictData = groupAttendeeConflictData
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}AttendeeConflictData
# abstract
class AttendeeConflictData
  def initialize
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}UnknownAttendeeConflictData
class UnknownAttendeeConflictData < AttendeeConflictData
  def initialize
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}TooBigGroupAttendeeConflictData
class TooBigGroupAttendeeConflictData < AttendeeConflictData
  def initialize
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}IndividualAttendeeConflictData
#   busyType - LegacyFreeBusyType
class IndividualAttendeeConflictData < AttendeeConflictData
  attr_accessor :busyType

  def initialize(busyType = nil)
    @busyType = busyType
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}GroupAttendeeConflictData
#   numberOfMembers - SOAP::SOAPInt
#   numberOfMembersAvailable - SOAP::SOAPInt
#   numberOfMembersWithConflict - SOAP::SOAPInt
#   numberOfMembersWithNoData - SOAP::SOAPInt
class GroupAttendeeConflictData < AttendeeConflictData
  attr_accessor :numberOfMembers
  attr_accessor :numberOfMembersAvailable
  attr_accessor :numberOfMembersWithConflict
  attr_accessor :numberOfMembersWithNoData

  def initialize(numberOfMembers = nil, numberOfMembersAvailable = nil, numberOfMembersWithConflict = nil, numberOfMembersWithNoData = nil)
    @numberOfMembers = numberOfMembers
    @numberOfMembersAvailable = numberOfMembersAvailable
    @numberOfMembersWithConflict = numberOfMembersWithConflict
    @numberOfMembersWithNoData = numberOfMembersWithNoData
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}Suggestion
#   meetingTime - SOAP::SOAPDateTime
#   isWorkTime - SOAP::SOAPBoolean
#   suggestionQuality - SuggestionQuality
#   attendeeConflictDataArray - ArrayOfAttendeeConflictData
class Suggestion
  attr_accessor :meetingTime
  attr_accessor :isWorkTime
  attr_accessor :suggestionQuality
  attr_accessor :attendeeConflictDataArray

  def initialize(meetingTime = nil, isWorkTime = nil, suggestionQuality = nil, attendeeConflictDataArray = nil)
    @meetingTime = meetingTime
    @isWorkTime = isWorkTime
    @suggestionQuality = suggestionQuality
    @attendeeConflictDataArray = attendeeConflictDataArray
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ArrayOfSuggestion
class ArrayOfSuggestion < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}SuggestionDayResult
#   date - SOAP::SOAPDateTime
#   dayQuality - SuggestionQuality
#   suggestionArray - ArrayOfSuggestion
class SuggestionDayResult
  attr_accessor :date
  attr_accessor :dayQuality
  attr_accessor :suggestionArray

  def initialize(date = nil, dayQuality = nil, suggestionArray = nil)
    @date = date
    @dayQuality = dayQuality
    @suggestionArray = suggestionArray
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ArrayOfSuggestionDayResult
class ArrayOfSuggestionDayResult < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ReplyBody
#   message - SOAP::SOAPString
#   xmlattr_lang - (any)
class ReplyBody
  AttrLang = XSD::QName.new("http://www.w3.org/XML/1998/namespace", "lang")

  attr_accessor :message

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_lang
    __xmlattr[AttrLang]
  end

  def xmlattr_lang=(value)
    __xmlattr[AttrLang] = value
  end

  def initialize(message = nil)
    @message = message
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}UserOofSettings
#   oofState - OofState
#   externalAudience - ExternalAudience
#   duration - Duration
#   internalReply - ReplyBody
#   externalReply - ReplyBody
class UserOofSettings
  attr_accessor :oofState
  attr_accessor :externalAudience
  attr_accessor :duration
  attr_accessor :internalReply
  attr_accessor :externalReply

  def initialize(oofState = nil, externalAudience = nil, duration = nil, internalReply = nil, externalReply = nil)
    @oofState = oofState
    @externalAudience = externalAudience
    @duration = duration
    @internalReply = internalReply
    @externalReply = externalReply
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}Value
#   xmlattr_Name - SOAP::SOAPString
class Value < ::String
  AttrName = XSD::QName.new(nil, "Name")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_Name
    __xmlattr[AttrName]
  end

  def xmlattr_Name=(value)
    __xmlattr[AttrName] = value
  end

  def initialize(*arg)
    super
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}AlternateIdBaseType
# abstract
#   xmlattr_Format - SOAP::SOAPString
class AlternateIdBaseType
  AttrFormat = XSD::QName.new(nil, "Format")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_Format
    __xmlattr[AttrFormat]
  end

  def xmlattr_Format=(value)
    __xmlattr[AttrFormat] = value
  end

  def initialize
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}AlternateIdType
#   xmlattr_Format - SOAP::SOAPString
#   xmlattr_Id - SOAP::SOAPString
#   xmlattr_Mailbox - SOAP::SOAPString
class AlternateIdType < AlternateIdBaseType
  AttrFormat = XSD::QName.new(nil, "Format")
  AttrId = XSD::QName.new(nil, "Id")
  AttrMailbox = XSD::QName.new(nil, "Mailbox")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_Format
    __xmlattr[AttrFormat]
  end

  def xmlattr_Format=(value)
    __xmlattr[AttrFormat] = value
  end

  def xmlattr_Id
    __xmlattr[AttrId]
  end

  def xmlattr_Id=(value)
    __xmlattr[AttrId] = value
  end

  def xmlattr_Mailbox
    __xmlattr[AttrMailbox]
  end

  def xmlattr_Mailbox=(value)
    __xmlattr[AttrMailbox] = value
  end

  def initialize
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}AlternatePublicFolderIdType
#   xmlattr_Format - SOAP::SOAPString
#   xmlattr_FolderId - SOAP::SOAPString
class AlternatePublicFolderIdType < AlternateIdBaseType
  AttrFolderId = XSD::QName.new(nil, "FolderId")
  AttrFormat = XSD::QName.new(nil, "Format")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_Format
    __xmlattr[AttrFormat]
  end

  def xmlattr_Format=(value)
    __xmlattr[AttrFormat] = value
  end

  def xmlattr_FolderId
    __xmlattr[AttrFolderId]
  end

  def xmlattr_FolderId=(value)
    __xmlattr[AttrFolderId] = value
  end

  def initialize
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}AlternatePublicFolderItemIdType
#   xmlattr_Format - SOAP::SOAPString
#   xmlattr_FolderId - SOAP::SOAPString
#   xmlattr_ItemId - SOAP::SOAPString
class AlternatePublicFolderItemIdType < AlternatePublicFolderIdType
  AttrFolderId = XSD::QName.new(nil, "FolderId")
  AttrFormat = XSD::QName.new(nil, "Format")
  AttrItemId = XSD::QName.new(nil, "ItemId")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_Format
    __xmlattr[AttrFormat]
  end

  def xmlattr_Format=(value)
    __xmlattr[AttrFormat] = value
  end

  def xmlattr_FolderId
    __xmlattr[AttrFolderId]
  end

  def xmlattr_FolderId=(value)
    __xmlattr[AttrFolderId] = value
  end

  def xmlattr_ItemId
    __xmlattr[AttrItemId]
  end

  def xmlattr_ItemId=(value)
    __xmlattr[AttrItemId] = value
  end

  def initialize
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}NonEmptyArrayOfAlternateIdsType
#   alternateId - AlternateIdType
#   alternatePublicFolderId - AlternatePublicFolderIdType
#   alternatePublicFolderItemId - AlternatePublicFolderItemIdType
class NonEmptyArrayOfAlternateIdsType
  attr_accessor :alternateId
  attr_accessor :alternatePublicFolderId
  attr_accessor :alternatePublicFolderItemId

  def initialize(alternateId = [], alternatePublicFolderId = [], alternatePublicFolderItemId = [])
    @alternateId = alternateId
    @alternatePublicFolderId = alternatePublicFolderId
    @alternatePublicFolderItemId = alternatePublicFolderItemId
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}UserIdType
#   sID - SOAP::SOAPString
#   primarySmtpAddress - SOAP::SOAPString
#   displayName - SOAP::SOAPString
#   distinguishedUser - DistinguishedUserType
class UserIdType
  attr_accessor :sID
  attr_accessor :primarySmtpAddress
  attr_accessor :displayName
  attr_accessor :distinguishedUser

  def initialize(sID = nil, primarySmtpAddress = nil, displayName = nil, distinguishedUser = nil)
    @sID = sID
    @primarySmtpAddress = primarySmtpAddress
    @displayName = displayName
    @distinguishedUser = distinguishedUser
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ArrayOfPermissionsType
class ArrayOfPermissionsType < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ArrayOfCalendarPermissionsType
class ArrayOfCalendarPermissionsType < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ArrayOfUnknownEntriesType
class ArrayOfUnknownEntriesType < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}BasePermissionType
# abstract
#   userId - UserIdType
#   canCreateItems - SOAP::SOAPBoolean
#   canCreateSubFolders - SOAP::SOAPBoolean
#   isFolderOwner - SOAP::SOAPBoolean
#   isFolderVisible - SOAP::SOAPBoolean
#   isFolderContact - SOAP::SOAPBoolean
#   editItems - PermissionActionType
#   deleteItems - PermissionActionType
class BasePermissionType
  attr_accessor :userId
  attr_accessor :canCreateItems
  attr_accessor :canCreateSubFolders
  attr_accessor :isFolderOwner
  attr_accessor :isFolderVisible
  attr_accessor :isFolderContact
  attr_accessor :editItems
  attr_accessor :deleteItems

  def initialize(userId = nil, canCreateItems = nil, canCreateSubFolders = nil, isFolderOwner = nil, isFolderVisible = nil, isFolderContact = nil, editItems = nil, deleteItems = nil)
    @userId = userId
    @canCreateItems = canCreateItems
    @canCreateSubFolders = canCreateSubFolders
    @isFolderOwner = isFolderOwner
    @isFolderVisible = isFolderVisible
    @isFolderContact = isFolderContact
    @editItems = editItems
    @deleteItems = deleteItems
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}PermissionType
#   userId - UserIdType
#   canCreateItems - SOAP::SOAPBoolean
#   canCreateSubFolders - SOAP::SOAPBoolean
#   isFolderOwner - SOAP::SOAPBoolean
#   isFolderVisible - SOAP::SOAPBoolean
#   isFolderContact - SOAP::SOAPBoolean
#   editItems - PermissionActionType
#   deleteItems - PermissionActionType
#   readItems - PermissionReadAccessType
#   permissionLevel - PermissionLevelType
class PermissionType < BasePermissionType
  attr_accessor :userId
  attr_accessor :canCreateItems
  attr_accessor :canCreateSubFolders
  attr_accessor :isFolderOwner
  attr_accessor :isFolderVisible
  attr_accessor :isFolderContact
  attr_accessor :editItems
  attr_accessor :deleteItems
  attr_accessor :readItems
  attr_accessor :permissionLevel

  def initialize(userId = nil, canCreateItems = nil, canCreateSubFolders = nil, isFolderOwner = nil, isFolderVisible = nil, isFolderContact = nil, editItems = nil, deleteItems = nil, readItems = nil, permissionLevel = nil)
    @userId = userId
    @canCreateItems = canCreateItems
    @canCreateSubFolders = canCreateSubFolders
    @isFolderOwner = isFolderOwner
    @isFolderVisible = isFolderVisible
    @isFolderContact = isFolderContact
    @editItems = editItems
    @deleteItems = deleteItems
    @readItems = readItems
    @permissionLevel = permissionLevel
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}CalendarPermissionType
#   userId - UserIdType
#   canCreateItems - SOAP::SOAPBoolean
#   canCreateSubFolders - SOAP::SOAPBoolean
#   isFolderOwner - SOAP::SOAPBoolean
#   isFolderVisible - SOAP::SOAPBoolean
#   isFolderContact - SOAP::SOAPBoolean
#   editItems - PermissionActionType
#   deleteItems - PermissionActionType
#   readItems - CalendarPermissionReadAccessType
#   calendarPermissionLevel - CalendarPermissionLevelType
class CalendarPermissionType < BasePermissionType
  attr_accessor :userId
  attr_accessor :canCreateItems
  attr_accessor :canCreateSubFolders
  attr_accessor :isFolderOwner
  attr_accessor :isFolderVisible
  attr_accessor :isFolderContact
  attr_accessor :editItems
  attr_accessor :deleteItems
  attr_accessor :readItems
  attr_accessor :calendarPermissionLevel

  def initialize(userId = nil, canCreateItems = nil, canCreateSubFolders = nil, isFolderOwner = nil, isFolderVisible = nil, isFolderContact = nil, editItems = nil, deleteItems = nil, readItems = nil, calendarPermissionLevel = nil)
    @userId = userId
    @canCreateItems = canCreateItems
    @canCreateSubFolders = canCreateSubFolders
    @isFolderOwner = isFolderOwner
    @isFolderVisible = isFolderVisible
    @isFolderContact = isFolderContact
    @editItems = editItems
    @deleteItems = deleteItems
    @readItems = readItems
    @calendarPermissionLevel = calendarPermissionLevel
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}PermissionSetType
#   permissions - ArrayOfPermissionsType
#   unknownEntries - ArrayOfUnknownEntriesType
class PermissionSetType
  attr_accessor :permissions
  attr_accessor :unknownEntries

  def initialize(permissions = nil, unknownEntries = nil)
    @permissions = permissions
    @unknownEntries = unknownEntries
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}CalendarPermissionSetType
#   calendarPermissions - ArrayOfCalendarPermissionsType
#   unknownEntries - ArrayOfUnknownEntriesType
class CalendarPermissionSetType
  attr_accessor :calendarPermissions
  attr_accessor :unknownEntries

  def initialize(calendarPermissions = nil, unknownEntries = nil)
    @calendarPermissions = calendarPermissions
    @unknownEntries = unknownEntries
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}EffectiveRightsType
#   createAssociated - SOAP::SOAPBoolean
#   createContents - SOAP::SOAPBoolean
#   createHierarchy - SOAP::SOAPBoolean
#   delete - SOAP::SOAPBoolean
#   modify - SOAP::SOAPBoolean
#   read - SOAP::SOAPBoolean
class EffectiveRightsType
  attr_accessor :createAssociated
  attr_accessor :createContents
  attr_accessor :createHierarchy
  attr_accessor :delete
  attr_accessor :modify
  attr_accessor :read

  def initialize(createAssociated = nil, createContents = nil, createHierarchy = nil, delete = nil, modify = nil, read = nil)
    @createAssociated = createAssociated
    @createContents = createContents
    @createHierarchy = createHierarchy
    @delete = delete
    @modify = modify
    @read = read
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ArrayOfDelegateUserType
class ArrayOfDelegateUserType < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ArrayOfUserIdType
class ArrayOfUserIdType < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}DelegateUserType
#   userId - UserIdType
#   delegatePermissions - DelegatePermissionsType
#   receiveCopiesOfMeetingMessages - SOAP::SOAPBoolean
#   viewPrivateItems - SOAP::SOAPBoolean
class DelegateUserType
  attr_accessor :userId
  attr_accessor :delegatePermissions
  attr_accessor :receiveCopiesOfMeetingMessages
  attr_accessor :viewPrivateItems

  def initialize(userId = nil, delegatePermissions = nil, receiveCopiesOfMeetingMessages = nil, viewPrivateItems = nil)
    @userId = userId
    @delegatePermissions = delegatePermissions
    @receiveCopiesOfMeetingMessages = receiveCopiesOfMeetingMessages
    @viewPrivateItems = viewPrivateItems
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}DelegatePermissionsType
#   calendarFolderPermissionLevel - DelegateFolderPermissionLevelType
#   tasksFolderPermissionLevel - DelegateFolderPermissionLevelType
#   inboxFolderPermissionLevel - DelegateFolderPermissionLevelType
#   contactsFolderPermissionLevel - DelegateFolderPermissionLevelType
#   notesFolderPermissionLevel - DelegateFolderPermissionLevelType
#   journalFolderPermissionLevel - DelegateFolderPermissionLevelType
class DelegatePermissionsType
  attr_accessor :calendarFolderPermissionLevel
  attr_accessor :tasksFolderPermissionLevel
  attr_accessor :inboxFolderPermissionLevel
  attr_accessor :contactsFolderPermissionLevel
  attr_accessor :notesFolderPermissionLevel
  attr_accessor :journalFolderPermissionLevel

  def initialize(calendarFolderPermissionLevel = nil, tasksFolderPermissionLevel = nil, inboxFolderPermissionLevel = nil, contactsFolderPermissionLevel = nil, notesFolderPermissionLevel = nil, journalFolderPermissionLevel = nil)
    @calendarFolderPermissionLevel = calendarFolderPermissionLevel
    @tasksFolderPermissionLevel = tasksFolderPermissionLevel
    @inboxFolderPermissionLevel = inboxFolderPermissionLevel
    @contactsFolderPermissionLevel = contactsFolderPermissionLevel
    @notesFolderPermissionLevel = notesFolderPermissionLevel
    @journalFolderPermissionLevel = journalFolderPermissionLevel
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ConflictResultsType
#   count - SOAP::SOAPInt
class ConflictResultsType
  attr_accessor :count

  def initialize(count = nil)
    @count = count
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/messages}ResponseCodeType
class ResponseCodeType < ::String
  ErrorADOperation = ResponseCodeType.new("ErrorADOperation")
  ErrorADSessionFilter = ResponseCodeType.new("ErrorADSessionFilter")
  ErrorADUnavailable = ResponseCodeType.new("ErrorADUnavailable")
  ErrorAccessDenied = ResponseCodeType.new("ErrorAccessDenied")
  ErrorAccountDisabled = ResponseCodeType.new("ErrorAccountDisabled")
  ErrorAddDelegatesFailed = ResponseCodeType.new("ErrorAddDelegatesFailed")
  ErrorAddressSpaceNotFound = ResponseCodeType.new("ErrorAddressSpaceNotFound")
  ErrorAffectedTaskOccurrencesRequired = ResponseCodeType.new("ErrorAffectedTaskOccurrencesRequired")
  ErrorAttachmentSizeLimitExceeded = ResponseCodeType.new("ErrorAttachmentSizeLimitExceeded")
  ErrorAutoDiscoverFailed = ResponseCodeType.new("ErrorAutoDiscoverFailed")
  ErrorAvailabilityConfigNotFound = ResponseCodeType.new("ErrorAvailabilityConfigNotFound")
  ErrorBatchProcessingStopped = ResponseCodeType.new("ErrorBatchProcessingStopped")
  ErrorCalendarCannotMoveOrCopyOccurrence = ResponseCodeType.new("ErrorCalendarCannotMoveOrCopyOccurrence")
  ErrorCalendarCannotUpdateDeletedItem = ResponseCodeType.new("ErrorCalendarCannotUpdateDeletedItem")
  ErrorCalendarCannotUseIdForOccurrenceId = ResponseCodeType.new("ErrorCalendarCannotUseIdForOccurrenceId")
  ErrorCalendarCannotUseIdForRecurringMasterId = ResponseCodeType.new("ErrorCalendarCannotUseIdForRecurringMasterId")
  ErrorCalendarDurationIsTooLong = ResponseCodeType.new("ErrorCalendarDurationIsTooLong")
  ErrorCalendarEndDateIsEarlierThanStartDate = ResponseCodeType.new("ErrorCalendarEndDateIsEarlierThanStartDate")
  ErrorCalendarFolderIsInvalidForCalendarView = ResponseCodeType.new("ErrorCalendarFolderIsInvalidForCalendarView")
  ErrorCalendarInvalidAttributeValue = ResponseCodeType.new("ErrorCalendarInvalidAttributeValue")
  ErrorCalendarInvalidDayForTimeChangePattern = ResponseCodeType.new("ErrorCalendarInvalidDayForTimeChangePattern")
  ErrorCalendarInvalidDayForWeeklyRecurrence = ResponseCodeType.new("ErrorCalendarInvalidDayForWeeklyRecurrence")
  ErrorCalendarInvalidPropertyState = ResponseCodeType.new("ErrorCalendarInvalidPropertyState")
  ErrorCalendarInvalidPropertyValue = ResponseCodeType.new("ErrorCalendarInvalidPropertyValue")
  ErrorCalendarInvalidRecurrence = ResponseCodeType.new("ErrorCalendarInvalidRecurrence")
  ErrorCalendarInvalidTimeZone = ResponseCodeType.new("ErrorCalendarInvalidTimeZone")
  ErrorCalendarIsDelegatedForAccept = ResponseCodeType.new("ErrorCalendarIsDelegatedForAccept")
  ErrorCalendarIsDelegatedForDecline = ResponseCodeType.new("ErrorCalendarIsDelegatedForDecline")
  ErrorCalendarIsDelegatedForRemove = ResponseCodeType.new("ErrorCalendarIsDelegatedForRemove")
  ErrorCalendarIsDelegatedForTentative = ResponseCodeType.new("ErrorCalendarIsDelegatedForTentative")
  ErrorCalendarIsNotOrganizer = ResponseCodeType.new("ErrorCalendarIsNotOrganizer")
  ErrorCalendarIsOrganizerForAccept = ResponseCodeType.new("ErrorCalendarIsOrganizerForAccept")
  ErrorCalendarIsOrganizerForDecline = ResponseCodeType.new("ErrorCalendarIsOrganizerForDecline")
  ErrorCalendarIsOrganizerForRemove = ResponseCodeType.new("ErrorCalendarIsOrganizerForRemove")
  ErrorCalendarIsOrganizerForTentative = ResponseCodeType.new("ErrorCalendarIsOrganizerForTentative")
  ErrorCalendarMeetingRequestIsOutOfDate = ResponseCodeType.new("ErrorCalendarMeetingRequestIsOutOfDate")
  ErrorCalendarOccurrenceIndexIsOutOfRecurrenceRange = ResponseCodeType.new("ErrorCalendarOccurrenceIndexIsOutOfRecurrenceRange")
  ErrorCalendarOccurrenceIsDeletedFromRecurrence = ResponseCodeType.new("ErrorCalendarOccurrenceIsDeletedFromRecurrence")
  ErrorCalendarOutOfRange = ResponseCodeType.new("ErrorCalendarOutOfRange")
  ErrorCalendarViewRangeTooBig = ResponseCodeType.new("ErrorCalendarViewRangeTooBig")
  ErrorCannotCreateCalendarItemInNonCalendarFolder = ResponseCodeType.new("ErrorCannotCreateCalendarItemInNonCalendarFolder")
  ErrorCannotCreateContactInNonContactFolder = ResponseCodeType.new("ErrorCannotCreateContactInNonContactFolder")
  ErrorCannotCreatePostItemInNonMailFolder = ResponseCodeType.new("ErrorCannotCreatePostItemInNonMailFolder")
  ErrorCannotCreateTaskInNonTaskFolder = ResponseCodeType.new("ErrorCannotCreateTaskInNonTaskFolder")
  ErrorCannotDeleteObject = ResponseCodeType.new("ErrorCannotDeleteObject")
  ErrorCannotDeleteTaskOccurrence = ResponseCodeType.new("ErrorCannotDeleteTaskOccurrence")
  ErrorCannotOpenFileAttachment = ResponseCodeType.new("ErrorCannotOpenFileAttachment")
  ErrorCannotSetCalendarPermissionOnNonCalendarFolder = ResponseCodeType.new("ErrorCannotSetCalendarPermissionOnNonCalendarFolder")
  ErrorCannotSetNonCalendarPermissionOnCalendarFolder = ResponseCodeType.new("ErrorCannotSetNonCalendarPermissionOnCalendarFolder")
  ErrorCannotSetPermissionUnknownEntries = ResponseCodeType.new("ErrorCannotSetPermissionUnknownEntries")
  ErrorCannotUseFolderIdForItemId = ResponseCodeType.new("ErrorCannotUseFolderIdForItemId")
  ErrorCannotUseItemIdForFolderId = ResponseCodeType.new("ErrorCannotUseItemIdForFolderId")
  ErrorChangeKeyRequired = ResponseCodeType.new("ErrorChangeKeyRequired")
  ErrorChangeKeyRequiredForWriteOperations = ResponseCodeType.new("ErrorChangeKeyRequiredForWriteOperations")
  ErrorConnectionFailed = ResponseCodeType.new("ErrorConnectionFailed")
  ErrorContentConversionFailed = ResponseCodeType.new("ErrorContentConversionFailed")
  ErrorCorruptData = ResponseCodeType.new("ErrorCorruptData")
  ErrorCreateItemAccessDenied = ResponseCodeType.new("ErrorCreateItemAccessDenied")
  ErrorCreateManagedFolderPartialCompletion = ResponseCodeType.new("ErrorCreateManagedFolderPartialCompletion")
  ErrorCreateSubfolderAccessDenied = ResponseCodeType.new("ErrorCreateSubfolderAccessDenied")
  ErrorCrossMailboxMoveCopy = ResponseCodeType.new("ErrorCrossMailboxMoveCopy")
  ErrorDataSizeLimitExceeded = ResponseCodeType.new("ErrorDataSizeLimitExceeded")
  ErrorDataSourceOperation = ResponseCodeType.new("ErrorDataSourceOperation")
  ErrorDelegateAlreadyExists = ResponseCodeType.new("ErrorDelegateAlreadyExists")
  ErrorDelegateCannotAddOwner = ResponseCodeType.new("ErrorDelegateCannotAddOwner")
  ErrorDelegateMissingConfiguration = ResponseCodeType.new("ErrorDelegateMissingConfiguration")
  ErrorDelegateNoUser = ResponseCodeType.new("ErrorDelegateNoUser")
  ErrorDelegateValidationFailed = ResponseCodeType.new("ErrorDelegateValidationFailed")
  ErrorDeleteDistinguishedFolder = ResponseCodeType.new("ErrorDeleteDistinguishedFolder")
  ErrorDeleteItemsFailed = ResponseCodeType.new("ErrorDeleteItemsFailed")
  ErrorDistinguishedUserNotSupported = ResponseCodeType.new("ErrorDistinguishedUserNotSupported")
  ErrorDuplicateInputFolderNames = ResponseCodeType.new("ErrorDuplicateInputFolderNames")
  ErrorDuplicateUserIdsSpecified = ResponseCodeType.new("ErrorDuplicateUserIdsSpecified")
  ErrorEmailAddressMismatch = ResponseCodeType.new("ErrorEmailAddressMismatch")
  ErrorEventNotFound = ResponseCodeType.new("ErrorEventNotFound")
  ErrorExpiredSubscription = ResponseCodeType.new("ErrorExpiredSubscription")
  ErrorFolderCorrupt = ResponseCodeType.new("ErrorFolderCorrupt")
  ErrorFolderExists = ResponseCodeType.new("ErrorFolderExists")
  ErrorFolderNotFound = ResponseCodeType.new("ErrorFolderNotFound")
  ErrorFolderPropertRequestFailed = ResponseCodeType.new("ErrorFolderPropertRequestFailed")
  ErrorFolderSave = ResponseCodeType.new("ErrorFolderSave")
  ErrorFolderSaveFailed = ResponseCodeType.new("ErrorFolderSaveFailed")
  ErrorFolderSavePropertyError = ResponseCodeType.new("ErrorFolderSavePropertyError")
  ErrorFreeBusyGenerationFailed = ResponseCodeType.new("ErrorFreeBusyGenerationFailed")
  ErrorGetServerSecurityDescriptorFailed = ResponseCodeType.new("ErrorGetServerSecurityDescriptorFailed")
  ErrorImpersonateUserDenied = ResponseCodeType.new("ErrorImpersonateUserDenied")
  ErrorImpersonationDenied = ResponseCodeType.new("ErrorImpersonationDenied")
  ErrorImpersonationFailed = ResponseCodeType.new("ErrorImpersonationFailed")
  ErrorIncorrectSchemaVersion = ResponseCodeType.new("ErrorIncorrectSchemaVersion")
  ErrorIncorrectUpdatePropertyCount = ResponseCodeType.new("ErrorIncorrectUpdatePropertyCount")
  ErrorIndividualMailboxLimitReached = ResponseCodeType.new("ErrorIndividualMailboxLimitReached")
  ErrorInsufficientResources = ResponseCodeType.new("ErrorInsufficientResources")
  ErrorInternalServerError = ResponseCodeType.new("ErrorInternalServerError")
  ErrorInternalServerTransientError = ResponseCodeType.new("ErrorInternalServerTransientError")
  ErrorInvalidAccessLevel = ResponseCodeType.new("ErrorInvalidAccessLevel")
  ErrorInvalidAttachmentId = ResponseCodeType.new("ErrorInvalidAttachmentId")
  ErrorInvalidAttachmentSubfilter = ResponseCodeType.new("ErrorInvalidAttachmentSubfilter")
  ErrorInvalidAttachmentSubfilterTextFilter = ResponseCodeType.new("ErrorInvalidAttachmentSubfilterTextFilter")
  ErrorInvalidAuthorizationContext = ResponseCodeType.new("ErrorInvalidAuthorizationContext")
  ErrorInvalidChangeKey = ResponseCodeType.new("ErrorInvalidChangeKey")
  ErrorInvalidClientSecurityContext = ResponseCodeType.new("ErrorInvalidClientSecurityContext")
  ErrorInvalidCompleteDate = ResponseCodeType.new("ErrorInvalidCompleteDate")
  ErrorInvalidCrossForestCredentials = ResponseCodeType.new("ErrorInvalidCrossForestCredentials")
  ErrorInvalidDelegatePermission = ResponseCodeType.new("ErrorInvalidDelegatePermission")
  ErrorInvalidDelegateUserId = ResponseCodeType.new("ErrorInvalidDelegateUserId")
  ErrorInvalidExchangeImpersonationHeaderData = ResponseCodeType.new("ErrorInvalidExchangeImpersonationHeaderData")
  ErrorInvalidExcludesRestriction = ResponseCodeType.new("ErrorInvalidExcludesRestriction")
  ErrorInvalidExpressionTypeForSubFilter = ResponseCodeType.new("ErrorInvalidExpressionTypeForSubFilter")
  ErrorInvalidExtendedProperty = ResponseCodeType.new("ErrorInvalidExtendedProperty")
  ErrorInvalidExtendedPropertyValue = ResponseCodeType.new("ErrorInvalidExtendedPropertyValue")
  ErrorInvalidFolderId = ResponseCodeType.new("ErrorInvalidFolderId")
  ErrorInvalidFolderTypeForOperation = ResponseCodeType.new("ErrorInvalidFolderTypeForOperation")
  ErrorInvalidFractionalPagingParameters = ResponseCodeType.new("ErrorInvalidFractionalPagingParameters")
  ErrorInvalidFreeBusyViewType = ResponseCodeType.new("ErrorInvalidFreeBusyViewType")
  ErrorInvalidId = ResponseCodeType.new("ErrorInvalidId")
  ErrorInvalidIdEmpty = ResponseCodeType.new("ErrorInvalidIdEmpty")
  ErrorInvalidIdMalformed = ResponseCodeType.new("ErrorInvalidIdMalformed")
  ErrorInvalidIdMalformedEwsLegacyIdFormat = ResponseCodeType.new("ErrorInvalidIdMalformedEwsLegacyIdFormat")
  ErrorInvalidIdMonikerTooLong = ResponseCodeType.new("ErrorInvalidIdMonikerTooLong")
  ErrorInvalidIdNotAnItemAttachmentId = ResponseCodeType.new("ErrorInvalidIdNotAnItemAttachmentId")
  ErrorInvalidIdReturnedByResolveNames = ResponseCodeType.new("ErrorInvalidIdReturnedByResolveNames")
  ErrorInvalidIdStoreObjectIdTooLong = ResponseCodeType.new("ErrorInvalidIdStoreObjectIdTooLong")
  ErrorInvalidIdTooManyAttachmentLevels = ResponseCodeType.new("ErrorInvalidIdTooManyAttachmentLevels")
  ErrorInvalidIdXml = ResponseCodeType.new("ErrorInvalidIdXml")
  ErrorInvalidIndexedPagingParameters = ResponseCodeType.new("ErrorInvalidIndexedPagingParameters")
  ErrorInvalidInternetHeaderChildNodes = ResponseCodeType.new("ErrorInvalidInternetHeaderChildNodes")
  ErrorInvalidItemForOperationAcceptItem = ResponseCodeType.new("ErrorInvalidItemForOperationAcceptItem")
  ErrorInvalidItemForOperationCancelItem = ResponseCodeType.new("ErrorInvalidItemForOperationCancelItem")
  ErrorInvalidItemForOperationCreateItem = ResponseCodeType.new("ErrorInvalidItemForOperationCreateItem")
  ErrorInvalidItemForOperationCreateItemAttachment = ResponseCodeType.new("ErrorInvalidItemForOperationCreateItemAttachment")
  ErrorInvalidItemForOperationDeclineItem = ResponseCodeType.new("ErrorInvalidItemForOperationDeclineItem")
  ErrorInvalidItemForOperationExpandDL = ResponseCodeType.new("ErrorInvalidItemForOperationExpandDL")
  ErrorInvalidItemForOperationRemoveItem = ResponseCodeType.new("ErrorInvalidItemForOperationRemoveItem")
  ErrorInvalidItemForOperationSendItem = ResponseCodeType.new("ErrorInvalidItemForOperationSendItem")
  ErrorInvalidItemForOperationTentative = ResponseCodeType.new("ErrorInvalidItemForOperationTentative")
  ErrorInvalidManagedFolderProperty = ResponseCodeType.new("ErrorInvalidManagedFolderProperty")
  ErrorInvalidManagedFolderQuota = ResponseCodeType.new("ErrorInvalidManagedFolderQuota")
  ErrorInvalidManagedFolderSize = ResponseCodeType.new("ErrorInvalidManagedFolderSize")
  ErrorInvalidMergedFreeBusyInterval = ResponseCodeType.new("ErrorInvalidMergedFreeBusyInterval")
  ErrorInvalidNameForNameResolution = ResponseCodeType.new("ErrorInvalidNameForNameResolution")
  ErrorInvalidNetworkServiceContext = ResponseCodeType.new("ErrorInvalidNetworkServiceContext")
  ErrorInvalidOofParameter = ResponseCodeType.new("ErrorInvalidOofParameter")
  ErrorInvalidOperation = ResponseCodeType.new("ErrorInvalidOperation")
  ErrorInvalidPagingMaxRows = ResponseCodeType.new("ErrorInvalidPagingMaxRows")
  ErrorInvalidParentFolder = ResponseCodeType.new("ErrorInvalidParentFolder")
  ErrorInvalidPercentCompleteValue = ResponseCodeType.new("ErrorInvalidPercentCompleteValue")
  ErrorInvalidPermissionSettings = ResponseCodeType.new("ErrorInvalidPermissionSettings")
  ErrorInvalidPropertyAppend = ResponseCodeType.new("ErrorInvalidPropertyAppend")
  ErrorInvalidPropertyDelete = ResponseCodeType.new("ErrorInvalidPropertyDelete")
  ErrorInvalidPropertyForExists = ResponseCodeType.new("ErrorInvalidPropertyForExists")
  ErrorInvalidPropertyForOperation = ResponseCodeType.new("ErrorInvalidPropertyForOperation")
  ErrorInvalidPropertyRequest = ResponseCodeType.new("ErrorInvalidPropertyRequest")
  ErrorInvalidPropertySet = ResponseCodeType.new("ErrorInvalidPropertySet")
  ErrorInvalidPropertyUpdateSentMessage = ResponseCodeType.new("ErrorInvalidPropertyUpdateSentMessage")
  ErrorInvalidProxySecurityContext = ResponseCodeType.new("ErrorInvalidProxySecurityContext")
  ErrorInvalidPullSubscriptionId = ResponseCodeType.new("ErrorInvalidPullSubscriptionId")
  ErrorInvalidPushSubscriptionUrl = ResponseCodeType.new("ErrorInvalidPushSubscriptionUrl")
  ErrorInvalidRecipientSubfilter = ResponseCodeType.new("ErrorInvalidRecipientSubfilter")
  ErrorInvalidRecipientSubfilterComparison = ResponseCodeType.new("ErrorInvalidRecipientSubfilterComparison")
  ErrorInvalidRecipientSubfilterOrder = ResponseCodeType.new("ErrorInvalidRecipientSubfilterOrder")
  ErrorInvalidRecipientSubfilterTextFilter = ResponseCodeType.new("ErrorInvalidRecipientSubfilterTextFilter")
  ErrorInvalidRecipients = ResponseCodeType.new("ErrorInvalidRecipients")
  ErrorInvalidReferenceItem = ResponseCodeType.new("ErrorInvalidReferenceItem")
  ErrorInvalidRequest = ResponseCodeType.new("ErrorInvalidRequest")
  ErrorInvalidRestriction = ResponseCodeType.new("ErrorInvalidRestriction")
  ErrorInvalidRoutingType = ResponseCodeType.new("ErrorInvalidRoutingType")
  ErrorInvalidScheduledOofDuration = ResponseCodeType.new("ErrorInvalidScheduledOofDuration")
  ErrorInvalidSecurityDescriptor = ResponseCodeType.new("ErrorInvalidSecurityDescriptor")
  ErrorInvalidSendItemSaveSettings = ResponseCodeType.new("ErrorInvalidSendItemSaveSettings")
  ErrorInvalidSerializedAccessToken = ResponseCodeType.new("ErrorInvalidSerializedAccessToken")
  ErrorInvalidServerVersion = ResponseCodeType.new("ErrorInvalidServerVersion")
  ErrorInvalidSid = ResponseCodeType.new("ErrorInvalidSid")
  ErrorInvalidSmtpAddress = ResponseCodeType.new("ErrorInvalidSmtpAddress")
  ErrorInvalidSubfilterType = ResponseCodeType.new("ErrorInvalidSubfilterType")
  ErrorInvalidSubfilterTypeNotAttendeeType = ResponseCodeType.new("ErrorInvalidSubfilterTypeNotAttendeeType")
  ErrorInvalidSubfilterTypeNotRecipientType = ResponseCodeType.new("ErrorInvalidSubfilterTypeNotRecipientType")
  ErrorInvalidSubscription = ResponseCodeType.new("ErrorInvalidSubscription")
  ErrorInvalidSubscriptionRequest = ResponseCodeType.new("ErrorInvalidSubscriptionRequest")
  ErrorInvalidSyncStateData = ResponseCodeType.new("ErrorInvalidSyncStateData")
  ErrorInvalidTimeInterval = ResponseCodeType.new("ErrorInvalidTimeInterval")
  ErrorInvalidUserInfo = ResponseCodeType.new("ErrorInvalidUserInfo")
  ErrorInvalidUserOofSettings = ResponseCodeType.new("ErrorInvalidUserOofSettings")
  ErrorInvalidUserPrincipalName = ResponseCodeType.new("ErrorInvalidUserPrincipalName")
  ErrorInvalidUserSid = ResponseCodeType.new("ErrorInvalidUserSid")
  ErrorInvalidUserSidMissingUPN = ResponseCodeType.new("ErrorInvalidUserSidMissingUPN")
  ErrorInvalidValueForProperty = ResponseCodeType.new("ErrorInvalidValueForProperty")
  ErrorInvalidWatermark = ResponseCodeType.new("ErrorInvalidWatermark")
  ErrorIrresolvableConflict = ResponseCodeType.new("ErrorIrresolvableConflict")
  ErrorItemCorrupt = ResponseCodeType.new("ErrorItemCorrupt")
  ErrorItemNotFound = ResponseCodeType.new("ErrorItemNotFound")
  ErrorItemPropertyRequestFailed = ResponseCodeType.new("ErrorItemPropertyRequestFailed")
  ErrorItemSave = ResponseCodeType.new("ErrorItemSave")
  ErrorItemSavePropertyError = ResponseCodeType.new("ErrorItemSavePropertyError")
  ErrorLegacyMailboxFreeBusyViewTypeNotMerged = ResponseCodeType.new("ErrorLegacyMailboxFreeBusyViewTypeNotMerged")
  ErrorLocalServerObjectNotFound = ResponseCodeType.new("ErrorLocalServerObjectNotFound")
  ErrorLogonAsNetworkServiceFailed = ResponseCodeType.new("ErrorLogonAsNetworkServiceFailed")
  ErrorMailRecipientNotFound = ResponseCodeType.new("ErrorMailRecipientNotFound")
  ErrorMailboxConfiguration = ResponseCodeType.new("ErrorMailboxConfiguration")
  ErrorMailboxDataArrayEmpty = ResponseCodeType.new("ErrorMailboxDataArrayEmpty")
  ErrorMailboxDataArrayTooBig = ResponseCodeType.new("ErrorMailboxDataArrayTooBig")
  ErrorMailboxLogonFailed = ResponseCodeType.new("ErrorMailboxLogonFailed")
  ErrorMailboxMoveInProgress = ResponseCodeType.new("ErrorMailboxMoveInProgress")
  ErrorMailboxStoreUnavailable = ResponseCodeType.new("ErrorMailboxStoreUnavailable")
  ErrorManagedFolderAlreadyExists = ResponseCodeType.new("ErrorManagedFolderAlreadyExists")
  ErrorManagedFolderNotFound = ResponseCodeType.new("ErrorManagedFolderNotFound")
  ErrorManagedFoldersRootFailure = ResponseCodeType.new("ErrorManagedFoldersRootFailure")
  ErrorMeetingSuggestionGenerationFailed = ResponseCodeType.new("ErrorMeetingSuggestionGenerationFailed")
  ErrorMessageDispositionRequired = ResponseCodeType.new("ErrorMessageDispositionRequired")
  ErrorMessageSizeExceeded = ResponseCodeType.new("ErrorMessageSizeExceeded")
  ErrorMimeContentConversionFailed = ResponseCodeType.new("ErrorMimeContentConversionFailed")
  ErrorMimeContentInvalid = ResponseCodeType.new("ErrorMimeContentInvalid")
  ErrorMimeContentInvalidBase64String = ResponseCodeType.new("ErrorMimeContentInvalidBase64String")
  ErrorMissingArgument = ResponseCodeType.new("ErrorMissingArgument")
  ErrorMissingEmailAddress = ResponseCodeType.new("ErrorMissingEmailAddress")
  ErrorMissingEmailAddressForManagedFolder = ResponseCodeType.new("ErrorMissingEmailAddressForManagedFolder")
  ErrorMissingInformationEmailAddress = ResponseCodeType.new("ErrorMissingInformationEmailAddress")
  ErrorMissingInformationReferenceItemId = ResponseCodeType.new("ErrorMissingInformationReferenceItemId")
  ErrorMissingItemForCreateItemAttachment = ResponseCodeType.new("ErrorMissingItemForCreateItemAttachment")
  ErrorMissingManagedFolderId = ResponseCodeType.new("ErrorMissingManagedFolderId")
  ErrorMissingRecipients = ResponseCodeType.new("ErrorMissingRecipients")
  ErrorMissingUserIdInformation = ResponseCodeType.new("ErrorMissingUserIdInformation")
  ErrorMoreThanOneAccessModeSpecified = ResponseCodeType.new("ErrorMoreThanOneAccessModeSpecified")
  ErrorMoveCopyFailed = ResponseCodeType.new("ErrorMoveCopyFailed")
  ErrorMoveDistinguishedFolder = ResponseCodeType.new("ErrorMoveDistinguishedFolder")
  ErrorNameResolutionMultipleResults = ResponseCodeType.new("ErrorNameResolutionMultipleResults")
  ErrorNameResolutionNoMailbox = ResponseCodeType.new("ErrorNameResolutionNoMailbox")
  ErrorNameResolutionNoResults = ResponseCodeType.new("ErrorNameResolutionNoResults")
  ErrorNoCalendar = ResponseCodeType.new("ErrorNoCalendar")
  ErrorNoDestinationCASDueToKerberosRequirements = ResponseCodeType.new("ErrorNoDestinationCASDueToKerberosRequirements")
  ErrorNoDestinationCASDueToSSLRequirements = ResponseCodeType.new("ErrorNoDestinationCASDueToSSLRequirements")
  ErrorNoDestinationCASDueToVersionMismatch = ResponseCodeType.new("ErrorNoDestinationCASDueToVersionMismatch")
  ErrorNoFolderClassOverride = ResponseCodeType.new("ErrorNoFolderClassOverride")
  ErrorNoFreeBusyAccess = ResponseCodeType.new("ErrorNoFreeBusyAccess")
  ErrorNoPropertyTagForCustomProperties = ResponseCodeType.new("ErrorNoPropertyTagForCustomProperties")
  ErrorNoPublicFolderReplicaAvailable = ResponseCodeType.new("ErrorNoPublicFolderReplicaAvailable")
  ErrorNoRespondingCASInDestinationSite = ResponseCodeType.new("ErrorNoRespondingCASInDestinationSite")
  ErrorNonExistentMailbox = ResponseCodeType.new("ErrorNonExistentMailbox")
  ErrorNonPrimarySmtpAddress = ResponseCodeType.new("ErrorNonPrimarySmtpAddress")
  ErrorNotDelegate = ResponseCodeType.new("ErrorNotDelegate")
  ErrorNotEnoughMemory = ResponseCodeType.new("ErrorNotEnoughMemory")
  ErrorObjectTypeChanged = ResponseCodeType.new("ErrorObjectTypeChanged")
  ErrorOccurrenceCrossingBoundary = ResponseCodeType.new("ErrorOccurrenceCrossingBoundary")
  ErrorOccurrenceTimeSpanTooBig = ResponseCodeType.new("ErrorOccurrenceTimeSpanTooBig")
  ErrorOperationNotAllowedWithPublicFolderRoot = ResponseCodeType.new("ErrorOperationNotAllowedWithPublicFolderRoot")
  ErrorParentFolderIdRequired = ResponseCodeType.new("ErrorParentFolderIdRequired")
  ErrorParentFolderNotFound = ResponseCodeType.new("ErrorParentFolderNotFound")
  ErrorPasswordChangeRequired = ResponseCodeType.new("ErrorPasswordChangeRequired")
  ErrorPasswordExpired = ResponseCodeType.new("ErrorPasswordExpired")
  ErrorPropertyUpdate = ResponseCodeType.new("ErrorPropertyUpdate")
  ErrorPropertyValidationFailure = ResponseCodeType.new("ErrorPropertyValidationFailure")
  ErrorProxiedSubscriptionCallFailure = ResponseCodeType.new("ErrorProxiedSubscriptionCallFailure")
  ErrorProxyCallFailed = ResponseCodeType.new("ErrorProxyCallFailed")
  ErrorProxyGroupSidLimitExceeded = ResponseCodeType.new("ErrorProxyGroupSidLimitExceeded")
  ErrorProxyRequestNotAllowed = ResponseCodeType.new("ErrorProxyRequestNotAllowed")
  ErrorProxyRequestProcessingFailed = ResponseCodeType.new("ErrorProxyRequestProcessingFailed")
  ErrorProxyTokenExpired = ResponseCodeType.new("ErrorProxyTokenExpired")
  ErrorPublicFolderRequestProcessingFailed = ResponseCodeType.new("ErrorPublicFolderRequestProcessingFailed")
  ErrorPublicFolderServerNotFound = ResponseCodeType.new("ErrorPublicFolderServerNotFound")
  ErrorQueryFilterTooLong = ResponseCodeType.new("ErrorQueryFilterTooLong")
  ErrorQuotaExceeded = ResponseCodeType.new("ErrorQuotaExceeded")
  ErrorReadEventsFailed = ResponseCodeType.new("ErrorReadEventsFailed")
  ErrorReadReceiptNotPending = ResponseCodeType.new("ErrorReadReceiptNotPending")
  ErrorRecurrenceEndDateTooBig = ResponseCodeType.new("ErrorRecurrenceEndDateTooBig")
  ErrorRecurrenceHasNoOccurrence = ResponseCodeType.new("ErrorRecurrenceHasNoOccurrence")
  ErrorRemoveDelegatesFailed = ResponseCodeType.new("ErrorRemoveDelegatesFailed")
  ErrorRequestAborted = ResponseCodeType.new("ErrorRequestAborted")
  ErrorRequestStreamTooBig = ResponseCodeType.new("ErrorRequestStreamTooBig")
  ErrorRequiredPropertyMissing = ResponseCodeType.new("ErrorRequiredPropertyMissing")
  ErrorResolveNamesInvalidFolderType = ResponseCodeType.new("ErrorResolveNamesInvalidFolderType")
  ErrorResolveNamesOnlyOneContactsFolderAllowed = ResponseCodeType.new("ErrorResolveNamesOnlyOneContactsFolderAllowed")
  ErrorResponseSchemaValidation = ResponseCodeType.new("ErrorResponseSchemaValidation")
  ErrorRestrictionTooComplex = ResponseCodeType.new("ErrorRestrictionTooComplex")
  ErrorRestrictionTooLong = ResponseCodeType.new("ErrorRestrictionTooLong")
  ErrorResultSetTooBig = ResponseCodeType.new("ErrorResultSetTooBig")
  ErrorSavedItemFolderNotFound = ResponseCodeType.new("ErrorSavedItemFolderNotFound")
  ErrorSchemaValidation = ResponseCodeType.new("ErrorSchemaValidation")
  ErrorSearchFolderNotInitialized = ResponseCodeType.new("ErrorSearchFolderNotInitialized")
  ErrorSendAsDenied = ResponseCodeType.new("ErrorSendAsDenied")
  ErrorSendMeetingCancellationsRequired = ResponseCodeType.new("ErrorSendMeetingCancellationsRequired")
  ErrorSendMeetingInvitationsOrCancellationsRequired = ResponseCodeType.new("ErrorSendMeetingInvitationsOrCancellationsRequired")
  ErrorSendMeetingInvitationsRequired = ResponseCodeType.new("ErrorSendMeetingInvitationsRequired")
  ErrorSentMeetingRequestUpdate = ResponseCodeType.new("ErrorSentMeetingRequestUpdate")
  ErrorSentTaskRequestUpdate = ResponseCodeType.new("ErrorSentTaskRequestUpdate")
  ErrorServerBusy = ResponseCodeType.new("ErrorServerBusy")
  ErrorServiceDiscoveryFailed = ResponseCodeType.new("ErrorServiceDiscoveryFailed")
  ErrorStaleObject = ResponseCodeType.new("ErrorStaleObject")
  ErrorSubscriptionAccessDenied = ResponseCodeType.new("ErrorSubscriptionAccessDenied")
  ErrorSubscriptionDelegateAccessNotSupported = ResponseCodeType.new("ErrorSubscriptionDelegateAccessNotSupported")
  ErrorSubscriptionNotFound = ResponseCodeType.new("ErrorSubscriptionNotFound")
  ErrorSyncFolderNotFound = ResponseCodeType.new("ErrorSyncFolderNotFound")
  ErrorTimeIntervalTooBig = ResponseCodeType.new("ErrorTimeIntervalTooBig")
  ErrorTimeoutExpired = ResponseCodeType.new("ErrorTimeoutExpired")
  ErrorToFolderNotFound = ResponseCodeType.new("ErrorToFolderNotFound")
  ErrorTokenSerializationDenied = ResponseCodeType.new("ErrorTokenSerializationDenied")
  ErrorUnableToGetUserOofSettings = ResponseCodeType.new("ErrorUnableToGetUserOofSettings")
  ErrorUnsupportedCulture = ResponseCodeType.new("ErrorUnsupportedCulture")
  ErrorUnsupportedMapiPropertyType = ResponseCodeType.new("ErrorUnsupportedMapiPropertyType")
  ErrorUnsupportedMimeConversion = ResponseCodeType.new("ErrorUnsupportedMimeConversion")
  ErrorUnsupportedPathForQuery = ResponseCodeType.new("ErrorUnsupportedPathForQuery")
  ErrorUnsupportedPathForSortGroup = ResponseCodeType.new("ErrorUnsupportedPathForSortGroup")
  ErrorUnsupportedPropertyDefinition = ResponseCodeType.new("ErrorUnsupportedPropertyDefinition")
  ErrorUnsupportedQueryFilter = ResponseCodeType.new("ErrorUnsupportedQueryFilter")
  ErrorUnsupportedRecurrence = ResponseCodeType.new("ErrorUnsupportedRecurrence")
  ErrorUnsupportedSubFilter = ResponseCodeType.new("ErrorUnsupportedSubFilter")
  ErrorUnsupportedTypeForConversion = ResponseCodeType.new("ErrorUnsupportedTypeForConversion")
  ErrorUpdateDelegatesFailed = ResponseCodeType.new("ErrorUpdateDelegatesFailed")
  ErrorUpdatePropertyMismatch = ResponseCodeType.new("ErrorUpdatePropertyMismatch")
  ErrorVirusDetected = ResponseCodeType.new("ErrorVirusDetected")
  ErrorVirusMessageDeleted = ResponseCodeType.new("ErrorVirusMessageDeleted")
  ErrorVoiceMailNotImplemented = ResponseCodeType.new("ErrorVoiceMailNotImplemented")
  ErrorWebRequestInInvalidState = ResponseCodeType.new("ErrorWebRequestInInvalidState")
  ErrorWin32InteropError = ResponseCodeType.new("ErrorWin32InteropError")
  ErrorWorkingHoursSaveFailed = ResponseCodeType.new("ErrorWorkingHoursSaveFailed")
  ErrorWorkingHoursXmlMalformed = ResponseCodeType.new("ErrorWorkingHoursXmlMalformed")
  NoError = ResponseCodeType.new("NoError")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ExchangeVersionType
class ExchangeVersionType < ::String
  Exchange2007 = ExchangeVersionType.new("Exchange2007")
  Exchange2007_SP1 = ExchangeVersionType.new("Exchange2007_SP1")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}MailboxTypeType
class MailboxTypeType < ::String
  Contact = MailboxTypeType.new("Contact")
  Mailbox = MailboxTypeType.new("Mailbox")
  PrivateDL = MailboxTypeType.new("PrivateDL")
  PublicDL = MailboxTypeType.new("PublicDL")
  PublicFolder = MailboxTypeType.new("PublicFolder")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}UnindexedFieldURIType
class UnindexedFieldURIType < ::String
  CalendarAdjacentMeetingCount = UnindexedFieldURIType.new("calendar:AdjacentMeetingCount")
  CalendarAdjacentMeetings = UnindexedFieldURIType.new("calendar:AdjacentMeetings")
  CalendarAllowNewTimeProposal = UnindexedFieldURIType.new("calendar:AllowNewTimeProposal")
  CalendarAppointmentReplyTime = UnindexedFieldURIType.new("calendar:AppointmentReplyTime")
  CalendarAppointmentSequenceNumber = UnindexedFieldURIType.new("calendar:AppointmentSequenceNumber")
  CalendarAppointmentState = UnindexedFieldURIType.new("calendar:AppointmentState")
  CalendarCalendarItemType = UnindexedFieldURIType.new("calendar:CalendarItemType")
  CalendarConferenceType = UnindexedFieldURIType.new("calendar:ConferenceType")
  CalendarConflictingMeetingCount = UnindexedFieldURIType.new("calendar:ConflictingMeetingCount")
  CalendarConflictingMeetings = UnindexedFieldURIType.new("calendar:ConflictingMeetings")
  CalendarDateTimeStamp = UnindexedFieldURIType.new("calendar:DateTimeStamp")
  CalendarDeletedOccurrences = UnindexedFieldURIType.new("calendar:DeletedOccurrences")
  CalendarDuration = UnindexedFieldURIType.new("calendar:Duration")
  CalendarEnd = UnindexedFieldURIType.new("calendar:End")
  CalendarFirstOccurrence = UnindexedFieldURIType.new("calendar:FirstOccurrence")
  CalendarIsAllDayEvent = UnindexedFieldURIType.new("calendar:IsAllDayEvent")
  CalendarIsCancelled = UnindexedFieldURIType.new("calendar:IsCancelled")
  CalendarIsMeeting = UnindexedFieldURIType.new("calendar:IsMeeting")
  CalendarIsOnlineMeeting = UnindexedFieldURIType.new("calendar:IsOnlineMeeting")
  CalendarIsRecurring = UnindexedFieldURIType.new("calendar:IsRecurring")
  CalendarIsResponseRequested = UnindexedFieldURIType.new("calendar:IsResponseRequested")
  CalendarLastOccurrence = UnindexedFieldURIType.new("calendar:LastOccurrence")
  CalendarLegacyFreeBusyStatus = UnindexedFieldURIType.new("calendar:LegacyFreeBusyStatus")
  CalendarLocation = UnindexedFieldURIType.new("calendar:Location")
  CalendarMeetingRequestWasSent = UnindexedFieldURIType.new("calendar:MeetingRequestWasSent")
  CalendarMeetingTimeZone = UnindexedFieldURIType.new("calendar:MeetingTimeZone")
  CalendarMeetingWorkspaceUrl = UnindexedFieldURIType.new("calendar:MeetingWorkspaceUrl")
  CalendarModifiedOccurrences = UnindexedFieldURIType.new("calendar:ModifiedOccurrences")
  CalendarMyResponseType = UnindexedFieldURIType.new("calendar:MyResponseType")
  CalendarNetShowUrl = UnindexedFieldURIType.new("calendar:NetShowUrl")
  CalendarOptionalAttendees = UnindexedFieldURIType.new("calendar:OptionalAttendees")
  CalendarOrganizer = UnindexedFieldURIType.new("calendar:Organizer")
  CalendarOriginalStart = UnindexedFieldURIType.new("calendar:OriginalStart")
  CalendarRecurrence = UnindexedFieldURIType.new("calendar:Recurrence")
  CalendarRecurrenceId = UnindexedFieldURIType.new("calendar:RecurrenceId")
  CalendarRequiredAttendees = UnindexedFieldURIType.new("calendar:RequiredAttendees")
  CalendarResources = UnindexedFieldURIType.new("calendar:Resources")
  CalendarStart = UnindexedFieldURIType.new("calendar:Start")
  CalendarTimeZone = UnindexedFieldURIType.new("calendar:TimeZone")
  CalendarUID = UnindexedFieldURIType.new("calendar:UID")
  CalendarWhen = UnindexedFieldURIType.new("calendar:When")
  ContactsAssistantName = UnindexedFieldURIType.new("contacts:AssistantName")
  ContactsBirthday = UnindexedFieldURIType.new("contacts:Birthday")
  ContactsBusinessHomePage = UnindexedFieldURIType.new("contacts:BusinessHomePage")
  ContactsChildren = UnindexedFieldURIType.new("contacts:Children")
  ContactsCompanies = UnindexedFieldURIType.new("contacts:Companies")
  ContactsCompanyName = UnindexedFieldURIType.new("contacts:CompanyName")
  ContactsCompleteName = UnindexedFieldURIType.new("contacts:CompleteName")
  ContactsContactSource = UnindexedFieldURIType.new("contacts:ContactSource")
  ContactsCulture = UnindexedFieldURIType.new("contacts:Culture")
  ContactsDepartment = UnindexedFieldURIType.new("contacts:Department")
  ContactsDisplayName = UnindexedFieldURIType.new("contacts:DisplayName")
  ContactsEmailAddresses = UnindexedFieldURIType.new("contacts:EmailAddresses")
  ContactsFileAs = UnindexedFieldURIType.new("contacts:FileAs")
  ContactsFileAsMapping = UnindexedFieldURIType.new("contacts:FileAsMapping")
  ContactsGeneration = UnindexedFieldURIType.new("contacts:Generation")
  ContactsGivenName = UnindexedFieldURIType.new("contacts:GivenName")
  ContactsImAddresses = UnindexedFieldURIType.new("contacts:ImAddresses")
  ContactsInitials = UnindexedFieldURIType.new("contacts:Initials")
  ContactsJobTitle = UnindexedFieldURIType.new("contacts:JobTitle")
  ContactsManager = UnindexedFieldURIType.new("contacts:Manager")
  ContactsMiddleName = UnindexedFieldURIType.new("contacts:MiddleName")
  ContactsMileage = UnindexedFieldURIType.new("contacts:Mileage")
  ContactsNickname = UnindexedFieldURIType.new("contacts:Nickname")
  ContactsOfficeLocation = UnindexedFieldURIType.new("contacts:OfficeLocation")
  ContactsPhoneNumbers = UnindexedFieldURIType.new("contacts:PhoneNumbers")
  ContactsPhysicalAddresses = UnindexedFieldURIType.new("contacts:PhysicalAddresses")
  ContactsPostalAddressIndex = UnindexedFieldURIType.new("contacts:PostalAddressIndex")
  ContactsProfession = UnindexedFieldURIType.new("contacts:Profession")
  ContactsSpouseName = UnindexedFieldURIType.new("contacts:SpouseName")
  ContactsSurname = UnindexedFieldURIType.new("contacts:Surname")
  ContactsWeddingAnniversary = UnindexedFieldURIType.new("contacts:WeddingAnniversary")
  FolderChildFolderCount = UnindexedFieldURIType.new("folder:ChildFolderCount")
  FolderDisplayName = UnindexedFieldURIType.new("folder:DisplayName")
  FolderEffectiveRights = UnindexedFieldURIType.new("folder:EffectiveRights")
  FolderFolderClass = UnindexedFieldURIType.new("folder:FolderClass")
  FolderFolderId = UnindexedFieldURIType.new("folder:FolderId")
  FolderManagedFolderInformation = UnindexedFieldURIType.new("folder:ManagedFolderInformation")
  FolderParentFolderId = UnindexedFieldURIType.new("folder:ParentFolderId")
  FolderPermissionSet = UnindexedFieldURIType.new("folder:PermissionSet")
  FolderSearchParameters = UnindexedFieldURIType.new("folder:SearchParameters")
  FolderTotalCount = UnindexedFieldURIType.new("folder:TotalCount")
  FolderUnreadCount = UnindexedFieldURIType.new("folder:UnreadCount")
  ItemAttachments = UnindexedFieldURIType.new("item:Attachments")
  ItemBody = UnindexedFieldURIType.new("item:Body")
  ItemCategories = UnindexedFieldURIType.new("item:Categories")
  ItemCulture = UnindexedFieldURIType.new("item:Culture")
  ItemDateTimeCreated = UnindexedFieldURIType.new("item:DateTimeCreated")
  ItemDateTimeReceived = UnindexedFieldURIType.new("item:DateTimeReceived")
  ItemDateTimeSent = UnindexedFieldURIType.new("item:DateTimeSent")
  ItemDisplayCc = UnindexedFieldURIType.new("item:DisplayCc")
  ItemDisplayTo = UnindexedFieldURIType.new("item:DisplayTo")
  ItemEffectiveRights = UnindexedFieldURIType.new("item:EffectiveRights")
  ItemHasAttachments = UnindexedFieldURIType.new("item:HasAttachments")
  ItemImportance = UnindexedFieldURIType.new("item:Importance")
  ItemInReplyTo = UnindexedFieldURIType.new("item:InReplyTo")
  ItemInternetMessageHeaders = UnindexedFieldURIType.new("item:InternetMessageHeaders")
  ItemIsDraft = UnindexedFieldURIType.new("item:IsDraft")
  ItemIsFromMe = UnindexedFieldURIType.new("item:IsFromMe")
  ItemIsResend = UnindexedFieldURIType.new("item:IsResend")
  ItemIsSubmitted = UnindexedFieldURIType.new("item:IsSubmitted")
  ItemIsUnmodified = UnindexedFieldURIType.new("item:IsUnmodified")
  ItemItemClass = UnindexedFieldURIType.new("item:ItemClass")
  ItemItemId = UnindexedFieldURIType.new("item:ItemId")
  ItemLastModifiedName = UnindexedFieldURIType.new("item:LastModifiedName")
  ItemLastModifiedTime = UnindexedFieldURIType.new("item:LastModifiedTime")
  ItemMimeContent = UnindexedFieldURIType.new("item:MimeContent")
  ItemParentFolderId = UnindexedFieldURIType.new("item:ParentFolderId")
  ItemReminderDueBy = UnindexedFieldURIType.new("item:ReminderDueBy")
  ItemReminderIsSet = UnindexedFieldURIType.new("item:ReminderIsSet")
  ItemReminderMinutesBeforeStart = UnindexedFieldURIType.new("item:ReminderMinutesBeforeStart")
  ItemResponseObjects = UnindexedFieldURIType.new("item:ResponseObjects")
  ItemSensitivity = UnindexedFieldURIType.new("item:Sensitivity")
  ItemSize = UnindexedFieldURIType.new("item:Size")
  ItemSubject = UnindexedFieldURIType.new("item:Subject")
  MeetingAssociatedCalendarItemId = UnindexedFieldURIType.new("meeting:AssociatedCalendarItemId")
  MeetingHasBeenProcessed = UnindexedFieldURIType.new("meeting:HasBeenProcessed")
  MeetingIsDelegated = UnindexedFieldURIType.new("meeting:IsDelegated")
  MeetingIsOutOfDate = UnindexedFieldURIType.new("meeting:IsOutOfDate")
  MeetingRequestIntendedFreeBusyStatus = UnindexedFieldURIType.new("meetingRequest:IntendedFreeBusyStatus")
  MeetingRequestMeetingRequestType = UnindexedFieldURIType.new("meetingRequest:MeetingRequestType")
  MeetingResponseType = UnindexedFieldURIType.new("meeting:ResponseType")
  MessageBccRecipients = UnindexedFieldURIType.new("message:BccRecipients")
  MessageCcRecipients = UnindexedFieldURIType.new("message:CcRecipients")
  MessageConversationIndex = UnindexedFieldURIType.new("message:ConversationIndex")
  MessageConversationTopic = UnindexedFieldURIType.new("message:ConversationTopic")
  MessageFrom = UnindexedFieldURIType.new("message:From")
  MessageInternetMessageId = UnindexedFieldURIType.new("message:InternetMessageId")
  MessageIsDeliveryReceiptRequested = UnindexedFieldURIType.new("message:IsDeliveryReceiptRequested")
  MessageIsRead = UnindexedFieldURIType.new("message:IsRead")
  MessageIsReadReceiptRequested = UnindexedFieldURIType.new("message:IsReadReceiptRequested")
  MessageIsResponseRequested = UnindexedFieldURIType.new("message:IsResponseRequested")
  MessageReceivedBy = UnindexedFieldURIType.new("message:ReceivedBy")
  MessageReceivedRepresenting = UnindexedFieldURIType.new("message:ReceivedRepresenting")
  MessageReferences = UnindexedFieldURIType.new("message:References")
  MessageReplyTo = UnindexedFieldURIType.new("message:ReplyTo")
  MessageSender = UnindexedFieldURIType.new("message:Sender")
  MessageToRecipients = UnindexedFieldURIType.new("message:ToRecipients")
  PostitemPostedTime = UnindexedFieldURIType.new("postitem:PostedTime")
  TaskActualWork = UnindexedFieldURIType.new("task:ActualWork")
  TaskAssignedTime = UnindexedFieldURIType.new("task:AssignedTime")
  TaskBillingInformation = UnindexedFieldURIType.new("task:BillingInformation")
  TaskChangeCount = UnindexedFieldURIType.new("task:ChangeCount")
  TaskCompanies = UnindexedFieldURIType.new("task:Companies")
  TaskCompleteDate = UnindexedFieldURIType.new("task:CompleteDate")
  TaskContacts = UnindexedFieldURIType.new("task:Contacts")
  TaskDelegationState = UnindexedFieldURIType.new("task:DelegationState")
  TaskDelegator = UnindexedFieldURIType.new("task:Delegator")
  TaskDueDate = UnindexedFieldURIType.new("task:DueDate")
  TaskIsAssignmentEditable = UnindexedFieldURIType.new("task:IsAssignmentEditable")
  TaskIsComplete = UnindexedFieldURIType.new("task:IsComplete")
  TaskIsRecurring = UnindexedFieldURIType.new("task:IsRecurring")
  TaskIsTeamTask = UnindexedFieldURIType.new("task:IsTeamTask")
  TaskMileage = UnindexedFieldURIType.new("task:Mileage")
  TaskOwner = UnindexedFieldURIType.new("task:Owner")
  TaskPercentComplete = UnindexedFieldURIType.new("task:PercentComplete")
  TaskRecurrence = UnindexedFieldURIType.new("task:Recurrence")
  TaskStartDate = UnindexedFieldURIType.new("task:StartDate")
  TaskStatus = UnindexedFieldURIType.new("task:Status")
  TaskStatusDescription = UnindexedFieldURIType.new("task:StatusDescription")
  TaskTotalWork = UnindexedFieldURIType.new("task:TotalWork")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}DictionaryURIType
class DictionaryURIType < ::String
  ContactsEmailAddress = DictionaryURIType.new("contacts:EmailAddress")
  ContactsImAddress = DictionaryURIType.new("contacts:ImAddress")
  ContactsPhoneNumber = DictionaryURIType.new("contacts:PhoneNumber")
  ContactsPhysicalAddressCity = DictionaryURIType.new("contacts:PhysicalAddress:City")
  ContactsPhysicalAddressCountryOrRegion = DictionaryURIType.new("contacts:PhysicalAddress:CountryOrRegion")
  ContactsPhysicalAddressPostalCode = DictionaryURIType.new("contacts:PhysicalAddress:PostalCode")
  ContactsPhysicalAddressState = DictionaryURIType.new("contacts:PhysicalAddress:State")
  ContactsPhysicalAddressStreet = DictionaryURIType.new("contacts:PhysicalAddress:Street")
  ItemInternetMessageHeader = DictionaryURIType.new("item:InternetMessageHeader")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ExceptionPropertyURIType
class ExceptionPropertyURIType < ::String
  AttachmentContent = ExceptionPropertyURIType.new("attachment:Content")
  AttachmentContentType = ExceptionPropertyURIType.new("attachment:ContentType")
  AttachmentName = ExceptionPropertyURIType.new("attachment:Name")
  RecurrenceDayOfMonth = ExceptionPropertyURIType.new("recurrence:DayOfMonth")
  RecurrenceDayOfWeekIndex = ExceptionPropertyURIType.new("recurrence:DayOfWeekIndex")
  RecurrenceDaysOfWeek = ExceptionPropertyURIType.new("recurrence:DaysOfWeek")
  RecurrenceInterval = ExceptionPropertyURIType.new("recurrence:Interval")
  RecurrenceMonth = ExceptionPropertyURIType.new("recurrence:Month")
  RecurrenceNumberOfOccurrences = ExceptionPropertyURIType.new("recurrence:NumberOfOccurrences")
  TimezoneOffset = ExceptionPropertyURIType.new("timezone:Offset")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}DistinguishedPropertySetType
class DistinguishedPropertySetType < ::String
  Address = DistinguishedPropertySetType.new("Address")
  Appointment = DistinguishedPropertySetType.new("Appointment")
  CalendarAssistant = DistinguishedPropertySetType.new("CalendarAssistant")
  Common = DistinguishedPropertySetType.new("Common")
  InternetHeaders = DistinguishedPropertySetType.new("InternetHeaders")
  Meeting = DistinguishedPropertySetType.new("Meeting")
  PublicStrings = DistinguishedPropertySetType.new("PublicStrings")
  Task = DistinguishedPropertySetType.new("Task")
  UnifiedMessaging = DistinguishedPropertySetType.new("UnifiedMessaging")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}MapiPropertyTypeType
class MapiPropertyTypeType < ::String
  ApplicationTime = MapiPropertyTypeType.new("ApplicationTime")
  ApplicationTimeArray = MapiPropertyTypeType.new("ApplicationTimeArray")
  Binary = MapiPropertyTypeType.new("Binary")
  BinaryArray = MapiPropertyTypeType.new("BinaryArray")
  Boolean = MapiPropertyTypeType.new("Boolean")
  CLSID = MapiPropertyTypeType.new("CLSID")
  CLSIDArray = MapiPropertyTypeType.new("CLSIDArray")
  C_Float = MapiPropertyTypeType.new("Float")
  C_Integer = MapiPropertyTypeType.new("Integer")
  C_Object = MapiPropertyTypeType.new("Object")
  C_String = MapiPropertyTypeType.new("String")
  Currency = MapiPropertyTypeType.new("Currency")
  CurrencyArray = MapiPropertyTypeType.new("CurrencyArray")
  Double = MapiPropertyTypeType.new("Double")
  DoubleArray = MapiPropertyTypeType.new("DoubleArray")
  Error = MapiPropertyTypeType.new("Error")
  FloatArray = MapiPropertyTypeType.new("FloatArray")
  IntegerArray = MapiPropertyTypeType.new("IntegerArray")
  Long = MapiPropertyTypeType.new("Long")
  LongArray = MapiPropertyTypeType.new("LongArray")
  Null = MapiPropertyTypeType.new("Null")
  ObjectArray = MapiPropertyTypeType.new("ObjectArray")
  Short = MapiPropertyTypeType.new("Short")
  ShortArray = MapiPropertyTypeType.new("ShortArray")
  StringArray = MapiPropertyTypeType.new("StringArray")
  SystemTime = MapiPropertyTypeType.new("SystemTime")
  SystemTimeArray = MapiPropertyTypeType.new("SystemTimeArray")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}PropertyTagType
#  any of xs:unsignedShort
class PropertyTagType < ::String
end

# {http://schemas.microsoft.com/exchange/services/2006/types}FolderQueryTraversalType
class FolderQueryTraversalType < ::String
  Deep = FolderQueryTraversalType.new("Deep")
  Shallow = FolderQueryTraversalType.new("Shallow")
  SoftDeleted = FolderQueryTraversalType.new("SoftDeleted")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}SearchFolderTraversalType
class SearchFolderTraversalType < ::String
  Deep = SearchFolderTraversalType.new("Deep")
  Shallow = SearchFolderTraversalType.new("Shallow")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ItemQueryTraversalType
class ItemQueryTraversalType < ::String
  Shallow = ItemQueryTraversalType.new("Shallow")
  SoftDeleted = ItemQueryTraversalType.new("SoftDeleted")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}DefaultShapeNamesType
class DefaultShapeNamesType < ::String
  AllProperties = DefaultShapeNamesType.new("AllProperties")
  Default = DefaultShapeNamesType.new("Default")
  IdOnly = DefaultShapeNamesType.new("IdOnly")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}BodyTypeResponseType
class BodyTypeResponseType < ::String
  Best = BodyTypeResponseType.new("Best")
  HTML = BodyTypeResponseType.new("HTML")
  Text = BodyTypeResponseType.new("Text")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}DisposalType
class DisposalType < ::String
  HardDelete = DisposalType.new("HardDelete")
  MoveToDeletedItems = DisposalType.new("MoveToDeletedItems")
  SoftDelete = DisposalType.new("SoftDelete")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ConflictResolutionType
class ConflictResolutionType < ::String
  AlwaysOverwrite = ConflictResolutionType.new("AlwaysOverwrite")
  AutoResolve = ConflictResolutionType.new("AutoResolve")
  NeverOverwrite = ConflictResolutionType.new("NeverOverwrite")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ResponseClassType
class ResponseClassType < ::String
  Error = ResponseClassType.new("Error")
  Success = ResponseClassType.new("Success")
  Warning = ResponseClassType.new("Warning")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}SensitivityChoicesType
class SensitivityChoicesType < ::String
  Confidential = SensitivityChoicesType.new("Confidential")
  Normal = SensitivityChoicesType.new("Normal")
  Personal = SensitivityChoicesType.new("Personal")
  Private = SensitivityChoicesType.new("Private")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ImportanceChoicesType
class ImportanceChoicesType < ::String
  High = ImportanceChoicesType.new("High")
  Low = ImportanceChoicesType.new("Low")
  Normal = ImportanceChoicesType.new("Normal")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}BodyTypeType
class BodyTypeType < ::String
  HTML = BodyTypeType.new("HTML")
  Text = BodyTypeType.new("Text")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}DistinguishedFolderIdNameType
class DistinguishedFolderIdNameType < ::String
  Calendar = DistinguishedFolderIdNameType.new("calendar")
  Contacts = DistinguishedFolderIdNameType.new("contacts")
  Deleteditems = DistinguishedFolderIdNameType.new("deleteditems")
  Drafts = DistinguishedFolderIdNameType.new("drafts")
  Inbox = DistinguishedFolderIdNameType.new("inbox")
  Journal = DistinguishedFolderIdNameType.new("journal")
  Junkemail = DistinguishedFolderIdNameType.new("junkemail")
  Msgfolderroot = DistinguishedFolderIdNameType.new("msgfolderroot")
  Notes = DistinguishedFolderIdNameType.new("notes")
  Outbox = DistinguishedFolderIdNameType.new("outbox")
  Publicfoldersroot = DistinguishedFolderIdNameType.new("publicfoldersroot")
  Root = DistinguishedFolderIdNameType.new("root")
  Searchfolders = DistinguishedFolderIdNameType.new("searchfolders")
  Sentitems = DistinguishedFolderIdNameType.new("sentitems")
  Tasks = DistinguishedFolderIdNameType.new("tasks")
  Voicemail = DistinguishedFolderIdNameType.new("voicemail")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}MessageDispositionType
class MessageDispositionType < ::String
  SaveOnly = MessageDispositionType.new("SaveOnly")
  SendAndSaveCopy = MessageDispositionType.new("SendAndSaveCopy")
  SendOnly = MessageDispositionType.new("SendOnly")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}CalendarItemCreateOrDeleteOperationType
class CalendarItemCreateOrDeleteOperationType < ::String
  SendOnlyToAll = CalendarItemCreateOrDeleteOperationType.new("SendOnlyToAll")
  SendToAllAndSaveCopy = CalendarItemCreateOrDeleteOperationType.new("SendToAllAndSaveCopy")
  SendToNone = CalendarItemCreateOrDeleteOperationType.new("SendToNone")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}CalendarItemUpdateOperationType
class CalendarItemUpdateOperationType < ::String
  SendOnlyToAll = CalendarItemUpdateOperationType.new("SendOnlyToAll")
  SendOnlyToChanged = CalendarItemUpdateOperationType.new("SendOnlyToChanged")
  SendToAllAndSaveCopy = CalendarItemUpdateOperationType.new("SendToAllAndSaveCopy")
  SendToChangedAndSaveCopy = CalendarItemUpdateOperationType.new("SendToChangedAndSaveCopy")
  SendToNone = CalendarItemUpdateOperationType.new("SendToNone")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}AffectedTaskOccurrencesType
class AffectedTaskOccurrencesType < ::String
  AllOccurrences = AffectedTaskOccurrencesType.new("AllOccurrences")
  SpecifiedOccurrenceOnly = AffectedTaskOccurrencesType.new("SpecifiedOccurrenceOnly")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}TaskStatusType
class TaskStatusType < ::String
  Completed = TaskStatusType.new("Completed")
  Deferred = TaskStatusType.new("Deferred")
  InProgress = TaskStatusType.new("InProgress")
  NotStarted = TaskStatusType.new("NotStarted")
  WaitingOnOthers = TaskStatusType.new("WaitingOnOthers")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}TaskDelegateStateType
class TaskDelegateStateType < ::String
  Accepted = TaskDelegateStateType.new("Accepted")
  Declined = TaskDelegateStateType.new("Declined")
  Max = TaskDelegateStateType.new("Max")
  NoMatch = TaskDelegateStateType.new("NoMatch")
  OwnNew = TaskDelegateStateType.new("OwnNew")
  Owned = TaskDelegateStateType.new("Owned")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}IndexBasePointType
class IndexBasePointType < ::String
  Beginning = IndexBasePointType.new("Beginning")
  End = IndexBasePointType.new("End")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ResolveNamesSearchScopeType
class ResolveNamesSearchScopeType < ::String
  ActiveDirectory = ResolveNamesSearchScopeType.new("ActiveDirectory")
  ActiveDirectoryContacts = ResolveNamesSearchScopeType.new("ActiveDirectoryContacts")
  Contacts = ResolveNamesSearchScopeType.new("Contacts")
  ContactsActiveDirectory = ResolveNamesSearchScopeType.new("ContactsActiveDirectory")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}MeetingRequestTypeType
class MeetingRequestTypeType < ::String
  FullUpdate = MeetingRequestTypeType.new("FullUpdate")
  InformationalUpdate = MeetingRequestTypeType.new("InformationalUpdate")
  NewMeetingRequest = MeetingRequestTypeType.new("NewMeetingRequest")
  None = MeetingRequestTypeType.new("None")
  Outdated = MeetingRequestTypeType.new("Outdated")
  PrincipalWantsCopy = MeetingRequestTypeType.new("PrincipalWantsCopy")
  SilentUpdate = MeetingRequestTypeType.new("SilentUpdate")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ReminderMinutesBeforeStartType
class ReminderMinutesBeforeStartType < ::String
end

# {http://schemas.microsoft.com/exchange/services/2006/types}LegacyFreeBusyType
class LegacyFreeBusyType < ::String
  Busy = LegacyFreeBusyType.new("Busy")
  Free = LegacyFreeBusyType.new("Free")
  NoData = LegacyFreeBusyType.new("NoData")
  OOF = LegacyFreeBusyType.new("OOF")
  Tentative = LegacyFreeBusyType.new("Tentative")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}CalendarItemTypeType
class CalendarItemTypeType < ::String
  C_Exception = CalendarItemTypeType.new("Exception")
  Occurrence = CalendarItemTypeType.new("Occurrence")
  RecurringMaster = CalendarItemTypeType.new("RecurringMaster")
  Single = CalendarItemTypeType.new("Single")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ResponseTypeType
class ResponseTypeType < ::String
  Accept = ResponseTypeType.new("Accept")
  Decline = ResponseTypeType.new("Decline")
  NoResponseReceived = ResponseTypeType.new("NoResponseReceived")
  Organizer = ResponseTypeType.new("Organizer")
  Tentative = ResponseTypeType.new("Tentative")
  Unknown = ResponseTypeType.new("Unknown")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}DayOfWeekType
class DayOfWeekType < ::String
  Day = DayOfWeekType.new("Day")
  Friday = DayOfWeekType.new("Friday")
  Monday = DayOfWeekType.new("Monday")
  Saturday = DayOfWeekType.new("Saturday")
  Sunday = DayOfWeekType.new("Sunday")
  Thursday = DayOfWeekType.new("Thursday")
  Tuesday = DayOfWeekType.new("Tuesday")
  Wednesday = DayOfWeekType.new("Wednesday")
  Weekday = DayOfWeekType.new("Weekday")
  WeekendDay = DayOfWeekType.new("WeekendDay")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}DaysOfWeekType
#   contains list of DayOfWeekType::*
class DaysOfWeekType < ::Array
end

# {http://schemas.microsoft.com/exchange/services/2006/types}DayOfWeekIndexType
class DayOfWeekIndexType < ::String
  First = DayOfWeekIndexType.new("First")
  Fourth = DayOfWeekIndexType.new("Fourth")
  Last = DayOfWeekIndexType.new("Last")
  Second = DayOfWeekIndexType.new("Second")
  Third = DayOfWeekIndexType.new("Third")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}MonthNamesType
class MonthNamesType < ::String
  April = MonthNamesType.new("April")
  August = MonthNamesType.new("August")
  December = MonthNamesType.new("December")
  February = MonthNamesType.new("February")
  January = MonthNamesType.new("January")
  July = MonthNamesType.new("July")
  June = MonthNamesType.new("June")
  March = MonthNamesType.new("March")
  May = MonthNamesType.new("May")
  November = MonthNamesType.new("November")
  October = MonthNamesType.new("October")
  September = MonthNamesType.new("September")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ImAddressKeyType
class ImAddressKeyType < ::String
  ImAddress1 = ImAddressKeyType.new("ImAddress1")
  ImAddress2 = ImAddressKeyType.new("ImAddress2")
  ImAddress3 = ImAddressKeyType.new("ImAddress3")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}EmailAddressKeyType
class EmailAddressKeyType < ::String
  EmailAddress1 = EmailAddressKeyType.new("EmailAddress1")
  EmailAddress2 = EmailAddressKeyType.new("EmailAddress2")
  EmailAddress3 = EmailAddressKeyType.new("EmailAddress3")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}PhoneNumberKeyType
class PhoneNumberKeyType < ::String
  AssistantPhone = PhoneNumberKeyType.new("AssistantPhone")
  BusinessFax = PhoneNumberKeyType.new("BusinessFax")
  BusinessPhone = PhoneNumberKeyType.new("BusinessPhone")
  BusinessPhone2 = PhoneNumberKeyType.new("BusinessPhone2")
  Callback = PhoneNumberKeyType.new("Callback")
  CarPhone = PhoneNumberKeyType.new("CarPhone")
  CompanyMainPhone = PhoneNumberKeyType.new("CompanyMainPhone")
  HomeFax = PhoneNumberKeyType.new("HomeFax")
  HomePhone = PhoneNumberKeyType.new("HomePhone")
  HomePhone2 = PhoneNumberKeyType.new("HomePhone2")
  Isdn = PhoneNumberKeyType.new("Isdn")
  MobilePhone = PhoneNumberKeyType.new("MobilePhone")
  OtherFax = PhoneNumberKeyType.new("OtherFax")
  OtherTelephone = PhoneNumberKeyType.new("OtherTelephone")
  Pager = PhoneNumberKeyType.new("Pager")
  PrimaryPhone = PhoneNumberKeyType.new("PrimaryPhone")
  RadioPhone = PhoneNumberKeyType.new("RadioPhone")
  Telex = PhoneNumberKeyType.new("Telex")
  TtyTddPhone = PhoneNumberKeyType.new("TtyTddPhone")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}PhysicalAddressIndexType
class PhysicalAddressIndexType < ::String
  Business = PhysicalAddressIndexType.new("Business")
  Home = PhysicalAddressIndexType.new("Home")
  None = PhysicalAddressIndexType.new("None")
  Other = PhysicalAddressIndexType.new("Other")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}PhysicalAddressKeyType
class PhysicalAddressKeyType < ::String
  Business = PhysicalAddressKeyType.new("Business")
  Home = PhysicalAddressKeyType.new("Home")
  Other = PhysicalAddressKeyType.new("Other")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}FileAsMappingType
class FileAsMappingType < ::String
  Company = FileAsMappingType.new("Company")
  CompanyLastCommaFirst = FileAsMappingType.new("CompanyLastCommaFirst")
  CompanyLastFirst = FileAsMappingType.new("CompanyLastFirst")
  CompanyLastSpaceFirst = FileAsMappingType.new("CompanyLastSpaceFirst")
  FirstSpaceLast = FileAsMappingType.new("FirstSpaceLast")
  LastCommaFirst = FileAsMappingType.new("LastCommaFirst")
  LastCommaFirstCompany = FileAsMappingType.new("LastCommaFirstCompany")
  LastFirst = FileAsMappingType.new("LastFirst")
  LastFirstCompany = FileAsMappingType.new("LastFirstCompany")
  LastFirstSuffix = FileAsMappingType.new("LastFirstSuffix")
  LastSpaceFirst = FileAsMappingType.new("LastSpaceFirst")
  LastSpaceFirstCompany = FileAsMappingType.new("LastSpaceFirstCompany")
  None = FileAsMappingType.new("None")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ContactSourceType
class ContactSourceType < ::String
  ActiveDirectory = ContactSourceType.new("ActiveDirectory")
  Store = ContactSourceType.new("Store")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}AggregateType
class AggregateType < ::String
  Maximum = AggregateType.new("Maximum")
  Minimum = AggregateType.new("Minimum")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}StandardGroupByType
class StandardGroupByType < ::String
  ConversationTopic = StandardGroupByType.new("ConversationTopic")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ContainmentModeType
class ContainmentModeType < ::String
  ExactPhrase = ContainmentModeType.new("ExactPhrase")
  FullString = ContainmentModeType.new("FullString")
  PrefixOnWords = ContainmentModeType.new("PrefixOnWords")
  Prefixed = ContainmentModeType.new("Prefixed")
  Substring = ContainmentModeType.new("Substring")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ContainmentComparisonType
class ContainmentComparisonType < ::String
  Exact = ContainmentComparisonType.new("Exact")
  IgnoreCase = ContainmentComparisonType.new("IgnoreCase")
  IgnoreCaseAndNonSpacingCharacters = ContainmentComparisonType.new("IgnoreCaseAndNonSpacingCharacters")
  IgnoreNonSpacingCharacters = ContainmentComparisonType.new("IgnoreNonSpacingCharacters")
  Loose = ContainmentComparisonType.new("Loose")
  LooseAndIgnoreCase = ContainmentComparisonType.new("LooseAndIgnoreCase")
  LooseAndIgnoreCaseAndIgnoreNonSpace = ContainmentComparisonType.new("LooseAndIgnoreCaseAndIgnoreNonSpace")
  LooseAndIgnoreNonSpace = ContainmentComparisonType.new("LooseAndIgnoreNonSpace")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}SortDirectionType
class SortDirectionType < ::String
  Ascending = SortDirectionType.new("Ascending")
  Descending = SortDirectionType.new("Descending")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}NotificationEventTypeType
class NotificationEventTypeType < ::String
  CopiedEvent = NotificationEventTypeType.new("CopiedEvent")
  CreatedEvent = NotificationEventTypeType.new("CreatedEvent")
  DeletedEvent = NotificationEventTypeType.new("DeletedEvent")
  ModifiedEvent = NotificationEventTypeType.new("ModifiedEvent")
  MovedEvent = NotificationEventTypeType.new("MovedEvent")
  NewMailEvent = NotificationEventTypeType.new("NewMailEvent")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}SubscriptionStatusType
class SubscriptionStatusType < ::String
  OK = SubscriptionStatusType.new("OK")
  Unsubscribe = SubscriptionStatusType.new("Unsubscribe")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}AvailabilityProxyRequestType
class AvailabilityProxyRequestType < ::String
  CrossForest = AvailabilityProxyRequestType.new("CrossForest")
  CrossSite = AvailabilityProxyRequestType.new("CrossSite")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}MeetingAttendeeType
class MeetingAttendeeType < ::String
  Optional = MeetingAttendeeType.new("Optional")
  Organizer = MeetingAttendeeType.new("Organizer")
  Required = MeetingAttendeeType.new("Required")
  Resource = MeetingAttendeeType.new("Resource")
  Room = MeetingAttendeeType.new("Room")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}FreeBusyViewType
#   contains list of FreeBusyViewType::*
class FreeBusyViewType < ::Array
  Detailed = "Detailed"
  DetailedMerged = "DetailedMerged"
  FreeBusy = "FreeBusy"
  FreeBusyMerged = "FreeBusyMerged"
  MergedOnly = "MergedOnly"
  None = "None"
end

# {http://schemas.microsoft.com/exchange/services/2006/types}SuggestionQuality
class SuggestionQuality < ::String
  Excellent = SuggestionQuality.new("Excellent")
  Fair = SuggestionQuality.new("Fair")
  Good = SuggestionQuality.new("Good")
  Poor = SuggestionQuality.new("Poor")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}OofState
class OofState < ::String
  Disabled = OofState.new("Disabled")
  Enabled = OofState.new("Enabled")
  Scheduled = OofState.new("Scheduled")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ExternalAudience
class ExternalAudience < ::String
  All = ExternalAudience.new("All")
  Known = ExternalAudience.new("Known")
  None = ExternalAudience.new("None")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}IdFormatType
class IdFormatType < ::String
  EntryId = IdFormatType.new("EntryId")
  EwsId = IdFormatType.new("EwsId")
  EwsLegacyId = IdFormatType.new("EwsLegacyId")
  HexEntryId = IdFormatType.new("HexEntryId")
  OwaId = IdFormatType.new("OwaId")
  StoreId = IdFormatType.new("StoreId")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}DistinguishedUserType
class DistinguishedUserType < ::String
  Anonymous = DistinguishedUserType.new("Anonymous")
  Default = DistinguishedUserType.new("Default")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}PermissionReadAccessType
class PermissionReadAccessType < ::String
  FullDetails = PermissionReadAccessType.new("FullDetails")
  None = PermissionReadAccessType.new("None")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}CalendarPermissionReadAccessType
class CalendarPermissionReadAccessType < ::String
  FullDetails = CalendarPermissionReadAccessType.new("FullDetails")
  None = CalendarPermissionReadAccessType.new("None")
  TimeAndSubjectAndLocation = CalendarPermissionReadAccessType.new("TimeAndSubjectAndLocation")
  TimeOnly = CalendarPermissionReadAccessType.new("TimeOnly")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}PermissionActionType
class PermissionActionType < ::String
  All = PermissionActionType.new("All")
  None = PermissionActionType.new("None")
  Owned = PermissionActionType.new("Owned")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}PermissionLevelType
class PermissionLevelType < ::String
  Author = PermissionLevelType.new("Author")
  Contributor = PermissionLevelType.new("Contributor")
  Custom = PermissionLevelType.new("Custom")
  Editor = PermissionLevelType.new("Editor")
  None = PermissionLevelType.new("None")
  NoneditingAuthor = PermissionLevelType.new("NoneditingAuthor")
  Owner = PermissionLevelType.new("Owner")
  PublishingAuthor = PermissionLevelType.new("PublishingAuthor")
  PublishingEditor = PermissionLevelType.new("PublishingEditor")
  Reviewer = PermissionLevelType.new("Reviewer")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}CalendarPermissionLevelType
class CalendarPermissionLevelType < ::String
  Author = CalendarPermissionLevelType.new("Author")
  Contributor = CalendarPermissionLevelType.new("Contributor")
  Custom = CalendarPermissionLevelType.new("Custom")
  Editor = CalendarPermissionLevelType.new("Editor")
  FreeBusyTimeAndSubjectAndLocation = CalendarPermissionLevelType.new("FreeBusyTimeAndSubjectAndLocation")
  FreeBusyTimeOnly = CalendarPermissionLevelType.new("FreeBusyTimeOnly")
  None = CalendarPermissionLevelType.new("None")
  NoneditingAuthor = CalendarPermissionLevelType.new("NoneditingAuthor")
  Owner = CalendarPermissionLevelType.new("Owner")
  PublishingAuthor = CalendarPermissionLevelType.new("PublishingAuthor")
  PublishingEditor = CalendarPermissionLevelType.new("PublishingEditor")
  Reviewer = CalendarPermissionLevelType.new("Reviewer")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}DeliverMeetingRequestsType
class DeliverMeetingRequestsType < ::String
  DelegatesAndMe = DeliverMeetingRequestsType.new("DelegatesAndMe")
  DelegatesAndSendInformationToMe = DeliverMeetingRequestsType.new("DelegatesAndSendInformationToMe")
  DelegatesOnly = DeliverMeetingRequestsType.new("DelegatesOnly")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}DelegateFolderPermissionLevelType
class DelegateFolderPermissionLevelType < ::String
  Author = DelegateFolderPermissionLevelType.new("Author")
  Custom = DelegateFolderPermissionLevelType.new("Custom")
  Editor = DelegateFolderPermissionLevelType.new("Editor")
  None = DelegateFolderPermissionLevelType.new("None")
  Reviewer = DelegateFolderPermissionLevelType.new("Reviewer")
end

# {http://schemas.microsoft.com/exchange/services/2006/types}ServerVersionInfo
#   xmlattr_MajorVersion - SOAP::SOAPInt
#   xmlattr_MinorVersion - SOAP::SOAPInt
#   xmlattr_MajorBuildNumber - SOAP::SOAPInt
#   xmlattr_MinorBuildNumber - SOAP::SOAPInt
#   xmlattr_Version - SOAP::SOAPString
class ServerVersionInfo
  AttrMajorBuildNumber = XSD::QName.new(nil, "MajorBuildNumber")
  AttrMajorVersion = XSD::QName.new(nil, "MajorVersion")
  AttrMinorBuildNumber = XSD::QName.new(nil, "MinorBuildNumber")
  AttrMinorVersion = XSD::QName.new(nil, "MinorVersion")
  AttrVersion = XSD::QName.new(nil, "Version")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_MajorVersion
    __xmlattr[AttrMajorVersion]
  end

  def xmlattr_MajorVersion=(value)
    __xmlattr[AttrMajorVersion] = value
  end

  def xmlattr_MinorVersion
    __xmlattr[AttrMinorVersion]
  end

  def xmlattr_MinorVersion=(value)
    __xmlattr[AttrMinorVersion] = value
  end

  def xmlattr_MajorBuildNumber
    __xmlattr[AttrMajorBuildNumber]
  end

  def xmlattr_MajorBuildNumber=(value)
    __xmlattr[AttrMajorBuildNumber] = value
  end

  def xmlattr_MinorBuildNumber
    __xmlattr[AttrMinorBuildNumber]
  end

  def xmlattr_MinorBuildNumber=(value)
    __xmlattr[AttrMinorBuildNumber] = value
  end

  def xmlattr_Version
    __xmlattr[AttrVersion]
  end

  def xmlattr_Version=(value)
    __xmlattr[AttrVersion] = value
  end

  def initialize
    @__xmlattr = {}
  end
end

# {http://schemas.microsoft.com/exchange/services/2006/types}RequestServerVersion
#   xmlattr_Version - SOAP::SOAPString
class RequestServerVersion
  AttrVersion = XSD::QName.new(nil, "Version")

  def __xmlattr
    @__xmlattr ||= {}
  end

  def xmlattr_Version
    __xmlattr[AttrVersion]
  end

  def xmlattr_Version=(value)
    __xmlattr[AttrVersion] = value
  end

  def initialize
    @__xmlattr = {}
  end
end
