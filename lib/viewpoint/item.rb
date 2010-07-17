#############################################################################
# Copyright © 2009 Dan Wanek <dan.wanek@gmail.com>
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


# This class is inherited by all Item subtypes such as Message, Event,
# and Task.  It will serve as the brain for all of the methods that
# each of these Item types have in common.
module Viewpoint
  module EWS
    class Item

      attr_accessor :item_id, :parent_folder, :item_class
      attr_reader :ews_item if $DEBUG

      # This is a Class method that fetches an existing Item from the
      #  Exchange Store.  To create a new item that does not exist in
      #  the store use Item#new
      def self.get_item(item_id)
        conn = Viewpoint::EWS::EWS.instance
        conn.ews.
      end

      # Initialize an Exchange Web Services item
      def initialize(ews_item, parent_folder)
        @ews_item = ews_item if $DEBUG

        @item_id = ews_item.itemId.xmlattr_Id
        @parent_folder = parent_folder
        @item_class = ews_item.itemClass
      end

      # Takes an object of type Viewpoint::Folder as an argument
      # Returns a boolean value, true if the move ocurred, false otherwise.
      def move_to!(new_folder)
        retval = @parent_folder.move_item(@item_id, new_folder)
        @parent_folder = new_folder if retval

        return retval
      end


      def entry_id
        convert_id(IdFormatType::EntryId)
      end

      # Return the OWA ID so we can link to webmail
      # Example usage: uri = "https://host/owa/?ae=Item&a=open&id=" + owa_id
      def owa_id
        convert_id(IdFormatType::OwaId)
      end

      def ews_legacy_id
        convert_id(IdFormatType::EwsLegacyId)
      end

      def hex_id
        convert_id(IdFormatType::HexEntryId)
      end

      def store_id
        convert_id(IdFormatType::StoreId)
      end

      # Returns a boolean value, true if the delete ocurred, false otherwise.
      def delete!
        @parent_folder.delete_item(@item_id)
      end

      # Returns a boolean value, true if the recycle ocurred, false otherwise.
      def recycle!
        @parent_folder.recycle_item(@item_id)
      end


      private

      def convert_id(dest_type)
        vp = ExchWebServ.instance
        altids_ar = NonEmptyArrayOfAlternateIdsType.new

        altid_t = AlternateIdType.new
        altid_t.xmlattr_Format = IdFormatType::EwsId
        altid_t.xmlattr_Id = @item_id
        altid_t.xmlattr_Mailbox = vp.email
        altids_ar.alternateId << altid_t

        convertid_t = ConvertIdType.new(altids_ar)
        convertid_t.xmlattr_DestinationFormat = dest_type

        resp = vp.ews.convertId(convertid_t)
        resp.responseMessages.convertIdResponseMessage.first.alternateId.xmlattr_Id
      end
    end # Item
  end # EWS
end # Viewpoint
