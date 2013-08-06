RSpec::Matchers.define :match_xml do |expected|
  match do |actual|
    compare_xml(actual, expected)
  end

  def compare_xml(actual, expected)
    actual.to_xml == Nokogiri::XML(expected).to_xml
  end
end
