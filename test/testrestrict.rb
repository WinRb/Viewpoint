require 'rubygems'
gem 'soap4r'
require File.dirname(__FILE__) + '/../lib/viewpoint'
require File.dirname(__FILE__) + '/../lib/wsdl/exchangeServiceBinding'

$DEBUG = true

vp = Viewpoint.instance

vp.find_folders

fit = FindItemType.new
fit.xmlattr_Traversal = ItemQueryTraversalType::Shallow
fit.itemShape = ItemResponseShapeType.new(DefaultShapeNamesType::Default, false)

fid = NonEmptyArrayOfBaseFolderIdsType.new()
fidt = DistinguishedFolderIdType.new
fidt.xmlattr_Id = DistinguishedFolderIdNameType::Calendar
fid.distinguishedFolderId = fidt
fit.parentFolderIds = fid



# Set up restriction
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

=begin
rt = RestrictionType.new
se = ExistsType.new
fielduri = PathToUnindexedFieldType.new
fielduri.xmlattr_FieldURI="item:Subject"
se.path = fielduri
rt.exists = se
=end


fit.restriction = rt


vp.ews.findItem(fit)
