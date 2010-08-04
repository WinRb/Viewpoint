$: << File.dirname(__FILE__) + '/../../lib/'
require 'kconv'
require 'viewpoint'
require 'json'

# To run this test put a file called 'creds.json' in this directory with the following format:
#   {"user":"myuser","pass":"mypass","endpoint":"https://mydomain.com/ews/exchange.asmx"}


describe "Test the basic features of Viewpoint" do
  before(:all) do
    creds = JSON.load(File.open('spec/creds.json','r'))
    Viewpoint::EWS::EWS.endpoint = creds['endpoint']
    Viewpoint::EWS::EWS.set_auth(creds['user'],creds['pass'])
    @ews = Viewpoint::EWS::EWS.instance
  end

  it 'should retrieve the various Folder Types' do
    (Viewpoint::EWS::GenericFolder.get_folder :inbox).should be_instance_of(Viewpoint::EWS::Folder)
    (Viewpoint::EWS::GenericFolder.get_folder :calendar).should be_instance_of(Viewpoint::EWS::CalendarFolder)
    (Viewpoint::EWS::GenericFolder.get_folder :contacts).should be_instance_of(Viewpoint::EWS::ContactsFolder)
    (Viewpoint::EWS::GenericFolder.get_folder :tasks).should be_instance_of(Viewpoint::EWS::TasksFolder)
  end

  it 'should retrive the Inbox by name' do
    (Viewpoint::EWS::GenericFolder.get_folder_by_name 'Inbox').should be_instance_of(Viewpoint::EWS::Folder)
  end

  it 'should retrive the Inbox by FolderId' do
    inbox = Viewpoint::EWS::GenericFolder.get_folder_by_name 'Inbox'
    (Viewpoint::EWS::GenericFolder.get_folder inbox.id).should be_instance_of(Viewpoint::EWS::Folder)
  end

  it 'should retrieve an Array of Folder Types' do
    flds = Viewpoint::EWS::GenericFolder.find_folders
    flds.should be_instance_of(Array)
    flds.first.should be_kind_of(Viewpoint::EWS::GenericFolder)
  end

  it 'should retrieve messages from a mail folder' do
    inbox = Viewpoint::EWS::GenericFolder.get_folder :inbox
    msgs  = inbox.find_items
    msgs.should be_instance_of(Array)
    if(msgs.length > 0)
      msgs.first.should be_kind_of(Viewpoint::EWS::Item)
    end
  end

  it 'should retrieve an item by id if one exists' do
    inbox = Viewpoint::EWS::GenericFolder.get_folder :inbox
    msgs  = inbox.find_items
    if(msgs.length > 0)
      item = inbox.get_item(msgs.first.id)
      item.should be_kind_of(Viewpoint::EWS::Item)
    else
      msgs.should be_empty
    end
  end

  it 'should retrieve a folder by name' do
    inbox = Viewpoint::EWS::GenericFolder.get_folder_by_name("Inbox")
    inbox.should be_instance_of(Viewpoint::EWS::Folder)
  end

  it 'should retrieve a list of folder names' do
    Viewpoint::EWS::GenericFolder.folder_names.should_not be_empty
  end

end
