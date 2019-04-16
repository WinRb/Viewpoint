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
require 'httpclient'

class Viewpoint::EWS::Connection
  include Viewpoint::EWS::ConnectionHelper
  include Viewpoint::EWS

  # This class returns both raw http response which is used to get cookies for grouping subscription
  EWSHttpResponse = Struct.new(:headers, :viewpoint_response)

  attr_reader :endpoint, :hostname
  # @param [String] endpoint the URL of the web service.
  #   @example https://<site>/ews/Exchange.asmx
  # @param [Hash] opts Misc config options (mostly for development)
  # @option opts [Fixnum] :ssl_verify_mode
  # @option opts [Fixnum] :receive_timeout override the default receive timeout
  #   seconds
  # @option opts [Array]  :trust_ca an array of hashed dir paths or a file
  def initialize(endpoint, opts = {})
    @log = Logging.logger[self.class.name.to_s.to_sym]
    if opts[:force_basic_auth].to_i == 1
      @httpcli = HTTPClient.new(:force_basic_auth => true)
    else
      @httpcli = HTTPClient.new
    end
    if opts[:trust_ca]
      @httpcli.ssl_config.clear_cert_store
      opts[:trust_ca].each do |ca|
        @httpcli.ssl_config.add_trust_ca ca
      end
    end
    @httpcli.ssl_config.verify_mode = opts[:ssl_verify_mode] if opts[:ssl_verify_mode]
    @httpcli.ssl_config.ssl_version = opts[:ssl_version] if opts[:ssl_version]
    # extend support for client_key and client_cert
    @httpcli.ssl_config.client_key = opts[:client_key] if opts[:client_key]
    @httpcli.ssl_config.client_cert = opts[:client_cert] if opts[:client_cert]
    # Up the keep-alive so we don't have to do the NTLM dance as often.
    @httpcli.keep_alive_timeout = 60
    @httpcli.receive_timeout = opts[:receive_timeout] if opts[:receive_timeout]
    @endpoint = endpoint
  end

  def set_auth(user,pass)
    @httpcli.set_auth(@endpoint.to_s, user, pass)
  end

  # Authenticate to the web service. You don't have to do this because
  # authentication will happen on the first request if you don't do it here.
  # @return [Boolean] true if authentication is successful, false otherwise
  def authenticate
    self.get && true
  end

  def hostname
    @hostname ||= URI(endpoint).hostname
  end

  # Every Connection class must have the dispatch method. It is what sends the
  # SOAP request to the server and calls the parser method on the EWS instance.
  #
  # This was originally in the ExchangeWebService class but it was added here
  # to make the processing chain easier to modify. For example, it allows the
  # reactor pattern to handle the request with a callback.
  # @param ews [Viewpoint::EWS::SOAP::ExchangeWebService] used to call
  #   #parse_soap_response
  # @param soapmsg [String]
  # @param opts [Hash] misc opts for handling the Response
  def dispatch(ews, soapmsg, opts)
    respmsg = post(soapmsg, options: opts)

    respmsg, resp_headers = respmsg if respmsg.is_a?(Array)

    @log.debug <<-EOF.gsub(/^ {6}/, '')
      Received SOAP Response:
      ----------------
      #{Nokogiri::XML(respmsg).to_xml}
      ----------------
    EOF

    # Returning raw http response in order to get Exchange cookie in header
    if opts[:include_http_headers]
      EWSHttpResponse.new(resp_headers, ews.parse_soap_response(respmsg, opts))
    else
      opts[:raw_response] ? respmsg : ews.parse_soap_response(respmsg, opts)
    end
  end

  # Copied from #dispatch above
  #
  # Every Connection class must have the dispatch method. It is what sends the
  # SOAP request to the server and calls the parser method on the EWS instance.
  #
  # This was originally in the ExchangeWebService class but it was added here
  # to make the processing chain easier to modify. For example, it allows the
  # reactor pattern to handle the request with a callback.
  # @param ews [Viewpoint::EWS::SOAP::ExchangeWebService] used to call
  #   #parse_soap_response
  # @param soapmsg [String]
  # @param opts [Hash] misc opts for handling the Response
  def dispatch_async(ews, soapmsg, opts)
    streaming_connection = post_async(soapmsg)

    if opts[:raw_response]
      streaming_connection # Returns the HTTPClient::Connection instance as a result
    else
      # TODO: Make do_soap_request_async returns another IO pipe if raw_response is false
      raise "Not yet supporting"
      # @log.debug <<-EOF.gsub(/^ {6}/, '')
      #   Received SOAP Response:
      #   ----------------
      #   #{Nokogiri::XML(respmsg).to_xml}
      #   ----------------
      # EOF
    end
  end

  # Send a GET to the web service
  # @return [String] If the request is successful (200) it returns the body of
  #   the response.
  def get
    check_response( @httpcli.get(@endpoint) )
  end

  # Send a POST to the web service
  # @return [String] If the request is successful (200) it returns the body of
  #   the response.
  def post(xmldoc, options: {})
    headers = {'Content-Type' => 'text/xml', 'Return-Client-Request-Id' => 'true', 'Send-Client-Latencies' => 'true'}
    headers.merge!(custom_http_headers(options[:customisable_headers])) if options[:customisable_headers]
    set_custom_http_cookies(options[:customisable_cookies]) if options[:customisable_cookies]

    raw_http_response = @httpcli.post(@endpoint, xmldoc, headers)

    check_response(raw_http_response, include_http_headers: options[:include_http_headers], request_body: xmldoc)
  end

  def custom_http_headers(headers)
    custom_headers = Viewpoint::EWS::SOAP::CUSTOMISABLE_HTTP_HEADERS.inject({}) do |header_hash, (header_key, header_name)|
      if headers.include?(header_key)
        header_hash[header_name] = headers[header_key]
      end
      header_hash
    end

    custom_headers || {}
  end

  def set_custom_http_cookies(cookies)
    Viewpoint::EWS::SOAP::CUSTOMISABLE_HTTP_COOKIES.each do |cookie_key, cookie_name|
      if cookies.include?(cookie_key)
        cookie = WebAgent::Cookie.new
        cookie.name = cookie_name
        cookie.value = cookies[cookie_key]
        cookie.url = URI(endpoint)
        @httpcli.cookie_manager.add(cookie)
      end
    end
  end

  # Copied from #post above but make a HTTP::Client#post_async request,
  #   which returns a HTTPClient::Connection instance as a result.
  #
  # Send a asynchronous POST to the web service which creates a connection for sending/receiving data
  # @return [HTTPClient::Connection] HTTPClient::Connection
  def post_async(xmldoc)
    headers = {'Content-Type' => 'text/xml', 'Return-Client-Request-Id' => 'true', 'Send-Client-Latencies' => 'true'}
    @httpcli.post_async(@endpoint, xmldoc, headers, request_body: xmldoc)
  end


  private

  def check_response(resp, include_http_headers: false, request_body: nil)
    @log.debug("Got HTTP response with headers: #{resp.headers}")
    @log.debug("Got HTTP response with body: #{resp.body}") if resp.body

    case resp.status
    when 200
      if include_http_headers
        return resp.body, resp.headers
      else
        return resp.body
      end
    when 302
      # @todo redirect
      raise Errors::UnhandledResponseError.new("Unhandled HTTP Redirect", resp, request_body: request_body)
    when 401
      raise Errors::UnauthorizedResponseError.new("Unauthorized request", resp, request_body: request_body)
    when 429
      raise Errors::TooManyRequestsError.new("Too many requests", resp, request_body: request_body)
    when 500
      if resp.headers['Content-Type'] =~ /xml/
        err_string, err_code = parse_soap_error(resp.body)
        raise Errors::SoapResponseError.new("SOAP Error: Message: #{err_string}  Code: #{err_code}", resp, err_code, err_string, request_body: request_body)
      else
        raise Errors::ServerError.new("Internal Server Error. Message: #{resp.body}", resp, request_body: request_body)
      end
    else
      raise Errors::ResponseError.new("HTTP Error Code: #{resp.status}, Msg: #{resp.body}", resp, request_body: request_body)
    end
  end

  # @param [String] xml to parse the errors from.
  def parse_soap_error(xml)
    ndoc = Nokogiri::XML(xml)
    ns = ndoc.collect_namespaces
    err_string  = ndoc.xpath("//faultstring",ns).text
    err_code    = ndoc.xpath("//faultcode",ns).text
    @log.debug "Internal SOAP error. Message: #{err_string}, Code: #{err_code}"
    [err_string, err_code]
  end

end
