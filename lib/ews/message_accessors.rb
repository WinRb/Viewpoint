=begin
  This file is part of Viewpoint; the Ruby library for Microsoft Exchange Web Services.

  Copyright © 2011 Dan Wanek <dan.wanek@gmail.com>

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
=end
module Viewpoint::EWS::MessageAccessors
  include Viewpoint::EWS

  # Send an E-mail message
  #
  # @param [Hash] opts A Hash with message params
  # @option opts [String] :subject The message subject
  # @option opts [String] :body The message body
  # @option opts [Array] :to_recipients An array of e-mail addresses to send to
  # @option opts [Array] :cc_recipients An array of e-mail addresses to send to
  # @option opts [Array] :bcc_recipients An array of e-mail addresses to send to
  # @option opts [Boolean] :draft if true it will save to the draft folder
  #   without sending the message.
  # @option opts [Array<File>] file_attachments An array of File objects to
  #   read data from that will attach to this message.
  # @return [Message,true] Returns true if the message is sent, if draft is
  #   true it will return the Message object or it raises an error with a
  #   message stating why the e-mail could not be sent.
  def send_message(opts)
    msg = set_message_params(opts)
    disposition = opts[:draft] ? 'SaveOnly' : 'SendAndSaveCopy'
    resp = ews.create_item(:items => [{:message => msg}], :message_disposition => disposition)
    return resp
    if(resp.status == 'Success')
      #msg_key = resp.items.first.keys.first
      #msg_id = add_attachments(msg_id, file_attachments) unless (file_attachments.nil? || file_attachments.empty?)
      #Message.new(ews,resp.items.first[msg_key])
    else
      raise EwsError, "Could not send message. #{resp.code}: #{resp.message}"
    end
  end


private

  def set_message_params(mopts)
    msg = {}
    msg[:subject] = mopts[:subject] if mopts[:subject]
    msg[:body] = {:text => mopts[:body]} if mopts[:body]
    msg[:body][:body_type] = (mopts[:body_type] ? mopts[:body_type] : 'Text')
    (msg[:to_recipients] = []) && mopts[:to_recipients].each do |a|
      msg[:to_recipients] << {:mailbox => {:email_address => a}}
    end
    (msg[:cc_recipients] = []) && mopts[:cc_recipients].each do |a|
      msg[:cc_recipients] << {:mailbox => {:email_address => a}}
    end if mopts[:cc_recipients]
    (msg[:bcc_recipients] = []) && mopts[:bcc_recipients].each do |a|
      msg[:bcc_recipients] << {:mailbox => {:email_address => a}}
    end if mopts[:bcc_recipients]
    msg
  end

end # Viewpoint::EWS::MessageAccessors
