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

    # describe "#notifications" do
    #   subject { resp.notifications }
    #
    #   it { is_expected.to eq(1) }
    # end

    describe "#notification_hashes" do
      let(:notification_hashes) do
        [{:notification=>
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
                       {:unread_count=>{:text=>"1"}}]}}]}}]
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

    describe "#subscription_id" do
      let(:notification_event_hashes) do
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
                {:unread_count=>{:text=>"1"}}]}}]
      end

      subject { resp.subscription_id(notification_event_hashes: notification_event_hashes) }

      it { is_expected.to eq("f6bc657d-dde1-4f94-952d-143b95d6483d") }
    end

    describe "#events" do
      let(:notification_event_hashes) do
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
                {:unread_count=>{:text=>"1"}}]}}]
      end

      subject { resp.events(notification_event_hashes: notification_event_hashes) }

      # it { expect(subject).to eq([1]) }
      it { expect(subject.object_id).to eq(notification_event_hashes[1..-1].map { |event| Viewpoint::EWS::SOAP::GetStreamingEventResponse.new(event) }.object_id) }
      #
      # it { is_expected.to match_array([]) }

      # it "works" do
      #   expect(subject[0]).to eq(Viewpoint::EWS::SOAP::GetStreamingEventResponse.new(notification_event_hashes[1]))
      # end
    end


    # describe "#events" do
    #   subject { resp.events }
    #
    #   it "returns GetStreamingEventResponse array" do
    #     expect(subject.map(&:id) ).to eq(["AAMkADkzNjJjODUzLWZhMDMtNDVkMS05ZDdjLWVmMDlkYjQ1Zjc4MwBGAAAAAABSSWVKrmGUTJE+MVIvofglBwDZGACZQpSgSpyNkexYe2b7AAAAAAENAADZGACZQpSgSpyNkexYe2b7AAANGFYwAAA=",
    #                                       "AAMkADkzNjJjODUzLWZhMDMtNDVkMS05ZDdjLWVmMDlkYjQ1Zjc4MwBGAAAAAABSSWVKrmGUTJE+MVIvofglBwDZGACZQpSgSpyNkexYe2b7AAAAAAENAADZGACZQpSgSpyNkexYe2b7AAANGFYwAAA=",
    #                                      nil])
    #   end
    # end
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
