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

      # This is a class method that fetches an existing Item from the
      #  Exchange Store.
      # @param [String] item_id The id of the item.
      # @return [Item] Returns an Item or subclass of Item
      # @todo Add support to fetch an item with a ChangeKey
      def self.get_item(item_id)
        conn = Viewpoint::EWS::EWS.instance
        resp = conn.ews.get_item([item_id])
        resp = resp.items.shift
        self.new(resp[resp.keys.first])
      end

      # Add attachments to the passed in ParentId
      # @param [String,Hash] parent_id Either a String ItemId or a Hash ItemId with a ChangeKey
      # @option parent_id [String] :id The Id
      # @option parent_id [String] :change_key The ChangeKey
      # @param [Array<File>] attachments An Array of File objects to read in.
      def self.add_attachments(parent_id, attachments)
        conn = Viewpoint::EWS::EWS.instance
        b64attach = []
        attachments.each do |a|
          b64attach << {:name => {:text =>(File.basename a.path)}, :content => {:text => Base64.encode64(a.read)}}
        end
        resp = conn.ews.create_attachment(parent_id, b64attach) 
        (resp.status == 'Success') || (raise EwsError, "Could not create attachments. #{resp.code}: #{resp.message}")
        {:id => resp.items.first[:attachment_id][:root_item_id], :change_key => resp.items.first[:attachment_id][:root_item_change_key]}
      end

      attr_reader :item_id, :change_key, :body_type
      alias :id :item_id

      # Initialize an Exchange Web Services item
      # @param [Hash] ews_item A hash representing this item
      # @param [Boolean] shallow Whether or not we have retrieved all the elements for this object
      def initialize(ews_item, shallow = true)
        super() # Calls initialize in Model (creates @ews_methods Array)
        @ews_item = ews_item
        @shallow = shallow
        @item_id = ews_item[:item_id][:id]
        @change_key = ews_item[:item_id][:change_key]

        init_methods
      end

      def deepen!
        conn = Viewpoint::EWS::EWS.instance
        resp = conn.ews.get_item([@item_id], {:base_shape => 'AllProperties'})
        resp = resp.items.shift
        @ews_item = resp[resp.keys.first]
        @shallow = false
        @ews_methods = []
        @ews_methods_undef = []
        init_methods
      end

      # Move this item to a new folder
      # @param [String,Symbol,GenericFolder] new_folder The new folder to move it to. This should
      #   be a subclass of GenericFolder, a DistinguishedFolderId (must me a Symbol) or a FolderId (String)
      def move!(new_folder)
        new_folder = new_folder.id if new_folder.kind_of?(GenericFolder)
        resp = (Viewpoint::EWS::EWS.instance).ews.move_item([@item_id], new_folder)
        if(resp.status == 'Success')
          @item_id = resp.items.first[resp.items.first.keys.first][:item_id][:id]
          @change_key = resp.items.first[resp.items.first.keys.first][:item_id][:change_key]
          true
        else
          raise EwsError, "Could not move item. #{resp.code}: #{resp.message}"
        end
      end

      # Copy this item to a new folder
      # @param [String,Symbol,GenericFolder] new_folder The new folder to move it to. This should
      #   be a subclass of GenericFolder, a DistinguishedFolderId (must me a Symbol) or a FolderId (String)
      # @return [Item] The Item object of the copy
      def copy(new_folder)
        new_folder = new_folder.id if new_folder.kind_of?(GenericFolder)
        resp = (Viewpoint::EWS::EWS.instance).ews.copy_item([@item_id], new_folder)
        if(resp.status == 'Success')
          item = resp.items.first
          i_type = item.keys.first.to_s.camel_case
          return(eval "#{i_type}.new(item[item.keys.first])")
        else
          raise EwsError, "Could not copy item. #{resp.code}: #{resp.message}"
        end
      end

      # Delete this item
      # @param [Boolean] soft Whether or not to do a soft delete.  By default EWS will do a 
      #   hard delete of this item.  See the MSDN docs for more info:
      #   http://msdn.microsoft.com/en-us/library/aa562961.aspx
      # @return [Boolean] Whether or not the item was deleted
      # @todo Add exception handling for failed deletes
      def delete!(soft=false)
        deltype = soft ? 'SoftDelete' : 'HardDelete'
        resp = (Viewpoint::EWS::EWS.instance).ews.delete_item([@item_id], deltype)
        self.clear_object!
        (resp.status == 'Success') || (raise EwsError, "Could not delete message. #{resp.code}: #{resp.message}")
      end

      # Delete this item by moving it to the Deleted Items folder
      # @see  http://msdn.microsoft.com/en-us/library/aa562961.aspx
      # @return [Boolean] Whether or not the item was deleted
      # @todo Add exception handling for failed deletes
      def recycle!
        resp = (Viewpoint::EWS::EWS.instance).ews.delete_item([@item_id], 'MoveToDeletedItems')
        self.clear_object!
        (resp.status == 'Success') || (raise EwsError, "Could not recycle message. #{resp.code}: #{resp.message}")
      end

      private

      # @todo Handle:
      #   <Attachments/> <Categories/> <InternetMessageHeaders/> <ResponseObjects/>
      #   <ExtendedProperty/> <EffectiveRights/>
      def init_methods
        @parent_folder_id = @ews_item[:parent_folder_id][:id] if @ews_item[:parent_folder_id].is_a?(Hash)
        @conversation_id  = @ews_item[:conversation_id][:id] if @ews_item[:conversation_id].is_a?(Hash)
        @ews_methods << :item_id
        if(@ews_item[:body] && @ews_item[:body][:body_type])
          @body_type = @ews_item[:body][:body_type]
          @ews_methods << :body_type
        end
        if(@ews_item[:unique_body] && @ews_item[:unique_body][:body_type])
          @unique_body_type = @ews_item[:body][:body_type]
          @ews_methods << :unique_body_type
        end
        if(@ews_item[:mime_content] && @ews_item[:mime_content][:character_set])
          @mime_charset = @ews_item[:mime_content][:character_set]
          @ews_methods << :mime_charset
        end
        define_str_var :subject, :sensitivity, :body, :item_class, :importance, :in_reply_to, :unique_body
        define_str_var :display_cc, :display_to, :culture, :last_modified_name, :mime_content
        define_str_var :web_client_read_form_query_string, :web_client_edit_form_query_string
        define_int_var :size, :reminder_minutes_before_start
        define_bool_var :has_attachments, :is_submitted, :is_draft, :is_from_me, :is_resend, :is_unmodified, :reminder_is_set, :is_associated
        define_datetime_var :date_time_sent, :date_time_created, :date_time_received, :reminder_due_by, :last_modified_time
      end

      def method_missing(m, *args, &block)
        warn "!!! No such method: #{m}"
      end

    end # Item
  end # EWS
end # Viewpoint
