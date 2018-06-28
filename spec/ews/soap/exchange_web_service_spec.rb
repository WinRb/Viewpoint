require 'spec_helper'

describe Viewpoint::EWS::SOAP::ExchangeWebService do
  let(:connection) { Viewpoint::EWSClient.new("http://www.example.com", "test", "test") }
  let(:ews_instance) { described_class.new(connection) }
  let(:opts) { { some_attribute: "some_value" } }
  let(:ews_builder_double) { double(:ews_builder) }
  let(:autodiscover_address) { "http://example.com/autodiscover" }
  let(:soap_double) { double(:soap_double) }

  describe "#get_user_settings" do

    subject { ews_instance.get_user_settings(opts) }

    it "makes SOAP request" do
      allow(ews_instance).to receive(:autodiscover_address) { autodiscover_address }
      expect(Viewpoint::EWS::SOAP::EwsBuilder).to receive(:new) { ews_builder_double }
      expect(ews_builder_double).to receive(:build_get_user_settings_soap).with(
        {
          some_attribute: "some_value",
          server_version: "Exchange2010",
          autodiscover_address: autodiscover_address
        }
      ).and_return(soap_double)
      expect(ews_instance).to receive(:do_soap_request).with(soap_double, {
        response_class: Viewpoint::EWS::SOAP::EwsSoapGetUserSettingsResponse
        }
      )

      subject
    end
  end
end
