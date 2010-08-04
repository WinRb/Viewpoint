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
require 'date'
require 'base64'

# Class Extensions
require 'extensions/string'

# Load the backend SOAP infrastructure.  Today this is Handsoap.
require 'soap/soap_provider'

# Load the model classes
# Base Models
require 'model/model'
require 'model/mailbox_user'
require 'model/generic_folder'
require 'model/item'
# Specific Models
# Folders
require 'model/folder'
require 'model/calendar_folder'
require 'model/contacts_folder'
require 'model/search_folder'
require 'model/tasks_folder'
# Items
require 'model/message'
require 'model/calendar_item'
require 'model/contact'
require 'model/distribution_list'
require 'model/meeting_message'
require 'model/meeting_request'
require 'model/meeting_response'
require 'model/meeting_cancellation'
require 'model/task'

# Load the Exception classes
require 'exceptions/exceptions'


# This is the Singlenton class that controls access and presentation to Exchange
# Web Services.  It is possible to just use the SOAP classes themselves but this
# is what ties all the pieces together.
# @attr_reader [SOAP::ExchangeWebService] :ews The SOAP object used to make calls
#   to the Exchange Web Service.
module Viewpoint
  module EWS
    # @attr_reader [Viewpoint::EWS::SOAP::ExchangeWebService] :ews The EWS object used
    #   to make SOAP calls.  You typically don't need to use this, but if you want to
    #   play around with the SOAP back-end it's available.
    class EWS
      include Singleton
      include Viewpoint

      attr_reader :ews

      # Set the endpoint for Exchange Web Services.  
      # @param [String] endpoint The URL of the endpoint. This should end in
      #   'exchange.asmx' and is typically something like this:
      #   https://myexch/ews/exchange.asmx
      # @param [Integer] version The SOAP version to use.  This defaults to 1
      #   and you should not need to pass this parameter.
      def self.endpoint=(endpoint, version = 1)
        @@endpoint = endpoint
        SOAP::ExchangeWebService.endpoint(:uri => endpoint, :version => version)
      end

      # Fetch the current endpoint
      def self.endpoint
        @@endpoint
      end

      # Set the SOAP username and password.
      # @param [String] user The user name
      # @param [String] pass The password
      def self.set_auth(user,pass)
        @@user = user
        SOAP::ExchangeWebService.set_auth(user,pass)
      end

      # Set the http driver that the SOAP back-end will use.
      # @param [Symbol] driver The HTTP driver.  Available drivers:
      #   :curb, :net_http, :http_client(Default)
      def self.set_http_driver(driver)
        Handsoap.http_driver = driver
      end

      def initialize
        @ews = SOAP::ExchangeWebService.new
      end

      # The MailboxUser object that represents the user connected to EWS.
      def me
        @me ||= MailboxUser.find_user("#{@@user}@")
      end

    end # class EWS
  end # EWS
end
