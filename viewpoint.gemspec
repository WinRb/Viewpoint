# -*- encoding: utf-8 -*-
require 'date'

version = File.read(File.expand_path("../VERSION", __FILE__)).strip

Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = 'viewpoint'
  s.version = version
  s.date		= Date.today.to_s
  s.summary = 'A Ruby client access library for Microsoft Exchange Web Services (EWS)'
  s.description = 'A Ruby client access library for Microsoft Exchange Web Services (EWS).  Examples can be found here: http://distributed-frostbite.blogspot.com'

  s.required_ruby_version = '>= 1.8.7'

  s.author = 'Dan Wanek'
  s.email = 'dan.wanek@gmail.com'
  s.homepage = 'http://github.com/zenchild/Viewpoint'
  s.rubyforge_project = nil

  s.files = Dir['Changelog.txt', 'README', 'COPYING.txt', 'TODO', 'lib/**/*']
  s.require_path = 'lib'
  s.rdoc_options	= %w(-x test/ -x examples/)
  s.extra_rdoc_files = %w(README COPYING.txt)

  s.add_runtime_dependency  'handsoap'
  s.add_runtime_dependency  'nokogiri'
  s.add_runtime_dependency  'httpclient'
  s.add_runtime_dependency  'rubyntlm'
  s.add_runtime_dependency  'icalendar', '>= 1.1.5'
  s.add_runtime_dependency  'mail', '>= 2.2.5'
end
