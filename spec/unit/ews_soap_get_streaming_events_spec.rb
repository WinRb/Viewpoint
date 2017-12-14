require_relative '../spec_helper'

describe Viewpoint::EWS::SOAP::EwsSoapGetStreamingEventsResponse do

  let(:ews)  { Viewpoint::EWS::SOAP::ExchangeWebService.new(double(:connection)) }
  let(:resp) { ews.parse_soap_response(response_xml, :response_class => described_class) }

  context "When valid GetStreamingEventsResponseMessage" do
    let(:response_xml) do
<<EOS.gsub(%r{>\s+}, '>')
<?xml version="1.0" encoding="utf-8" ?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
    <ServerVersionInfo xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" MajorVersion="15" MinorVersion="0" MajorBuildNumber="775" MinorBuildNumber="7" Version="V2_4" xmlns="http://schemas.microsoft.com/exchange/services/2006/types" />
  </soap:Header>
  <soap:Body xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
    <m:GetStreamingEventsResponse xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:t="http://schemas.microsoft.com/exchange/services/2006/types" xmlns:m="http://schemas.microsoft.com/exchange/services/2006/messages">
      <m:ResponseMessages>
        <m:GetStreamingEventsResponseMessage ResponseClass="Success">
          <m:ResponseCode>NoError</m:ResponseCode>
          <m:Notifications>
            <m:Notification>
              <t:SubscriptionId>f6bc657d-dde1-4f94-952d-143b95d6483d</t:SubscriptionId>
              <t:CreatedEvent>
                <t:TimeStamp>2013-09-16T04:31:29Z</t:TimeStamp>
                <t:ItemId Id="AAMkADkzNjJjODUzLWZhMDMtNDVkMS05ZDdjLWVmMDlkYjQ1Zjc4MwBGAAAAAABSSWVKrmGUTJE+MVIvofglBwDZGACZQpSgSpyNkexYe2b7AAAAAAENAADZGACZQpSgSpyNkexYe2b7AAANGFYwAAA=" ChangeKey="CQAAAA==" />
                <t:ParentFolderId Id="AQMkADkzNjJjODUzLWZhMDMtNDVkMS05ZDdjLWVmMDlkYjQ1Zjc4MwAuAAADUkllSq5hlEyRPjFSL6H4JQEA2RgAmUKUoEqcjZHsWHtm+wAAAgENAAAA" ChangeKey="AQAAAA==" />
              </t:CreatedEvent>
              <t:NewMailEvent>
                <t:TimeStamp>2013-09-16T04:31:29Z</t:TimeStamp>
                <t:ItemId Id="AAMkADkzNjJjODUzLWZhMDMtNDVkMS05ZDdjLWVmMDlkYjQ1Zjc4MwBGAAAAAABSSWVKrmGUTJE+MVIvofglBwDZGACZQpSgSpyNkexYe2b7AAAAAAENAADZGACZQpSgSpyNkexYe2b7AAANGFYwAAA=" ChangeKey="CQAAAA==" />
                <t:ParentFolderId Id="AQMkADkzNjJjODUzLWZhMDMtNDVkMS05ZDdjLWVmMDlkYjQ1Zjc4MwAuAAADUkllSq5hlEyRPjFSL6H4JQEA2RgAmUKUoEqcjZHsWHtm+wAAAgENAAAA" ChangeKey="AQAAAA==" />
              </t:NewMailEvent>
              <t:ModifiedEvent>
                <t:TimeStamp>2013-09-16T04:31:29Z</t:TimeStamp>
                <t:FolderId Id="AQMkADkzNjJjODUzLWZhMDMtNDVkMS05ZDdjLWVmMDlkYjQ1Zjc4MwAuAAADUkllSq5hlEyRPjFSL6H4JQEA2RgAmUKUoEqcjZHsWHtm+wAAAgENAAAA" ChangeKey="AQAAAA==" />
                <t:ParentFolderId Id="AQMkADkzNjJjODUzLWZhMDMtNDVkMS05ZDdjLWVmMDlkYjQ1Zjc4MwAuAAADUkllSq5hlEyRPjFSL6H4JQEA2RgAmUKUoEqcjZHsWHtm+wAAAgEJAAAA" ChangeKey="AQAAAA==" />
                <t:UnreadCount>1</t:UnreadCount>
              </t:ModifiedEvent>
            </m:Notification>
          </m:Notifications>
        </m:GetStreamingEventsResponseMessage>
      </m:ResponseMessages>
    </m:GetStreamingEventsResponse>
  </soap:Body>
</s:Envelope>
EOS
    end

    it "response should be successful" do
      expect(resp.status).to eq("Success")
    end

    describe "#subscription_id" do
      subject { resp.subscription_id }
      it { is_expected.to eq("f6bc657d-dde1-4f94-952d-143b95d6483d") }
    end

    describe "#events" do
      subject { resp.events }

      it "returns GetStreamingEventResponse array" do
        expect(subject.map(&:id) ).to eq(["AAMkADkzNjJjODUzLWZhMDMtNDVkMS05ZDdjLWVmMDlkYjQ1Zjc4MwBGAAAAAABSSWVKrmGUTJE+MVIvofglBwDZGACZQpSgSpyNkexYe2b7AAAAAAENAADZGACZQpSgSpyNkexYe2b7AAANGFYwAAA=",
                                          "AAMkADkzNjJjODUzLWZhMDMtNDVkMS05ZDdjLWVmMDlkYjQ1Zjc4MwBGAAAAAABSSWVKrmGUTJE+MVIvofglBwDZGACZQpSgSpyNkexYe2b7AAAAAAENAADZGACZQpSgSpyNkexYe2b7AAANGFYwAAA=",
                                         nil])
      end
    end
  end # context "When valid GetStreamingEventsResponseMessage"

  context "When invalid GetStreamingEventsResponseMessage" do
    let(:response_xml) do
<<EOS.gsub(%r{>\s+}, '>')
<?xml version="1.0" encoding="utf-8" ?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <soap:Header>
    <t:ServerVersionInfo MajorVersion="8" MinorVersion="0" MajorBuildNumber="628" MinorBuildNumber="0" xmlns:t="http://schemas.microsoft.com/exchange/services/2006/types" />
  </soap:Header>
  <soap:Body>
    <GetStreamingEventsResponse xmlns:m="http://schemas.microsoft.com/exchange/services/2006/messages" xmlns:t="http://schemas.microsoft.com/exchange/services/2006/types" xmlns="http://schemas.microsoft.com/exchange/services/2006/messages">
      <m:ResponseMessages>
        <m:GetStreamingEventsResponseMessage ResponseClass="Error">
          <m:MessageText>Some Error</m:MessageText>
          <m:DescriptiveLinkKey>0</m:DescriptiveLinkKey>
          <m:ResponseCode>ErrorInvalidSubscription</m:ResponseCode>
          <m:ConnectionStatus>Closed</m:ConnectionStatus>
        </m:GetStreamingEventsResponseMessage>
      </m:ResponseMessages>
    </GetStreamingEventsResponse>
  </soap:Body>
</soap:Envelope>
EOS
    end

    it "response should be error" do
      expect(resp.status).to eq("Error")
    end

    it "response should be error" do
      expect(resp.response_message_text).to eq("Some Error")
    end
  end # context "When invalid GetStreamingEventsResponseMessage"


end
