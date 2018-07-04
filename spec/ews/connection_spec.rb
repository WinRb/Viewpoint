require "spec_helper"

describe Viewpoint::EWS::Connection do
  let(:endpoint) { "https://endpoint.com/exchange.asmx" }
  let(:connection) { described_class.new(endpoint) }
  let(:anchor_mailbox) { "mailbox@example.com" }
  let(:prefer_server_affinity) { true }
  let(:backend_override_cookie) { "cookie" }
  let(:request_options) {
    {
      anchor_mailbox: anchor_mailbox,
      prefer_server_affinity: prefer_server_affinity,
      backend_override_cookie: backend_override_cookie
    }
  }

  describe "#post" do
    let(:options) { {} }
    let(:xmldoc) { double(:xmldoc) }

    before do
      allow(connection).to receive(:check_response)
    end

    subject { connection.post(xmldoc, options: options) }

    context "when request options are passed in" do
      let(:options) { { request_options: request_options } }

      it "sets the custom HTTP headers and cookies" do
        expect(connection).to receive(:set_custom_http_headers).with(request_options)
        expect(connection).to receive(:set_custom_http_cookies).with(request_options)

        subject
      end
    end

    context "when no request options are passed in" do
      it "doesn't set the HTTP headers and cookies" do
        expect(connection).not_to receive(:set_custom_http_headers)
        expect(connection).not_to receive(:set_custom_http_cookies)

        subject
      end
    end
  end

  describe "#set_custom_http_headers" do
    let(:existing_http_headers) { { "some_header" => "some_value" } }

    before { connection.instance_variable_set(:@http_headers, existing_http_headers) }
    subject { connection.set_custom_http_headers(request_options) }

    context "when custom HTTP headers are passed in" do

      it "merges to the existing HTTP headers" do
        subject
        expect(connection.instance_variable_get(:@http_headers)).to eq(
          {
            "some_header" => "some_value",
            Viewpoint::EWS::SOAP::CUSTOMISABLE_HTTP_HEADERS[:anchor_mailbox] => anchor_mailbox,
            Viewpoint::EWS::SOAP::CUSTOMISABLE_HTTP_HEADERS[:prefer_server_affinity] => prefer_server_affinity
          }
        )
      end
    end

    context "when no custom HTTP headers are passed in" do
      let(:request_options) { {} }

      it "doesn't change the HTTP headers" do
        subject
        expect(connection.instance_variable_get(:@http_headers)).to eq(existing_http_headers)
      end
    end
  end

  describe "#set_custom_http_cookies" do
    subject { connection.set_custom_http_cookies(request_options) }

    context "when custom HTTP cookies are passed in" do
      # Using an OpenStruct object instead of a double because the name attribute
      # is being overwritten in the set_custom_http_cookies method, and it's
      # going to clash with the double's built-in name method.
      let(:backend_override_cookie_object) { OpenStruct.new(name: nil, value: nil, url: nil) }

      it "adds a new cookie to the HTTP cookie manager" do
        httpcli = connection.instance_variable_get(:@httpcli)
        expect(WebAgent::Cookie).to receive(:new) { backend_override_cookie_object }
        allow(backend_override_cookie_object).to receive(:name)
          .with(Viewpoint::EWS::SOAP::CUSTOMISABLE_HTTP_HEADERS[:backend_override_cookie])
        allow(backend_override_cookie_object).to receive(:value)
          .with(backend_override_cookie)
        allow(backend_override_cookie_object).to receive(:url).with(
            URI(connection.endpoint)
          )
        expect(httpcli.cookie_manager).to receive(:add).with(
          backend_override_cookie_object
        )

        subject
      end
    end

    context "when no custom HTTP cookies are passed in" do
      let(:request_options) { {} }

      it "doesn't add a new cookie to the HTTP cookie manager" do
        httpcli = connection.instance_variable_get(:@httpcli)
        expect(WebAgent::Cookie).not_to receive(:new)
        expect(httpcli.cookie_manager).not_to receive(:add)

        subject
      end
    end
  end

#   +  def set_custom_http_cookies(request_options)
# +    Viewpoint::EWS::SOAP::CUSTOMISABLE_HTTP_COOKIES.each do |cookie_key, cookie_name|
# +      if request_options.include?(cookie_key)
# +        cookie = WebAgent::Cookie.new
# +        cookie.name = cookie_name
# +        cookie.value = request_options[cookie_key]
# +        cookie.url = URI(endpoint)
# +        @httpcli.cookie_manager.add(cookie)
# +      end
# +    end
#    end	   end
end
