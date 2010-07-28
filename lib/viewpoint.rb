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

# Load the backend SOAP infrastructure.  Today this is Handsoap.
require 'soap/soap_provider'

# Load the model classes
# Base Models
require 'model/model'
require 'model/mailbox_user'
require 'model/folder'
require 'model/item'
# Specific Models
require 'model/calendar_folder'
require 'model/mail_folder'

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
      include Viewpoint

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

      # Search Contacts for this string
      # @param [String] contact_name The string to search for
      # @returns [EwsSoapResponse] A Response message with an items array: EwsSoapResponse#items
      def search_contacts(contact_name)
        @ews.resolve_names(contact_name)
      end

      # Get a Viewpoint folder object
      # @param [Symbol, String] fid The Id of the folder.  If you want to get the folder by name
      #   pass a Symbol like :calendar, if you know the Exchange Id of the folder pass that as
      #   a String
      # @return The folder asked for
      def get_folder(fid)
        resp_msg = @ews.get_folder([fid])
        folder = resp_msg.items.first
        case folder.keys.first
        when :folder
          return MailFolder.new(folder[folder.keys.first])
        when :calendar_folder
          return CalendarFolder.new(folder[folder.keys.first])
        else
          raise StandardError, "<#{fid}> Unknow Folder Type"
        end
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
  # The String#to_s is done in case we are passed a Symbol
  # @see Viewpoint::ruby_case
  def camel_case(string)
    string.to_s.split(/_/).map {|i| i.capitalize}.join
  end
end
