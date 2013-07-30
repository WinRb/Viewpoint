require_relative '../../../spec_helper'

describe Viewpoint::EWS::SOAP::EwsBuilder do
  before do
    @builder = described_class.new
    @namespaces = Viewpoint::EWS::SOAP::NAMESPACES
  end

  it 'should #build a basic structure' do
    doc = @builder.build!(server_version: Viewpoint::EWS::SOAP::VERSION_2007) {|s| }
    doc.should match_xml(load_soap('basic', :request))
  end

  it 'should build BodyType' do
    doc = @builder.build! do |section|
      if section == :body
        @builder.body_type!(:html)
        @builder.body_type!(:text)
        @builder.body_type!(:best)
      end
    end
    doc.xpath('//t:BodyType[1]').text.should eq('HTML')
    doc.xpath('//t:BodyType[2]').text.should eq('Text')
    doc.xpath('//t:BodyType[3]').text.should eq('Best')
  end

end
