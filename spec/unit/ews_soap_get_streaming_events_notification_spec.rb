require_relative '../spec_helper'

describe Viewpoint::EWS::SOAP::EwsSoapGetStreamingEventsNotification do
  let(:streaming_events_notification)  { described_class.new(notification_event_hashes: notification_event_hashes) }
  let(:valid_notification_event_hashes) do
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

  describe "#subscription_id" do
    context "when valid notification_event_hashes" do
      let(:notification_event_hashes) { valid_notification_event_hashes }
      subject { streaming_events_notification.subscription_id }

      it { is_expected.to eq("f6bc657d-dde1-4f94-952d-143b95d6483d") }
    end

    context "when INVALID notification_event_hashes" do
      let(:notification_event_hashes) { {} }
      subject { streaming_events_notification.subscription_id }

      it "raise ArgumentError" do
        expect{subject}.to raise_error(ArgumentError)
      end
    end
  end # describe "#subscription_id" do

  describe "#notification_events" do
    context "when valid notification_event_hashes" do
      let(:notification_event_hashes) { valid_notification_event_hashes }
      subject { streaming_events_notification.notification_events }

      it { expect(subject).to eq(notification_event_hashes[1..-1].map { |event| Viewpoint::EWS::SOAP::GetStreamingEventResponse.new(event) }) }
    end

    context "when INVALID notification_event_hashes" do
      let(:notification_event_hashes) { {} }
      subject { streaming_events_notification.subscription_id }

      it "raise ArgumentError" do
        expect{subject}.to raise_error(ArgumentError)
      end
    end
  end # describe "#notification_events" do

end # describe Viewpoint::EWS::SOAP::EwsSoapGetStreamingEventsNotification do
