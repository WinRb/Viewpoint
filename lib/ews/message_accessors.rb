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
  # @option opts [String,Symbol,Hash] saved_item_folder_id Either a
  #   FolderId(String) or a DistinguishedFolderId(Symbol). You can also pass a
  #   Hash in the form: {id: <fold_id>, change_key: <change_key>}
  # @option opts [Array<File>] file_attachments An array of File objects to
  #   read data from that will attach to this message.
  # @return [Message,Boolean] Returns true if the message is sent, false if
  #   nothing is returned from EWS or if draft is true it will return the
  #   Message object. Finally, if something goes wrong, it raises an error
  #   with a message stating why the e-mail could not be sent.
  def send_message(opts)
    opts = opts.clone
    ews_opts = set_create_item_params(opts)
    yield ews_opts if block_given?
    resp = ews.create_item(ews_opts)
    resp.response_messages ?  parse_create_item(resp) : false
  end


  private


  def set_create_item_params(opts)
    ews_opts = {}
    set_disposition!(ews_opts, opts)
    set_saved_item_folder_id!(ews_opts, opts)

    msg = {}
    msg[:subject] = opts[:subject] if opts[:subject]
    msg[:body] = {:text => opts[:body]} if opts[:body]
    msg[:body][:body_type] = (opts[:body_type] ? opts[:body_type] : 'Text')
    (msg[:to_recipients] = []) && opts[:to_recipients].each do |a|
      msg[:to_recipients] << {:mailbox => {:email_address => a}}
    end
    (msg[:cc_recipients] = []) && opts[:cc_recipients].each do |a|
      msg[:cc_recipients] << {:mailbox => {:email_address => a}}
    end if opts[:cc_recipients]
    (msg[:bcc_recipients] = []) && opts[:bcc_recipients].each do |a|
      msg[:bcc_recipients] << {:mailbox => {:email_address => a}}
    end if opts[:bcc_recipients]

    ews_opts.merge!({items: [{message: msg}]})
  end

  def set_disposition!(ews_opts, opts)
    if(opts[:draft] || opts[:file_attachments] || opts[:item_attachments])
      d = 'SaveOnly'
    else
      d = 'SendAndSaveCopy'
    end
    ews_opts[:message_disposition] = d
  end

  def set_saved_item_folder_id!(ews_opts, opts)
    if (fid = opts[:saved_item_folder_id])
      if fid.kind_of?(Hash)
        ews_opts[:saved_item_folder_id] = fid
      else
        ews_opts[:saved_item_folder_id] = {id: fid}
      end
    end
  end

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

end # Viewpoint::EWS::MessageAccessors
