module Viewpoint::EWS::Types
  module Item
    include Viewpoint::EWS
    include Viewpoint::EWS::Types

    module KlassMethods

      def key_paths
        KEY_PATHS
      end

      def key_types
        KEY_TYPES
      end

      def key_alias
        KEY_ALIAS
      end

    end

    def self.included(klass)
      klass.extend KlassMethods
    end

    KEY_PATHS = {
      id:             [:item_id, :attribs, :id],
      change_key:     [:item_id, :attribs, :change_key],
      subject:        [:subject, :text],
      sensitivity:    [:sensitivity, :text],
      size:           [:size, :text],
      date_time_sent: [:date_time_sent, :text],
      date_time_created: [:date_time_created, :text],
      has_attachments:[:has_attachments, :text],
      is_associated:  [:is_associated, :text],
      is_read:        [:is_read, :text],
    }
    @@key_paths = KEY_PATHS

    KEY_TYPES = {
      size:               ->(str){str.to_i},
      date_time_sent:     ->(str){DateTime.parse(str)},
      date_time_created:  ->(str){DateTime.parse(str)},
      has_attachments:    ->(str){str.downcase == 'true'},
      is_associated:      ->(str){str.downcase == 'true'},
      is_read:            ->(str){str.downcase == 'true'},
    }
    @@key_types = KEY_TYPES

    KEY_ALIAS = {
    }
    @@key_alias = KEY_ALIAS

    attr_reader :ews_item

    # @param [SOAP::ExchangeWebService] ews the EWS reference
    # @param [Hash] ews_item the EWS parsed response document
    def initialize(ews, ews_item)
      super
      simplify!
    end

    def delete!
      opts = {
        :folder_ids   => [:id => id],
        :delete_type  => 'HardDelete'
      }
      resp = @ews.delete_folder(opts)
      if resp.success?
        true
      else
        raise EwsError, "Could not delete folder. #{resp.code}: #{resp.message}"
      end
    end

    def get_all_properties!
      @ews_item = get_folder(:base_shape => 'AllProperties')
      simplify!
    end


    private


    def simplify!
      @ews_item = @ews_item[:elems].inject(&:merge)
    end

    # Get a specific folder by its ID.
    # @param [Hash] opts Misc options to control request
    # @option opts [String] :base_shape IdOnly/Default/AllProperties
    # @raise [EwsError] raised when the backend SOAP method returns an error.
    def get_folder(opts = {})
      args = get_folder_args(opts)
      resp = ews.get_folder(args)
      get_folder_parser(resp)
    end

    # Build up the arguements for #get_folder
    # @todo: should we really pass the ChangeKey or do we want the freshest obj?
    def get_folder_args(opts)
      opts[:base_shape] ||= 'Default'
      default_args = {
        :folder_ids   => [{:id => self.id, :change_key => self.change_key}],
        :folder_shape => {:base_shape => opts[:base_shape]}
      }
      default_args.merge(opts)
    end

    def get_folder_parser(resp)
      if(resp.status == 'Success')
        f = resp.response_message[:elems][:folders][:elems][0]
        f.values.first
      else
        raise EwsError, "Could not retrieve folder. #{resp.code}: #{resp.message}"
      end
    end

  end
end
