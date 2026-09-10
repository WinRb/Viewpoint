# frozen_string_literal: true

$LOAD_PATH << "#{File.dirname(__FILE__)}/../lib/"
require 'viewpoint'
require 'viewpoint/logging/config'
require 'ostruct'
require 'turn/autorun'
require_relative 'xml_matcher'

module SpecHelper
  def specdir
    File.dirname(__FILE__)
  end

  def load_soap(name, type)
    File.read("#{specdir}/soap_data/#{name}_#{type}.xml").gsub(/>\s+/, '>')
  end
end

RSpec.configure do |config|
  config.include SpecHelper
  config.mock_with :rspec do |mocks|
    mocks.yield_receiver_to_any_instance_implementation_blocks = false
  end
  config.raise_errors_for_deprecations!
end

Turn.config.format = :outline
