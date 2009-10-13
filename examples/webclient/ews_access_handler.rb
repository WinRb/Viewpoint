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
require File.dirname(__FILE__) + '/../../lib/viewpoint'
include Viewpoint
require 'dm-core'
require 'dm-timestamps'

module Viewpoint::WEB
	# This class will facilitate handling EWS NTLM credentials on the server
	# so we don't have to store passwords in the browser session cookie.
	class EWSAccessHandler
		include DataMapper::Resource

		# ==================== DataMapper Model Definition ==================== #
		# Manually set the table name or else you will get 'comment_monster_articles'
		storage_names[:default]='ews_access_handler'

		property :session_id, String, :key => true
		property :user, String
		property :pass, String
		property :endpoint, String
		timestamps :created_at
		# ===================================================================== #
	end
end
