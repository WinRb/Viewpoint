require 'spec_helper'

describe Viewpoint::EWS::SOAP::ExchangeNotification do
  class TestIncludeExchangeNotification
    include Viewpoint::EWS::SOAP::ExchangeNotification
  end

  shared_examples "empty options" do
    context "when an empty has is passed in" do
      let(:options) { {} }

      it { is_expected.to eq({}) }
    end
  end

  let(:test_instance) { TestIncludeExchangeNotification.new }

  describe "#subscribe" do
    let(:options) { { anchor_mailbox: "mailbox@example.com"} }
    let(:req_double) { double(:request) }
    let(:subscriptions) { double(:subscriptions) }
    let(:customisable_headers) { { some_header: "some_value" } }
    let(:customisable_cookies) { { some_cookie: "some_other_value" } }

    subject { test_instance.subscribe(subscriptions, options: options) }

    it "passes the customisable_cookies and customisable_headers options to the do_soap_request method" do
      expect(test_instance).to receive(:get_customisable_headers).with(options) { customisable_headers }
      expect(test_instance).to receive(:get_customisable_cookies).with(options) { customisable_cookies }
      allow(test_instance).to receive(:build_soap!) { req_double }
      expect(test_instance).to receive(:do_soap_request).with(
        req_double, {
          anchor_mailbox: "mailbox@example.com",
          response_class: Viewpoint::EWS::SOAP::EwsResponse,
          customisable_headers: customisable_headers,
          customisable_cookies: customisable_cookies,
          request_type: 'Subscribe'
        }
      )
      subject
    end

    context "when get_customisable_headers and get_customisable_cookies return nil" do
      it "passes empty headers and cookies hashes to the do_soap_request method" do
        expect(test_instance).to receive(:get_customisable_headers).with(options) { nil }
        expect(test_instance).to receive(:get_customisable_cookies).with(options) { nil }
        allow(test_instance).to receive(:build_soap!) { req_double }
        expect(test_instance).to receive(:do_soap_request).with(
          req_double, {
            anchor_mailbox: "mailbox@example.com",
            response_class: Viewpoint::EWS::SOAP::EwsResponse,
            customisable_headers: {},
            customisable_cookies: {},
            request_type: 'Subscribe'
          }
        )
        subject
      end
    end
  end

  describe "#get_customisable_headers" do
    let(:anchor_mailbox) { "mailbox@example.com" }
    let(:prefer_server_affinity) { true }

    subject { test_instance.get_customisable_headers(options) }

    context "when a supported HTTP header is passed in" do
      let(:options) {
        {
          customisable_headers: {
            anchor_mailbox: anchor_mailbox,
            prefer_server_affinity: prefer_server_affinity
          }
        }
      }

      it "includes the HTTP header" do
        result = subject

        expect(result[:anchor_mailbox]).to eq(anchor_mailbox)
        expect(result[:prefer_server_affinity]).to eq(prefer_server_affinity)
      end
    end

    context "when extra options are passed in" do
      let(:options) {
        {
          customisable_headers: {
            some_other_header: "some_value",
            anchor_mailbox: anchor_mailbox,
            prefer_server_affinity: prefer_server_affinity
          }
        }
      }

      it "excludes the extra options" do
        result = subject

        expect(result[:anchor_mailbox]).to eq(anchor_mailbox)
        expect(result[:prefer_server_affinity]).to eq(prefer_server_affinity)
        expect(result[:some_other_header]).to be_nil
      end
    end

    include_examples "empty options"
  end

  describe "#get_customisable_cookies" do
    let(:backend_override_cookie) { "cookie" }

    subject { test_instance.get_customisable_cookies(options) }

    context "when a supported HTTP cookie is passed in" do
      let(:options) do  {
        customisable_cookies: { backend_override_cookie: backend_override_cookie }
      }
      end

      it "includes the HTTP cookie" do
        expect(subject[:backend_override_cookie]).to eq(backend_override_cookie)
      end
    end

    context "when extra options are passed in" do
      let(:options) {
        {
          customisable_cookies: {
            some_other_cookie: "some_value",
            backend_override_cookie: backend_override_cookie
          }
        }
      }

      it "excludes the extra options" do
        result = subject

        expect(result[:backend_override_cookie]).to eq(backend_override_cookie)
        expect(result[:some_other_cookie]).to be_nil
      end
    end

    include_examples "empty options"
  end
end
