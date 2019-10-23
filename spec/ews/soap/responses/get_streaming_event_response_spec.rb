require 'spec_helper'

describe Viewpoint::EWS::SOAP::GetStreamingEventResponse do
  let(:event_hash) do
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
                          :change_key=>"AQAAAA=="}}}]}}
  end

  let(:event) { described_class.new(event_hash) }

  describe "#type" do
    subject { event.type }
    it { is_expected.to eq(:created_event) }
  end

  describe "#watermark" do
    subject { event.watermark }
    it { is_expected.to eq nil }
  end

  describe "#time_stamp" do
    subject { event.time_stamp }
    it { is_expected.to eq("2013-09-16T04:31:29Z") }
  end

  describe "#item_id" do
    subject { event.item_id }
    it { is_expected.to eq({:id=>
                                "AAMkADkzNjJjODUzLWZhMDMtNDVkMS05ZDdjLWVmMDlkYjQ1Zjc4MwBGAAAAAABSSWVKrmGUTJE+MVIvofglBwDZGACZQpSgSpyNkexYe2b7AAAAAAENAADZGACZQpSgSpyNkexYe2b7AAANGFYwAAA=",
                            :change_key=>"CQAAAA=="}) }
  end

  describe "#id" do
    subject { event.id }
    it { is_expected.to eq("AAMkADkzNjJjODUzLWZhMDMtNDVkMS05ZDdjLWVmMDlkYjQ1Zjc4MwBGAAAAAABSSWVKrmGUTJE+MVIvofglBwDZGACZQpSgSpyNkexYe2b7AAAAAAENAADZGACZQpSgSpyNkexYe2b7AAANGFYwAAA=") }
    it { is_expected.to eq("AAMkADkzNjJjODUzLWZhMDMtNDVkMS05ZDdjLWVmMDlkYjQ1Zjc4MwBGAAAAAABSSWVKrmGUTJE+MVIvofglBwDZGACZQpSgSpyNkexYe2b7AAAAAAENAADZGACZQpSgSpyNkexYe2b7AAANGFYwAAA=") }
  end

  describe "#change_key" do
    subject { event.change_key }
    it { is_expected.to eq("CQAAAA==") }
  end

  describe "#folder_id" do
    subject { event.folder_id }
    it { is_expected.to eq nil }
  end

  describe "#parent_folder_id" do
    subject { event.parent_folder_id }
    it { is_expected.to eq({:id=>
                                "AQMkADkzNjJjODUzLWZhMDMtNDVkMS05ZDdjLWVmMDlkYjQ1Zjc4MwAuAAADUkllSq5hlEyRPjFSL6H4JQEA2RgAmUKUoEqcjZHsWHtm+wAAAgENAAAA",
                            :change_key=>"AQAAAA=="}) }
  end

  describe "#item?" do
    subject { event.item? }
    it { is_expected.to be_truthy }
  end

end
