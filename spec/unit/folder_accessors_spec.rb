require_relative '../spec_helper'

module ResponseObjects
  def self.folders
    [ {:folder => {:display_name => {:text => 'Inbox'}}},
      {:folder => {:display_name => {:text => 'Drafts'}}},
      {:tasks_folder => {:display_name => {:text => 'Tasks'}}} ]
  end
end

describe Viewpoint::EWS::FolderAccessors do
  before do
    ews = double("ews")
    @ecli = double("EWSClient")
    @ecli.extend subject
    @ecli.stub(:ews) {ews}
  end

  context "ensure FolderAccessors methods are returning good data" do
    context "methods utilizing ExchangeWebService#find_folder" do
      before do
        resp = OpenStruct.new
        resp.status = 'Success'
        rhash = {:elems => {:root_folder => {:elems => [{:folders =>{:elems => ResponseObjects.folders}}]}}}
        resp.response_message = rhash
        @ecli.ews.stub(:find_folder).with(an_instance_of(Hash)) { resp }
        cbn = double("ClassByName")
        cbn.stub(:new) { double("FolderMock") }
        @ecli.stub(:class_by_name) { cbn }
      end

      it '#find_folders should return folders' do
        @ecli.folders.should be_instance_of(Array)
      end
    end
    context "methods utilizing ExchangeWebService#get_folder" do
      before do
        resp = OpenStruct.new
        resp.status = 'Success'
        rhash = {:elems => {:folders =>{:elems => ResponseObjects.folders}}}
        resp.response_message = rhash
        @ecli.ews.stub(:get_folder).with(an_instance_of(Hash)) { resp }
        cbn = double("ClassByName")
        cbn.stub(:new) { double("Folder") }
        @ecli.stub(:class_by_name) { cbn }
      end
      it '#get_folder should return a Folder' do
        @ecli.get_folder(:inbox).should be_instance_of(RSpec::Mocks::Mock)
      end
    end
  end

  context "ensure that exceptions are being raised" do
    before do
      resp = OpenStruct.new
      resp.status = 'Failure'
      @ecli.ews.stub(:find_folder).with(an_instance_of(Hash)) { resp }
      @ecli.ews.stub(:get_folder).with(an_instance_of(Hash)) { resp }
    end
    it '#find_folders should raise an exception' do
      expect {
        @ecli.folders
      }.to raise_error(Viewpoint::EWS::EwsError)
    end
    it '#get_folder should raise an exception' do
      expect {
        @ecli.get_folder(:inbox)
      }.to raise_error(Viewpoint::EWS::EwsError)
    end
  end

end
