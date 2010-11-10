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
    class MeetingRequest < Item


      private

      def init_methods
        super()
        define_str_var :conversation_index, :conversation_topic, :internet_message_id, :references
        define_mbox_users :to_recipients, :cc_recipients, :bcc_recipients, :reply_to, :required_attendees, :optional_attendees
        define_mbox_user :from, :sender, :received_by, :received_representing, :organizer
        define_bool_var :is_read, :is_read_receipt_requested, :is_response_requested, :is_delivery_receipt_requested, :is_draft, :is_from_me
        define_bool_var :is_all_day_event, :is_cancelled, :is_delegated, :is_meeting, :is_out_of_date, :is_recurring, :is_resend
        define_bool_var :is_submitted, :is_unmodified, :allow_new_time_proposal
        define_int_var :adjacent_meeting_count, :appointment_sequence_number, :appointment_state, :conflicting_meeting_count
        define_datetime_var :start, :end
      end
    end # MeetingRequest
  end # EWS
end # Viewpoint
