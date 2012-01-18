require 'httpclient'
class Viewpoint::EWS::Connection
  include Viewpoint::EWS

  attr_reader :endpoint, :ews
  # @param [String] endpoint the URL of the web service.
  #   @example https://<site>/ews/Exchange.asmx
  def initialize(endpoint)
    @log = Logging.logger[self.class.name.to_s.to_sym]
    @httpcli = HTTPClient.new
    # Up the keep-alive so we don't have to do the NTLM dance as often.
    @httpcli.keep_alive_timeout = 60
    @endpoint = endpoint
    @ews = SOAP::ExchangeWebService.new(self)
  end

  def set_auth(user,pass)
    @httpcli.set_auth(@endpoint.to_s, user, pass)
  end

  # Authenticate to the web service
  # @return [Boolean] true if authentication is successful, false otherwise
  def authenticate(websvc)
    self.get && true
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
  def post(xmldoc)
    headers = {'Content-Type' => 'text/xml'}
    check_response( @httpcli.post(@endpoint, xmldoc, headers) )
  end


  private

  def check_response(resp)
    case resp.status
    when 200
      resp.body
    when 302
      # @todo redirect
      raise "Unhandled HTTP Redirect"
    when 500
      if resp.headers['Content-Type'].include?('xml')
        err_string, err_code = parse_soap_error(resp.body)
        raise "SOAP Error: Message: #{err_string}  Code: #{err_code}"
      else
        raise "Internal Server Error. Message: #{resp.body}"
      end
    else
      raise "HTTP Error Code: #{resp.status}, Msg: #{resp.body}"
    end
  end

  # @param [String] xml to parse the errors from.
  def parse_soap_error(xml)
    ndoc = Nokogiri::XML(xml)
    ns = ndoc.collect_namespaces
    err_string  = ndoc.xpath("//xmlns:errorstring",ns).text
    err_code    = ndoc.xpath("//xmlns:errorcode",ns).text
    @log.debug "Internal SOAP error. Message: #{err_string}, Code: #{err_code}"
    [err_string, err_code]
  end

end
