# frozen_string_literal: true

#   This file is part of Viewpoint; the Ruby library for Microsoft Exchange Web Services.
#
#   Copyright © 2011 Dan Wanek <dan.wanek@gmail.com>
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

module Viewpoint
  module EWS
    module Types
      # Item Attachment EWS data type.
      class ItemAttachment < Attachment
        ITEM_ATTACH_KEY_PATHS = {
          item: [:item],
          message: [:message],
          calendar_item: [:calendar_item],
          contact: [:contact],
          task: [:task],
          meeting_message: [:meeting_message],
          meeting_request: [:meeting_request],
          meeting_response: [:meeting_response],
          meeting_cancellation: [:meeting_cancellation]
        }.freeze

        ITEM_ATTACH_KEY_TYPES = {
          message: :build_message,
          calendar_item: :build_calendar_item,
          contact: :build_contact,
          task: :build_task,
          meeting_message: :build_meeting_message,
          meeting_request: :build_meeting_request,
          meeting_response: :build_meeting_response,
          meeting_cancellation: :build_meeting_cancellation
        }.freeze

        ITEM_ATTACH_KEY_ALIAS = {}.freeze

        def get_all_properties!
          resp = ews.get_attachment attachment_ids: [id]
          @ews_item.merge!(parse_response(resp))
        end

        def self.method_missing(method, *args, &block)
          if method.to_s =~ /^build_(.+)$/
            class_by_name(::Regexp.last_match(1)).new(ews, args[0])
          else
            super
          end
        end
        private_class_method :method_missing

        def self.respond_to_missing?(method, include_private = false)
          method.to_s.match?(/^build_(.+)$/) || super
        end
        private_class_method :respond_to_missing?

        def key_paths
          super.merge(ITEM_ATTACH_KEY_PATHS)
        end

        def key_types
          super.merge(ITEM_ATTACH_KEY_TYPES)
        end

        def key_alias
          super.merge(ITEM_ATTACH_KEY_ALIAS)
        end

        def parse_response(resp)
          unless resp.status == 'Success'
            raise EwsError,
                  "Could not retrieve #{self.class}. #{resp.code}: #{resp.message}"
          end

          resp.response_message[:elems][:attachments][:elems][0][:item_attachment][:elems].inject(&:merge)
        end
      end
    end
  end
end
