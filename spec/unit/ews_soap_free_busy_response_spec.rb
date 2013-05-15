require_relative '../spec_helper'

describe Viewpoint::EWS::SOAP::EwsSoapFreeBusyResponse do

ERROR_INVALID_SMTP_ADDRESS = <<EOS
<?xml version="1.0" encoding="utf-8"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
  <s:Header>
    <h:ServerVersionInfo xmlns:h="http://schemas.microsoft.com/exchange/services/2006/types" xmlns="http://schemas.microsoft.com/exchange/services/2006/types" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" MajorVersion="8" MinorVersion="0" MajorBuildNumber="652" MinorBuildNumber="0" />
  </s:Header>
  <s:Body xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <GetUserAvailabilityResponse xmlns="http://schemas.microsoft.com/exchange/services/2006/messages">
<FreeBusyResponseArray>
  <FreeBusyResponse>
    <ResponseMessage ResponseClass="Error">
      <MessageText>E-mail address &lt;&gt;SMTP:foobar is not a valid SMTP address.</MessageText>
      <ResponseCode>ErrorInvalidSmtpAddress</ResponseCode>
      <DescriptiveLinkKey>0</DescriptiveLinkKey>
      <MessageXml>
        <ExceptionType xmlns="http://schemas.microsoft.com/exchange/services/2006/errors">Microsoft.Exchange.InfoWorker.Common.Availability.InvalidSmtpAddressException</ExceptionType>
        <ExceptionCode xmlns="http://schemas.microsoft.com/exchange/services/2006/errors">5035</ExceptionCode>
        <ExceptionServerName xmlns="http://schemas.microsoft.com/exchange/services/2006/errors">ANY-SERVER-NAME</ExceptionServerName>
      </MessageXml>
    </ResponseMessage>
    <FreeBusyView>
      <FreeBusyViewType xmlns="http://schemas.microsoft.com/exchange/services/2006/types">None</FreeBusyViewType>
    </FreeBusyView>
  </FreeBusyResponse>
</FreeBusyResponseArray>
    </GetUserAvailabilityResponse>
  </s:Body>
</s:Envelope>
EOS

  context "Exchange responds with InvalidSmtpAddress error" do
    let(:ews)  { Viewpoint::EWS::SOAP::ExchangeWebService.new(double(:connection)) }
    let(:resp) { ews.parse_soap_response(ERROR_INVALID_SMTP_ADDRESS, :response_class => described_class) }

    it "should deliver the error code" do
      resp.code.should eq "ErrorInvalidSmtpAddress"
    end

    it "should extract the response message" do
      extracted_response_message = {
        attribs: {response_class: "Error"},
        elems: [
          {message_text:         {text: "E-mail address<>SMTP:foobar is not a valid SMTP address."}},
          {response_code:        {text: "ErrorInvalidSmtpAddress"}},
          {descriptive_link_key: {text: "0"}},
          {message_xml: {
            elems: [
              {exception_type: {text: "Microsoft.Exchange.InfoWorker.Common.Availability.InvalidSmtpAddressException"}},
              {exception_code: {text: "5035"}},
              {exception_server_name: {text: "ANY-SERVER-NAME"}}
            ]
          }}
        ]
      }
      resp.response_message.should == extracted_response_message
    end
  end

end
