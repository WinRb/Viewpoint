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
    module SOAP
      class GetEventsResponseMessage < ResponseMessage
        def notification
          safe_hash_access message, %i[elems notification elems]
        end

        def subscription_id
          safe_hash_access notification[0], %i[subscription_id text]
        end

        def previous_watermark
          safe_hash_access notification[1], %i[previous_watermark text]
        end

        def new_watermark
          ev = notification.last
          return unless ev

          type = ev.keys.first
          ev[type][:elems][0][:watermark][:text]
        end

        def more_events?
          safe_hash_access(notification[2], %i[more_events text]) == 'true'
        end

        def events
          notification[3..]
        end
      end
    end
  end
end
