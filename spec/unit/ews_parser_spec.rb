require_relative '../spec_helper'

describe "Exchange Response Parser Functionality" do

  let(:success_body) {
    [{:find_folder_response=>{:elems=>[{:response_messages=>{:elems=>[{:find_folder_response_message=>{:attribs=>{:response_class=>"Success"}, :elems=>{:response_code=>{:text=>"NoError"}, :root_folder=>{:attribs=>{:total_items_in_view=>"1", :includes_last_item_in_range=>"true"}, :elems=>[{:folders=>{:elems=>[{:folder=>{:elems=>[{:folder_id=>{:attribs=>{:id=>"AQAnAH", :change_key=>"AQAAABY"}}}, {:display_name=>{:text=>"TestFolder"}}, {:total_count=>{:text=>"0"}}, {:child_folder_count=>{:text=>"0"}}, {:unread_count=>{:text=>"0"}}]}}]}}]}}}}]}}]}}]
  }
  let(:error_body) {
    [{:find_folder_response=>{:elems=>[{:response_messages=>{:elems=>[{:find_folder_response_message=>{:attribs=>{:response_class=>"Error"}, :elems=>{:message_text=>{:text=>"Id is malformed."}, :response_code=>{:text=>"ErrorInvalidIdMalformed"}, :descriptive_link_key=>{:text=>"0"}}}}]}}]}}]
  }

  it 'parses a successful response' do
    soap_resp = load_soap 'find_folder', :response
    resp = Viewpoint::EWS::SOAP::EwsParser.new(soap_resp).parse
    resp.body.should == success_body
  end

  it 'parses an unsuccessful response' do
    soap_resp = load_soap 'find_folder_error', :response
    resp = Viewpoint::EWS::SOAP::EwsParser.new(soap_resp).parse
    resp.body.should == error_body
  end

end
