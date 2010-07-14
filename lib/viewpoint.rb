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
require 'singleton'

# Load the backend SOAP infrastructure.  Today this is Handsoap.
#require 'soap/soap_provider'

# Load the model classes
#require 'model/sp_message'


module Viewpoint
  module EWS
    class EWS
      include Singleton

      attr_reader :ews

      def self.endpoint=(endpoint)
        @@endpoint = endpoint
      end

      def self.endpoint
        @@endpoint
      end

      def self.set_auth(user,pass)
        @@user = user
        @@pass = pass
      end

      def initialize
        require 'soap/soap_provider'

        @ews = SOAP::ExchangeWebService.new
      end

    end # class EWS
  end # EWS
end
