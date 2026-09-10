# frozen_string_literal: true

module Viewpoint
  module EWS
    module SOAP
      # Known Exchange time zone definitions.
      module ExchangeTimeZones
        include Viewpoint::EWS::SOAP

        # Request list of server known time zones
        # @param full [Boolean] Request full time zone definition? Returns only name and id if false.
        # @param ids [Array] Returns only the specified time zones instead of all if present
        # @return [Array] Array of Objects responding to #id() and #name()
        # @example Retrieving server time zones
        #   ews_client = Viewpoint::EWSClient.new # ...
        #   zones = ews_client.ews.get_time_zones
        # @todo Implement TimeZoneDefinition with sub elements Periods, TransitionsGroups and Transitions
        def get_time_zones(full = false, ids = nil)
          req = build_soap! { |type, builder|
            builder.get_server_time_zones!(full: full, ids: ids) unless type == :header
          }
          result = do_soap_request req, response_class: EwsSoapResponse

          raise EwsError, 'Could not get time zones' unless result.success?

          zones = []
          result.response_messages.each do |message|
            elements = message[:get_server_time_zones_response_message][:elems][:time_zone_definitions][:elems]
            elements.each do |definition|
              data = {
                id: definition[:time_zone_definition][:attribs][:id],
                name: definition[:time_zone_definition][:attribs][:name]
              }
              zones << OpenStruct.new(data)
            end
          end
          zones
        end

        # Sets the time zone context header
        # @param id [String] Identifier of a Microsoft well known time zone
        # @example Set time zone context for connection
        #   ews_client = Viewpoint::EWSClient.new # ...
        #   ews_client.set_time_zone 'AUS Central Standard Time'
        #   # subsequent request will send the TimeZoneContext header
        # @see EWSClient#set_time_zone
        def set_time_zone_context(id)
          @time_zone_context = ({ id: id } if id)
        end
      end
    end
  end
end
