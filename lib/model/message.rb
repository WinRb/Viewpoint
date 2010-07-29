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
    class Message < Item

      # Initialize an Exchange Web Services item of type Message
      def initialize(ews_item)
        super(ews_item)
        init_methods
      end


      # Output the message in RFC 822 format: http://www.ietf.org/rfc/rfc0822.txt
      def to_rfc822
        get_message if @message == nil
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

      private

      def init_methods
        super()
        define_str_var :conversation_index, :conversation_topic, :internet_message_id, :references
        define_mbox_users :to_recipients, :cc_recipients, :bcc_recipients, :reply_to
        define_mbox_user :from, :sender, :received_by, :received_representing
        define_bool_var :is_read, :is_read_receipt_requested, :is_response_requested, :is_delivery_receipt_requested
      end

    end # Message
  end # EWS
end # Viewpoint
