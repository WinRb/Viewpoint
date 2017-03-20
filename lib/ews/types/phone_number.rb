module Viewpoint::EWS::Types
  class PhoneNumber
    include Viewpoint::EWS
    include Viewpoint::EWS::Types

    PHONE_NUMBER_KEY_PATHS = {
      key:          [:attribs, :key],
      phone_number: [:text]
    }
    PHONE_NUMBER_KEY_TYPES = { }
    PHONE_NUMBER_KEY_ALIAS = {
      name: :key
    }

    def initialize(ews, phone_number)
      @ews = ews
      @ews_item = phone_number
    end


    private


    def key_paths
      @key_paths ||= super.merge(PHONE_NUMBER_KEY_PATHS)
    end

    def key_types
      @key_types ||= super.merge(PHONE_NUMBER_KEY_TYPES)
    end

    def key_alias
      @key_alias ||= super.merge(PHONE_NUMBER_KEY_ALIAS)
    end

  end # PhoneNumber
end # Viewpoint::EWS::Types

