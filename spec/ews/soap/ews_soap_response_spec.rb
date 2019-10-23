require 'spec_helper'

describe Viewpoint::EWS::SOAP::EwsSoapResponse do
  describe '.string_attribs_array_to_hash' do
    let(:elems) do
      [
        {:user_setting=>{:attribs=>{:type=>"StringSetting"}, :elems=>[{:name=>{:text=>"GroupingInformation"}}, {:value=>{:text=>"Default-First-Site-Name"}}]}},
        {:user_setting=>{:attribs=>{:type=>"StringSetting"}, :elems=>[{:name=>{:text=>"ExternalEwsUrl"}}, {:value=>{:text=>"https://exchange.example.com/ews/exchange.asmx"}}]}}
      ]
    end

    it 'converts correctly' do
      expect(Viewpoint::EWS::SOAP::EwsSoapResponse.string_attribs_array_to_hash(elems)).to eq({
                                                                                                'GroupingInformation' => 'Default-First-Site-Name',
                                                                                                'ExternalEwsUrl' => 'https://exchange.example.com/ews/exchange.asmx'
                                                                                              })
    end
  end

  describe '.guard_hash' do
    let(:soap_data) { {a: [{b:1, c: {d: 2}}]} }

    it 'extracts the data correctly' do
      expect(Viewpoint::EWS::SOAP::EwsSoapResponse.guard_hash(soap_data,[:a, :c, :d])).to eq(2)
    end
  end
end
