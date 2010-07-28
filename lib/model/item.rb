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


# This class is inherited by all Item subtypes such as Message, Event,
# and Task.  It will serve as the brain for all of the methods that
# each of these Item types have in common.
module Viewpoint
  module EWS
    class Item
      include Model

      # This is a Class method that fetches an existing Item from the
      #  Exchange Store.  To create a new item that does not exist in
      #  the store use Item#new
      # @param [String] item_id The id of the item.
      # @todo Add support to fetch an item with a ChangeKey
      def self.get_item(item_id)
        conn = Viewpoint::EWS::EWS.instance
        conn.ews.get_item([item_id])
      end

      attr_reader :item_id, :body_type
      alias :id :item_id

      # Initialize an Exchange Web Services item
      def initialize(ews_item)
        super() # Calls initialize in Model (creates @ews_methods Array)
        @ews_item = ews_item
        @item_id = ews_item[:item_id][:id]
        @ews_methods << :item_id
        if(ews_item[:body] && ews_item[:body][:body_type])
          @body_type = ews_item[:body][:body_type]
          @ews_methods << :body_type
        end
        define_str_var :subject, :sensitivity, :body
        define_int_var :size
        define_bool_var :is_read, :has_attachments, :is_read_receipt_requested, :is_delivery_receipt_requested
        define_datetime_var :date_time_sent, :date_time_created
        define_mbox_users :to_recipients, :cc_recipients
        define_mbox_user :from
        # @todo Handle:  :attachments
      end

      def move_to!(new_folder)
      end

      def delete!
      end

      def recycle!
      end


    end # Item
  end # EWS
end # Viewpoint
