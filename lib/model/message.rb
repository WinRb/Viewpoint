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
        msg_id = add_attachments(msg_id, file_attachments) unless (file_attachments.nil? || file_attachments.empty?)
        if !draft
          resp = conn.ews.send_item([msg_id])
          (resp.status == 'Success') || (raise EwsError, "Could not send message. #{resp.code}: #{resp.message}")
        else
          self.new({:item_id => msg_id})
        end
      end

      # Initialize an Exchange Web Services item of type Message
      def initialize(ews_item, opts={})
        super(ews_item, opts)
      end

      def headers
        deepen! if @shallow
        return @headers if defined?(@headers) && !@headers.empty?
        return nil unless @ews_item.has_key?(:internet_message_headers)
        @headers = {}
        # @todo When ruby 1.9 becomes more pervasive the Enumerator#each_with_object
        #@headers ||= @ews_item[:internet_message_headers][:internet_message_header].each_with_object({}) do |h,obj|
        @ews_item[:internet_message_headers][:internet_message_header].each do |h|
          @headers[h[:header_name]] = h[:text]
        end
        @headers
      end


      # This creates an object of type Mail (mail gem) and allows us to
      # manipulate and output Message Items in standards compliant ways.
      # @see http://www.ietf.org/rfc/rfc2822.txt
      def to_mail
        mail = Mail.new
        unless(headers.nil?)
          mail.received  headers['Received']
          mail.content_type headers['Content-Type']
          mail.content_transfer_encoding headers['Content-Transfer-Encoding']
        end
        mail.date date_time_sent unless date_time_sent.nil?
        mail.message_id internet_message_id unless internet_message_id.nil?
        mail.in_reply_to in_reply_to unless in_reply_to.nil?
        mail.references references unless references.nil?
        mail.subject subject unless subject.nil?
        mail.return_path = sender.email_address unless(sender.nil? || ! sender.respond_to?(:email_address))
        mail.to to_recipients.map {|r| r.email_address if r.respond_to?(:email_address) } unless to_recipients.nil?
        mail.cc cc_recipients.map {|r| r.email_address if r.respond_to?(:email_address) } unless cc_recipients.nil?
        mail.from from.email_address unless(from.nil? || ! from.respond_to?(:email_address))
        # Because the mail gem does not pass an object to the block there are some issues with using self
        msg = self
        if(body_type == "HTML")
          mail.html_part do
            body msg.body
          end
          mail.text_part do
            body Nokogiri::HTML(msg.body).content
          end
        else
          mail.text_part do
            body msg.body
          end
        end

        # add attachments
        if(self.has_attachments?)
          self.attachments.each do |att|
            if(att.is_a?(FileAttachment))
              mail.attachments[att.file_name] = Base64.decode64(att.content)
            end
          end
        end
        mail
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
