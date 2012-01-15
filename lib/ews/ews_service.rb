=begin
  This file is part of Viewpoint; the Ruby library for Microsoft Exchange Web Services.

  Copyright © 2011 Dan Wanek <dan.wanek@gmail.com>

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
=end

require 'soap/builder'
require 'soap/parser'

module Viewpoint::EWS::SOAP
  class ExchangeWebService
    include Viewpoint::EWS::SOAP

    NAMESPACES = {
      'soap'  => 'http://schemas.xmlsoap.org/soap/envelope/',
      'types' => 'http://schemas.microsoft.com/exchange/services/2006/types',
      'msgs'  => 'http://schemas.microsoft.com/exchange/services/2006/messages',
    }.freeze

    def initialize(endpoint)
      @log = Logging.logger[self.class.name.to_s.to_sym]
      @default_ns = NAMESPACES['m']
      @endpoint = endpoint
    end

    # Resolve ambiguous e-mail addresses and display names
    # @see http://msdn.microsoft.com/en-us/library/aa565329.aspx ResolveNames
    # @see http://msdn.microsoft.com/en-us/library/aa581054.aspx UnresolvedEntry
    #
    # @param [String] name an unresolved entry
    # @param [Boolean] full_contact_data whether or not to return full contact info
    # @param [Hash] opts optional parameters to this method
    # @option opts [String] :search_scope where to seach for this entry, one of
    #   SOAP::Contacts, SOAP::ActiveDirectory, SOAP::ActiveDirectoryContacts (default),
    #   SOAP::ContactsActiveDirectory
    # @option opts [String, FolderId] :parent_folder_id either the name of a folder or
    #   it's numerical ID.  @see http://msdn.microsoft.com/en-us/library/aa565998.aspx
    def resolve_names(name, full_contact_data = true, opts = {})
      attribs = {:ReturnFullContactData => full_contact_data.to_s}
      attribs[:SearchScope] = opts[:search_scope] if opts[:search_scope]

      req = build_soap_envelope do |type, builder|
        if(type == :header)
        else
        builder.ResolveNames(attribs) {
          builder.parent.default_namespace = @default_ns
          # @TODO builder.ParentFolderIds
          builder.UnresolvedEntry(name)
        }
        end
      end
      # @TODO rsp = Nokogiri::XML(send_soap_request(soapmsg.doc.to_xml))
      #parse!(resp)
    end


    # Exposes the full membership of distribution lists.
    # @see http://msdn.microsoft.com/en-us/library/aa494152.aspx ExpandDL
    #
    # @param [String] dist_email The e-mail address associated with the Distribution List
    # @TODO Fully support all of the ExpandDL operations. Today it just supports
    #   taking an e-mail address as an argument
    def expand_dl(dist_email)
      req = build_soap_envelope do |type, builder|
        if(type == :header)
        else
        builder.ExpandDL {
          builder.parent.default_namespace = @default_ns
          builder.Mailbox {
            builder.parent.default_namespace = NAMESPACES['types']
            builder.EmailAddress(dist_email)
          }
        }
        end
      end

      parse!(resp)
    end



    # Private Methods (Builders and Parsers)
    private


    def parse!(response, opts = {})
      #return response if @@raw_soap
      raise EwsError, "Can't parse an empty response. Please check your endpoint." if(response.nil?)
      EwsParser.new(response).parse(opts)
    end

    # Build the common elements in the SOAP message and yield to any custom elements.
    def build_soap_envelope
      new_ent = Nokogiri::XML::Builder.new do |xml|
        xml.Envelope(NAMESPACES) do |ent|
          xml.parent.namespace = xml.parent.namespace_definitions.find{|ns|ns.prefix=="soap"}
          ent['soap'].Header {
            yield(:header, ent) if block_given?
          }
          ent['soap'].Body {
            yield(:body, ent) if block_given?
          }
        end
      end
    end

    # Send the SOAP request to the endpoint
    # @param [String] soapmsg an XML formatted string
    # @TODO make this work for Viewpoint (imported from SPWS)
    def send_soap_request(soapmsg)
      @log.debug "Sending SOAP Request:\n----------------\n#{soapmsg}\n----------------"
      respmsg = @spcon.post(@ws_endpoint, soapmsg)
      @log.debug "Received SOAP Response:\n----------------\n#{Nokogiri::XML(respmsg).to_xml}\n----------------"
      respmsg
    end

  end # class ExchangeWebService
end # Viewpoint
