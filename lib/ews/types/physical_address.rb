module Viewpoint::EWS::Types
  class PhysicalAddress
    include Viewpoint::EWS
    include Viewpoint::EWS::Types
    
    ADDRESS_KEY_PATHS = {
      street: [ :street, :text ],
      city: [ :city, :text ],
      state: [ :state, :text ],
      country_or_region: [ :country_or_region, :text ],
      postal_code: [ :postal_code, :text ],
      address_type: [ :address_type, :key ]
    }

    def initialize(ews, addresses)
      @ews = ews
      @ews_item = addresses
      simplify!
    end

    private

    def simplify!
      @ews_item = @ews_item.inject({}){|m,o|
        m[o.keys.first] = o.values.first;
        m
      }
    end

    def key_paths
      super.merge(ADDRESS_KEY_PATHS)
    end
  end
end
