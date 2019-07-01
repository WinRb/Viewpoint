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
  class EwsSoapGetStreamingEventsNotification
    attr_reader :notification_event_hashes

    def initialize(notification_event_hashes:)
      @notification_event_hashes = notification_event_hashes
    end

    def subscription_id
      @subscription_id ||= notification_event_hashes[0][:subscription_id][:text]
    rescue => expection
      raise ArgumentError.new("invalid notification_event_hashes: #{notification_event_hashes} (#{expection.message})")
    end

    def notification_events
      @notification_events ||= notification_event_hashes[1..-1].map { |event| Viewpoint::EWS::SOAP::GetStreamingEventResponse.new(event) }
    rescue => expection
      raise ArgumentError.new("invalid notification_event_hashes: #{notification_event_hashes} (#{expection.message})")
    end

  end # class EwsSoapGetStreamingEventsNotification
end # Viewpoint::EWS::SOAP
