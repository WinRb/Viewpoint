module Viewpoint::EWS::Types
  class EmailAddress
    include Viewpoint::EWS
    include Viewpoint::EWS::Types
    
    EMAIL_KEY_PATHS = {
      email: [ :text ],
      name: [ :attribs, :name ],
      email_type: [ :attribs, :key ]
    }

    def initialize(ews, addresses)
      @ews = ews
      @ews_item = addresses
    end

    private

    def key_paths
      super.merge(EMAIL_KEY_PATHS)
    end
  end
end
