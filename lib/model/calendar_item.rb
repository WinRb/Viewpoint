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
    class CalendarItem < Message

      # Initialize an Exchange Web Services item of type CalendarItem
      def initialize(ews_item)
        super(ews_item)
        define_str_var :calendar_item_type, :duration, :time_zone, :when, :location
        define_str_var :legacy_free_busy_status, :my_response_type, :meeting_workspace_url, :net_show_url
        define_int_var :adjacent_meeting_count, :appointment_sequence_number, :appointment_state
        define_int_var :conference_type, :conflicting_meeting_count
        define_mbox_user :organizer
        define_bool_var :is_all_day_event, :is_cancelled, :is_meeting, :is_online_meeting, :is_recurring
        define_bool_var :allow_new_time_proposal, :meeting_request_was_sent
        define_datetime_var :appointment_reply_time, :start, :end, :original_start

        # @todo Handle:
        #   <AdjacentMeetings/> <ConflictingMeetings/> <DeletedOccurrences/>
        #   <FirstOccurrence/> <LastOccurrence/> <ModifiedOccurrences/>
        #   <StartTimeZone/> <EndTimeZone/> <MeetingTimeZone/>
        #   <OptionalAttendees/> <RequiredAttendees/> <Resources/>
        #   <Recurrence/>

      end

    end # CalendarItem
  end # EWS
end # Viewpoint
