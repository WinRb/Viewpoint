require "spec_helper"

describe Viewpoint::EWS::Connection do
  let(:endpoint) { "https://endpoint.com/exchange.asmx" }
  let(:connection) { described_class.new(endpoint) }
  let(:anchor_mailbox) { "mailbox@example.com" }
  let(:prefer_server_affinity) { true }
  let(:backend_override_cookie) { "cookie" }
  let(:customisable_headers) { { anchor_mailbox: anchor_mailbox, prefer_server_affinity: prefer_server_affinity } }
  let(:customisable_cookies) { { backend_override_cookie: backend_override_cookie } }

  describe "#post" do
    let(:options) { {} }
    let(:xmldoc) { double(:xmldoc) }

    before do
      allow(connection).to receive(:check_response)
    end

    subject { connection.post(xmldoc, options: options) }

    context "when customisable headers are passed in" do
      let(:options) { { customisable_headers: customisable_headers } }
      let(:expected_headers) { {'Content-Type' => 'text/xml'}.merge!(customisable_headers) }

      it "merges the custom HTTP headers to the existing headers" do
        expect(connection).to receive(:custom_http_headers) { customisable_headers }
        expect(connection.instance_variable_get(:@httpcli)).to receive(:post)
          .with(endpoint, xmldoc, expected_headers)

        subject
      end
    end

    context "when customisable cookies are passed in" do
      let(:options) { { customisable_cookies: customisable_cookies } }

      it "sets the custom HTTP cookies" do
        expect(connection).to receive(:set_custom_http_cookies).with(customisable_cookies)

        subject
      end
    end

    context "when no customisable cookies are passed in" do
      let(:expected_headers) { {'Content-Type' => 'text/xml'} }

      it "sets only the default headers" do
        expect(connection).not_to receive(:custom_http_headers)
        expect(connection.instance_variable_get(:@httpcli)).to receive(:post)
          .with(endpoint, xmldoc, expected_headers)

        subject
      end

      it "doesn't set additional cookies" do
        expect(connection).not_to receive(:set_custom_http_cookies)

        subject
      end
    end
  end

  describe "#custom_http_headers" do
    let(:additional_headers) { { "some_header" => "some_value" } }
    let(:headers) { customisable_headers.merge(additional_headers) }

    subject { connection.custom_http_headers(headers) }

    context "when custom HTTP headers are passed in" do
      it "only sets the whitelisted headers" do
        expect(subject).to eq(
          {
            Viewpoint::EWS::SOAP::CUSTOMISABLE_HTTP_HEADERS[:anchor_mailbox] => anchor_mailbox,
            Viewpoint::EWS::SOAP::CUSTOMISABLE_HTTP_HEADERS[:prefer_server_affinity] => prefer_server_affinity
          }
        )
      end
    end

    context "when no custom HTTP headers are passed in" do
      let(:customisable_headers) { {} }

      it { is_expected.to eq({}) }
    end
  end

  describe "#set_custom_http_cookies" do
    subject { connection.set_custom_http_cookies(customisable_cookies) }

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
      let(:customisable_cookies) { {} }

      it "doesn't add a new cookie to the HTTP cookie manager" do
        httpcli = connection.instance_variable_get(:@httpcli)
        expect(WebAgent::Cookie).not_to receive(:new)
        expect(httpcli.cookie_manager).not_to receive(:add)

        subject
      end
    end
  end
end
