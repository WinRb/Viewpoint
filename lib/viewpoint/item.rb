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
class Viewpoint::Item
	include Viewpoint

	attr_accessor :item_id

	# Initialize an Exchange Web Services item
	def initialize(ews_item, parent_folder)
		@item_id = ews_item.itemId.xmlattr_Id
		@parent_folder = parent_folder
	end

	# Takes an object of type Viewpoint::Folder as an argument
	# Returns a boolean value, true if the move ocurred, false otherwise.
	def move_to!(new_folder)
		retval = @parent_folder.move_item(@item_id, new_folder)
		@parent_folder = new_folder if retval

		return retval
	end


	# Return the OWA ID so we can link to webmail
	def owa_id
		vp = ExchWebServ.instance
		altids_ar = NonEmptyArrayOfAlternateIdsType.new
		
		altid_t = AlternateIdType.new
		altid_t.xmlattr_Format = IdFormatType::EwsId
		altid_t.xmlattr_Id = @item_id
		altid_t.xmlattr_Mailbox = vp.email
		altids_ar.alternateId << altid_t
		
		convertid_t = ConvertIdType.new(altids_ar)
		convertid_t.xmlattr_DestinationFormat = IdFormatType::OwaId
		
		resp = vp.ews.convertId(convertid_t)
		resp.responseMessages.convertIdResponseMessage.first.alternateId.xmlattr_Id
		#uri = "https://host/owa/?ae=Item&a=open&id=" + owa_id
	end


	# Returns a boolean value, true if the delete ocurred, false otherwise.
	def delete!
		@parent_folder.delete_item(@item_id)
	end

	# Returns a boolean value, true if the recycle ocurred, false otherwise.
	def recycle!
		@parent_folder.recycle_item(@item_id)
	end
end
