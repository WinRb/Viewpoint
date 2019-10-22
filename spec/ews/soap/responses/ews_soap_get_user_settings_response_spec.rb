require 'spec_helper'

describe Viewpoint::EWS::SOAP::EwsSoapGetUserSettingsResponse do
  describe '.user_settings_string_values_from_response' do
    let(:response) { {:response=>{:elems=>{:error_code=>{:text=>"NoError"}, :error_message=>{}, :user_responses=>{:elems=>[{:user_response=>{:elems=>[{:error_code=>{:text=>"NoError"}}, {:error_message=>{:text=>"No error."}}, {:redirect_target=>{:attribs=>{:nil=>"true"}}}, {:user_setting_errors=>{}}, {:user_settings=>{:elems=>[{:user_setting=>{:attribs=>{:type=>"StringSetting"}, :elems=>[{:name=>{:text=>"GroupingInformation"}}, {:value=>{:text=>"Default-First-Site-Name"}}]}}, {:user_setting=>{:attribs=>{:type=>"StringSetting"}, :elems=>[{:name=>{:text=>"ExternalEwsUrl"}}, {:value=>{:text=>"https://exchange.example.com/ews/exchange.asmx"}}]}}]}}]}}]}}}} }

    it 'extracts correctly the string values' do
      expect(Viewpoint::EWS::SOAP::EwsSoapGetUserSettingsResponse.user_settings_string_values_from_response(response)).to eq({
        'GroupingInformation' => 'Default-First-Site-Name',
        'ExternalEwsUrl' => 'https://exchange.example.com/ews/exchange.asmx'
      })
    end
  end
end

