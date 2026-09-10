module Viewpoint::EWS::Types
  class EmailAddress
    include Viewpoint::EWS
    include Viewpoint::EWS::Types

    EMAIL_ADDRESS_KEY_PATHS = {
      key:           [:attribs, :key],
      name:          [:attribs, :name],
      mailbox_type:  [:attribs, :mailbox_type],
      email_address: [:text]
    }
    EMAIL_ADDRESS_KEY_TYPES = { }
    EMAIL_ADDRESS_KEY_ALIAS = {
      email: :email_address
    }

    def initialize(ews, email_address)
      @ews = ews
      @ews_item = email_address
    end


    private


    def key_paths
      @key_paths ||= super.merge(EMAIL_ADDRESS_KEY_PATHS)
    end

    def key_types
      @key_types ||= super.merge(EMAIL_ADDRESS_KEY_TYPES)
    end

    def key_alias
      @key_alias ||= super.merge(EMAIL_ADDRESS_KEY_ALIAS)
    end

  end # EmailAddress
end # Viewpoint::EWS::Types

