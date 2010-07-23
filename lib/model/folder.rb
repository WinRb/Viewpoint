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

# This class is inherited by all folder subtypes such as Mail, Calendar,
# Tasks and Search.  It will serve as the brain for all of the methods that
# each of these folder types have in common.
module Viewpoint
  module EWS
    class Folder

      @@distinguished_folder_ids = %w{ calendar contacts deleteditems drafts
        inbox journal notes outbox sentitems tasks msgfolderroot root
        junkemail searchfolders voicemail recoverableitemsroot recoverableitemsdeletions
        recoverableitemsversions recoverableitemspurges archiveroot archivemsgfolderroot
        archivedeleteditems archiverecoverableitemsroot archiverecoverableitemsdeletions
        archiverecoverableitemsversions archiverecoverableitemspurges }

      @@event_types = %w{CopiedEvent CreatedEvent DeletedEvent ModifiedEvent
        MovedEvent NewMailEvent FreeBusyChangedEvent}


      def self.get_folder(folder_id)
        tfolder_id = folder_id.downcase
        # If the folder_id is a DistinguishedFolderId change it to a symbol so our SOAP
        # method does the right thing.
        folder_id = @@distinguished_folder_ids.find_index(tfolder_id) ? tfolder_id.to_sym : folder_id
        (Viewpoint::EWS::EWS.instance).ews.get_folder([folder_id])
      end

      def self.delete_folder(folder_id)
        # @todo Implement Folder::delete_folder
      end

      attr_accessor :folder_id, :parent_id, :display_name
      def initialize(folder)
        @folder_id = folder.folderId.xmlattr_Id
        @parent_id = folder.parentFolderId.xmlattr_Id unless folder.parentFolderId == nil
        @display_name = folder.displayName
        @sync_state = nil
        @subscription_id = nil
        @watermark = nil
      end

      # Subscribe this folder to events.  This method initiates an Exchange pull
      # type subscription.
      #
      # @param [Array] event_types Which event types to subscribe to.  By default
      #   we subscribe to all Exchange event types: CopiedEvent, CreatedEvent,
      #   DeletedEvent, ModifiedEvent, MovedEvent, NewMailEvent, FreeBusyChangedEvent
      # @return [Boolean] Did the subscription happen successfully?
      def subscribe(event_types = @@event_types)
        # Refresh the subscription if already subscribed
        unsubscribe if subscribed?

        begin
          resp = (Viewpoint::EWS::EWS.instance).ews.subscribe([folder_id],event_types)

          @subscription_id = resp[:subscription_id]
          @watermark = resp[:watermark]
          return true
        rescue
          return false
        end
      end

      # Check if there is a subscription for this folder.
      # @return [Boolean] Are we subscribed to this folder?
      def subscribed?
        ( @subscription_id.nil? or @watermark.nil? )? false : true
      end


      # Unsubscribe this folder from further Exchange events.
      # @return [Boolean] Did we unsubscribe successfully?
      def unsubscribe
        begin
          return true if @subscription_id.nil?

          (Viewpoint::EWS::EWS.instance).ews.unsubscribe(@subscription_id)
        rescue
          return false
        end
      end


      # Fetch events with the subscription_id.  If one does not exists or is expired,
      # call subscribe.
      # Returns a hash with the event type as the key and an Array of Hashes that
      # represent each event's data
      # An :error key is set if there is a problem
      def check_subscription
        if subscribed?
      end


      # This is a proxy for the SyncFolderItems operation detailed here: http://msdn.microsoft.com/en-us/library/aa563967.aspx
      # It returns a SyncFolderItemsResponseType object
      def sync_folder(max_items = 256)
        begin
          # ItemResponseShapeType
          itemshapeT = ItemResponseShapeType.new(DefaultShapeNamesType::IdOnly, false)

          # TargetFolderIdType
          tfolderidT = TargetFolderIdType.new
          folderidT = FolderIdType.new
          folderidT.xmlattr_Id = self.folder_id
          tfolderidT.folderId = folderidT

          # SyncFolderItemsType
          syncitemsT = SyncFolderItemsType.new(itemshapeT,tfolderidT,self.sync_state,nil,max_items)

          # Call Sync => returns SyncFolderItemsResponseType
          resp = ExchWebServ.instance.ews.syncFolderItems(syncitemsT).responseMessages.syncFolderItemsResponseMessage[0]
          @sync_state = resp.syncState
          return resp
        rescue
          puts "** Something happened during synchronizing folder => #{self.display_name}"
          raise
        end
      end


      # Wrapper around EWS's FindItem method:  http://msdn.microsoft.com/en-us/library/aa566107.aspx
      # The specifics of this method should be set up in the child classes and then this method should
      # be called with a parameter of FindItemType:  http://msdn.microsoft.com/en-us/library/aa566370.aspx
      # This allows for a central place of error handling.  See Calendar::get_events for an example
      # of how this works.
      def find_items(find_item_t)
        # FindItemResponseMessageType: http://msdn.microsoft.com/en-us/library/aa566424.aspx
        resp = ExchWebServ.instance.ews.findItem(find_item_t).responseMessages.findItemResponseMessage[0]

        #TODO: Error handling
        if resp.xmlattr_ResponseClass == "Success"
          return resp
        else
          return nil
        end
      end


      # Fetch item by item_id
      # Params: item_id: ItemIdType
      #         item_type: String (message, calendarItem)
      #         all_props: boolean; default is to get just the Default props
      # Returns:  a Item type of some sort ( depends on 'item_type' parameter )
      def get_item(item_id, item_type = nil, all_props = false)
        get_item = GetItemType.new

        if all_props
          shape_name = DefaultShapeNamesType::AllProperties
        else
          shape_name = DefaultShapeNamesType::Default
        end

        item_shape = ItemResponseShapeType.new( shape_name, false, BodyTypeResponseType::Text )

        #additional_props = NonEmptyArrayOfPathsToElementType.new
        #prop_a = PathToUnindexedFieldType.new
        #prop_b = PathToUnindexedFieldType.new
        #prop_c = PathToUnindexedFieldType.new
        #prop_d = PathToUnindexedFieldType.new
        #prop_a.xmlattr_FieldURI = UnindexedFieldURIType::CalendarMeetingTimeZone
        #prop_b.xmlattr_FieldURI = UnindexedFieldURIType.new("calendar:EndTimeZone")
        #prop_c.xmlattr_FieldURI = UnindexedFieldURIType::ItemInternetMessageHeaders
        #prop_d.xmlattr_FieldURI = UnindexedFieldURIType::MessageFrom
        #additional_props.upath << prop_a
        #additional_props.upath << prop_b
        #additional_props.upath << prop_c
        #additional_props << prop_d
        #item_shape.additionalProperties = additional_props



        item_id_t = ItemIdType.new
        item_id_t.xmlattr_Id = item_id
        item_ids = NonEmptyArrayOfBaseItemIdsType.new([item_id_t])

        get_item.itemShape = item_shape
        get_item.itemIds= item_ids

        # ItemInfoResponseMessageType: http://msdn.microsoft.com/en-us/library/aa565417.aspx
        resp = ExchWebServ.instance.ews.getItem(get_item).responseMessages.getItemResponseMessage[0]

        #TODO: Error handling
        if resp.xmlattr_ResponseClass == "Success"
          item = resp.items.send(item_type)
          if( item.length > 1 )
            puts "ERROR:  Item Id should only resolve to a single item!"
          end
          return item[0]
        else
          return nil
        end
      end


      # More info: http://msdn.microsoft.com/en-us/library/aa565781.aspx
      def move_item(item_id, new_folder)
        return false unless new_folder.kind_of?(Viewpoint::Folder)

        folder_id_t = FolderIdType.new
        folder_id_t.xmlattr_Id =  new_folder.folder_id
        target_folder_t = TargetFolderIdType.new(folder_id_t)

        item_ids = NonEmptyArrayOfBaseItemIdsType.new
        item_t = ItemIdType.new
        item_t.xmlattr_Id = item_id
        item_ids.itemId << item_t

        move_t = MoveItemType.new(target_folder_t, item_ids)
        resp = ExchWebServ.instance.ews.moveItem(move_t).responseMessages.moveItemResponseMessage.first
        #TODO: Error handling
        if resp.xmlattr_ResponseClass == "Success"
          return true
        else
          return false
        end
      end

      # Delete item by item_id
      # More info: http://msdn.microsoft.com/en-us/library/aa580484.aspx
      def delete_item(item_id, delete_type=DisposalType::HardDelete)
        item_ids = NonEmptyArrayOfBaseItemIdsType.new
        item = ItemIdType.new
        item.xmlattr_Id = item_id
        item_ids.itemId << item

        delete = DeleteItemType.new(item_ids)
        delete.xmlattr_DeleteType = delete_type
        resp = ExchWebServ.instance.ews.deleteItem(delete).responseMessages.deleteItemResponseMessage.first

        #TODO: Error handling
        if resp.xmlattr_ResponseClass == "Success"
          return true
        else
          return false
        end
      end

      # Move item to Deleted Items folder instead of deleting it
      def recycle_item(item_id)
        delete_item(item_id, DisposalType::MoveToDeletedItems)
      end
    end # Folder
  end # EWS
end # Viewpoint
