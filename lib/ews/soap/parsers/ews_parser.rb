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

module Viewpoint::EWS::SOAP
  class EwsParser
    include Viewpoint::EWS

    # @param [String] soap_resp
    def initialize(soap_resp)
      @soap_resp  = soap_resp
      @sax_doc    = EwsSaxDocument.new
    end

    def parse(opts = {})
      opts[:response_class] ||= EwsSoapResponse
      sax_parser.parse(clean_xml(@soap_resp))
      opts[:response_class].new @sax_doc.struct
    end

    private

    # Responses from Exchange may contain characters which are invalid
    # XML (control characters and such), which Microsoft will not fix.
    # This method will munge the EWS payload  and replace any unicode
    # characters not in the XML 1.0 specification with a placeholder.
    # INFO: https://www.w3.org/TR/REC-xml/#charsets
    # INFO: https://blogs.msdn.microsoft.com/mstehle/2009/02/12/kb-xml-schema-validation-errors-when-exchange-web-service-requests-and-responses-have-invalid-xml-characters/
    def clean_xml(xml = '')
      xml = xml.gsub(/[^\u{9 A D}\u{20}-\u{D7FF}\u{E000}-\u{FFFD}\u{10000}-\u{10FFFF}]/, "\uFFFD")
      # It's also necessary to clean up HTML-encoded control characters.
      xml.gsub(/&#x[0-1]?[0-9a-eA-E];/, ' ')
    end

    def sax_parser
      @parser ||= Nokogiri::XML::SAX::Parser.new(@sax_doc)
    end

  end # EwsParser
end # Viewpoint
