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
require 'icalendar'
require 'viewpoint'
require 'item'

class Viewpoint::CalendarItem < Viewpoint::Item
	include Viewpoint

	attr_reader :subject, :parent_folder, :sender
	attr_reader :ews_item if $DEBUG

	# Initialize an Exchange Web Services item
	def initialize(ews_item, parent_folder)
		# keep this now for debuging
		@ews_item = ews_item if $DEBUG
		@subject = ews_item.subject # String
		@location = ews_item.location
		@cal_item_type = ews_item.calendarItemType
		@organizer = ews_item.organizer.mailbox.name # String
		@start = ews_item.start # DateTime
		@end = ews_item.v_end # DateTime
		@busy_status = ews_item.legacyFreeBusyStatus # String
		@date_time_recieved = ews_item.dateTimeReceived # DateTime

		# This is where the event object gets loaded if it
		# is requested.  Think of it like IMAP downloading the
		# body when the message is viewed.
		@message = nil

		super(ews_item, parent_folder)
	end

	def get_calitem
		@message = @parent_folder.get_item(@item_id)
	end

	# Convert item to iCal format: http://www.ietf.org/rfc/rfc2445.txt
	# Returns Icalendar::Event object
	def to_ical_event
		get_calitem if @message == nil
		puts "MESSAGE: #{@message.class.to_s}"
		iev = Icalendar::Event.new
		iev.uid = @message.uID
		iev.organizer = "CN=\"#{@message.organizer.mailbox.name}\":MAILTO:#{@message.organizer.mailbox.emailAddress}"
		# TODO: Handle EWS Timezones better.  TZ_HASH in viewpoint.rb is the start of this
		require 'time'
		dtstart = Time.at(@message.start.strftime('%s').to_i)
		dtend   = Time.at(@message.v_end.strftime('%s').to_i)
		dtstamp = Time.at(@message.dateTimeStamp.strftime('%s').to_i)
		last_modified = Time.at(@message.lastModifiedTime.strftime('%s').to_i)
		iev.dtstart = dtstart.strftime('%Y%m%d%H%M%S%Z')
		iev.dtend   = dtend.strftime('%Y%m%d%H%M%S%Z')
		iev.tzid    = dtstart.strftime('%Z')
		iev.dtstamp = dtstamp.strftime('%Y%m%d%H%M%S%Z')
		iev.last_modified = last_modified.strftime('%Y%m%d%H%M%S%Z')
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
			iev.attendees << "ROLE=REQ-PARTICIPANT;CN=\"#{pers.mailbox.name}\":MAILTO:#{pers.mailbox.emailAddress}"
		end if @message.requiredAttendees
		@message.optionalAttendees.each do |pers|
			iev.attendees << "ROLE=OPT-PARTICIPANT;CN=\"#{pers.mailbox.name}\":MAILTO:#{pers.mailbox.emailAddress}"
		end if @message.optionalAttendees

		iev.categories = @message.categories if @message.categories
		iev.resources  = @message.resources if @message.resources
		return iev
	end
end
