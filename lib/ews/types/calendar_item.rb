# frozen_string_literal: true

module Viewpoint
  module EWS
    module Types
      class CalendarItem
        include Viewpoint::EWS
        include Viewpoint::EWS::Types
        include Viewpoint::EWS::Types::Item
        include Viewpoint::StringUtils

        CALENDAR_ITEM_KEY_PATHS = {
          recurring?: %i[is_recurring text],
          meeting?: %i[is_meeting text],
          cancelled?: %i[is_cancelled text],
          duration: %i[duration text],
          time_zone: %i[time_zone text],
          start: %i[start text],
          end: %i[end text],
          location: %i[location text],
          all_day?: %i[is_all_day_event text],
          legacy_free_busy_status: %i[legacy_free_busy_status text],
          my_response_type: %i[my_response_type text],
          organizer: [:organizer, :elems, 0, :mailbox, :elems],
          optional_attendees: %i[optional_attendees elems],
          required_attendees: %i[required_attendees elems],
          recurrence: %i[recurrence elems],
          deleted_occurrences: %i[deleted_occurrences elems],
          modified_occurrences: %i[modified_occurrences elems]
        }.freeze

        CALENDAR_ITEM_KEY_TYPES = {
          start: ->(str) { DateTime.parse(str) },
          end: ->(str) { DateTime.parse(str) },
          recurring?: ->(str) { str.downcase == 'true' },
          meeting?: ->(str) { str.downcase == 'true' },
          cancelled?: ->(str) { str.downcase == 'true' },
          all_day?: ->(str) { str.downcase == 'true' },
          organizer: :build_mailbox_user,
          optional_attendees: :build_attendees_users,
          required_attendees: :build_attendees_users,
          deleted_occurrences: :build_deleted_occurrences,
          modified_occurrences: :build_modified_occurrences
        }.freeze
        CALENDAR_ITEM_KEY_ALIAS = {}.freeze

        # Delete this calendar item
        # @param deltype [Symbol] The delete type; must be :hard, :soft, or :recycle.
        #   By default EWS will do a  hard delete of this calendar item.  See the=
        #   MSDN docs for more info: http://msdn.microsoft.com/en-us/library/aa562961.aspx
        # @param cancel_type [String] 'SendToNone'/'SendOnlyToAll'/'SendToAllAndSaveCopy'
        #   Default is 'SendOnlyToAll'
        # @return [Boolean] Whether or not the calendar item was deleted
        def delete!(deltype = :hard, cancel_type = 'SendOnlyToAll', opts = {})
          opts = opts.merge(send_meeting_cancellations: cancel_type)
          super(deltype, opts)
        end

        # Updates the specified item attributes
        #
        # Uses `SetItemField` if value is present and `DeleteItemField` if value is nil
        # @param updates [Hash] with (:attribute => value)
        # @param options [Hash]
        # @option options :conflict_resolution [String] one of 'NeverOverwrite', 'AutoResolve' (default) or 'AlwaysOverwrite'
        # @option options :send_meeting_invitations_or_cancellations [String] one of 'SendToNone' (default), 'SendOnlyToAll',
        #   'SendOnlyToChanged', 'SendToAllAndSaveCopy' or 'SendToChangedAndSaveCopy'
        # @return [CalendarItem, false]
        # @example Update Subject and Body
        #   item = #...
        #   item.update_item!(subject: 'New subject', body: 'New Body')
        # @see http://msdn.microsoft.com/en-us/library/exchange/aa580254.aspx
        # @todo AppendToItemField updates not implemented
        def update_item!(updates, options = {})
          item_updates = []
          updates.each do |attribute, value|
            item_field = FIELD_URIS[attribute][:text] if FIELD_URIS.include? attribute
            field = { field_uRI: { field_uRI: item_field } }

            if value.nil? && item_field
              # Build DeleteItemField Change
              item_updates << { delete_item_field: field }
            elsif item_field
              # Build SetItemField Change
              item = Viewpoint::EWS::Template::CalendarItem.new(attribute => value)

              # Remap attributes because ews_builder #dispatch_field_item! uses #build_xml!
              item_attributes = item.to_ews_item.map { |name, value|
                if value.is_a? String
                  { name => { text: value } }
                elsif value.is_a? Hash
                  node = { name => {} }
                  value.each do |attrib_key, attrib_value|
                    attrib_key = camel_case(attrib_key) unless attrib_key == :text
                    node[name][attrib_key] = attrib_value
                  end
                  node
                else
                  { name => value }
                end
              }

              item_updates << { set_item_field: field.merge(calendar_item: { sub_elements: item_attributes }) }
            end
          end

          return unless item_updates.any?

          data = {}
          data[:conflict_resolution] = options[:conflict_resolution] || 'AutoResolve'
          data[:send_meeting_invitations_or_cancellations] =
            options[:send_meeting_invitations_or_cancellations] || 'SendToNone'
          data[:item_changes] = [{ item_id: item_id, updates: item_updates }]
          rm = ews.update_item(data).response_messages.first
          if rm&.success?
            get_all_properties!
            self
          else
            raise EwsCreateItemError, "Could not update calendar item. #{rm.code}: #{rm.message_text}" if rm

            raise EwsCreateItemError, 'Could not update calendar item.'

          end
        end

        def duration_in_seconds
          iso8601_duration_to_seconds(duration)
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
  end
end
