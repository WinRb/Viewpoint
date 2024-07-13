require_relative '../spec_helper'

describe Viewpoint::EWS::MeetingAccessors do
  let(:ecli) { Viewpoint::EWSClient.new({endpoint: 'dontcare', user: 'dontcare', password: 'dontcare'}) }

  let(:default_opts) do
    {
      id: 'foo-id',
      change_key: 'change-key',
      text: 'example text',
      sensitivity: 'Private',
    }
  end

  context "#accept_meeting" do
    let(:create_item_request) do
      "<soap:Body>
  <CreateItem xmlns=\"http://schemas.microsoft.com/exchange/services/2006/messages\" MessageDisposition=\"SendOnly\">
    <Items>
      <t:AcceptItem>
        <t:Sensitivity>Private</t:Sensitivity>
        <t:Body BodyType=\"Text\">example text</t:Body>
        <t:ReferenceItemId Id=\"foo-id\" ChangeKey=\"change-key\"/>
      </t:AcceptItem>
    </Items>
  </CreateItem>
</soap:Body>"
    end

    it "should form valid accept item request" do
      expect_any_instance_of(Viewpoint::EWS::SOAP::ExchangeWebService).to receive(:do_soap_request) do |request_document|
        expect(request_document.at_xpath('//soap:Envelope/soap:Body').to_s).to eq create_item_request
      end.
      and_return(double(:resp, :status => 'Success'))

      ecli.accept_meeting(default_opts)
    end
  end

  context "#decline_meeting" do
    let(:create_item_request) do
      "<soap:Body>
  <CreateItem xmlns=\"http://schemas.microsoft.com/exchange/services/2006/messages\" MessageDisposition=\"SendOnly\">
    <Items>
      <t:DeclineItem>
        <t:Sensitivity>Private</t:Sensitivity>
        <t:Body BodyType=\"Text\">example text</t:Body>
        <t:ReferenceItemId Id=\"foo-id\" ChangeKey=\"change-key\"/>
      </t:DeclineItem>
    </Items>
  </CreateItem>
</soap:Body>"
    end

    it "should form valid accept item request" do
      expect_any_instance_of(Viewpoint::EWS::SOAP::ExchangeWebService).to receive(:do_soap_request) do |request_document|
        expect(request_document.at_xpath('//soap:Envelope/soap:Body').to_s).to eq create_item_request
      end.
      and_return(double(:resp, :status => 'success'))

      ecli.decline_meeting(default_opts)
    end
  end

  context "#tentatively_accept_meeting" do
    let(:create_item_request) do
      "<soap:Body>
  <CreateItem xmlns=\"http://schemas.microsoft.com/exchange/services/2006/messages\" MessageDisposition=\"SendOnly\">
    <Items>
      <t:TentativelyAcceptItem>
        <t:Sensitivity>Private</t:Sensitivity>
        <t:Body BodyType=\"Text\">example text</t:Body>
        <t:ReferenceItemId Id=\"foo-id\" ChangeKey=\"change-key\"/>
      </t:TentativelyAcceptItem>
    </Items>
  </CreateItem>
</soap:Body>"
    end

    it "should form valid accept item request" do
      expect_any_instance_of(Viewpoint::EWS::SOAP::ExchangeWebService).to receive(:do_soap_request) do |request_document|
        expect(request_document.at_xpath('//soap:Envelope/soap:Body').to_s).to eq create_item_request
      end.
      and_return(double(:resp, :status => 'success'))

      ecli.tentatively_accept_meeting(default_opts)
    end
  end
end
