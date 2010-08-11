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

      # This is a class method that creates a new CalendarItem in the Exchange Data Store.
      # @param [Hash] item A Hash of values based on values found here:
      #   http://msdn.microsoft.com/en-us/library/aa564765.aspx
      # @param [String, Symbol] folder_id The folder to create this item in. Either a
      #   DistinguishedFolderId (must me a Symbol) or a FolderId (String)
      # @param [String] send_invites "SendToNone/SendOnlyToAll/SendToAllAndSaveCopy"
      #   See:  http://msdn.microsoft.com/en-us/library/aa565209.aspx
      # @example Typical Usage
      #   item = { :subject => {:text => 'Planning'},
      #     :body => {:body_type => 'Text', :text => 'This is a test'},
      #     :start => {:text => '2010-07-29T14:00:00'},
      #     :end => {:text => '2010-07-29T15:00:00'},
      #     :is_all_day_event => {:text => 'false'},
      #     :location => {:text => 'Room 234'},
      #     :required_attendees => {:attendee => {:mailbox => {:email_address => {:text => 'test@test.com'}}}}
      #   }
      # @example Minimal Usage
      #   item = { :subject => {:text => 'Planning'},
      #     :start => {:text => '2010-07-29T14:00:00'},
      #     :end => {:text => '2010-07-29T15:00:00'}
      #   }
      def self.create_item_from_hash(item, folder_id = :calendar, send_invites = 'SendToAllAndSaveCopy')
        conn = Viewpoint::EWS::EWS.instance
        resp = conn.ews.create_calendar_item(folder_id, item, send_invites)
        if(resp.status == 'Success')
          resp = resp.items.shift
          self.new(resp[resp.keys.first])
        else
          raise EwsError, "Could not create CalendarItem. #{resp.code}: #{resp.message}"
        end
      end

      # Create a new CalendarItem.
      # @param [DateTime] v_start The date and time when the CalendarItem begins
      # @param [DateTime] v_end The date and time when the CalendarItem ends
      # @param [String] subject The subject of this Item
      # @param [String,optional] body The body of this object
      # @param [String,optional] location The location where this calendar item will ocurr
      # @param [Array<String>,optional] required_attendees An Array of e-mail addresses of required attendees
      # @param [Array<String>,optional] optional_attendees An Array of e-mail addresses of optional attendees
      # @param [Array<String>,optional] resources An Array of e-mail addresses of resources
      def self.create_item(v_start, v_end, subject, body = nil, location = nil, required_attendees=[], optional_attendees=[], resources=[])
        item = {}
        item[:start] = {:text => v_start.to_s}
        item[:end] = {:text => v_end.to_s}
        item[:subject] = {:text => subject}
        item[:body] = {:text => body, :body_type => 'Text'} unless body.nil?
        item[:location] = {:text => location} unless location.nil?
        required_attendees.each do |a|
          item[:required_attendees] = [] unless item[:required_attendees].is_a?(Array)
          item[:required_attendees] << {:attendee => {:mailbox => {:email_address => {:text => a}}}}
        end
        optional_attendees.each do |a|
          item[:optional_attendees] = [] unless item[:optional_attendees].is_a?(Array)
          item[:optional_attendees] << {:attendee => {:mailbox => {:email_address => {:text => a}}}}
        end
        resources.each do |a|
          item[:resources] = [] unless item[:resources].is_a?(Array)
          item[:resources] << {:attendee => {:mailbox => {:email_address => {:text => a}}}}
        end
        puts item
        self.create_item_from_hash(item)
      end

      # Initialize an Exchange Web Services item of type CalendarItem
      def initialize(ews_item)
        super(ews_item)
      end
      
      # Delete this item
      # @param [Boolean] soft Whether or not to do a soft delete.  By default EWS will do a 
      #   hard delete of this item.  See the MSDN docs for more info:
      #   http://msdn.microsoft.com/en-us/library/aa562961.aspx
      # @param [String] cancel_type "SendToNone/SendOnlyToAll/SendToAllAndSaveCopy"
      #   Default is SendOnlyToAll
      # @return [Boolean] Whether or not the item was deleted
      # @todo Add exception handling for failed deletes
      #
      def delete!(soft=false, cancel_type='SendOnlyToAll')
        deltype = soft ? 'SoftDelete' : 'HardDelete'
        resp = (Viewpoint::EWS::EWS.instance).ews.delete_item([@item_id], deltype, cancel_type)
        self.clear_object!
        resp.status == 'Success'
      end

      # Delete this item by moving it to the Deleted Items folder
      # @see  http://msdn.microsoft.com/en-us/library/aa562961.aspx
      # @return [Boolean] Whether or not the item was deleted
      # @todo Add exception handling for failed deletes
      def recycle!(cancel_type='SendOnlyToAll')
        resp = (Viewpoint::EWS::EWS.instance).ews.delete_item([@item_id], 'MoveToDeletedItems', cancel_type)
        self.clear_object!
        resp.status == 'Success'
      end


      private

      def init_methods
        super
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
