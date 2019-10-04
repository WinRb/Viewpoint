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
  # @option opts [Array] :extended_properties An array of extended properties
  #   [{extended_field_uri: {epros}, value: <val>}] or values: [<val>, <val>]
  # @option opts [Boolean] :draft if true it will save to the draft folder
  #   without sending the message.
  # @option opts [String,Symbol,Hash] saved_item_folder_id Either a
  #   FolderId(String) or a DistinguishedFolderId(Symbol). You can also pass a
  #   Hash in the form: {id: <fold_id>, change_key: <change_key>}
  # @option opts [Array<File>] :file_attachments an Array of File or Tempfile objects
  # @option opts [Array<File>] :inline_attachments an Array of Inline File or Tempfile objects
  # @return [Message,Boolean] Returns true if the message is sent, false if
  #   nothing is returned from EWS or if draft is true it will return the
  #   Message object. Finally, if something goes wrong, it raises an error
  #   with a message stating why the e-mail could not be sent.
  # @todo Finish ItemAttachments
  def send_message(opts = {}, &block)
    msg = Template::Message.new opts.clone
    yield msg if block_given?
    if msg.has_attachments? || opts[:return_message_id]
      draft = msg.draft
      msg.draft = true
      create_item_response = ews.create_item(msg.to_ews)
      sent_message_id = fetch_message_id_from_response(create_item_response)
      resp = parse_create_item(create_item_response)
      msg.file_attachments.each do |attachment|
        if attachment.kind_of?(Hash)
          resp.file_attachment_from_hash(attachment)
        elsif attachment.kind_of?(File) || attachment.kind_of?(Tempfile)
          resp.file_attachment_from_file(attachment)
        else
          next
        end
      end
      msg.inline_attachments.each do |attachment|
        if attachment.kind_of?(Hash)
          resp.inline_attachment_from_hash(attachment)
        elsif attachment.kind_of?(File) || attachment.kind_of?(Tempfile)
          resp.inline_attachment_from_file(attachment)
        else
          next
        end
      end
      if draft
        submit_response = resp.submit_attachments!
        return sent_message_id if opts[:return_message_id] && submit_response
        resp
      else
        submit_response = resp.submit!
        return sent_message_id if opts[:return_message_id] && submit_response
        submit_response
      end
    else
      resp = ews.create_item(msg.to_ews)
      resp.response_messages ?  parse_create_item(resp) : false
    end
  end

  # See #send_message for options
  def draft_message(opts = {}, &block)
    send_message opts.merge(draft: true), &block
  end


  private


  def parse_create_item(resp)
    rm = resp.response_messages[0]
    if(rm.status == 'Success')
      rm.items.empty? ? true : parse_message(rm.items.first)
    else
      raise EwsError, "Could not send message. #{rm.code}: #{rm.message_text}"
    end
  end

  def parse_message(msg)
    mtype = msg.keys.first
    message = class_by_name(mtype).new(ews, msg[mtype])
  end

  def fetch_message_id_from_response(resp)
    resp.response_messages[0].items.first[:message][:elems].first[:item_id][:attribs][:id]
  end
end # Viewpoint::EWS::MessageAccessors
