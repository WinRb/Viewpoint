require "spec_helper"
require "viewpoint/ews/soap/builder"

describe Viewpoint::EWS::SOAP::Builder do
  let(:builder) { described_class.new }

  def build_element
    allow(builder).to receive(:namespace_ews_soap) { "s" }
    allow(builder).to receive(:namespace_ews_types) { "t" }
    allow(builder).to receive(:namespace_ews_messages) { "m" }
    allow(builder).to receive(:namespaces) { {"xmlns:s" => "s", "xmlns:t" => "t", "xmlns:m" => "m"} }
    builder.build {|type, b| yield b if type == :body }
  end

  describe "#request_server_version" do
    it "creates a RequestServerVersion element" do
      resp = build_element {|b| b.request_server_version("Exchange2007")}
      expect(resp.xpath("//t:RequestServerVersion")).to match_xml("<t:RequestServerVersion Version=\"Exchange2007\"/>")
    end
  end

  describe "#exchange_impersonation" do
    it "creates an ExchangeImpersonation element" do
      resp = build_element {|b| b.exchange_impersonation("SID", "someIDhere")}
      expect(resp.xpath("//t:ExchangeImpersonation")).to match_xml(<<-EOF
        <t:ExchangeImpersonation>
          <t:ConnectingSID>
            <t:SID>someIDhere</t:SID>
          </t:ConnectingSID>
        </t:ExchangeImpersonation>
        EOF
      )
    end

    it "won't create an ExchangeImpersonation element if the type is invalid" do
      resp = build_element {|b| b.exchange_impersonation("BadType", "someIDhere")}
      expect(resp.xpath("//t:ExchangeImpersonation").to_xml).to eql ""
    end
  end

  describe "#time_zone_context" do
    it "will build a minimal TimeZoneContext" do
      resp = build_element {|b| b.time_zone_context({id: "Central Standard Time", name: "(GMT-06:00) Central Time (US & Canada)"})}
      expect(resp.xpath("//t:TimeZoneContext")).to match_xml(<<-EOF
        <t:TimeZoneContext>
          <t:TimeZoneDefinition Id="Central Standard Time" Name="(GMT-06:00) Central Time (US &amp; Canada)"/>
        </t:TimeZoneContext>
        EOF
      )
    end
  end

end
