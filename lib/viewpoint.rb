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
require 'ostruct'
require 'logging'

# String utilities
require 'viewpoint/string_utils'

# Load the logging setup
require 'viewpoint/logging'

# Load the Exception classes
require 'viewpoint/ews/exceptions/exceptions'

# Load the backend SOAP / EWS infrastructure.
require 'viewpoint/ews/soap'
require 'viewpoint/ews/soap/response_message'
require 'viewpoint/ews/soap/ews_response'
require 'viewpoint/ews/soap/ews_soap_response'
require 'viewpoint/ews/soap/ews_soap_availability_response'
require 'viewpoint/ews/soap/ews_soap_free_busy_response'
require 'viewpoint/ews/soap/ews_soap_room_response'
require 'viewpoint/ews/soap/ews_soap_roomlist_response'
require 'viewpoint/ews/soap/builders/ews_builder'
require 'viewpoint/ews/soap/parsers/ews_parser'
require 'viewpoint/ews/soap/parsers/ews_sax_document'
# Mix-ins for the ExchangeWebService
require 'viewpoint/ews/soap/exchange_data_services'
require 'viewpoint/ews/soap/exchange_notification'
require 'viewpoint/ews/soap/exchange_synchronization'
require 'viewpoint/ews/soap/exchange_availability'
require 'viewpoint/ews/soap/exchange_user_configuration'
require 'viewpoint/ews/soap/exchange_time_zones'
require 'viewpoint/ews/soap/exchange_web_service'

require 'viewpoint/ews/errors'
require 'viewpoint/ews/connection_helper'
require 'viewpoint/ews/connection'

require 'viewpoint/ews/impersonation'

# Base Types
require 'viewpoint/ews/types'
require 'viewpoint/ews/types/item_field_uri_map'
require 'viewpoint/ews/types/generic_folder'
require 'viewpoint/ews/types/item'
# Folders
require 'viewpoint/ews/types/folder'
require 'viewpoint/ews/types/calendar_folder'
require 'viewpoint/ews/types/contacts_folder'
require 'viewpoint/ews/types/tasks_folder'
require 'viewpoint/ews/types/search_folder'
# Items
require 'viewpoint/ews/types/message'
require 'viewpoint/ews/types/calendar_item'
require 'viewpoint/ews/types/contact'
require 'viewpoint/ews/types/distribution_list'
require 'viewpoint/ews/types/meeting_message'
require 'viewpoint/ews/types/meeting_request'
require 'viewpoint/ews/types/meeting_response'
require 'viewpoint/ews/types/meeting_cancellation'
require 'viewpoint/ews/types/task'
require 'viewpoint/ews/types/attachment'
require 'viewpoint/ews/types/file_attachment'
require 'viewpoint/ews/types/item_attachment'
require 'viewpoint/ews/types/mailbox_user'
require 'viewpoint/ews/types/out_of_office'
require 'viewpoint/ews/types/export_items_response_message'

# Events
require 'viewpoint/ews/types/event'
require 'viewpoint/ews/types/copied_event'
require 'viewpoint/ews/types/created_event'
require 'viewpoint/ews/types/deleted_event'
require 'viewpoint/ews/types/free_busy_changed_event'
require 'viewpoint/ews/types/modified_event'
require 'viewpoint/ews/types/moved_event'
require 'viewpoint/ews/types/new_mail_event'
require 'viewpoint/ews/types/status_event'

# Template Objects
require 'viewpoint/ews/templates/message'
require 'viewpoint/ews/templates/forward_item'
require 'viewpoint/ews/templates/reply_to_item'
require 'viewpoint/ews/templates/calendar_item'
require 'viewpoint/ews/templates/task'

# The proxy between the models and the web service
require 'viewpoint/ews/ews_client'
