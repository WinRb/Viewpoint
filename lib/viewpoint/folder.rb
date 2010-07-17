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

# This class is inherited by all folder subtypes such as Mail, Calendar,
# Tasks and Search.  It will serve as the brain for all of the methods that
# each of these folder types have in common.
module Viewpoint
  module EWS
    class Folder

      @@distinguished_folder_ids = [ "calendar", "contacts", "deleteditems", "drafts",
        "inbox", "journal", "notes", "outbox", "sentitems", "tasks", "msgfolderroot", "root",
        "junkemail", "searchfolders", "voicemail", "recoverableitemsroot", "recoverableitemsdeletions",
        "recoverableitemsversions", "recoverableitemspurges", "archiveroot", "archivemsgfolderroot",
        "archivedeleteditems", "archiverecoverableitemsroot", "archiverecoverableitemsdeletions",
        "archiverecoverableitemsversions", "archiverecoverableitemspurges" ]

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

      # Subscribe to folder and save the subscription_id into the database.  Subsequent calls
      # to check_subscription will use that id.
      # Returns true if the operation is successful, false otherwise
      def subscribe
        # Refresh the subscription if already subscribed
        if( subscribed? )
          unsubscribe
        end
        subscribe = SubscribeType.new
        pull = PullSubscriptionRequestType.new

        # Set-up folder Id
        f_id_t = FolderIdType.new
        f_id_t.xmlattr_Id = @folder_id
        f_ids = NonEmptyArrayOfBaseFolderIdsType.new([f_id_t],nil)
        pull.folderIds = f_ids

        # Set-up event types
        event_types = NonEmptyArrayOfNotificationEventTypesType.new
        event_types.push(NotificationEventTypeType::CopiedEvent)
        event_types.push(NotificationEventTypeType::CreatedEvent)
        event_types.push(NotificationEventTypeType::DeletedEvent)
        event_types.push(NotificationEventTypeType::ModifiedEvent)
        event_types.push(NotificationEventTypeType::MovedEvent)
        event_types.push(NotificationEventTypeType::NewMailEvent)
        pull.eventTypes = event_types

        pull.timeout = 10

        subscribe.pullSubscriptionRequest = pull

        resp = ExchWebServ.instance.ews.subscribe(subscribe).responseMessages.subscribeResponseMessage.first
        @subscription_id = resp.subscriptionId
        @watermark = resp.watermark

        return (resp.responseCode == "NoError")? true: false
      end

      def subscribed?
        ( @subscription_id.nil? or @watermark.nil? )? false : true
      end


      # unsubscribe from folder
      # Returns true if unsubscription succeeds, false otherwise
      def unsubscribe
        begin
          if( @subscription_id == nil ) then
            return true
          end

          unsub_t = UnsubscribeType.new(@subscription_id)
          resp = ExchWebServ.instance.ews.unsubscribe(unsub_t).responseMessages.unsubscribeResponseMessage.first

          return (resp.responseCode == "NoError")? true: false
        end
      end


      # Fetch events with the subscription_id.  If one does not exists or is expired,
      # call subscribe.
      # Returns a hash with the event type as the key and an Array of Hashes that
      # represent each event's data
      # An :error key is set if there is a problem
      def check_subscription
        begin
          if( @subscription_id == nil or @watermark == nil) then
            self.subscribe
          end
          ge = GetEventsType.new(@subscription_id, @watermark)

          resp = ExchWebServ.instance.ews.getEvents(ge).responseMessages.getEventsResponseMessage

          #TODO:  Add more event processing


          notifications = resp.first.notification

          notif_hash = {}
          # Process Notifications
          if( notifications.copiedEvent != nil)
            notif_hash[:copiedEvent] = []
            notifications.copiedEvent.each do |note|
              @watermark = note.watermark
              item = {}
              item.store(:old_item_id,note.oldItemId.xmlattr_Id) if note.itemId
              item.store(:old_folder_id,note.oldParentFolderId.xmlattr_Id) if note.oldParentFolderId
              item.store(:item_id,note.itemId.xmlattr_Id) if note.itemId
              item.store(:folder_id,note.parentFolderId.xmlattr_Id) if note.parentFolderId
              notif_hash[:copiedEvent] << item
            end
          end

          if( notifications.createdEvent != nil)
            notif_hash[:createdEvent] = []
            notifications.createdEvent.each do |note|
              @watermark = note.watermark
              item = {}
              item.store(:item_id,note.itemId.xmlattr_Id) if note.itemId
              item.store(:folder_id,note.parentFolderId.xmlattr_Id) if note.parentFolderId
              notif_hash[:createdEvent] << item
            end
          end

          if( notifications.deletedEvent != nil)
            notif_hash[:deletedEvent] = []
            notifications.deletedEvent.each do |note|
              @watermark = note.watermark
              item = {}
              item.store(:item_id,note.itemId.xmlattr_Id) if note.itemId
              item.store(:folder_id,note.parentFolderId.xmlattr_Id) if note.parentFolderId
              notif_hash[:deletedEvent] << item
            end
          end

          if( notifications.modifiedEvent != nil)
            notif_hash[:modifiedEvent] = []
            notifications.modifiedEvent.each do |note|
              @watermark = note.watermark
              item = {}
              item.store(:item_id,note.itemId.xmlattr_Id) if note.itemId
              item.store(:folder_id,note.folderId.xmlattr_Id) if note.folderId
              item.store(:parent_folder_id,note.parentFolderId.xmlattr_Id) if note.parentFolderId
              item.store(:unreadCount,note.unreadCount)
              notif_hash[:modifiedEvent] << item
            end
          end

          if( notifications.movedEvent != nil)
            notif_hash[:movedEvent] = []
            notifications.movedEvent.each do |note|
              @watermark = note.watermark
              item = {}
              item.store(:old_item_id,note.oldItemId.xmlattr_Id) if note.oldItemId
              item.store(:old_folder_id,note.oldParentFolderId.xmlattr_Id) if note.oldParentFolderId
              item.store(:item_id,note.itemId.xmlattr_Id) if note.itemId
              item.store(:folder_id,note.parentFolderId.xmlattr_Id) if note.parentFolderId
              notif_hash[:movedEvent] << item
            end
          end

          if( notifications.newMailEvent!= nil)
            notif_hash[:newMailEvent] = []
            notifications.newMailEvent.each do |note|
              @watermark = note.watermark
              item = {}
              item.store(:item_id,note.itemId.xmlattr_Id) if note.itemId
              item.store(:folder_id,note.parentFolderId.xmlattr_Id) if note.parentFolderId
              notif_hash[:newMailEvent] << item
            end
          end

          if( notifications.statusEvent != nil)
            notifications.statusEvent.each do |note|
              @watermark = note.watermark
            end
          end

        rescue NoMethodError
          # This ocurrs if something bad happened to the subscription.
          # This is handled by resubscribing to the subscription and returning
          # an error key.
          self.subscribe
          return {:error => "Something bad happened to your subscription.  You have been re-subscribed" }
        end

        #return resp
        notif_hash[:resp] = resp
        return notif_hash
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
