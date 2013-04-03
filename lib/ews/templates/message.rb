module Viewpoint::EWS
  module Template
    class Message < OpenStruct

      def initialize(opts = {})
        super opts.clone
        init_defaults!
      end

      # Format this object for EWS backend consumption.
      def to_ews
        ews_opts = {}

        ews_opts[:message_disposition] = (draft ? 'SaveOnly' : 'SendAndSaveCopy')

        if saved_item_folder_id
          if saved_item_folder_id.kind_of?(Hash)
            ews_opts[:saved_item_folder_id] = saved_item_folder_id
          else
            ews_opts[:saved_item_folder_id] = {id: saved_item_folder_id}
          end
        end

        msg = {}
        msg[:subject] = subject
        msg[:body] = {text: body, body_type: body_type}

        to_r = to_recipients.collect{|r| {mailbox: {email_address: r}}}
        msg[:to_recipients] = to_r unless to_r.empty?

        cc_r = cc_recipients.collect{|r| {mailbox: {email_address: r}}}
        msg[:cc_recipients] = cc_r unless cc_r.empty?

        bcc_r = bcc_recipients.collect{|r| {mailbox: {email_address: r}}}
        msg[:bcc_recipients] = bcc_r unless bcc_r.empty?

        ews_opts.merge({items: [{message: msg}]})
      end

      def has_attachments?
        !(file_attachments.empty? && item_attachments.empty?)
      end


      private


      def init_defaults!
        self.subject ||= ""
        self.body ||= ""
        self.body_type ||= 'Text'
        self.draft ||= false
        self.to_recipients ||= []
        self.cc_recipients ||= []
        self.bcc_recipients ||= []
        self.file_attachments ||= []
        self.item_attachments ||= []
      end

    end
  end
end
