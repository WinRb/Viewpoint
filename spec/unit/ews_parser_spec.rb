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

  it 'parses a message item with text body response successfully' do
    soap_resp = load_soap 'get_text_item', :response
    resp = Viewpoint::EWS::SOAP::EwsParser.new(soap_resp).parse
    expect(resp.body).to eq([{:get_item_response=>{:elems=>[{:response_messages=>{:elems=>[{:get_item_response_message=>{:elems=>{:response_code=>{:text=>"NoError"}, :items=>{:elems=>[{:message=>{:elems=>[{:item_id=>{:attribs=>{:id=>"AAMkADg4NGVhZGUyLTU2ZTQtNGMwZS1iODRjLWY0YWE2NTYxMGE4ZQBGAAAAAADOrkJOZi/nSp0H8kv4afZtBwDDehUq0W+iQrSvaM5VNEX8AAAAAE5bAACCesYbTRQFQqmH6sMUNPnlAAAAkWs1AAA=", :change_key=>"CQAAABYAAACCesYbTRQFQqmH6sMUNPnlAAAAkdWa"}}}, {:parent_folder_id=>{:attribs=>{:id=>"AAMkADg4NGVhZGUyLTU2ZTQtNGMwZS1iODRjLWY0YWE2NTYxMGE4ZQAuAAAAAADOrkJOZi/nSp0H8kv4afZtAQDDehUq0W+iQrSvaM5VNEX8AAAAAE5bAAA=", :change_key=>"AQAAAA=="}}}, {:item_class=>{:text=>"IPM.Note"}}, {:subject=>{:text=>"Re: Insatisfação total"}}, {:sensitivity=>{:text=>"Normal"}}, {:body=>{:attribs=>{:body_type=>"Text"}, :text=>"Em 17/01/2015 16:36, josedasilvasauro@yahoo.com.brO coiso escreveu:\n\n Meu nome é José da Silva Sauro\n CPF.12345678901\n   Minha reclamação é do coiso em relação a meu pedido\n O que vcs tem pra me informar??\n"}}, {:date_time_received=>{:text=>"2015-01-21T13:03:52Z"}}, {:size=>{:text=>"2445"}}, {:importance=>{:text=>"Normal"}}, {:is_submitted=>{:text=>"false"}}, {:is_draft=>{:text=>"false"}}, {:is_from_me=>{:text=>"false"}}, {:is_resend=>{:text=>"false"}}, {:is_unmodified=>{:text=>"true"}}, {:date_time_sent=>{:text=>"2015-01-21T13:03:47Z"}}, {:date_time_created=>{:text=>"2015-01-21T13:03:52Z"}}, {:response_objects=>{:elems=>[{:reply_to_item=>{}}, {:reply_all_to_item=>{}}, {:forward_item=>{}}]}}, {:display_cc=>{}}, {:display_to=>{:text=>"atendimento"}}, {:has_attachments=>{:text=>"false"}}, {:culture=>{:text=>"pt-BR"}}, {:effective_rights=>{:elems=>[{:create_associated=>{:text=>"false"}}, {:create_contents=>{:text=>"false"}}, {:create_hierarchy=>{:text=>"false"}}, {:delete=>{:text=>"true"}}, {:modify=>{:text=>"true"}}, {:read=>{:text=>"true"}}]}}, {:last_modified_name=>{:text=>"Coiso da Coisa"}}, {:last_modified_time=>{:text=>"2015-01-21T13:03:52Z"}}, {:is_associated=>{:text=>"false"}}, {:web_client_read_form_query_string=>{:text=>"?ae=Itema=Opent=IPM.Noteid=RgAAAADOrkJOZi%2fnSp0H8kv4afZtBwDDehUq0W%2biQrSvaM5VNEX8AAAAAE5bAACCesYbTRQFQqmH6sMUNPnlAAAAkWs1AAAJexvsurl=1"}}, {:conversation_id=>{:attribs=>{:id=>"AAQkADg4NGVhZGUyLTU2ZTQtNGMwZS1iODRjLWY0YWE2NTYxMGE4ZQAQAO7cPg/JE9FBocl5VhMomEo="}}}, {:sender=>{:elems=>[{:mailbox=>{:elems=>[{:name=>{:text=>"Coiso da Coisa"}}, {:email_address=>{:text=>"josedasilvasauro@yahoo.com.br"}}, {:routing_type=>{:text=>"SMTP"}}, {:mailbox_type=>{:text=>"OneOff"}}]}}]}}, {:to_recipients=>{:elems=>[{:mailbox=>{:elems=>[{:name=>{:text=>"atendimento"}}, {:email_address=>{:text=>"atendimento@coisodacoisa.com.br"}}, {:routing_type=>{:text=>"SMTP"}}, {:mailbox_type=>{:text=>"Mailbox"}}]}}]}}, {:is_read_receipt_requested=>{:text=>"false"}}, {:conversation_index=>{:text=>"AQHQNXqx7tw+D8kT0UGhyXlWEyiYSg=="}}, {:conversation_topic=>{:text=>"Insatisfação total"}}, {:from=>{:elems=>[{:mailbox=>{:elems=>[{:name=>{:text=>"Coisa da Coisa"}}, {:email_address=>{:text=>"josedasilvasauro@yahoo.com.br"}}, {:routing_type=>{:text=>"SMTP"}}, {:mailbox_type=>{:text=>"OneOff"}}]}}]}}, {:internet_message_id=>{:text=>"831821.76477.bm@smtp212.mail.bf1.yahoo.com"}}, {:is_read=>{:text=>"true"}}, {:received_by=>{:elems=>[{:mailbox=>{:elems=>[{:name=>{:text=>"atendimento"}}, {:email_address=>{:text=>"atendimento@coisodacoisa.com.br"}}, {:routing_type=>{:text=>"SMTP"}}, {:mailbox_type=>{:text=>"Mailbox"}}]}}]}}, {:received_representing=>{:elems=>[{:mailbox=>{:elems=>[{:name=>{:text=>"atendimento"}}, {:email_address=>{:text=>"atendimento@coisodacoisa.com.br"}}, {:routing_type=>{:text=>"SMTP"}}, {:mailbox_type=>{:text=>"Mailbox"}}]}}]}}]}}]}}, :attribs=>{:response_class=>"Success"}}}]}}]}}])
  end

  it 'parser struct is empty when trying to parse a message item with text body using buggy SAX parser' do
    soap_resp = load_soap 'get_text_item', :response
    doc = Viewpoint::EWS::SOAP::EwsSaxDocument.new
    Nokogiri::XML::SAX::Parser.new(doc).parse soap_resp
    expect(doc.struct.empty?).to be true
  end
end
