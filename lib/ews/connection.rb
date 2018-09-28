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
require 'httparty'
require 'httpclient'

class Viewpoint::EWS::Connection
  include Viewpoint::EWS::ConnectionHelper
  include Viewpoint::EWS

  attr_reader :endpoint
  # @param [String] endpoint the URL of the web service.
  #   @example https://<site>/ews/Exchange.asmx
  # @param [Hash] opts Misc config options (mostly for developement)
  # @option opts [Fixnum] :ssl_verify_mode
  # @option opts [Fixnum] :receive_timeout override the default receive timeout
  #   seconds
  # @option opts [Fixnum] :connect_timeout override the default connect timeout
  #   seconds
  # @option opts [Array]  :trust_ca an array of hashed dir paths or a file
  # @option opts [String] :user_agent the http user agent to use in all requests
  def initialize(endpoint, username, credentials, opts = {})
    @log = Logging.logger[self.class.name.to_s.to_sym]
    @endpoint = endpoint
    @username = username
    @credentials = credentials
    oauth? ? init_oauth_http_client : init_ntlm_http_client(opts)
  end

  def oauth?
    @credentials[:type] == :oauth
  end

  def init_ntlm_http_client(opts)
    @httpcli = opts[:user_agent] ? HTTPClient.new(agent_name: opts[:user_agent]) : HTTPClient.new

    if opts[:trust_ca]
      @httpcli.ssl_config.clear_cert_store
      opts[:trust_ca].each do |ca|
        @httpcli.ssl_config.add_trust_ca ca
      end
    end

    @httpcli.ssl_config.verify_mode = opts[:ssl_verify_mode] if opts[:ssl_verify_mode]
    @httpcli.ssl_config.ssl_version = opts[:ssl_version] if opts[:ssl_version]
    # Up the keep-alive so we don't have to do the NTLM dance as often.
    @httpcli.keep_alive_timeout = 60
    @httpcli.receive_timeout = opts[:receive_timeout] if opts[:receive_timeout]
    @httpcli.connect_timeout = opts[:connect_timeout] if opts[:connect_timeout]
    set_auth
  end

  def set_auth
    @httpcli.set_auth(@endpoint.to_s, @username, @credentials[:password])
  end

  def init_oauth_http_client
    @auth_header = { 'Authorization' => 'Bearer ' + @credentials[:access_token] }
    #see if i can get that other fancy stuff
    @httpcli = HTTParty
  end

  # Authenticate to the web service. You don't have to do this because
  # authentication will happen on the first request if you don't do it here.
  # @return [Boolean] true if authentication is successful, false otherwise
  def authenticate
    self.get && true
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
    respmsg = post(soapmsg)
    @log.debug <<-EOF.gsub(/^ {6}/, '')
      Received SOAP Response:
      ----------------
      #{Nokogiri::XML(respmsg).to_xml}
      ----------------
    EOF
    opts[:raw_response] ? respmsg : ews.parse_soap_response(respmsg, opts)
  end

  # Send a GET to the web service
  # @return [String] If the request is successful (200) it returns the body of
  #   the response.
  def get
    headers = oauth? ? [headers: @auth_header] : []
    response = @httpcli.get(@endpoint, *headers)
    check_response(response)
  end

  # Send a POST to the web service
  # @return [String] If the request is successful (200) it returns the body of
  #   the response.
  def post(xmldoc)
    headers = { 'Content-Type' => 'text/xml' }
    payload = oauth? ? [{ headers: headers.merge(@auth_header), body: xmldoc.to_s }] : [xmldoc, headers] 
    check_response(@httpcli.post(@endpoint, *payload))
  end


  private

  def check_response(resp)
    status = oauth? ? resp.code : resp.status
    case status
    when 200
      resp.body
    when 302
      # @todo redirect
      raise Errors::UnhandledResponseError.new("Unhandled HTTP Redirect", resp)
    when 401
      raise Errors::UnauthorizedResponseError.new("Unauthorized request", resp)
    when 500
      if resp.headers['Content-Type'] =~ /xml/
        err_string, err_code = parse_soap_error(resp.body)
        raise Errors::SoapResponseError.new("SOAP Error: Message: #{err_string}  Code: #{err_code}", resp, err_code, err_string)
      else
        raise Errors::ServerError.new("Internal Server Error. Message: #{resp.body}", resp)
      end
    else
      raise Errors::ResponseError.new("HTTP Error Code: #{resp.status}, Msg: #{resp.body}", resp)
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
