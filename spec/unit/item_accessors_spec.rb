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

end
