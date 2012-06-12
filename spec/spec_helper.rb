$: << File.dirname(__FILE__) + '/../lib/'
require 'viewpoint'
require 'ostruct'

module SpecHelper
  def self.specdir
    File.dirname(__FILE__)
  end
end

RSpec.configure do |c|
end
