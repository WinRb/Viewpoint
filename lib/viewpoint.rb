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

# We only what one instance of this class so include Singleton
require 'singleton'

# Load the backend SOAP infrastructure.  Today this is Handsoap.
require 'soap/soap_provider'

# Load the model classes
# Base Models
require 'model/mailbox_user'
#require 'model/folder'
#require 'model/item'
# Specific Models
#require 'model/calendar'

# Load the Exception classes
require 'exceptions/exceptions'


# This is the Singlenton class that controls access and presentation to Exchange
# Web Services.  It is possible to just use the SOAP classes themselves but this
# is what ties all the pieces together.
# @attr_reader [SOAP::ExchangeWebService] :ews The SOAP object used to make calls
#   to the Exchange Web Service.
module Viewpoint
  module EWS
    class EWS
      include Singleton

      attr_reader :ews

      def self.endpoint=(endpoint)
        @@endpoint = endpoint
        SOAP::ExchangeWebService.endpoint(:uri => endpoint, :version => 1)
      end

      def self.endpoint
        @@endpoint
      end
      
      def self.set_auth(user,pass)
        SOAP::ExchangeWebService.set_auth(user,pass)
      end

      def initialize
        @ews = SOAP::ExchangeWebService.new
      end

    end # class EWS
  end # EWS
  
  # Change CamelCased strings to ruby_cased strings
  # It uses the lookahead assertion ?=  In this case it basically says match
  # anything followed by a capital letter, but not the capital letter itself.
  # @see http://www.pcre.org/pcre.txt The PCRE guide for more details
  # @see Viewpoint::camel_case
  def ruby_case(string)
    string.split(/(?=[A-Z])/).join('_').downcase
  end

  # Change a ruby_cased string to CamelCased
  # @see Viewpoint::ruby_case
  def camel_case(string)
    string.split(/_/).map {|i| i.capitalize}.join
  end
end
