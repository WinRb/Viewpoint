require 'spec_helper'

describe Viewpoint::EWS::SOAP::ExchangeNotification do
  class TestIncludeExchangeNotification
    include Viewpoint::EWS::SOAP::ExchangeNotification
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
          response_class: Viewpoint::EWS::SOAP::EwsResponse,
          options: { customisable_headers: customisable_headers, customisable_cookies: customisable_cookies }
        }
      )
      subject
    end
  end

  describe "#get_customisable_cookies" do
    subject { test_instance.get_customisable_cookies(options) }
  end

  describe "#get_customisable_headers" do
      subject { test_instance.get_customisable_headers(options) }
  end

  # describe "#get_request_options" do
  #
  #   subject { test_instance.get_request_options(options) }
  #
  #   context "when a supported HTTP header is passed in" do
  #     let(:anchor_mailbox) { "mailbox@example.com" }
  #     let(:prefer_server_affinity) { true }
  #     let(:options) {
  #       {
  #         anchor_mailbox: anchor_mailbox,
  #         prefer_server_affinity: prefer_server_affinity
  #       }
  #     }
  #
  #     it "includes the HTTP header" do
  #       result = subject
  #
  #       expect(result[:anchor_mailbox]).to eq(anchor_mailbox)
  #       expect(result[:prefer_server_affinity]).to eq(prefer_server_affinity)
  #     end
  #   end
  #
  #   context "when extra options are passed in" do
  #     it "excludes the extra options" do
  #
  #     end
  #   end

    # context "when a supported HTTP cookie is passed in" do
    #   let(:backend_override_cookie) { "cookie" }
    #   let(:options) { { backend_override_cookie: backend_override_cookie } }
    #
    #   it "includes the HTTP cookie" do
    #     expect(subject[:backend_override_cookie]).to eq(backend_override_cookie)
    #   end
    # end

  # end
end
