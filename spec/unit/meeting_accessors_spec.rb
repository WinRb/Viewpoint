require_relative '../spec_helper'

describe Viewpoint::EWS::MeetingAccessors do
  let(:ecli) { Viewpoint::EWSClient.new('dontcare', 'dontcare', 'dontcare') }

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
        <t:ReferenceItemId Id=\"foo-id\" ChangeKey=\"change-key\"/>
        <t:Body>example text</t:Body>
        <t:Sensitivity>Private</t:Sensitivity>
      </t:AcceptItem>
    </Items>
  </CreateItem>
</soap:Body>"
    end

    it "should form valid accept item request" do
      Viewpoint::EWS::SOAP::ExchangeWebService.any_instance.
        should_receive(:do_soap_request) do |request_document|
        request_document.at_xpath('//soap:Envelope/soap:Body').to_s.should eq create_item_request
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
        <t:ReferenceItemId Id=\"foo-id\" ChangeKey=\"change-key\"/>
        <t:Body>example text</t:Body>
        <t:Sensitivity>Private</t:Sensitivity>
      </t:DeclineItem>
    </Items>
  </CreateItem>
</soap:Body>"
    end

    it "should form valid accept item request" do
      Viewpoint::EWS::SOAP::ExchangeWebService.any_instance.
        should_receive(:do_soap_request) do |request_document|
        request_document.at_xpath('//soap:Envelope/soap:Body').to_s.should eq create_item_request
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
        <t:ReferenceItemId Id=\"foo-id\" ChangeKey=\"change-key\"/>
        <t:Body>example text</t:Body>
        <t:Sensitivity>Private</t:Sensitivity>
      </t:TentativelyAcceptItem>
    </Items>
  </CreateItem>
</soap:Body>"
    end

    it "should form valid accept item request" do
      Viewpoint::EWS::SOAP::ExchangeWebService.any_instance.
        should_receive(:do_soap_request) do |request_document|
        request_document.at_xpath('//soap:Envelope/soap:Body').to_s.should eq create_item_request
      end.
      and_return(double(:resp, :status => 'success'))

      ecli.tentatively_accept_meeting(default_opts)
    end
  end
end
