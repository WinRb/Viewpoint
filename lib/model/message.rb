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

      # Send an E-mail message
      #
      # @param [String] subject The message subject
      # @param [String] body The message body
      # @param [Array] to_recipients An array of e-mail addresses to send to
      # @param [Array] cc_recipients An array of e-mail addresses to send to
      # @param [Array] bcc_recipients An array of e-mail addresses to send to
      # @param [Array<File>] file_attachments An array of File objects to read data from that
      #   will attach to this message.
      # @return [Message,true] Returns true if the message is sent, if draft is true it will return the Message object
      #   or it raises an error with a message stating why the e-mail could not be sent.
      def self.send(subject, body, to_recipients, cc_recipients=[], bcc_recipients=[], file_attachments=nil, draft=false)
        item = {}
        item[:subject] = {:text => subject}
        item[:body] = {:text => body, :body_type => 'Text'} unless body.nil?
        to_recipients.each do |a|
          item[:to_recipients] = [] unless item[:to_recipients].is_a?(Array)
          item[:to_recipients] << {:mailbox => {:email_address => {:text => a}}}
        end
        cc_recipients.each do |a|
          item[:cc_recipients] = [] unless item[:cc_recipients].is_a?(Array)
          item[:cc_recipients] << {:mailbox => {:email_address => {:text => a}}}
        end unless cc_recipients.nil?
        bcc_recipients.each do |a|
          item[:bcc_recipients] = [] unless item[:bcc_recipients].is_a?(Array)
          item[:bcc_recipients] << {:mailbox => {:email_address => {:text => a}}}
        end unless bcc_recipients.nil?
        
        conn = Viewpoint::EWS::EWS.instance
        resp = conn.ews.create_message_item(:drafts, item, 'SaveOnly')
        (resp.status == 'Success') || (raise EwsError, "Could not send message. #{resp.code}: #{resp.message}")
        msg_key = resp.items.first.keys.first
        msg_id = resp.items.first[msg_key][:item_id]
        msg_id = add_attachments(msg_id, file_attachments) unless file_attachments.nil?
        if !draft
          resp = conn.ews.send_item([msg_id])
          (resp.status == 'Success') || (raise EwsError, "Could not send message. #{resp.code}: #{resp.message}")
        else
          self.new({:item_id => msg_id})
        end
      end

      # Initialize an Exchange Web Services item of type Message
      def initialize(ews_item)
        super(ews_item)
      end

      def headers
        deepen! if @shallow
        return @headers if defined?(@headers) && !@headers.empty?
        @headers = {}
        # @todo When ruby 1.9 becomes more pervasive the Enumerator#each_with_object
        #@headers ||= @ews_item[:internet_message_headers][:internet_message_header].each_with_object({}) do |h,obj|
        @ews_item[:internet_message_headers][:internet_message_header].each do |h|
          @headers[h[:header_name]] = h[:text]
        end
        @headers
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
