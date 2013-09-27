module Viewpoint::EWS::Types
  class CalendarItem
    include Viewpoint::EWS
    include Viewpoint::EWS::Types
    include Viewpoint::EWS::Types::Item

    CALENDAR_ITEM_KEY_PATHS = {
      recurring?:   [:is_recurring, :text],
      meeting?:     [:is_meeting, :text],
      cancelled?:   [:is_cancelled, :text],
    }

    CALENDAR_ITEM_KEY_TYPES = {
      recurring?:   ->(str){str.downcase == 'true'},
      meeting?:     ->(str){str.downcase == 'true'},
      cancelled?:   ->(str){str.downcase == 'true'},
    }
    CALENDAR_ITEM_KEY_ALIAS = {}

    # Updates the specified item attributes
    #
    # Uses `SetItemField` if value is present and `DeleteItemField` if value is nil
    # @param updates [Hash] with (:attribute => value)
    # @param options [Hash]
    # @option options :conflict_resolution [String] one of 'NeverOverwrite', 'AutoResolve' (default) or 'AlwaysOverwrite'
    # @option options :send_meeting_invitations_or_cancellations [String] one of 'SendToNone' (default), 'SendOnlyToAll',
    #   'SendOnlyToChanged', 'SendToAllAndSaveCopy' or 'SendToChangedAndSaveCopy'
    # @return [CalendarItem]
    # @example Update Subject and Body
    #   item = #...
    #   item.update_item!(subject: 'New subject', body: 'New Body')
    # @see http://msdn.microsoft.com/en-us/library/exchange/aa580254.aspx
    # @todo AppendToItemField updates not implemented
    def update_item!(updates, options = {})
      item_updates = updates.map do |attribute, value|
        item_field = FIELD_URIS[attribute][:text] if FIELD_URIS.include? attribute
        field = {field_uRI: {field_uRI: item_field}}

        if value.nil?
          {delete_item_field: field}
        else
          item = Viewpoint::EWS::Template::CalendarItem.new(attribute => value)

          # Remap attributes because ews_builder #dispatch_field_item! uses #build_xml!
          item_attributes = item.to_ews_item.map do |name, value|
            if value.is_a? String
              {name => {text: value}}
            elsif value.is_a? Hash
              node = {name => {}}
              value.each do |attrib_key, attrib_value|
                attrib_key = attrib_key.to_s.camel_case unless attrib_key == :text
                node[name][attrib_key] = attrib_value
              end
              node
            else
              {name => value}
            end
          end

          {set_item_field: field.merge(calendar_item: {sub_elements: item_attributes})}
        end
      end

      data = {}
      data[:conflict_resolution] = options[:conflict_resolution] || 'AutoResolve'
      data[:send_meeting_invitations_or_cancellations] = options[:send_meeting_invitations_or_cancellations] || 'SendToNone'
      data[:item_changes] = [{item_id: self.item_id, updates: item_updates}]
      rm = ews.update_item(data).response_messages.first
      if rm && rm.success?
        self.get_all_properties!
        self
      else
        raise EwsCreateItemError, "Could not update calendar item. #{rm.code}: #{rm.message_text}" unless rm
      end

    end

    private

    def key_paths
      super.merge(CALENDAR_ITEM_KEY_PATHS)
    end

    def key_types
      super.merge(CALENDAR_ITEM_KEY_TYPES)
    end

    def key_alias
      super.merge(CALENDAR_ITEM_KEY_ALIAS)
    end


  end
end
