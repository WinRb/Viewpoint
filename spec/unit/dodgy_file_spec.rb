require_relative '../spec_helper'

describe "Tolerant parsing" do
  it 'parses a successful response' do
    soap_resp = load_soap 'dodgy_ews', :response
    resp = Viewpoint::EWS::SOAP::EwsParser.new(soap_resp).parse(response_class: Viewpoint::EWS::SOAP::EwsResponse)
    expect { resp.body }.to_not raise_error
  end
end
