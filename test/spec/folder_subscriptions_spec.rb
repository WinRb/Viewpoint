$: << File.dirname(__FILE__) + '/../../lib/'
require 'kconv'
require 'viewpoint'
require 'json'

# To run this test put a file called 'creds.json' in this directory with the following format:
#   {"user":"myuser","pass":"mypass","endpoint":"https://mydomain.com/ews/exchange.asmx"}


describe "Folder Subscriptions" do
  before(:all) do
    creds = JSON.load(File.open('spec/creds.json','r'))
    Viewpoint::EWS::EWS.endpoint = creds['endpoint']
    Viewpoint::EWS::EWS.set_auth(creds['user'],creds['pass'])
    @ews = Viewpoint::EWS::EWS.instance
    @inbox = Viewpoint::EWS::GenericFolder.get_folder :inbox
  end

  describe "Example Folder Subscription for the Inbox" do

    it 'should subscribe to the Inbox Folder' do
      @inbox.subscribe.should be_true
    end

    it 'should retrieve new subscription events' do
      @inbox.get_events.should_not be_empty
    end

    it 'should unsubscribe to the Inbox Folder' do
      @inbox.unsubscribe.should be_true
    end

  end

end
