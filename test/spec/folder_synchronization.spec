$: << File.dirname(__FILE__) + '/../../lib/'
require 'kconv'
require 'viewpoint'
require 'json'

# To run this test put a file called 'creds.json' in this directory with the following format:
#   {"user":"myuser","pass":"mypass","endpoint":"https://mydomain.com/ews/exchange.asmx"}


describe "Folder Synchronization" do
  before(:all) do
    creds = JSON.load(File.open('spec/creds.json','r'))
    Viewpoint::EWS::EWS.endpoint = creds['endpoint']
    Viewpoint::EWS::EWS.set_auth(creds['user'],creds['pass'])
    @ews = Viewpoint::EWS::EWS.instance
    @inbox = Viewpoint::EWS::GenericFolder.get_folder :inbox
  end

  describe "Example Folder Synchronization for the Inbox" do

    it 'should start synchronization of the Inbox Folder' do
      @inbox.sync_items!(2)
      @inbox.sync_state.should_not be_nil
    end

  end

end
