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
require 'rubygems'
require 'dm-core'


# This class is inherited by all folder subtypes such as Mail, Calendar,
# Tasks and Search.  It will serve as the brain for all of the methods that
# each of these folder types have in common.
class Folder
	include DataMapper::Resource
	# ===================== DataMapper Model Definition ===================== #
	#  Manually set the table name
	storage_names[:default]='folders'
	property :folder_id, String, :key => true
	property :parent_id, String
	property :display_name, String
	property :folder_type, Discriminator
	property :sync_state, String
	property :subscription_id, String
	property :watermark, String  # subscription watermark.  needed in getEvents
	# ======================================================================= #

	def initialize(folder)
		self.folder_id = folder.folderId.xmlattr_Id
		self.parent_id = folder.parentFolderId.xmlattr_Id unless folder.parentFolderId == nil
		self.display_name = folder.displayName
		self.save
	end

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
			resp = Viewpoint.instance.ews.syncFolderItems(syncitemsT).responseMessages.syncFolderItemsResponseMessage[0]
			self.sync_state = resp.syncState
			self.save
			return resp
		rescue
			puts "** Something happened during synchronizing folder => #{self.display_name}"
			raise
		end
	end

	# Subscribe to folder and save the subscription_id into the database.  Subsequent calls
	# to get_events will use that id.  We also return the SubscribeResponseMessageType in
	# case any further processing is needed.
	def subscribe
		subscribe = SubscribeType.new
		pull = PullSubscriptionRequestType.new

		# Set-up folder Id
		dist_fid = DistinguishedFolderIdType.new
		dist_fid.xmlattr_Id = DistinguishedFolderIdNameType::Calendar
		f_ids = NonEmptyArrayOfBaseFolderIdsType.new()
		f_ids.distinguishedFolderId = dist_fid
		pull.folderIds = f_ids

		# Set-up event types
		event_types = NonEmptyArrayOfNotificationEventTypesType.new
		#event_types.push(NotificationEventTypeType::NewMailEvent)
		event_types.push(NotificationEventTypeType::CreatedEvent)
		event_types.push(NotificationEventTypeType::DeletedEvent)
		#event_types.push(NotificationEventTypeType::ModifiedEvent)
		event_types.push(NotificationEventTypeType::MovedEvent)
		pull.eventTypes = event_types

		pull.timeout = 10

		subscribe.pullSubscriptionRequest = pull
		
		resp = Viewpoint.instance.ews.subscribe(subscribe).responseMessages.subscribeResponseMessage[0]
		self.subscription_id = resp.subscriptionId
		self.watermark = resp.watermark
		self.save

		return resp
	end


	# Fetch events with the subscription_id.  If one does not exists or is expired,
	# call subscribe.
	def get_events
		begin
			if( self.subscription_id == nil or self.watermark == nil) then
				self.subscribe
			end
			ge = GetEventsType.new(self.subscription_id, self.watermark)

			resp = Viewpoint.instance.ews.getEvents(ge).responseMessages.getEventsResponseMessage[0] 

			#TODO:  Add more event processing
			

			notifications = resp.notification

			# Process Notifications
			if( notifications.createdEvent != nil)
				notifications.createdEvent.each do |note|
					self.watermark = note.watermark
				end
			end

			if( notifications.deletedEvent != nil)
				notifications.deletedEvent.each do |note|
					self.watermark = note.watermark
				end
			end

			if( notifications.movedEvent != nil)
				notifications.movedEvent.each do |note|
					self.watermark = note.watermark
				end
			end

			if( notifications.statusEvent != nil)
				notifications.statusEvent.each do |note|
					self.watermark = note.watermark
				end
			end

			self.save
		end

		return resp
	end


	def get_item(item_id)
		get_item = GetItemType.new

		item_shape = ItemResponseShapeType.new( DefaultShapeNamesType.new("Default"),
					  false, BodyTypeResponseType::Text )
		
		item_id_t = ItemIdType.new()
		item_id_t.xmlattr_Id = item_id
		item_ids = NonEmptyArrayOfBaseItemIdsType.new([item_id_t])

		get_item.itemShape = item_shape
		get_item.itemIds= item_ids

		# ItemInfoResponseMessageType
		resp = Viewpoint.instance.ews.getItem(get_item).responseMessages.getItemResponseMessage[0]

		return resp
	end
end
