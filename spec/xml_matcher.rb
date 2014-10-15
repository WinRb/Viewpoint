require "nokogiri"
require "rspec/expectations"

RSpec::Matchers.define :match_xml do |expected|
  match do |actual|
    a = actual.respond_to?(:to_xml) ? actual.to_xml : actual
    e = expected.respond_to?(:to_xml) ? expected.to_xml : expected
    @actual   = strict_parse(a).to_xml
    @expected = strict_parse(e).to_xml
    compare_xml(@actual, @expected)
  end

  def compare_xml(actual, expected)
    actual == expected
  end

  def strict_parse(str)
    Nokogiri::XML(str,&:noblanks)
  end
end
