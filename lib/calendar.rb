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
$:.unshift(File.dirname(__FILE__))
require 'rubygems'
require 'wsdl/exchangeServiceBinding'
require 'dm-core'
require 'folder'


class CalendarFolder
	include DataMapper::Resource
	include Folder
	# ==================== DataMapper Model Definition ==================== #
	#  Manually set the table name
	storage_names[:default]='calendar_folders'
	property :folderId, String, :key => true
	property :parentId, String
	property :displayName, String
	property :syncState, String
	# ===================================================================== #
	
	# initialize with an item of CalendarFolderType
	def initialize(cal_folder)
		@folderId = self.folderId = cal_folder.folderId.xmlattr_Id
		@parentId = self.parentId = cal_folder.parentFolderId.xmlattr_Id unless cal_folder.parentFolderId == nil
		@displayName = self.displayName = cal_folder.displayName
		self.save
	end

	def sync_folder(max_items = 64)
		begin
			# ItemResponseShapeType
			itemshapeT = ItemResponseShapeType.new(DefaultShapeNamesType::Default, false)
 
			# TargetFolderIdType
			tfolderidT = TargetFolderIdType.new
			folderidT = FolderIdType.new
			folderidT.xmlattr_Id = self.folderId
			tfolderidT.folderId = folderidT

			# SyncFolderItemsType
			syncitemsT = SyncFolderItemsType.new(itemshapeT,tfolderidT,self.syncState,nil,max_items)

			# Call Sync => returns SyncFolderItemsResponseType
			resp = Viewpoint.instance.ews.syncFolderItems(syncitemsT).responseMessages.syncFolderItemsResponseMessage[0]
			self.syncState = resp.syncState
			self.save
			return resp
		rescue
			puts "** Something happened during synchronizing folder => #{@displayName}"
			raise
		end
	end
end

=begin

class CalendarItem
	include Item
	include DataMapper::Resource

	# ==================== DataMapper Model Definition ==================== #
	#  Manually set the table name
	storage_names[:default]='calendar_items'
	property :itemId, String, :key => true
	property :folderId, String
	# ===================================================================== #
end
=end
