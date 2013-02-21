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

require 'kconv' if(RUBY_VERSION.start_with? '1.9') # bug in rubyntlm with ruby 1.9.x
require 'date'
require 'base64'
require 'nokogiri'
require 'logging'

# Class Extensions (Monkey patches)
require 'extensions/string'

module Viewpoint
  module EWS
    attr_reader :logger
    Logging.logger.root.level = :debug
    Logging.logger.root.appenders = Logging.appenders.stdout

    def self.root_logger
      Logging.logger.root
    end

  end # EWS
end

# Load the Exception classes
require 'ews/exceptions/exceptions'

# Load the backend SOAP / EWS infrastructure.
require 'ews/soap'
require 'ews/soap/ews_soap_response'
require 'ews/soap/ews_soap_availability_response'
require 'ews/soap/ews_soap_free_busy_response'
require 'ews/soap/builders/ews_builder'
require 'ews/soap/parsers/ews_parser'
require 'ews/soap/parsers/ews_sax_document'
# Mix-ins for the ExchangeWebService
require 'ews/soap/exchange_data_services'
require 'ews/soap/exchange_availability'
require 'ews/soap/exchange_user_configuration'
require 'ews/soap/exchange_web_service'

require 'ews/connection'

# Base Types
require 'ews/types'
require 'ews/types/item_field_uri_map'
require 'ews/types/generic_folder'
require 'ews/types/item'
# Folders
require 'ews/types/folder'
require 'ews/types/calendar_folder'
require 'ews/types/contacts_folder'
require 'ews/types/tasks_folder'
require 'ews/types/search_folder'
# Items
require 'ews/types/message'
require 'ews/types/calendar_item'
require 'ews/types/contact'
require 'ews/types/distribution_list'
require 'ews/types/meeting_message'
require 'ews/types/meeting_request'
require 'ews/types/meeting_response'
require 'ews/types/meeting_cancellation'
require 'ews/types/task'
require 'ews/types/attachment'
require 'ews/types/file_attachment'
require 'ews/types/item_attachment'
require 'ews/types/mailbox_user'
require 'ews/types/out_of_office'

# The proxy between the models and the web service
require 'ews/ews_client'
