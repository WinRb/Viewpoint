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
require 'exceptions/exceptions'

# Load the backend SOAP / EWS infrastructure.
require 'ews/soap'
require 'ews/ews_service'

# Load the model classes
# Base Models
require 'model/model'
require 'model/mailbox_user'
require 'model/attendee'
require 'model/generic_folder'
require 'model/item_field_uri_map' # supports Item
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
require 'model/attachment'
require 'model/file_attachment'
require 'model/item_attachment'
