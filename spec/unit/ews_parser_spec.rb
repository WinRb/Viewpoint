require_relative '../spec_helper'

describe "Exchange Response Parser Functionality" do

  let(:success_body) {
    [{:find_folder_response=>{:elems=>[{:response_messages=>{:elems=>[{:find_folder_response_message=>{:attribs=>{:response_class=>"Success"}, :elems=>{:response_code=>{:text=>"NoError"}, :root_folder=>{:attribs=>{:total_items_in_view=>"1", :includes_last_item_in_range=>"true"}, :elems=>[{:folders=>{:elems=>[{:folder=>{:elems=>[{:folder_id=>{:attribs=>{:id=>"AQAnAH", :change_key=>"AQAAABY"}}}, {:display_name=>{:text=>"TestFolder"}}, {:total_count=>{:text=>"0"}}, {:child_folder_count=>{:text=>"0"}}, {:unread_count=>{:text=>"0"}}]}}]}}]}}}}]}}]}}]
  }

  let(:success_body_malformed) {
    [{:find_folder_response=>{:elems=>[{:response_messages=>{:elems=>[{:find_folder_response_message=>{:attribs=>{:response_class=>"Success"}, :elems=>{:response_code=>{:text=>"NoError"}, :root_folder=>{:attribs=>{:total_items_in_view=>"1", :includes_last_item_in_range=>"true"}, :elems=>[{:folders=>{:elems=>[{:folder=>{:elems=>[{:folder_id=>{:attribs=>{:id=>"AQAnAH", :change_key=>"AQAAABY"}}}, {:display_name=>{:text=>"DING!\uFFFD"}}, {:total_count=>{:text=>"0"}}, {:child_folder_count=>{:text=>"0"}}, {:unread_count=>{:text=>"0"}}]}}]}}]}}}}]}}]}}]
  }

  let(:error_body) {
    [{:find_folder_response=>{:elems=>[{:response_messages=>{:elems=>[{:find_folder_response_message=>{:attribs=>{:response_class=>"Error"}, :elems=>{:message_text=>{:text=>"Id is malformed."}, :response_code=>{:text=>"ErrorInvalidIdMalformed"}, :descriptive_link_key=>{:text=>"0"}}}}]}}]}}]
  }

  it 'parses a successful response' do
    soap_resp = load_soap 'find_folder', :response
    resp = Viewpoint::EWS::SOAP::EwsParser.new(soap_resp).parse
    resp.body.should == success_body
  end

  it 'parses a successful response, even if it contains invalid characters' do
    soap_resp = load_soap 'find_folder_malformed', :response
    resp = Viewpoint::EWS::SOAP::EwsParser.new(soap_resp).parse
    resp.body.should == success_body_malformed
  end

  it 'parses an unsuccessful response' do
    soap_resp = load_soap 'find_folder_error', :response
    resp = Viewpoint::EWS::SOAP::EwsParser.new(soap_resp).parse
    resp.body.should == error_body
  end

  it 'parses an error case with a bad character' do
    soap_resp = load_soap 'get_item_bad_character', :response
    resp = Viewpoint::EWS::SOAP::EwsParser.new(soap_resp).parse
    expect(resp.envelope).to_not be_empty
  end

  it 'parses with EwsResponse' do
    soap_resp = load_soap 'get_item_bad_character', :response
    resp = Viewpoint::EWS::SOAP::EwsParser.new(soap_resp).parse(response_class: Viewpoint::EWS::SOAP::EwsResponse)
    expect(resp.response_messages[0].items).to_not be_empty
  end

  it 'parses an empty body' do
    soap_resp = load_soap 'empty_body', :response
    resp = Viewpoint::EWS::SOAP::EwsParser.new(soap_resp).parse
    expect(resp).to_not be_success
    expect(resp.response_code).to be nil
    expect(resp.response_message_text).to be nil
  end

  it 'parses fault without header' do
    soap_resp = load_soap 'fault_no_header', :response
    resp = Viewpoint::EWS::SOAP::EwsParser.new(soap_resp).parse
    expect(resp).to_not be_success
    expect(resp.header).to be nil
    expect(resp.response_messages).to be_empty
  end

  it 'parses fault without header using EwsResponse' do
    soap_resp = load_soap 'fault_no_header', :response
    resp = Viewpoint::EWS::SOAP::EwsParser.new(soap_resp).parse(response_class: Viewpoint::EWS::SOAP::EwsResponse)
    expect(resp.header).to be nil
    expect(resp.response_messages).to be_empty
  end

end
