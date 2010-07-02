require 'rubygems'
require 'nokogiri'

wsdl = Nokogiri::XML(File.read('Services.wsdl'))

methods = []

wsdl.xpath('//wsdl:binding/wsdl:operation').each do |op|
  meth_name = op[:name].gsub(/([a-z])([A-Z])/, '\1_\2').downcase
  methods << meth_name
  str = "  def #{meth_name}\n"
  str << "    action = '#{op.xpath('soap:operation').first[:soapAction]}'\n"
  str << "    resp = invoke('tns:#{op[:name]}', :soap_action => action) do |#{meth_name}|\n"
  str << "      build_#{meth_name}!(#{meth_name})\n"
  str << "    end\n"
  str << "    parse_#{meth_name}(resp)\n"
  str << "  end\n\n"
  puts str
end

puts "\n\n  ## Helper methods (builders and parsers)\n"
puts "  private\n\n"
methods.each do |meth|
  str =  "  def build_#{meth}!(#{meth})\n"
  str << "  end\n\n"
  str << "  def parse_#{meth}()\n"
  str << "  end\n\n"
  puts str
end
