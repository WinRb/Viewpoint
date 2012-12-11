module Viewpoint::EWS::Types
  module GenericFolder
    include Viewpoint::EWS
    include Viewpoint::EWS::Types

    GFOLDER_KEY_PATHS = {
      :id               => [:folder_id, :attribs, :id],
      :change_key       => [:folder_id, :attribs, :change_key],
      :parent_folder_id => [:parent_folder_id, :attribs, :id],
      :parent_folder_change_key => [:parent_folder_id, :attribs, :change_key],
      :folder_class     => [:folder_class, :text],
      :total_count      => [:total_count, :text],
      :child_folder_count => [:child_folder_count, :text],
      :display_name     => [:display_name, :text],
    }

    GFOLDER_KEY_TYPES = {
      :total_count        => ->(str){str.to_i},
      :child_folder_count => ->(str){str.to_i},
    }

    GFOLDER_KEY_ALIAS = {
      :name   => :display_name,
      :ckey   => :change_key,
    }

    # @param [SOAP::ExchangeWebService] ews the EWS reference
    # @param [Hash] ews_item the EWS parsed response document
    def initialize(ews, ews_item)
      super
      simplify!
    end

    def items
      items_parser ews.find_item(items_args)
    end

    def items_args
      { :parent_folder_ids => [{:id => self.id}],
        :traversal => 'Shallow',
        :item_shape  => {:base_shape => 'Default'} }
    end

    def items_parser(resp)
      if(resp.status == 'Success')
        allitems = resp.response_message[:elems][:root_folder][:elems][0][:items][:elems] || []
        items = []
        allitems.each do |i|
          type = i.keys.first
          items << class_by_name(type).new(ews, i[type])
        end
        items
      else
        raise EwsError, "Could not retrieve folder. #{resp.code}: #{resp.message}"
      end
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


    def key_paths
      @key_paths ||= super.merge(GFOLDER_KEY_PATHS)
    end

    def key_types
      @key_types ||= super.merge(GFOLDER_KEY_TYPES)
    end

    def key_alias
      @key_alias ||= super.merge(GFOLDER_KEY_ALIAS)
    end

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
