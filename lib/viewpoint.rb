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

# Third Party Libraries
require 'mail' # used to convert Message items to RFC822 compliant messages
require 'icalendar' # used to convert Calendar items to iCalendar objects

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
require 'ews/soap/builders/ews_builder'
require 'ews/soap/parsers/parser'
require 'ews/soap/parsers/ews_parser'
require 'ews/soap/exchange_web_service'

require 'ews/connection'

# Load the model classes
# Base Models
require 'ews/model/model'
require 'ews/model/mailbox_user'
require 'ews/model/attendee'
require 'ews/model/generic_folder'
require 'ews/model/item_field_uri_map' # supports Item
require 'ews/model/item'
# Specific Models
# Folders
require 'ews/model/folder'
require 'ews/model/calendar_folder'
require 'ews/model/contacts_folder'
require 'ews/model/search_folder'
require 'ews/model/tasks_folder'
# Items
require 'ews/model/message'
require 'ews/model/calendar_item'
require 'ews/model/contact'
require 'ews/model/distribution_list'
require 'ews/model/meeting_message'
require 'ews/model/meeting_request'
require 'ews/model/meeting_response'
require 'ews/model/meeting_cancellation'
require 'ews/model/task'
require 'ews/model/attachment'
require 'ews/model/file_attachment'
require 'ews/model/item_attachment'

# The proxy between the models and the web service
require 'ews/ews_client'
