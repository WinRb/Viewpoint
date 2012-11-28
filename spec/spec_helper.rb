$: << File.dirname(__FILE__) + '/../lib/'
require 'viewpoint'
require 'ostruct'
require_relative 'request_xml'
require_relative 'response_xml'
require_relative 'xml_matcher'

module SpecHelper
  def self.specdir
    File.dirname(__FILE__)
  end
end

RSpec.configure do |c|
end
