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
        end

        # This is the main parser method.  It takes the response type and tries to
        # call a Ruby method of the same name.
        # @todo Decide on an appropriate response if a method does not exist.
        def parse(opts)
          resp_method = ruby_case(@response_type)
          if(respond_to?(resp_method))
            puts "Method Exists: #{resp_method}" if $DEBUG
            method(resp_method).call(opts)
          else
            puts "No Method: #{resp_method}" if $DEBUG
            @response
          end
        end

        private

        def method_exists?(method_name)
          return self.methods.include?(method_name)
        end

      end # Parser
    end # SOAP
  end # SPWS
end # Viewpoint

require 'parsers/ews_parser'
