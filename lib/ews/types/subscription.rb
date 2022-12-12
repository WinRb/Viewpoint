module Viewpoint::EWS::Types
  module Subscription
    include Viewpoint::EWS
    include Viewpoint::EWS::Types

    def self.included(klass)
      klass.extend ClassMethods
    end

    module ClassMethods
      def init_simple_item(ews, id, watermark = nil, parent = nil)
        ews_item = {subscription_id: {attribs: {id: id, watermark: watermark}}}
        self.new ews, ews_item, parent
      end
    end

    SUBSCRIPTION_KEY_PATHS = {
      subscription_id: [:elems, :subscription_id, :text],
      watermark:       [:elems, :watermark, :text]
    }

    SUBSCRIPTION_KEY_TYPES = {
      subscription_id:    ->(str){str.to_s},
      watermark:          ->(str){str.to_s}
    }

    SUBSCRIPTION_KEY_ALIAS = {
    }

    attr_reader :ews_item, :parent

    # @param ews [SOAP::ExchangeWebService] the EWS reference
    # @param ews_item [Hash] the EWS parsed response document
    # @param parent [GenericFolder] an optional parent object
    def initialize(ews, ews_item, parent = nil)
      super(ews, ews_item)
      @parent = parent
    end

    def get_all_properties!
      @ews_item
    end

    private

    def key_paths
      super.merge(SUBSCRIPTION_KEY_PATHS)
    end

    def key_types
      super.merge(SUBSCRIPTION_KEY_TYPES)
    end

    def key_alias
      super.merge(SUBSCRIPTION_KEY_ALIAS)
    end
  end
end
