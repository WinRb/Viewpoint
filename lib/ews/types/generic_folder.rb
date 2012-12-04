module Viewpoint::EWS::Types
  module GenericFolder
    include Viewpoint::EWS
    include Viewpoint::EWS::Types

    KEY_PATHS = {
      :id               => [:folder_id, :attribs, :id],
      :change_key       => [:folder_id, :attribs, :change_key],
      :parent_folder_id => [:parent_folder_id, :attribs, :id],
      :parent_folder_change_key => [:parent_folder_id, :attribs, :change_key],
      :folder_class     => [:folder_class, :text],
      :total_count      => [:total_count, :text],
      :child_folder_count => [:child_folder_count, :text],
      :display_name     => [:display_name, :text],
    }

    KEY_TYPES = {
      :total_count        => ->(str){str.to_i},
      :child_folder_count => ->(str){str.to_i},
    }

    KEY_ALIAS = {
      :name   => :display_name,
      :ckey   => :change_key,
    }

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
