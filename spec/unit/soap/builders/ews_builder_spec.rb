require_relative '../../../spec_helper'

describe Viewpoint::EWS::SOAP::EwsBuilder do
  let(:builder)    { described_class.new }
  let(:namespaces) { Viewpoint::EWS::SOAP::NAMESPACES }

  it 'should #build a basic structure' do
    doc = builder.build!(server_version: Viewpoint::EWS::SOAP::VERSION_2007) {|s| }
    doc.should match_xml(load_soap('basic', :request))
  end

  it 'should build BodyType' do
    doc = builder.build! do |section|
      if section == :body
        builder.body_type!(:html)
        builder.body_type!(:text)
        builder.body_type!(:best)
      end
    end
    doc.xpath('//t:BodyType[1]').text.should eq('HTML')
    doc.xpath('//t:BodyType[2]').text.should eq('Text')
    doc.xpath('//t:BodyType[3]').text.should eq('Best')
  end

  it 'should format various Time inputs' do
    builder.send(:format_time, Date.iso8601('2013-01-01')).should eq('2013-01-01T00:00:00+00:00')
    builder.send(:format_time, DateTime.iso8601('2013-01-01T23:01:00-05:00')).should eq('2013-01-02T04:01:00+00:00')
    expect {builder.send(:format_time, true)}.to raise_error(Viewpoint::EWS::EwsBadArgumentError)
    expect {builder.send(:format_time, 'asdf')}.to raise_error(Viewpoint::EWS::EwsBadArgumentError)
  end

  it 'should contain time zone context' do
    doc = builder.build!(time_zone_context: {id: 'SpaceTime'})
    selector = "//soap:Header/t:TimeZoneContext/t:TimeZoneDefinition[@Id='SpaceTime']"
    doc.root.xpath(selector, namespaces).should be_any
  end

  describe "#field_uRI" do
    let(:field_uri_string) { "message:ToRecipients" }
    let(:match_string)     { "<FieldURI FieldURI=\"#{field_uri_string}\"/>" }

    before do
      builder.stub(:ews_types_builder) { builder.nbuild }
    end

    it "builds a fieldURI from a String" do
      builder.field_uri(field_uri_string)
      ndoc = builder.nbuild.doc
      expect(ndoc.children.length).to eq(1)
      expect(ndoc.children.first.to_s).to eq(match_string)
    end

    it "builds a fieldURI from a Hash with key :field_uRI" do
      builder.field_uri({field_uRI: field_uri_string})
      ndoc = builder.nbuild.doc
      expect(ndoc.children.length).to eq(1)
      expect(ndoc.children.first.to_s).to eq(match_string)
    end

    it "builds a fieldURI from a Hash with key :field_uri" do
      builder.field_uri({field_uri: field_uri_string})
      ndoc = builder.nbuild.doc
      expect(ndoc.children.length).to eq(1)
      expect(ndoc.children.first.to_s).to eq(match_string)
    end

  end

  describe ".camel_case_attributes" do
    let(:result) do
      Viewpoint::EWS::SOAP::EwsBuilder.camel_case_attributes(input)
    end

    context "flat, no special fields" do
      let(:input) do
        { foo: 1, bar: "two", baz: "three" }
      end

      let(:expected) do
        { "Foo" => 1, "Bar" => "two", "Baz" => "three" }
      end

      it "produces the expected output" do
        expect(result).to eq(expected)
      end
    end

    context "nested, no special fields" do
      let(:input) do
        { foo: 1, bar: "two", baz: { quux: "three" } }
      end

      let(:expected) do
        { "Foo" => 1, "Bar" => "two", "Baz" => { "Quux" => "three" } }
      end

      it "produces the expected output" do
        expect(result).to eq(expected)
      end
    end

    context "special fields" do
      context "text" do
        let(:input) do
          { foo: 1, text: "two" }
        end

        let(:expected) do
          { "Foo" => 1, :text => "two" }
        end

        it "produces the expected output" do
          expect(result).to eq(expected)
        end
      end

      context "sub_elements" do
        let(:input) do
          { foo: 1, sub_elements: [ { bar: 2 }, { baz: "three" } ] }
        end

        let(:expected) do
          { "Foo" => 1, :sub_elements => [ { "Bar" => 2 }, { "Baz" => "three" } ] }
        end

        it "produces the expected output" do
          expect(result).to eq(expected)
        end
      end

      context "xmlns_attribute" do
        let(:input) do
          { foo: 1, xmlns_attribute: "http://example.com/ns" }
        end

        let(:expected) do
          { "Foo" => 1, xmlns_attribute: "http://example.com/ns" }
        end

        it "produces the expected output" do
          expect(result).to eq(expected)
        end
      end
    end
  end
end
