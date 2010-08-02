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

module Viewpoint
  module EWS
    class CalendarFolder < GenericFolder

      # initialize with an item of CalendarFolderType
      def initialize(folder)
        super(folder)

        # @todo Handle:
        #   <SharingEffectiveRights/>
      end

      # Find Items
      # @see GenericFolder#find_items
      def find_items(start_date = nil, end_date = nil)
        opts ||= {}
        if(!start_date.nil? && !end_date.nil?)
          opts = {:calendar_view => {:max_entries_returned => 256, :start_date => start_date, :end_date => end_date}}
        end
        super(opts)
      end

    end # CalendarFolder
  end # EWS
end # Viewpoint
