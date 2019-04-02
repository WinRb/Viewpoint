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

module Viewpoint::EWS::Errors
  class ResponseError < RuntimeError
    attr_reader :response, :request_body

    def initialize(message, response, request_body: nil)
      super(message)
      @response = response
      @request_body = request_body
    end

    def status
      response.status
    end

    def body
      response.body
    end

    def headers
      response.headers
    end

  end

  class UnhandledResponseError < ResponseError
  end

  class ServerError < ResponseError
  end

  class UnauthorizedResponseError < ResponseError
  end

  class TooManyRequestsError < ResponseError
  end

  class SoapResponseError < ResponseError
    attr_reader :faultcode,
                :faultstring

    def initialize(message, response, faultcode, faultstring, request_body: nil)
      super(message, response, request_body: request_body)
      @faultcode = faultcode
      @faultstring = faultstring
    end
  end
end
