module Viewpoint
  module EWS
    module SOAP
    end
  end
end

require "nokogiri"

module Viewpoint::EWS::SOAP
  class Builder
    NS_SOAP         = 'soap'.freeze
    NS_EWS_TYPES    = 't'.freeze
    NS_EWS_MESSAGES = 'm'.freeze
    NAMESPACES = {
      "xmlns:#{NS_SOAP}"         => 'http://schemas.xmlsoap.org/soap/envelope/',
      "xmlns:#{NS_EWS_TYPES}"    => 'http://schemas.microsoft.com/exchange/services/2006/types',
      "xmlns:#{NS_EWS_MESSAGES}" => 'http://schemas.microsoft.com/exchange/services/2006/messages',
    }.freeze

    attr_reader :builder

    def initialize
      @builder = Nokogiri::XML::Builder.new
    end

    def build(header_opts = {}, &block)
      builder.Envelope(namespaces) do |node|
        #node.parent.namespace = NAMESPACES["xmlns:soap"]
        node.Header {
          #run header_opts
          yield(:header, self) if block_given?
        }
        node.Body {
          yield(:body, self) if block_given?
        }
      end
      builder.doc
    end

    def run(opts, required = [])
      methods.each do |m|
        raise RuntimeError, "Unknow method #{m}" unless respond_to?(m)
        required -= [m]
        send m
      end

      unless required.empty?
        raise RuntimeError, "Did not call required methods, #{required.join(', ')}"
      end
    end


    # ======== Element Methods ======== #

    def request_server_version(version)
      if version
        builder[namespace_ews_types].RequestServerVersion("Version" => version)
      end
    end

    def exchange_impersonation(type, address)
      if %w{PrincipalName SID PrimarySmtpAddress SmtpAddress}.include? type
        builder[namespace_ews_types].ExchangeImpersonation {
          builder[namespace_ews_types].ConnectingSID {
            builder[namespace_ews_types].send type, address
          }
        }
      end
    end

    def time_zone_context(time_zone_def)
      if time_zone_def
        builder[namespace_ews_types].TimeZoneContext do
          time_zone_definition time_zone_def
        end
      end
    end

    # @todo Implement subelements Periods, TransitionsGroups and Transitions to override zone
    # @see http://msdn.microsoft.com/en-us/library/exchange/dd899488.aspx
    def time_zone_definition(zone)
      attributes = {'Id' => zone[:id]}
      attributes['Name'] = zone[:name] if zone[:name]
      builder[namespace_ews_types].TimeZoneDefinition(attributes)
    end


    private


    def namespaces
      NAMESPACES
    end

    def namespace_soap
      NS_SOAP
    end

    def namespace_ews_types
      NS_EWS_TYPES
    end

    def namespace_ews_messages
      NS_EWS_MESSAGES
    end

    def parent_namespace(node)
      node.parent.namespace_definitions.find {|ns| ns.prefix == NS_SOAP}
    end

  end
end
