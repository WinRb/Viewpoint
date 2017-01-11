require_relative '../spec_helper'

module ResponseObjects
  def self.folders
    [ {:folder => {:display_name => {:text => 'Inbox'}}},
      {:folder => {:display_name => {:text => 'Drafts'}}},
      {:tasks_folder => {:display_name => {:text => 'Tasks'}}} ]
  end
end

describe Viewpoint::EWS::ItemAccessors do
  before do
    ews = double("ews")
    @ecli = double("EWSClient")
    @ecli.extend subject
    @ecli.stub(:ews) {ews}
  end

  context "ensure that exceptions are being raised" do
    before do
      resp = OpenStruct.new
      rm = OpenStruct.new
      rm.status = 'Failure'
      resp.response_messages = [rm]
      @ecli.ews.stub(:get_item).with(an_instance_of(Hash)) { resp }
    end
    it '#get_item should raise an exception' do
      expect {
        @ecli.get_item("MyItemId")
      }.to raise_error(Viewpoint::EWS::EwsItemNotFound)
    end
  end

  context "get_item_args should handle :occurrence_item_id" do
    class GetItemArgsAccessor
      include Viewpoint::EWS::ItemAccessors
      def call_get_item_args(*args)
        get_item_args(*args)
      end
    end

    it "should handle an :occurrence_item_id hash" do
      occurrence_item_id = {:occurrence_item_id => {:recurring_master_id => 'rid1', :change_key => 'ck', :instance_index => 1}}
      result = GetItemArgsAccessor.new.call_get_item_args(occurrence_item_id, {})
      result[:item_ids].should eq [occurrence_item_id]
    end

    it "should handle an Array of :occurrence_item_id hashes" do
      occurrences =  [
          {:occurrence_item_id => {:recurring_master_id => 'rid1', :change_key => 'ck1', :instance_index => 1}},
          {:occurrence_item_id => {:recurring_master_id => 'rid2', :change_key => 'ck2', :instance_index => 2}},
          {:occurrence_item_id => {:recurring_master_id => 'rid3', :change_key => 'ck3', :instance_index => 3}},
      ]
      result = GetItemArgsAccessor.new.call_get_item_args(occurrences, {})
      result[:item_ids].should eq occurrences
    end

    it "should handle an :id hash" do
      id = {:id => 'id1', :change_key => 'ck1'}
      result = GetItemArgsAccessor.new.call_get_item_args(id, {})
      result[:item_ids].should eq [{:item_id => {:id => 'id1', :change_key => 'ck1'}}]
    end

    it "should handle an Array of id strings" do
      ids = ['id1', 'id2', 'id3']
      result = GetItemArgsAccessor.new.call_get_item_args(ids, {})
      result[:item_ids].should eq [{:item_id=>{:id => 'id1'}},{:item_id=>{:id => 'id2'}},{:item_id=>{:id => 'id3'}}]
    end
  end

end
