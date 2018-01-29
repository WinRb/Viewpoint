=begin
  This file is a cotribution to Viewpoint; the Ruby library for Microsoft Exchange Web Services.

  Copyright © 2013 Mark McCahill <mark.mccahill@duke.edu>

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

module Viewpoint::EWS::SOAP
  class EwsSoapGetStreamingEventsResponse < EwsSoapResponse
    include Viewpoint::StringUtils

    def notifications
      guard_hash(response_message[:elems], [:notifications, :elems])
    end

    def notification_events
      guard_hash(notifications.first, [:notification, :elems])
    end

    def events
      notification_events[1..-1].map { |event| Viewpoint::EWS::SOAP::GetStreamingEventResponse.new(event) }
    end

    def subscription_id
      notification_events[0][:subscription_id][:text]
    end

    def error_subscription_ids
      ids = guard_hash(response_message[:elems], [:error_subscription_ids, :elems])

      if ids
        ids.map { |id| id[:subscription_id][:text] }
      else
        []
      end
    end

  end # END class EwsSoapGetStreamingEventsResponse < EwsSoapResponse
end # Viewpoint::EWS::SOAP
