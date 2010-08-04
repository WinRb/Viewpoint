$: << File.dirname(__FILE__) + '/../../lib/'
require 'kconv'
require 'viewpoint'
require 'json'

# To run this test put a file called 'creds.json' in this directory with the following format:
#   {"user":"myuser","pass":"mypass","endpoint":"https://mydomain.com/ews/exchange.asmx"}


describe "Test the basic functionality of Items" do
  before(:all) do
    creds = JSON.load(File.open('spec/creds.json','r'))
    Viewpoint::EWS::EWS.endpoint = creds['endpoint']
    Viewpoint::EWS::EWS.set_auth(creds['user'],creds['pass'])
    @ews = Viewpoint::EWS::EWS.instance
  end

  it 'should create a new Message Item that we can test with.' do
    $message = Viewpoint::EWS::Message.send('RSPEC test subject', 'RSPEC test body', [@ews.me.email_address],nil,nil,nil,true)
    $message.should be_instance_of(Viewpoint::EWS::Message)
  end

  it 'should move the Message Item to the Inbox folder' do
    inbox = Viewpoint::EWS::GenericFolder.get_folder :inbox
    $message.move!(inbox).should be_true
  end
  it 'should copy the Message Item to the Drafts folder' do
    drafts = Viewpoint::EWS::GenericFolder.get_folder :drafts
    $msg_copy = $message.copy(drafts)
    $msg_copy.should be_instance_of(Viewpoint::EWS::Message)
  end

  describe "Clean up after ourselves." do
    it 'should delete the initial Message' do
      $message.delete!.should be_true
    end
    
    it 'should send the copy message to Deleted Items' do
      $msg_copy.recycle!.should be_true
    end
  end

end
