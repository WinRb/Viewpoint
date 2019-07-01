require_relative '../spec_helper'

describe Viewpoint::EWS::SOAP::EwsSoapGetStreamingEventsResponse do

  let(:ews)  { Viewpoint::EWS::SOAP::ExchangeWebService.new(double(:connection)) }
  let(:resp) { ews.parse_soap_response(response_xml, :response_class => described_class) }

  context "When valid GetStreamingEventsResponseMessage" do
    let(:response_xml) do
<<EOS.gsub(%r{>\s+}, '>')
<?xml version="1.0"?>
<Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/">
<soap11:Header xmlns:soap11="http://schemas.xmlsoap.org/soap/envelope/">
<ServerVersionInfo xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://schemas.microsoft.com/exchange/services/2006/types" MajorVersion="15" MinorVersion="1" MajorBuildNumber="1591" MinorBuildNumber="10" Version="V2017_07_11"/>
</soap11:Header>
<soap11:Body xmlns:soap11="http://schemas.xmlsoap.org/soap/envelope/">
<m:GetStreamingEventsResponse xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:t="http://schemas.microsoft.com/exchange/services/2006/types" xmlns:m="http://schemas.microsoft.com/exchange/services/2006/messages">
<m:ResponseMessages>
    <m:GetStreamingEventsResponseMessage ResponseClass="Success">
        <m:ResponseCode>NoError</m:ResponseCode>
        <m:Notifications>
            <m:Notification>
                <t:SubscriptionId>FwBleGNoMDMuYm9va2luZ2J1Zy5sb2NhbBAAAACRSuDZ7LUVRZRdTUGgj8dRTln61/P61ggQAAAAXGkYiHJpukmWTKXM27pVgQ==</t:SubscriptionId>
                <t:ModifiedEvent>
                    <t:TimeStamp>2019-06-27T11:37:36Z</t:TimeStamp>
                    <t:ItemId Id="AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQBGAAAAAAAnT+v/XrekSJPJnfajaVp7BwB4AcCri66ATqtSWLqPBV/jAAAAAAENAAB4AcCri66ATqtSWLqPBV/jAAAMnbCEAAA=" ChangeKey="DwAAAA=="/>
                    <t:ParentFolderId Id="AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQAuAAAAAAAnT+v/XrekSJPJnfajaVp7AQB4AcCri66ATqtSWLqPBV/jAAAAAAENAAA=" ChangeKey="AQAAAA=="/>
                </t:ModifiedEvent>
                <t:FreeBusyChangedEvent>
                    <t:TimeStamp>2019-06-27T11:37:36Z</t:TimeStamp>
                    <t:ItemId Id="AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQBGAAAAAAAnT+v/XrekSJPJnfajaVp7BwB4AcCri66ATqtSWLqPBV/jAAAAAAENAAB4AcCri66ATqtSWLqPBV/jAAAMnbCEAAA=" ChangeKey="DwAAAA=="/>
                    <t:ParentFolderId Id="AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQAuAAAAAAAnT+v/XrekSJPJnfajaVp7AQB4AcCri66ATqtSWLqPBV/jAAAAAAENAAA=" ChangeKey="AQAAAA=="/>
                </t:FreeBusyChangedEvent>
                <t:ModifiedEvent>
                    <t:TimeStamp>2019-06-27T11:37:38Z</t:TimeStamp>
                    <t:ItemId Id="AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQBGAAAAAAAnT+v/XrekSJPJnfajaVp7BwB4AcCri66ATqtSWLqPBV/jAAAAAAENAAB4AcCri66ATqtSWLqPBV/jAAAMnbCGAAA=" ChangeKey="DwAAAA=="/>
                    <t:ParentFolderId Id="AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQAuAAAAAAAnT+v/XrekSJPJnfajaVp7AQB4AcCri66ATqtSWLqPBV/jAAAAAAENAAA=" ChangeKey="AQAAAA=="/>
                </t:ModifiedEvent>
                <t:FreeBusyChangedEvent>
                    <t:TimeStamp>2019-06-27T11:37:38Z</t:TimeStamp>
                    <t:ItemId Id="AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQBGAAAAAAAnT+v/XrekSJPJnfajaVp7BwB4AcCri66ATqtSWLqPBV/jAAAAAAENAAB4AcCri66ATqtSWLqPBV/jAAAMnbCGAAA=" ChangeKey="DwAAAA=="/>
                    <t:ParentFolderId Id="AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQAuAAAAAAAnT+v/XrekSJPJnfajaVp7AQB4AcCri66ATqtSWLqPBV/jAAAAAAENAAA=" ChangeKey="AQAAAA=="/>
                </t:FreeBusyChangedEvent>
                <t:ModifiedEvent>
                    <t:TimeStamp>2019-06-27T11:37:39Z</t:TimeStamp>
                    <t:ItemId Id="AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQBGAAAAAAAnT+v/XrekSJPJnfajaVp7BwB4AcCri66ATqtSWLqPBV/jAAAAAAENAAB4AcCri66ATqtSWLqPBV/jAAAMnbCHAAA=" ChangeKey="DwAAAA=="/>
                    <t:ParentFolderId Id="AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQAuAAAAAAAnT+v/XrekSJPJnfajaVp7AQB4AcCri66ATqtSWLqPBV/jAAAAAAENAAA=" ChangeKey="AQAAAA=="/>
                </t:ModifiedEvent>
                <t:FreeBusyChangedEvent>
                    <t:TimeStamp>2019-06-27T11:37:39Z</t:TimeStamp>
                    <t:ItemId Id="AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQBGAAAAAAAnT+v/XrekSJPJnfajaVp7BwB4AcCri66ATqtSWLqPBV/jAAAAAAENAAB4AcCri66ATqtSWLqPBV/jAAAMnbCHAAA=" ChangeKey="DwAAAA=="/>
                    <t:ParentFolderId Id="AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQAuAAAAAAAnT+v/XrekSJPJnfajaVp7AQB4AcCri66ATqtSWLqPBV/jAAAAAAENAAA=" ChangeKey="AQAAAA=="/>
                </t:FreeBusyChangedEvent>
                <t:ModifiedEvent>
                    <t:TimeStamp>2019-06-27T11:37:39Z</t:TimeStamp>
                    <t:FolderId Id="AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQAuAAAAAAAnT+v/XrekSJPJnfajaVp7AQB4AcCri66ATqtSWLqPBV/jAAAAAAENAAA=" ChangeKey="AgAAAA=="/>
                    <t:ParentFolderId Id="AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQAuAAAAAAAnT+v/XrekSJPJnfajaVp7AQB4AcCri66ATqtSWLqPBV/jAAAAAAEIAAA=" ChangeKey="AQAAAA=="/>
                </t:ModifiedEvent>
            </m:Notification>
            <m:Notification>
                <t:SubscriptionId>FwBleGNoMDMuYm9va2luZ2J1Zy5sb2NhbBAAAAB9DEFxT0GoT76vzMfF9cAfJeXk1/P61ggQAAAAzx24c/i+nkuy00/tlBOrpQ==</t:SubscriptionId>
                <t:ModifiedEvent>
                    <t:TimeStamp>2019-06-27T11:37:41Z</t:TimeStamp>
                    <t:ItemId Id="AAMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQBGAAAAAAB8etMk2+G/Q4RBejSGWikhBwBkjUI/GFqBRanwDilJ6rxlAAAAAAENAABkjUI/GFqBRanwDilJ6rxlAAALS2RBAAA=" ChangeKey="DwAAAA=="/>
                    <t:ParentFolderId Id="AQMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQAuAAADfHrTJNvhv0OEQXo0hlopIQEAZI1CPxhagUWp8A4pSeq8ZQAAAgENAAAA" ChangeKey="AQAAAA=="/>
                </t:ModifiedEvent>
                <t:FreeBusyChangedEvent>
                    <t:TimeStamp>2019-06-27T11:37:41Z</t:TimeStamp>
                    <t:ItemId Id="AAMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQBGAAAAAAB8etMk2+G/Q4RBejSGWikhBwBkjUI/GFqBRanwDilJ6rxlAAAAAAENAABkjUI/GFqBRanwDilJ6rxlAAALS2RBAAA=" ChangeKey="DwAAAA=="/>
                    <t:ParentFolderId Id="AQMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQAuAAADfHrTJNvhv0OEQXo0hlopIQEAZI1CPxhagUWp8A4pSeq8ZQAAAgENAAAA" ChangeKey="AQAAAA=="/>
                </t:FreeBusyChangedEvent>
                <t:ModifiedEvent>
                    <t:TimeStamp>2019-06-27T11:37:42Z</t:TimeStamp>
                    <t:ItemId Id="AAMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQBGAAAAAAB8etMk2+G/Q4RBejSGWikhBwBkjUI/GFqBRanwDilJ6rxlAAAAAAENAABkjUI/GFqBRanwDilJ6rxlAAALS2RDAAA=" ChangeKey="DwAAAA=="/>
                    <t:ParentFolderId Id="AQMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQAuAAADfHrTJNvhv0OEQXo0hlopIQEAZI1CPxhagUWp8A4pSeq8ZQAAAgENAAAA" ChangeKey="AQAAAA=="/>
                </t:ModifiedEvent>
                <t:FreeBusyChangedEvent>
                    <t:TimeStamp>2019-06-27T11:37:42Z</t:TimeStamp>
                    <t:ItemId Id="AAMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQBGAAAAAAB8etMk2+G/Q4RBejSGWikhBwBkjUI/GFqBRanwDilJ6rxlAAAAAAENAABkjUI/GFqBRanwDilJ6rxlAAALS2RDAAA=" ChangeKey="DwAAAA=="/>
                    <t:ParentFolderId Id="AQMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQAuAAADfHrTJNvhv0OEQXo0hlopIQEAZI1CPxhagUWp8A4pSeq8ZQAAAgENAAAA" ChangeKey="AQAAAA=="/>
                </t:FreeBusyChangedEvent>
                <t:ModifiedEvent>
                    <t:TimeStamp>2019-06-27T11:37:43Z</t:TimeStamp>
                    <t:ItemId Id="AAMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQBGAAAAAAB8etMk2+G/Q4RBejSGWikhBwBkjUI/GFqBRanwDilJ6rxlAAAAAAENAABkjUI/GFqBRanwDilJ6rxlAAALS2REAAA=" ChangeKey="DwAAAA=="/>
                    <t:ParentFolderId Id="AQMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQAuAAADfHrTJNvhv0OEQXo0hlopIQEAZI1CPxhagUWp8A4pSeq8ZQAAAgENAAAA" ChangeKey="AQAAAA=="/>
                </t:ModifiedEvent>
                <t:FreeBusyChangedEvent>
                    <t:TimeStamp>2019-06-27T11:37:43Z</t:TimeStamp>
                    <t:ItemId Id="AAMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQBGAAAAAAB8etMk2+G/Q4RBejSGWikhBwBkjUI/GFqBRanwDilJ6rxlAAAAAAENAABkjUI/GFqBRanwDilJ6rxlAAALS2REAAA=" ChangeKey="DwAAAA=="/>
                    <t:ParentFolderId Id="AQMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQAuAAADfHrTJNvhv0OEQXo0hlopIQEAZI1CPxhagUWp8A4pSeq8ZQAAAgENAAAA" ChangeKey="AQAAAA=="/>
                </t:FreeBusyChangedEvent>
                <t:ModifiedEvent>
                    <t:TimeStamp>2019-06-27T11:37:43Z</t:TimeStamp>
                    <t:FolderId Id="AQMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQAuAAADfHrTJNvhv0OEQXo0hlopIQEAZI1CPxhagUWp8A4pSeq8ZQAAAgENAAAA" ChangeKey="AgAAAA=="/>
                    <t:ParentFolderId Id="AQMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQAuAAADfHrTJNvhv0OEQXo0hlopIQEAZI1CPxhagUWp8A4pSeq8ZQAAAgEIAAAA" ChangeKey="AQAAAA=="/>
                </t:ModifiedEvent>
            </m:Notification>
        </m:Notifications>
    </m:GetStreamingEventsResponseMessage>
</m:ResponseMessages>
</m:GetStreamingEventsResponse>
</soap11:Body>
</Envelope>
EOS
    end

    it "response should be successful" do
      expect(resp.status).to eq("Success")
    end

    describe "#notifications" do
      subject { resp.notifications }

      it "just works" do
        notifications = subject
        expect(notifications.size).to eq(2)
        expect(notifications.map(&:subscription_id)).to eq(["FwBleGNoMDMuYm9va2luZ2J1Zy5sb2NhbBAAAACRSuDZ7LUVRZRdTUGgj8dRTln61/P61ggQAAAAXGkYiHJpukmWTKXM27pVgQ==", "FwBleGNoMDMuYm9va2luZ2J1Zy5sb2NhbBAAAAB9DEFxT0GoT76vzMfF9cAfJeXk1/P61ggQAAAAzx24c/i+nkuy00/tlBOrpQ=="])
        expect(notifications.map(&:notification_events).flatten.map(&:id).compact!).to eq([
          "AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQBGAAAAAAAnT+v/XrekSJPJnfajaVp7BwB4AcCri66ATqtSWLqPBV/jAAAAAAENAAB4AcCri66ATqtSWLqPBV/jAAAMnbCEAAA=",
          "AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQBGAAAAAAAnT+v/XrekSJPJnfajaVp7BwB4AcCri66ATqtSWLqPBV/jAAAAAAENAAB4AcCri66ATqtSWLqPBV/jAAAMnbCEAAA=",
          "AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQBGAAAAAAAnT+v/XrekSJPJnfajaVp7BwB4AcCri66ATqtSWLqPBV/jAAAAAAENAAB4AcCri66ATqtSWLqPBV/jAAAMnbCGAAA=",
          "AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQBGAAAAAAAnT+v/XrekSJPJnfajaVp7BwB4AcCri66ATqtSWLqPBV/jAAAAAAENAAB4AcCri66ATqtSWLqPBV/jAAAMnbCGAAA=",
          "AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQBGAAAAAAAnT+v/XrekSJPJnfajaVp7BwB4AcCri66ATqtSWLqPBV/jAAAAAAENAAB4AcCri66ATqtSWLqPBV/jAAAMnbCHAAA=",
          "AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQBGAAAAAAAnT+v/XrekSJPJnfajaVp7BwB4AcCri66ATqtSWLqPBV/jAAAAAAENAAB4AcCri66ATqtSWLqPBV/jAAAMnbCHAAA=",

          "AAMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQBGAAAAAAB8etMk2+G/Q4RBejSGWikhBwBkjUI/GFqBRanwDilJ6rxlAAAAAAENAABkjUI/GFqBRanwDilJ6rxlAAALS2RBAAA=",
          "AAMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQBGAAAAAAB8etMk2+G/Q4RBejSGWikhBwBkjUI/GFqBRanwDilJ6rxlAAAAAAENAABkjUI/GFqBRanwDilJ6rxlAAALS2RBAAA=",
          "AAMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQBGAAAAAAB8etMk2+G/Q4RBejSGWikhBwBkjUI/GFqBRanwDilJ6rxlAAAAAAENAABkjUI/GFqBRanwDilJ6rxlAAALS2RDAAA=",
          "AAMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQBGAAAAAAB8etMk2+G/Q4RBejSGWikhBwBkjUI/GFqBRanwDilJ6rxlAAAAAAENAABkjUI/GFqBRanwDilJ6rxlAAALS2RDAAA=",
          "AAMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQBGAAAAAAB8etMk2+G/Q4RBejSGWikhBwBkjUI/GFqBRanwDilJ6rxlAAAAAAENAABkjUI/GFqBRanwDilJ6rxlAAALS2REAAA=",
          "AAMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQBGAAAAAAB8etMk2+G/Q4RBejSGWikhBwBkjUI/GFqBRanwDilJ6rxlAAAAAAENAABkjUI/GFqBRanwDilJ6rxlAAALS2REAAA=",
        ])
      end
    end

    describe "#notification_hashes" do
      let(:notification_hashes) do
        [
          {:notification=>{:elems=>[
            {:subscription_id=>{:text=>"FwBleGNoMDMuYm9va2luZ2J1Zy5sb2NhbBAAAACRSuDZ7LUVRZRdTUGgj8dRTln61/P61ggQAAAAXGkYiHJpukmWTKXM27pVgQ=="}},
              {:modified_event=>{:elems=>[{:time_stamp=>{:text=>"2019-06-27T11:37:36Z"}}, {:item_id=>{:attribs=>{:id=>"AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQBGAAAAAAAnT+v/XrekSJPJnfajaVp7BwB4AcCri66ATqtSWLqPBV/jAAAAAAENAAB4AcCri66ATqtSWLqPBV/jAAAMnbCEAAA=", :change_key=>"DwAAAA=="}}}, {:parent_folder_id=>{:attribs=>{:id=>"AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQAuAAAAAAAnT+v/XrekSJPJnfajaVp7AQB4AcCri66ATqtSWLqPBV/jAAAAAAENAAA=", :change_key=>"AQAAAA=="}}}]}},
              {:free_busy_changed_event=>{:elems=>[{:time_stamp=>{:text=>"2019-06-27T11:37:36Z"}}, {:item_id=>{:attribs=>{:id=>"AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQBGAAAAAAAnT+v/XrekSJPJnfajaVp7BwB4AcCri66ATqtSWLqPBV/jAAAAAAENAAB4AcCri66ATqtSWLqPBV/jAAAMnbCEAAA=", :change_key=>"DwAAAA=="}}}, {:parent_folder_id=>{:attribs=>{:id=>"AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQAuAAAAAAAnT+v/XrekSJPJnfajaVp7AQB4AcCri66ATqtSWLqPBV/jAAAAAAENAAA=", :change_key=>"AQAAAA=="}}}]}},
              {:modified_event=>{:elems=>[{:time_stamp=>{:text=>"2019-06-27T11:37:38Z"}}, {:item_id=>{:attribs=>{:id=>"AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQBGAAAAAAAnT+v/XrekSJPJnfajaVp7BwB4AcCri66ATqtSWLqPBV/jAAAAAAENAAB4AcCri66ATqtSWLqPBV/jAAAMnbCGAAA=", :change_key=>"DwAAAA=="}}}, {:parent_folder_id=>{:attribs=>{:id=>"AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQAuAAAAAAAnT+v/XrekSJPJnfajaVp7AQB4AcCri66ATqtSWLqPBV/jAAAAAAENAAA=", :change_key=>"AQAAAA=="}}}]}},
              {:free_busy_changed_event=>{:elems=>[{:time_stamp=>{:text=>"2019-06-27T11:37:38Z"}}, {:item_id=>{:attribs=>{:id=>"AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQBGAAAAAAAnT+v/XrekSJPJnfajaVp7BwB4AcCri66ATqtSWLqPBV/jAAAAAAENAAB4AcCri66ATqtSWLqPBV/jAAAMnbCGAAA=", :change_key=>"DwAAAA=="}}}, {:parent_folder_id=>{:attribs=>{:id=>"AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQAuAAAAAAAnT+v/XrekSJPJnfajaVp7AQB4AcCri66ATqtSWLqPBV/jAAAAAAENAAA=", :change_key=>"AQAAAA=="}}}]}},
              {:modified_event=>{:elems=>[{:time_stamp=>{:text=>"2019-06-27T11:37:39Z"}}, {:item_id=>{:attribs=>{:id=>"AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQBGAAAAAAAnT+v/XrekSJPJnfajaVp7BwB4AcCri66ATqtSWLqPBV/jAAAAAAENAAB4AcCri66ATqtSWLqPBV/jAAAMnbCHAAA=", :change_key=>"DwAAAA=="}}}, {:parent_folder_id=>{:attribs=>{:id=>"AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQAuAAAAAAAnT+v/XrekSJPJnfajaVp7AQB4AcCri66ATqtSWLqPBV/jAAAAAAENAAA=", :change_key=>"AQAAAA=="}}}]}},
              {:free_busy_changed_event=>{:elems=>[{:time_stamp=>{:text=>"2019-06-27T11:37:39Z"}}, {:item_id=>{:attribs=>{:id=>"AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQBGAAAAAAAnT+v/XrekSJPJnfajaVp7BwB4AcCri66ATqtSWLqPBV/jAAAAAAENAAB4AcCri66ATqtSWLqPBV/jAAAMnbCHAAA=", :change_key=>"DwAAAA=="}}}, {:parent_folder_id=>{:attribs=>{:id=>"AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQAuAAAAAAAnT+v/XrekSJPJnfajaVp7AQB4AcCri66ATqtSWLqPBV/jAAAAAAENAAA=", :change_key=>"AQAAAA=="}}}]}},
              {:modified_event=>{:elems=>[{:time_stamp=>{:text=>"2019-06-27T11:37:39Z"}}, {:folder_id=>{:attribs=>{:id=>"AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQAuAAAAAAAnT+v/XrekSJPJnfajaVp7AQB4AcCri66ATqtSWLqPBV/jAAAAAAENAAA=", :change_key=>"AgAAAA=="}}}, {:parent_folder_id=>{:attribs=>{:id=>"AAMkADg4MTg2OTVjLTY5NzItNDliYS05NjRjLWE1Y2NkYmJhNTU4MQAuAAAAAAAnT+v/XrekSJPJnfajaVp7AQB4AcCri66ATqtSWLqPBV/jAAAAAAEIAAA=", :change_key=>"AQAAAA=="}}}]}}]}},
          {:notification=>{:elems=>[
            {:subscription_id=>{:text=>"FwBleGNoMDMuYm9va2luZ2J1Zy5sb2NhbBAAAAB9DEFxT0GoT76vzMfF9cAfJeXk1/P61ggQAAAAzx24c/i+nkuy00/tlBOrpQ=="}},
              {:modified_event=>{:elems=>[{:time_stamp=>{:text=>"2019-06-27T11:37:41Z"}}, {:item_id=>{:attribs=>{:id=>"AAMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQBGAAAAAAB8etMk2+G/Q4RBejSGWikhBwBkjUI/GFqBRanwDilJ6rxlAAAAAAENAABkjUI/GFqBRanwDilJ6rxlAAALS2RBAAA=", :change_key=>"DwAAAA=="}}}, {:parent_folder_id=>{:attribs=>{:id=>"AQMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQAuAAADfHrTJNvhv0OEQXo0hlopIQEAZI1CPxhagUWp8A4pSeq8ZQAAAgENAAAA", :change_key=>"AQAAAA=="}}}]}},
              {:free_busy_changed_event=>{:elems=>[{:time_stamp=>{:text=>"2019-06-27T11:37:41Z"}}, {:item_id=>{:attribs=>{:id=>"AAMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQBGAAAAAAB8etMk2+G/Q4RBejSGWikhBwBkjUI/GFqBRanwDilJ6rxlAAAAAAENAABkjUI/GFqBRanwDilJ6rxlAAALS2RBAAA=", :change_key=>"DwAAAA=="}}}, {:parent_folder_id=>{:attribs=>{:id=>"AQMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQAuAAADfHrTJNvhv0OEQXo0hlopIQEAZI1CPxhagUWp8A4pSeq8ZQAAAgENAAAA", :change_key=>"AQAAAA=="}}}]}},
              {:modified_event=>{:elems=>[{:time_stamp=>{:text=>"2019-06-27T11:37:42Z"}}, {:item_id=>{:attribs=>{:id=>"AAMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQBGAAAAAAB8etMk2+G/Q4RBejSGWikhBwBkjUI/GFqBRanwDilJ6rxlAAAAAAENAABkjUI/GFqBRanwDilJ6rxlAAALS2RDAAA=", :change_key=>"DwAAAA=="}}}, {:parent_folder_id=>{:attribs=>{:id=>"AQMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQAuAAADfHrTJNvhv0OEQXo0hlopIQEAZI1CPxhagUWp8A4pSeq8ZQAAAgENAAAA", :change_key=>"AQAAAA=="}}}]}},
              {:free_busy_changed_event=>{:elems=>[{:time_stamp=>{:text=>"2019-06-27T11:37:42Z"}}, {:item_id=>{:attribs=>{:id=>"AAMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQBGAAAAAAB8etMk2+G/Q4RBejSGWikhBwBkjUI/GFqBRanwDilJ6rxlAAAAAAENAABkjUI/GFqBRanwDilJ6rxlAAALS2RDAAA=", :change_key=>"DwAAAA=="}}}, {:parent_folder_id=>{:attribs=>{:id=>"AQMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQAuAAADfHrTJNvhv0OEQXo0hlopIQEAZI1CPxhagUWp8A4pSeq8ZQAAAgENAAAA", :change_key=>"AQAAAA=="}}}]}},
              {:modified_event=>{:elems=>[{:time_stamp=>{:text=>"2019-06-27T11:37:43Z"}}, {:item_id=>{:attribs=>{:id=>"AAMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQBGAAAAAAB8etMk2+G/Q4RBejSGWikhBwBkjUI/GFqBRanwDilJ6rxlAAAAAAENAABkjUI/GFqBRanwDilJ6rxlAAALS2REAAA=", :change_key=>"DwAAAA=="}}}, {:parent_folder_id=>{:attribs=>{:id=>"AQMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQAuAAADfHrTJNvhv0OEQXo0hlopIQEAZI1CPxhagUWp8A4pSeq8ZQAAAgENAAAA", :change_key=>"AQAAAA=="}}}]}},
              {:free_busy_changed_event=>{:elems=>[{:time_stamp=>{:text=>"2019-06-27T11:37:43Z"}}, {:item_id=>{:attribs=>{:id=>"AAMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQBGAAAAAAB8etMk2+G/Q4RBejSGWikhBwBkjUI/GFqBRanwDilJ6rxlAAAAAAENAABkjUI/GFqBRanwDilJ6rxlAAALS2REAAA=", :change_key=>"DwAAAA=="}}}, {:parent_folder_id=>{:attribs=>{:id=>"AQMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQAuAAADfHrTJNvhv0OEQXo0hlopIQEAZI1CPxhagUWp8A4pSeq8ZQAAAgENAAAA", :change_key=>"AQAAAA=="}}}]}},
              {:modified_event=>{:elems=>[{:time_stamp=>{:text=>"2019-06-27T11:37:43Z"}}, {:folder_id=>{:attribs=>{:id=>"AQMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQAuAAADfHrTJNvhv0OEQXo0hlopIQEAZI1CPxhagUWp8A4pSeq8ZQAAAgENAAAA", :change_key=>"AgAAAA=="}}}, {:parent_folder_id=>{:attribs=>{:id=>"AQMkADczYjgxZGNmLWJlZjgtNGI5ZS1iMmQzLTRmZWQ5NDEzYWJhNQAuAAADfHrTJNvhv0OEQXo0hlopIQEAZI1CPxhagUWp8A4pSeq8ZQAAAgEIAAAA", :change_key=>"AQAAAA=="}}}]}}]}}]
      end

      subject { resp.notification_hashes }

      it { is_expected.to eq(notification_hashes) }
    end


    describe "#notification_event_hashes" do
      let(:notification_hash) do
        {:notification=>
          {:elems=>
             [{:subscription_id=>{:text=>"f6bc657d-dde1-4f94-952d-143b95d6483d"}},
              {:created_event=>
                 {:elems=>
                    [{:time_stamp=>{:text=>"2013-09-16T04:31:29Z"}},
                     {:item_id=>
                        {:attribs=>
                           {:id=>
                              "AAMkADkzNjJjODUzLWZhMDMtNDVkMS05ZDdjLWVmMDlkYjQ1Zjc4MwBGAAAAAABSSWVKrmGUTJE+MVIvofglBwDZGACZQpSgSpyNkexYe2b7AAAAAAENAADZGACZQpSgSpyNkexYe2b7AAANGFYwAAA=",
                            :change_key=>"CQAAAA=="}}},
                     {:parent_folder_id=>
                        {:attribs=>
                           {:id=>
                              "AQMkADkzNjJjODUzLWZhMDMtNDVkMS05ZDdjLWVmMDlkYjQ1Zjc4MwAuAAADUkllSq5hlEyRPjFSL6H4JQEA2RgAmUKUoEqcjZHsWHtm+wAAAgENAAAA",
                            :change_key=>"AQAAAA=="}}}]}},
              {:new_mail_event=>
                 {:elems=>
                    [{:time_stamp=>{:text=>"2013-09-16T04:31:29Z"}},
                     {:item_id=>
                        {:attribs=>
                           {:id=>
                              "AAMkADkzNjJjODUzLWZhMDMtNDVkMS05ZDdjLWVmMDlkYjQ1Zjc4MwBGAAAAAABSSWVKrmGUTJE+MVIvofglBwDZGACZQpSgSpyNkexYe2b7AAAAAAENAADZGACZQpSgSpyNkexYe2b7AAANGFYwAAA=",
                            :change_key=>"CQAAAA=="}}},
                     {:parent_folder_id=>
                        {:attribs=>
                           {:id=>
                              "AQMkADkzNjJjODUzLWZhMDMtNDVkMS05ZDdjLWVmMDlkYjQ1Zjc4MwAuAAADUkllSq5hlEyRPjFSL6H4JQEA2RgAmUKUoEqcjZHsWHtm+wAAAgENAAAA",
                            :change_key=>"AQAAAA=="}}}]}},
              {:modified_event=>
                 {:elems=>
                    [{:time_stamp=>{:text=>"2013-09-16T04:31:29Z"}},
                     {:folder_id=>
                        {:attribs=>
                           {:id=>
                              "AQMkADkzNjJjODUzLWZhMDMtNDVkMS05ZDdjLWVmMDlkYjQ1Zjc4MwAuAAADUkllSq5hlEyRPjFSL6H4JQEA2RgAmUKUoEqcjZHsWHtm+wAAAgENAAAA",
                            :change_key=>"AQAAAA=="}}},
                     {:parent_folder_id=>
                        {:attribs=>
                           {:id=>
                              "AQMkADkzNjJjODUzLWZhMDMtNDVkMS05ZDdjLWVmMDlkYjQ1Zjc4MwAuAAADUkllSq5hlEyRPjFSL6H4JQEA2RgAmUKUoEqcjZHsWHtm+wAAAgEJAAAA",
                            :change_key=>"AQAAAA=="}}},
                     {:unread_count=>{:text=>"1"}}]}}]}}
      end

      subject { resp.notification_event_hashes(notification_hash: notification_hash) }

      it { is_expected.to eq(notification_hash[:notification][:elems]) }
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
          <m:ErrorSubscriptionIds>
            <m:SubscriptionId>SomeErrorSubscriptionId_1</m:SubscriptionId>
            <m:SubscriptionId>SomeErrorSubscriptionId_2</m:SubscriptionId>
          </m:ErrorSubscriptionIds>
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

    it "includes ErrorSubscriptionIds" do
      expect(resp.error_subscription_ids).to match_array(["SomeErrorSubscriptionId_1", "SomeErrorSubscriptionId_2"])
    end
  end # context "When invalid GetStreamingEventsResponseMessage"


end
