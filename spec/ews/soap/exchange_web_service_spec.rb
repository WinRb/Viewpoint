require 'spec_helper'

describe Viewpoint::EWS::SOAP::ExchangeWebService do
  let(:autodiscover_endpoint) { 'http://www.example.com/autodiscover/autodiscover.svc' }
  let(:ews_client) { Viewpoint::EWSClient.new(autodiscover_endpoint, "test", "test") }
  let(:ews_instance) { ews_client.ews }
  let(:opts) { { some_attribute: "some_value" } }
  let(:ews_builder_double) { double(:ews_builder) }
  let(:soap_double) { double(:soap_double) }

  describe "#get_user_settings" do

    subject { ews_instance.get_user_settings(opts) }

    it "makes SOAP request" do
      expect(Viewpoint::EWS::SOAP::EwsBuilder).to receive(:new) { ews_builder_double }
      expect(ews_builder_double).to receive(:build_get_user_settings_soap).with(
        {
          some_attribute: "some_value",
          server_version: "Exchange2010",
          autodiscover_address: autodiscover_endpoint
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
