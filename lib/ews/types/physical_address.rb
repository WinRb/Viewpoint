module Viewpoint::EWS::Types
  class PhysicalAddress
    include Viewpoint::EWS
    include Viewpoint::EWS::Types

    PHYSICAL_ADDRESS_KEY_PATHS = {
      key:               [:key],
      street:            [:street],
      city:              [:city],
      state:             [:state],
      country_or_region: [:country_or_region],
      postal_code:       [:postal_code]
    }
    PHYSICAL_ADDRESS_KEY_TYPES = { }
    PHYSICAL_ADDRESS_KEY_ALIAS = {
      country: :country_or_region,
      region:  :country_or_region,
      name:    :key
    }

    def initialize(ews, physical_address)
      @ews = ews
      @ews_item = physical_address
      simplify!
    end


    private


    def simplify!
      return unless @ews_item.has_key?(:elems)
      @ews_item[:key] = @ews_item[:attribs][:key]
      @ews_item = @ews_item[:elems].inject({}){|m,o|
        m[o.keys.first] = o.values.first[:text];
        m
      }
    end

    def key_paths
      @key_paths ||= super.merge(PHYSICAL_ADDRESS_KEY_PATHS)
    end

    def key_types
      @key_types ||= super.merge(PHYSICAL_ADDRESS_KEY_TYPES)
    end

    def key_alias
      @key_alias ||= super.merge(PHYSICAL_ADDRESS_KEY_ALIAS)
    end

  end # PhysicalAddress
end # Viewpoint::EWS::Types

