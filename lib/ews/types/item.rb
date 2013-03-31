module Viewpoint::EWS::Types
  module Item
    include Viewpoint::EWS
    include Viewpoint::EWS::Types
    include ItemFieldUriMap

    ITEM_KEY_PATHS = {
      id:             [:item_id, :attribs, :id],
      change_key:     [:item_id, :attribs, :change_key],
      subject:        [:subject, :text],
      sensitivity:    [:sensitivity, :text],
      size:           [:size, :text],
      date_time_sent: [:date_time_sent, :text],
      date_time_created: [:date_time_created, :text],
      has_attachments?:[:has_attachments, :text],
      associated?:    [:is_associated, :text],
      read?:          [:is_read, :text],
      conversation_id:[:conversation_id, :attribs, :id],
      categories:     [:categories, :elems],
      internet_message_id:[:internet_message_id, :text],
      internet_message_headers:[:internet_message_headers, :elems],
      sender:         [:sender, :elems, 0, :mailbox, :elems],
      from:           [:from, :elems, 0, :mailbox, :elems],
      to_recipients:  [:to_recipients, :elems],
      attachments:    [:attachments, :elems],
      importance:     [:importance, :text],
      conversation_index:     [:conversation_index, :text],
      conversation_topic:     [:conversation_topic, :text],
      body_type: [:body, :attribs, :body_type],
      body: [:body, :text]
    }

    ITEM_KEY_TYPES = {
      size:               ->(str){str.to_i},
      date_time_sent:     ->(str){DateTime.parse(str)},
      date_time_created:  ->(str){DateTime.parse(str)},
      has_attachments?:   ->(str){str.downcase == 'true'},
      associated?:        ->(str){str.downcase == 'true'},
      read?:              ->(str){str.downcase == 'true'},
      categories:         ->(obj){obj.collect{|s| s[:string][:text]}},
      internet_message_headers: ->(obj){obj.collect{|h|
          {h[:internet_message_header][:attribs][:header_name] =>
            h[:internet_message_header][:text]} } },
      sender: :build_mailbox_user,
      from:   :build_mailbox_user,
      attachments: :build_attachments,
    }

    ITEM_KEY_ALIAS = {
      :read?        => :is_read?,
      :associated?  => :is_associated?,
    }

    attr_reader :ews_item

    # @param [SOAP::ExchangeWebService] ews the EWS reference
    # @param [Hash] ews_item the EWS parsed response document
    def initialize(ews, ews_item)
      super
      simplify!
    end

    def delete!(deltype = :hard)
      opts = {
        :delete_type => delete_type(deltype),
        :item_ids => [{:item_id => {:id => id}}]
      }
      resp = @ews.delete_item(opts)
      if resp.success?
        true
      else
        raise EwsError, "Could not delete #{self.class}. #{resp.code}: #{resp.message}"
      end
    end

    def recycle!
      delete! :recycle
    end

    def get_all_properties!
      @ews_item = get_item(base_shape: 'AllProperties')
      simplify!
    end

    # Mark an item as read or if you pass false, unread
    # @param [Boolean] read mark read if true, unread if not. 
    def mark_read!(read = true)
      resp = update_is_read_status read
    end

    private

    def key_paths
      super.merge(ITEM_KEY_PATHS)
    end

    def key_types
      super.merge(ITEM_KEY_TYPES)
    end

    def key_alias
      super.merge(ITEM_KEY_ALIAS)
    end

    def update_is_read_status(read)
      field = :is_read
      opts = {item_changes:
        [
          { item_id: {id: id, change_key: change_key},
            updates: [
              {set_item_field: {field_uRI: {field_uRI: FIELD_URIS[field][:text]},
                message: {sub_elements: [{field => {text: read}}]}}}
            ]
          }
        ]
      }
      resp = ews.update_item({conflict_resolution: 'AutoResolve'}.merge(opts))
      unless resp.success? 
        raise EwsError, "#{resp.code}: #{resp.message}"
      end
      true
    end

    def simplify!
      @ews_item = @ews_item[:elems].inject(&:merge)
    end

    # Get a specific item by its ID.
    # @param [Hash] opts Misc options to control request
    # @option opts [String] :base_shape IdOnly/Default/AllProperties
    # @raise [EwsError] raised when the backend SOAP method returns an error.
    def get_item(opts = {})
      args = get_item_args(opts)
      resp = ews.get_item(args)
      get_item_parser(resp)
    end

    # Build up the arguements for #get_item
    # @todo: should we really pass the ChangeKey or do we want the freshest obj?
    def get_item_args(opts)
      opts[:base_shape] ||= 'Default'
      default_args = {
        item_shape: {base_shape: opts[:base_shape]},
        item_ids:   [{item_id:{id: id, change_key: change_key}}]
      }
      default_args
    end

    def get_item_parser(resp)
      if(resp.status == 'Success')
        f = resp.response_message[:elems][:items][:elems][0]
        f.values.first
      else
        raise EwsError, "Could not retrieve #{self.class}. #{resp.code}: #{resp.message}"
      end
    end

    # Map a delete type to what EWS expects
    # @param [Symbol] type. Must be :hard, :soft, or :recycle
    def delete_type(type)
      case type
      when :hard then 'HardDelete'
      when :soft then 'SoftDelete'
      when :recycle then 'MoveToDeletedItems'
      else 'MoveToDeletedItems'
      end
    end

    def build_mailbox_user(mbox_ews)
      MailboxUser.new(ews, mbox_ews)
    end

    def build_attachments(attachments)
      attachments.collect do |att|
        key = att.keys.first
        class_by_name(key).new(self, att[key])
      end
    end

  end
end
