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
    allow(@ecli).to receive(:ews).and_return ews
    allow(@ecli).to receive(:merge_restrictions!)
  end

  context "ensure FolderAccessors methods are returning good data" do
    context "methods utilizing ExchangeWebService#find_folder" do
      before do
        resp = OpenStruct.new
        resp.status = 'Success'
        rhash = {:elems => {:root_folder => {:elems => [{:folders =>{:elems => ResponseObjects.folders}}]}}}
        resp.response_message = rhash
        allow(@ecli.ews).to receive(:find_folder).with(an_instance_of(Hash)).and_return resp
        cbn = double("ClassByName")
        allow(cbn).to receive(:new).and_return double("FolderMock")
        allow(@ecli).to receive(:class_by_name).and_return cbn
      end

      it '#find_folders should return folders' do
        expect(@ecli.folders).to be_instance_of(Array)
      end
    end
    context "methods utilizing ExchangeWebService#get_folder" do
      before do
        resp = OpenStruct.new
        resp.status = 'Success'
        rhash = {:elems => {:folders =>{:elems => ResponseObjects.folders}}}
        resp.response_message = rhash
        allow(@ecli.ews).to receive(:get_folder).with(an_instance_of(Hash)).and_return resp
        cbn = double("ClassByName")
        allow(cbn).to receive(:new).and_return double("Folder")
        allow(@ecli).to receive(:class_by_name).and_return cbn
      end
      it '#get_folder should return a Folder' do
        expect(@ecli.get_folder(:inbox)).to be_a(RSpec::Mocks::Double)
      end
    end
  end

  context "ensure that exceptions are being raised" do
    before do
      resp = OpenStruct.new
      resp.status = 'Failure'
      allow(@ecli.ews).to receive(:find_folder).with(an_instance_of(Hash)).and_return resp
      allow(@ecli.ews).to receive(:get_folder).with(an_instance_of(Hash)).and_return resp
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
