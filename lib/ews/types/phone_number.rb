module Viewpoint::EWS::Types
  class PhoneNumber
    include Viewpoint::EWS
    include Viewpoint::EWS::Types
    
    PHONE_KEY_PATHS = {
      phone_number: [ :text ],
      phone_type: [ :attribs, :key ]
    }

    def initialize(ews, numbers)
      @ews = ews
      @ews_item = numbers
    end

    private

    def key_paths
      super.merge(PHONE_KEY_PATHS)
    end
  end
end
