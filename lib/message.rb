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
require 'item'
require 'viewpoint'

class Viewpoint::Message < Viewpoint::Item
	include Viewpoint

	attr_reader :subject, :parent_folder, :sender, :date_time_recieved
	attr_reader :ews_item if $DEBUG

	# Initialize an Exchange Web Services item of MessageType
	def initialize(ews_item, parent_folder)
		# keep this now for debuging
		@ews_item = ews_item if $DEBUG
		@subject = ews_item.subject # String
		@sender = ews_item.sender.mailbox.name if ews_item.sender # String
		@recipients = 
		@is_read = ews_item.isRead  # boolean
		@date_time_recieved = ews_item.dateTimeReceived # DateTime

		# This is where the entire message object gets loaded if it
		# is requested.  Think of it like IMAP downloading the
		# body when the message is viewed.
		@message = nil

		super(ews_item, parent_folder)
	end

	def body
		get_message if @message == nil
		return @message.body
	end

	def recipients
		get_message if @message == nil
		to_recipients = ''
		@message.toRecipients.each do |r|
			to_recipients += ', ' if to_recipients != ''
			to_recipients += "#{r.name} <#{r.emailAddress}>"
		end

		return to_recipients
	end

	def cc_recipients
		get_message if @message == nil
		if( @message.ccRecipients != nil)
			cc = ''
			@message.ccRecipients.each do |r|
				cc += ', ' if cc != ''
				cc += "#{r.name} <#{r.emailAddress}>"
			end
			return cc
		end
		return nil
	end

	def bcc_recipients
		get_message if @message == nil
		if( @message.bccRecipients != nil)
			bcc = ''
			@message.bccRecipients.each do |r|
				bcc += ', ' if bcc != ''
				bcc += "#{r.name} <#{r.emailAddress}>"
			end
			return bcc
		end
		return nil
	end

	def get_message
		@message = @parent_folder.get_item(@item_id)
	end

	# Output the message in RFC 822 format: http://www.ietf.org/rfc/rfc0822.txt
	def to_rfc822
		get_message if @message == nil
		puts "MESSAGE: #{@message.class.to_s}"
		rfc822 = []
		rfc822.push 'Return-Path'  => @message.sender.mailbox.emailAddress
		rfc822.push 'Delivered-To' => @message.receivedBy.mailbox.emailAddress
		@message.internetMessageHeaders.each do |hdr|
			# TODO: Quick Fix... needs more research
			if( hdr.xmlattr_HeaderName == 'Content-Type' && hdr =~ /tnef/ )
				rfc822.push hdr.xmlattr_HeaderName => 'multipart/alternative'
			else
				rfc822.push hdr.xmlattr_HeaderName => hdr
			end
		end

		# From
		rfc822.push 'From'  => "#{@message.sender.mailbox.name} <#{@message.sender.mailbox.emailAddress}>"

		# To
		rfc822.push 'To' => self.recipients

		# CC
		if( ( cc = self.cc_recipients) != nil)
			rfc822.push 'Cc' => cc
		end

		# BCC
		if( ( bcc = self.bcc_recipients) != nil)
			rfc822.push 'Bcc' => bcc
		end

		rfc822_msg = ""
		rfc822.each do |line|
			line.each_pair do |key,val|
				rfc822_msg += "#{key}: #{val}\n"
			end
		end

		rfc822_msg += "\n\n#{@message.body}"
	end
end
