#############################################################################
# Copyright © 2010 Dan Wanek <dan.wanek@gmail.com>
#
#
# This file is part of Viewpoint.
# 
# Viewpoint is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published
# by the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.
# 
# Viewpoint is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
# Public License for more details.
# 
# You should have received a copy of the GNU General Public License along
# with Viewpoint.  If not, see <http://www.gnu.org/licenses/>.
#############################################################################
module Viewpoint
  module EWS
    module SOAP
      module Parser

        def initialize(response)
          # Unwrap SOAP Envelope
          @response = response
          @response_type = (response/"//#{NS_SOAP}:Body/*").first.node_name

          rmsg = (response/'//*[@ResponseClass]').first
          @response_message = EwsSoapResponse.new(rmsg['ResponseClass'],
                                                  (rmsg/'m:ResponseCode/text()').first.to_s,
                                                  (rmsg/'m:MessageText/text()').first.to_s)

          @response_message.set_soap_resp(response)
        end

        # This is the main parser method.  It takes the response type and tries to
        # call a Ruby method of the same name.
        # @todo Decide on an appropriate response if a method does not exist.
        def parse(opts)
          resp_method = @response_type.ruby_case
          if(respond_to?(resp_method))
            puts "Method Exists: #{resp_method}" if $DEBUG
            method(resp_method).call(opts)
          else
            puts "No Method: #{resp_method}" if $DEBUG
          end
          @response_message
        end

        private

        def method_exists?(method_name)
          return self.methods.include?(method_name)
        end

        # Create a Hash from a Nokogiri element tree
        # @param [Nokogiri::XML::Element, Nokogiri::XML::Text] nokoelem The Nokogiri element passed to this method
        # @example XML
        #   <tiptop>
        #     <top Id="32fss">TestText</top>
        #     <middle Id='TestTestMiddle' />
        #     <bottom />
        #   </tiptop>
        #   becomes...
        #   {:tiptop=>{:top=>{:id=>"32fss", :text=>"TestText"}, :middle=>{:id=>"TestTestMiddle"}}} 
        def xml_to_hash!(nokoelem)
          e_hash = {}
          node_name = nokoelem.name.ruby_case.to_sym

          if nokoelem.is_a? Nokogiri::XML::Element
            nokoelem.attributes.each_pair do |k, v|
              e_hash[k.ruby_case.to_sym] = v.value
            end
            nokoelem.children.each do |c|
              new_hash = xml_to_hash!(c)
              unless new_hash.nil?
                e_hash.merge!(new_hash) do |k,v1,v2|
                  if(v1.is_a?(Array))
                    v1 << v2
                  else
                    [v1, v2]
                  end
                end
              end
            end
            return e_hash.empty? ? nil : {node_name => e_hash}
          elsif nokoelem.is_a? Nokogiri::XML::Text
            # Return a :text to value hash or nil if the text is empty
            return {node_name => nokoelem.text} if nokoelem.text != "\n"
            nil
          else
            # If something strange gets passed just return nil
            return nil
          end
        end


      end # Parser
    end # SOAP
  end # SPWS
end # Viewpoint

require 'soap/handsoap/parsers/ews_parser'
