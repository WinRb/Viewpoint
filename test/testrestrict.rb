require 'rubygems'
gem 'soap4r'
require File.dirname(__FILE__) + '/../lib/exchwebserv'
require File.dirname(__FILE__) + '/../lib/wsdl/exchangeServiceBinding'
include Viewpoint

$DEBUG = true

vp = ExchWebServ.instance

vp.find_folders

fit = FindItemType.new
fit.xmlattr_Traversal = ItemQueryTraversalType::Shallow
fit.itemShape = ItemResponseShapeType.new(DefaultShapeNamesType::Default, false)

fid = NonEmptyArrayOfBaseFolderIdsType.new()
fidt = DistinguishedFolderIdType.new
fidt.xmlattr_Id = DistinguishedFolderIdNameType::Calendar
fid.distinguishedFolderId = fidt
fit.parentFolderIds = fid

cal_span =  CalendarViewType.new
cal_span.xmlattr_StartDate = DateTime.parse(Date.today.to_s).to_s
cal_span.xmlattr_EndDate = DateTime.parse(Date.today.next.to_s).to_s
fit.calendarView = cal_span


# Set up restriction
# Filter by a "Contains" expression
=begin
rt = RestrictionType.new
se = ContainsExpressionType.new
fielduri = PathToUnindexedFieldType.new
fielduri.xmlattr_FieldURI = "item:Subject"
#const = FieldURIOrConstantType.new
c = ConstantValueType.new
c.xmlattr_Value = "Systems"
#const.constant = c 
se.path = fielduri
se.constant = c
se.xmlattr_ContainmentMode = "Substring"
rt.containsExpression = se
=end


# Filter by when Item was received
=begin
rt = RestrictionType.new
se = IsGreaterThanType.new
fielduri = PathToUnindexedFieldType.new
fielduri.xmlattr_FieldURI = UnindexedFieldURIType::ItemDateTimeReceived 
const = FieldURIOrConstantType.new
c = ConstantValueType.new
c.xmlattr_Value = (DateTime.now - 2).new_offset(0).to_s
const.constant = c 
se.path = fielduri
se.fieldURIOrConstant = const
rt.isGreaterThan = se
=end


# Filter by a simple "Exists" expression
=begin
rt = RestrictionType.new
se = ExistsType.new
fielduri = PathToUnindexedFieldType.new
fielduri.xmlattr_FieldURI="item:Subject"
se.path = fielduri
rt.exists = se
=end



vp.ews.findItem(fit)
