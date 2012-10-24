class XmlMatcher
  def initialize(expected)
    @expected = expected
  end

  def ==(actual)
    @expected == actual.to_xml
  end
end

def xml_matcher(expected_xml)
  XmlMatcher.new(expected_xml)
end
