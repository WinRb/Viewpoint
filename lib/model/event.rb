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
    class Event < Item

      attr_reader :subject, :organizer, :location, :start, :end, :cal_item_type

      # Initialize an Exchange Web Services item
      def initialize(ews_item, parent_folder)
        raise InvalidEWSItemError if ews_item.nil?

        @subject = ews_item.subject # String
        @location = ews_item.location if ews_item.location
        @cal_item_type = ews_item.calendarItemType
        @organizer = ews_item.organizer.mailbox.name if ews_item.organizer and ews_item.organizer.mailbox # String
        @start = ews_item.start if ews_item.start # DateTime
        @end = ews_item.v_end if ews_item.v_end # DateTime
        @busy_status = ews_item.legacyFreeBusyStatus if ews_item.legacyFreeBusyStatus # String
        @date_time_recieved = ews_item.dateTimeReceived if ews_item.dateTimeReceived # DateTime

        # This is where the event object gets loaded if it
        # is requested.  Think of it like IMAP downloading the
        # body when the message is viewed.
        @message = nil

        super(ews_item, :shallow => parent_folder)
      end



      def body
        get_calitem if @message == nil
        @message.body
      end

      def sender
        @organizer
      end


      # Convert item to iCal format: http://www.ietf.org/rfc/rfc2445.txt
      # Returns Icalendar::Event object
      def to_ical_event
        get_calitem if @message == nil
        iev = Icalendar::Event.new
        iev.uid = @message.uID
        unless(@message.organizer == nil)
          iev.organizer = "CN=\"#{@message.organizer.mailbox.name}\"" if @message.organizer.mailbox.name
          iev.organizer += ":MAILTO:#{@message.organizer.mailbox.emailAddress}" if @message.organizer.mailbox.emailAddress
        end
        # TODO: Handle EWS Timezones better.  TZ_HASH in viewpoint.rb is the start of this
        require 'time'
        #tzoffset = @message.timeZone.sub(/^\(GMT([^\)]+)\).*$/,'\1')
        dtstart = Time.at(@message.start.strftime('%s').to_i)
        dtend   = Time.at(@message.v_end.strftime('%s').to_i)
        dtstamp = Time.at(@message.dateTimeStamp.strftime('%s').to_i)
        last_modified = Time.at(@message.lastModifiedTime.strftime('%s').to_i)
        timestr = "%Y%m%dT%H%M%S"
        iev.dtstart = dtstart.strftime(timestr)
        iev.dtend   = dtend.strftime(timestr)
        iev.tzid    = dtstart.strftime('%Z')
        iev.dtstamp = dtstamp.strftime(timestr)
        iev.last_modified = last_modified.strftime(timestr)
        iev.location = @message.location if @message.location
        iev.klass = @message.sensitivity if @message.sensitivity
        iev.summary = @message.subject if @message.subject
        iev.description = @message.body if @message.body
        iev.transp = @message.legacyFreeBusyStatus if @message.legacyFreeBusyStatus
        iev.duration = @message.duration if @message.duration
        iev.sequence = @message.appointmentSequenceNumber if @message.appointmentSequenceNumber
        iev.status = @message.myResponseType if @message.myResponseType
        #iev.attach @message.attachments if @message.hasAttachments
        @message.requiredAttendees.each do |pers|
          output =  "ROLE=REQ-PARTICIPANT;CN=\"#{pers.mailbox.name}\"" if pers.mailbox.respond_to?(:name)
          output += ":MAILTO:#{pers.mailbox.emailAddress}" if pers.mailbox.respond_to?(:emailAddress)
          iev.attendees << output if output
        end if @message.requiredAttendees
        @message.optionalAttendees.each do |pers|
          output =  "ROLE=OPT-PARTICIPANT;CN=\"#{pers.mailbox.name}\"" if pers.mailbox.respond_to?(:name)
          output += ":MAILTO:#{pers.mailbox.emailAddress}" if pers.mailbox.respond_to?(:emailAddress)
          iev.attendees << output if output
        end if @message.optionalAttendees

        #iev.categories = @message.categories if @message.categories
        #iev.resources  = @message.resources if @message.resources
        return iev
      end


      # These methods are marked 'private' because they return EWS Types and I am trying to 
      # hide those because they are not elegant and a bit too tedious for the public interface.
      private

      def get_calitem
        @message = @parent_folder.get_item(@item_id)
      end
    end # Event
  end # EWS
end # Viewpoint
