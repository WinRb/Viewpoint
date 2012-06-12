$: << File.dirname(__FILE__) + '/../../lib/'
require 'kconv'
require 'viewpoint'
require 'json'
require 'date'

# To run this test put a file called 'creds.json' in this directory with the following format:
#   {"user":"myuser","pass":"mypass","endpoint":"https://mydomain.com/ews/exchange.asmx"}


describe Viewpoint::EWS::CalendarItem, "functionality testing" do
  before(:all) do
    creds = JSON.load(File.open("#{File.dirname(__FILE__)}/creds.json",'r'))
    Viewpoint::EWS::EWS.endpoint = creds['endpoint']
    Viewpoint::EWS::EWS.set_auth(creds['user'],creds['pass'])
    @v_start = DateTime.parse("#{Date.today}T14:00:00-06:00")
    @v_end   = DateTime.parse("#{Date.today}T15:00:00-06:00")
  end


  describe "class methods for CalendarItem" do
    it 'should #create_item_from_hash' do
      item = { :subject => {:text => 'RSpec Testing'},
        :start => {:text => @v_start.to_s},
        :end => {:text => @v_end.to_s}
      }

      citem = Viewpoint::EWS::CalendarItem.create_item_from_hash(item)
      citem.should be_instance_of(Viewpoint::EWS::CalendarItem)
      citem.recycle!.should be_true
    end

    it 'should #create_item from a user-friendly method' do
      citem = Viewpoint::EWS::CalendarItem.create_item(@v_start, @v_end, 'RSpec Testing', 'Test Body', 'TBA')
      citem.should be_instance_of(Viewpoint::EWS::CalendarItem)
      citem.recycle!.should be_true
    end
  end

  describe "CalendarItem instance functionality" do
    before(:all) do
      @ews = Viewpoint::EWS::EWS.instance
      @cal = Viewpoint::EWS::CalendarFolder.get_folder :calendar
      @citem = Viewpoint::EWS::CalendarItem.create_item(@v_start, @v_end, 'RSpec Testing', 'Test Body', 'TBA')
    end

    it 'should #update_attribs! for the CalendarItem' do
      update = {:sensitivity => {:text => 'Private'}, :body => {:body_type => 'Text', :text => 'Test Body addition'}}
      @citem.update_attribs!(update).should be_true
      @citem.body.should eql('Test Body addition')
    end

    it 'should add attendees to the Meeting' do
      attendees = JSON.load(File.open("#{File.dirname(__FILE__)}/attendees.json",'r'))
      @citem.add_attendees!((attendees.has_key?('required_attendees') ? attendees['required_attendees'] : []),
                            (attendees.has_key?('optional_attendees') ? attendees['optional_attendees'] : [])).should be_true

    end

    it 'should remove an attendee from the Meeting' do
      @citem.remove_attendees!([@citem.required_attendees.first]).should be_true
    end

    after(:all) do
      @citem.recycle!
    end
  end
end
