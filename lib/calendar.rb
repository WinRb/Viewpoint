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
# --- Folder Types ---
require 'folder'
# --- Item Types ---
require 'calendar_item'
#require 'meeting_request'



class CalendarFolder < Folder
	#include DataMapper::Resource

	# Make sure this is the last include or "initialize" will not work in the
	# Folder module by calling "super"
	#include Folder

	# initialize with an item of CalendarFolderType
	def initialize(folder)
		# Call initialize in the 
		super(folder)
	end

	def get_todays_events
		get_events(DateTime.parse(Date.today.to_s).to_s, DateTime.parse(Date.today.next.to_s).to_s)
	end

	def get_weeks_events
		start_date = Date.today
		end_date = (start_date + ( 6 - start_date.wday))

		get_events(DateTime.parse(start_date.to_s).to_s, DateTime.parse(end_date.to_s).to_s)
	end

	# Get events between a certain time period.  Defaults to "today"
	# This method will return an Array of type (CalendarItemType)
	def get_events(start_time = (DateTime.parse(Date.today.to_s).to_s), end_time = (DateTime.parse(Date.today.next.to_s).to_s))
		find_item_t = FindItemType.new
		find_item_t.xmlattr_Traversal = ItemQueryTraversalType::Shallow
		item_shape = ItemResponseShapeType.new(DefaultShapeNamesType::Default, false)
=begin
		additional_props = NonEmptyArrayOfPathsToElementType.new
		prop_a = PathToUnindexedFieldType.new
		prop_b = PathToUnindexedFieldType.new
		prop_c = PathToUnindexedFieldType.new
		prop_d = PathToUnindexedFieldType.new
		prop_e = PathToUnindexedFieldType.new
		prop_a.xmlattr_FieldURI = UnindexedFieldURIType::ItemSubject
		prop_b.xmlattr_FieldURI = UnindexedFieldURIType::ItemDateTimeReceived
		prop_c.xmlattr_FieldURI = UnindexedFieldURIType::MessageSender 
		prop_d.xmlattr_FieldURI = UnindexedFieldURIType::MessageFrom
		prop_e.xmlattr_FieldURI = UnindexedFieldURIType::CalendarCalendarItemType
		additional_props << prop_a
		additional_props << prop_b
		additional_props << prop_c
		additional_props << prop_d
		additional_props << prop_e
		item_shape.additionalProperties = additional_props
=end
		find_item_t.itemShape = item_shape


		
		folder_ids = NonEmptyArrayOfBaseFolderIdsType.new()
		dist_folder = DistinguishedFolderIdType.new
		dist_folder.xmlattr_Id = DistinguishedFolderIdNameType.new(self.display_name.downcase)
		folder_ids.distinguishedFolderId = dist_folder
		find_item_t.parentFolderIds = folder_ids
		
		cal_span =  CalendarViewType.new
		cal_span.xmlattr_StartDate = DateTime.parse(Date.today.to_s).to_s
		cal_span.xmlattr_EndDate = DateTime.parse(Date.today.next.to_s).to_s
		find_item_t.calendarView = cal_span

		resp = find_items(find_item_t)
		if resp != nil
			cal_items = []

			resp.rootFolder.items.calendarItem.each do |cali|
				cal_items << CalendarItem.new(cali, self.folder_id)
			end
			# TODO: Handle the following types of Calendar data
			# meetingMessage
			# meetingRequest
			# meetingResponse
			# meetingCancellation

			return cal_items
		else
			return resp
		end
	end

	def get_item(item_id)
		super(item_id, "calendarItem")
	end
end

