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

# This file requires the appropriate SOAP Library (Handsoap today) and also
# defines certain contants that SOAP methods may use.
module Viewpoint
  module EWS
    module SOAP

      # CONSTANTS

      NS_SOAP         = 'soap' # http://schemas.xmlsoap.org/soap/envelope/
      NS_EWS_TYPES    = 't'    # http://schemas.microsoft.com/exchange/services/2006/types
      NS_EWS_MESSAGES = 'm'    # http://schemas.microsoft.com/exchange/services/2006/messages

      # used in ResolveNames to determine where names are resolved
      ActiveDirectory = 'ActiveDirectory'
      ActiveDirectoryContacts = 'ActiveDirectoryContacts'
      Contacts = 'Contacts'
      ContactsActiveDirectory = 'ContactsActiveDirectory'



      # A Generic Class for SOAP returns.
      # @attr_reader [String] :message The text from the EWS element <m:ResponseCode>
      class EwsSoapResponse

        attr_reader :status, :code, :message, :soap_response
        attr_accessor :items

        def initialize(status, code, message)
          @status, @code, @message = status, code, message

          # Items is an array where hash types get stored for return
          @items = []
        end

        def set_soap_resp(response)
          @soap_response = response
        end

      end # EwsSoapResponse


    end # SOAP
  end # EWS
end # Viewpoint

require 'soap/handsoap/ews_service'
