class XmlMatcher
  def initialize(expected)
    @expected = Nokogiri::XML(expected)
  end

  def ==(actual)
    @expected.to_xml == actual.to_xml
  end
end

def xml_matcher(expected_xml)
  XmlMatcher.new(expected_xml)
end
