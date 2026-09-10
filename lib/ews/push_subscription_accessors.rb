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
    # Push Subscription operations mixed into the EWS client.
    module PushSubscriptionAccessors
      include Viewpoint::EWS

      def parse_send_notification(msg)
        parser = Viewpoint::EWS::SOAP::EwsParser.new(msg)
        resp = parser.parse response_class: Viewpoint::EWS::SOAP::EwsResponse
        rmsg = resp.response_messages[0]
        raise EwsSubscriptionError, "#{rmsg.code}: #{rmsg.message_text}" unless rmsg.success?

        rmsg
      end
    end
  end
end
