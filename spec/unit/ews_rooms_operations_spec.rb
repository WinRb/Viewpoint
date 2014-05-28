require_relative '../spec_helper'

describe "Room operations on Exchange Data Services" do

  #let(:ecli) { Viewpoint::EWSClient.new('dontcare', 'dontcare', 'dontcare') }
  before do
    con = double('Connection')
    @ews = Viewpoint::EWS::SOAP::ExchangeWebService.new con,
      {:server_version => Viewpoint::EWS::SOAP::VERSION_2010_SP2}
    @ews.stub(:do_soap_request)
  end

  it "generates GetRooms XML" do
    @ews.should_receive(:do_soap_request) do |request_document|
      doc = request_document.to_s.gsub(%r{>\s+}, '>')
      doc.should eq load_soap("get_rooms", :request)
    end
    @ews.get_rooms 'TestRoomList@test.microsoft.com'
  end

  it "generates GetRoomLists XML" do
    @ews.should_receive(:do_soap_request) do |request_document|
      doc = request_document.to_s.gsub(%r{>\s+}, '>')
      doc.should eq load_soap("get_room_lists", :request)
    end.and_return(double(:resp))
    @ews.get_room_lists
  end

end
