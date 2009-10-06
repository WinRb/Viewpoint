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
	# ==================== DataMapper Model Definition ==================== #
	#  Manually set the table name
	storage_names[:default]='folders'
	property :folder_id, String, :key => true
	property :parent_id, String
	property :display_name, String
	property :folder_type, Discriminator
	property :sync_state, String
	# ===================================================================== #

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
end
