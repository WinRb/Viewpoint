module Viewpoint::EWS::Types
  class CalendarFolder
    include Viewpoint::EWS
    include Viewpoint::EWS::Types
    include Viewpoint::EWS::Types::GenericFolder

    # Fetch items between a given time period
    # @param [DateTime] start_date the time to start fetching Items from
    # @param [DateTime] end_date the time to stop fetching Items from
    def items_between(start_date, end_date, opts={})
      items do |obj|
        obj.restriction = { :and =>
          [
            {:is_greater_than_or_equal_to =>
              [
                {:field_uRI => {:field_uRI=>'calendar:Start'}},
                {:field_uRI_or_constant=>{:constant => {:value =>start_date}}}
              ]
            },
            {:is_less_than_or_equal_to =>
              [
                {:field_uRI => {:field_uRI=>'calendar:End'}},
                {:field_uRI_or_constant=>{:constant => {:value =>end_date}}}
              ]
            }
          ]
        }
      end
    end

    # Fetch items between a given time period using a calendar view.
    # The calendar view will include occurences of recurring calendar items
    # next to the regular single calendar items.
    # @param [DateTime] start_date the time to start fetching Items from
    # @param [DateTime] end_date the time to stop fetching Items from
    # @param opts [Hash]
    # @option opts :max_entries_returned [Integer] the maximum number of entries to return
    def items_between_calendar_view(start_date, end_date, opts={})
      view_opts = {:start_date => start_date, :end_date => end_date}
      view_opts[:max_entries_returned] = opts.delete(:max_entries_returned) if opts[:max_entries_returned]
      items(opts.merge(:calendar_view => view_opts))
    end

    # Creates a new appointment
    # @param attributes [Hash] Parameters of the calendar item. Some example attributes are listed below.
    # @option attributes :subject [String]
    # @option attributes :start [Time]
    # @option attributes :end [Time]
    # @return [CalendarItem]
    # @see Template::CalendarItem
    def create_item(attributes, to_ews_create_opts = {})
      template = Viewpoint::EWS::Template::CalendarItem.new attributes
      template.saved_item_folder_id = {id: self.id, change_key: self.change_key}
      rm = ews.create_item(template.to_ews_create(to_ews_create_opts)).response_messages.first
      if rm && rm.success?
        CalendarItem.new ews, rm.items.first[:calendar_item][:elems].first
      else
        raise EwsCreateItemError, "Could not create item in folder. #{rm.code}: #{rm.message_text}" unless rm
      end
    end

  end
end
