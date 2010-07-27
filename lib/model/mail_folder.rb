#############################################################################
# Copyright © 2010 Dan Wanek <dan.wanek@gmail.com>
#
#
# This file is part of Viewpoint.
# 
# Viewpoint is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published
# by the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.
# 
# Viewpoint is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
# Public License for more details.
# 
# You should have received a copy of the GNU General Public License along
# with Viewpoint.  If not, see <http://www.gnu.org/licenses/>.
#############################################################################

module Viewpoint
  module EWS
    class MailFolder < Folder

      # initialize with an item of MailFolderType
      def initialize(folder)
        super(folder)
      end

      def get_todays_messages
        get_messages( DateTime.parse(Date.today.to_s).to_s )
      end

      # Get messages between a certain time period.  Defaults to "today"
      # Input: DateTime of start, DateTime of end
      # This method will return an Array of Message
      def get_messages(since = (DateTime.parse(Date.today.to_s)) )
        # Set-up FindItemType
        find_item_t = FindItemType.new
        find_item_t.xmlattr_Traversal = ItemQueryTraversalType::Shallow
        item_shape = ItemResponseShapeType.new(DefaultShapeNamesType::IdOnly, false)

        additional_props = NonEmptyArrayOfPathsToElementType.new
        prop_a = PathToUnindexedFieldType.new
        prop_b = PathToUnindexedFieldType.new
        prop_c = PathToUnindexedFieldType.new
        prop_d = PathToUnindexedFieldType.new
        prop_e = PathToUnindexedFieldType.new
        prop_f = PathToUnindexedFieldType.new
        prop_a.xmlattr_FieldURI = UnindexedFieldURIType::ItemSubject
        prop_b.xmlattr_FieldURI = UnindexedFieldURIType::ItemDateTimeReceived
        prop_c.xmlattr_FieldURI = UnindexedFieldURIType::MessageSender 
        prop_d.xmlattr_FieldURI = UnindexedFieldURIType::MessageFrom
        prop_e.xmlattr_FieldURI = UnindexedFieldURIType::MessageIsRead
        prop_f.xmlattr_FieldURI = UnindexedFieldURIType::MessageInternetMessageId
        additional_props.upath << prop_a
        additional_props.upath << prop_b
        additional_props.upath << prop_c
        additional_props.upath << prop_d
        additional_props.upath << prop_e
        additional_props.upath << prop_f
        item_shape.additionalProperties = additional_props
        find_item_t.itemShape = item_shape


        # Set-up folder Ids to search in
        folder_ids = NonEmptyArrayOfBaseFolderIdsType.new()
        dist_folder = DistinguishedFolderIdType.new
        dist_folder.xmlattr_Id = DistinguishedFolderIdNameType.new(@display_name.downcase)
        folder_ids.distinguishedFolderId = dist_folder
        find_item_t.parentFolderIds = folder_ids


        # Set-up date-based restriction.
        restriction = RestrictionType.new
        search_type = IsGreaterThanOrEqualToType.new
        fielduri = PathToUnindexedFieldType.new
        fielduri.xmlattr_FieldURI = UnindexedFieldURIType::ItemDateTimeReceived
        const = FieldURIOrConstantType.new
        c = ConstantValueType.new
        c.xmlattr_Value = (DateTime.now - 2).new_offset(0).to_s
        const.constant = c
        search_type.path = fielduri
        search_type.fieldURIOrConstant = const
        restriction.isGreaterThanOrEqualTo = search_type

        find_item_t.restriction = restriction

        resp = find_items(find_item_t)

        messages = []
        if resp != nil
          resp.rootFolder.items.message.each do |msg|
            messages << Message.new(msg, self)
          end
        end
        return messages

      end

      # @see Folder#get_item
      def get_item(item_id, change_key = nil)
        items = super(item_id, change_key)
        items[:message]
      end

      def get_message(item_id)
        Message.new(get_item(item_id), self)
      end
    end # MailFolder
  end # EWS
end # Viewpoint
