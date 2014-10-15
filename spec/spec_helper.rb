$: << File.dirname(__FILE__) + '/../lib/'
#require 'viewpoint'
#require 'viewpoint/logging/config'
#require 'ostruct'
require_relative 'xml_matcher'
require "pry"

RSpec.configure do |c|
end

module SpecHelper
  def specdir
    File.dirname(__FILE__)
  end

  def load_soap(name, type)
    File.read("#{specdir}/soap_data/#{name}_#{type}.xml").gsub(%r{>\s+}, '>')
  end
end

include SpecHelper
