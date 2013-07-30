$: << File.dirname(__FILE__) + '/../lib/'
require 'viewpoint'
require 'ostruct'
require 'turn/autorun'
require_relative 'xml_matcher'

RSpec.configure do |c|
end

Turn.config.format = :outline

module SpecHelper
  def specdir
    File.dirname(__FILE__)
  end

  def load_soap(name, type)
    File.read("#{specdir}/soap_data/#{name}_#{type}.xml")
  end
end

include SpecHelper
