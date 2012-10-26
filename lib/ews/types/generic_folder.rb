module Viewpoint::EWS::Types
  module GenericFolder
    include Viewpoint::EWS
    include Viewpoint::EWS::Types

    KEY_PATHS = {
      :id         => [:folder_id, :id],
      :change_key => [:folder_id, :change_key]
    }

    attr_reader :ews_item

    # @param [SOAP::ExchangeWebService] ews the EWS reference
    # @param [Hash] ews_item the EWS parsed response document that fetched this
    #   folder.
    def initialize(ews, ews_item)
      @ews      = ews
      @type_key = ews_item.keys.first
      @ews_item = ews_item[@type_key]
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
  end
end
