module Viewpoint::EWS
  module Template
    class ReplyToItem < Message

      # Format this object for EWS backend consumption.
      def to_ews
        ews_opts, msg = to_ews_basic
        msg[:reference_item_id] = reference_item_id
        msg[:new_body_content]  = {text: new_body_content, body_type: new_body_type}
        msg.delete(:is_read)
        ews_opts.merge({items: [{ews_type => msg}]})
      end

      private


      def init_defaults!
        super
        self.new_body_content ||= ''
        self.new_body_type ||= 'HTML'
        self.ews_type = :reply_to_item
        self.importance = nil
        self.extended_properties = []
      end

    end
  end
end
