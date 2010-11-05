require 'rubygems'
require 'rake/clean'
require 'rake/gempackagetask'
require 'date'
require 'metric_fu'

CLEAN.include("pkg")
CLEAN.include("doc")

GEMSPEC = Gem::Specification.new do |gem|
  gem.name = "viewpoint"
  gem.version = File.open('VERSION').readline.chomp
  gem.date		= Date.today.to_s
  gem.platform = Gem::Platform::RUBY
  gem.rubyforge_project  = nil

  gem.author = "Dan Wanek"
  gem.email = "dan.wanek@gmail.com"
  gem.homepage = "http://github.com/zenchild/Viewpoint"

  gem.summary = "A Ruby client access library for Microsoft Exchange Web Services (EWS)"
  gem.description	= <<-EOF
  	A Ruby client access library for Microsoft Exchange Web Services (EWS).  Examples can be found here: http://distributed-frostbite.blogspot.com
  EOF

  gem.files = `git ls-files`.split(/\n/)
  gem.require_path = "lib"
  gem.rdoc_options	= %w(-x test/ -x examples/)
  gem.extra_rdoc_files = %w(README COPYING.txt)

  gem.required_ruby_version	= '>= 1.8.7'
  gem.add_runtime_dependency  'handsoap'
  gem.add_runtime_dependency  'nokogiri'
  gem.add_runtime_dependency  'httpclient'
  gem.add_runtime_dependency  'rubyntlm'
  gem.add_runtime_dependency  'icalendar', '>= 1.1.5'
  gem.add_runtime_dependency  'mail', '>= 2.2.5'
end
 
Rake::GemPackageTask.new(GEMSPEC) do |pkg|
  pkg.need_tar = true
end

task :default => [:buildgem]

desc "Build the gem without a version change"
task :buildgem => [:clean, :repackage]

desc "Build the gem, but increment the version first"
task :newrelease => [:versionup, :clean, :repackage]


desc "Increment the version by 1 minor release"
task :versionup do
	ver = up_min_version
	puts "New version: #{ver}"
end


def up_min_version
	f = File.open('VERSION', 'r+')
	ver = f.readline.chomp
	v_arr = ver.split(/\./).map do |v|
		v.to_i
	end
	v_arr[2] += 1
	ver = v_arr.join('.')
	f.rewind
	f.write(ver)
	ver
end

MetricFu::Configuration.run do |config|
  #define which metrics you want to use
#  config.metrics  = [:churn, :saikuro, :stats, :flog, :flay]
  config.metrics  = [:flog, :flay]
  config.graphs   = [:flog, :flay]
end

