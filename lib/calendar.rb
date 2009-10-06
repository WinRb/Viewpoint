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

end


=begin
class CalendarItem
	include Item
	include DataMapper::Resource

	# ==================== DataMapper Model Definition ==================== #
	#  Manually set the table name
	#storage_names[:default]='calendar_items'
	#property :itemId, String, :key => true
	#property :folderId, String
	# ===================================================================== #
end
=end
