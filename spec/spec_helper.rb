$: << File.dirname(__FILE__) + '/../lib/'
require 'viewpoint'
require 'viewpoint/logging/config'
require 'ostruct'
require 'turn/autorun'
require_relative 'xml_matcher'

RSpec.configure do |rspec|
  rspec.mock_with :rspec do |mocks|
    mocks.yield_receiver_to_any_instance_implementation_blocks = false
  end
end

Turn.config.format = :outline

module SpecHelper
  def specdir
    File.dirname(__FILE__)
  end

  def load_soap(name, type)
    File.read("#{specdir}/soap_data/#{name}_#{type}.xml").gsub(%r{>\s+}, '>')
  end
end

include SpecHelper
