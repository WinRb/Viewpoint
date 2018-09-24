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
  class EwsSoapGetUserSettingsResponse < EwsSoapResponse
    include Viewpoint::StringUtils

    def response
      body[0][response_key]
    end

    def response_message
      key = response.keys.first
      response[key]
    end

    def response_code
      response_message[:elems][:response_code][:text]
    end
    alias :code :response_code

    def response_key
      body[0].keys.first
    end

    def user_settings_string_values
      self.class.user_settings_string_values_from_response(response)
    end

    private

    def simplify!
      key = response_key
      body[0][key] = body[0][key][:elems].inject(:merge)
      response_message[:elems] = response_message[:elems].inject(:merge)
    end

    # @param response [Hash] the response as a SOAP Hash
    # @return [Hash] settings as simple Hash
    def self.user_settings_string_values_from_response(response)
      string_attribs_array_to_hash(guard_hash(response, [:response, :elems, :user_responses, :elems, :user_response, :elems, :user_settings, :elems]))
    end
  end
end
