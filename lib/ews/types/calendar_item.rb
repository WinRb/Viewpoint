module Viewpoint::EWS::Types
  class CalendarItem
    include Viewpoint::EWS
    include Viewpoint::EWS::Types
    include Viewpoint::EWS::Types::Item

    CALENDAR_ITEM_KEY_PATHS = {
      recurring?:   [:is_recurring, :text],
      meeting?:     [:is_meeting, :text],
      cancelled?:   [:is_cancelled, :text],
      duration:   [:duration, :text],
      time_zone:   [:time_zone, :text],
      start:   [:start, :text],
      end:   [:end, :text],
      location:   [:location, :text],
      all_day?:   [:is_all_day_event, :text]
   }

    CALENDAR_ITEM_KEY_TYPES = {
      recurring?:   ->(str){str.downcase == 'true'},
      meeting?:     ->(str){str.downcase == 'true'},
      cancelled?:   ->(str){str.downcase == 'true'},
      all_day?:   ->(str){str.downcase == 'true'}
    }
    CALENDAR_ITEM_KEY_ALIAS = {}

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
