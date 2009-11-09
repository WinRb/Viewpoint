require 'rubygems'
require 'rake/clean'
require 'rake/gempackagetask'

CLEAN.include("pkg")
CLEAN.include("doc")

GEMSPEC = Gem::Specification.new do |gem|
  gem.name = "Viewpoint"
  gem.version = File.open('VERSION').readline.chomp
  gem.date		= Date.today.to_s
  gem.platform = Gem::Platform::RUBY
  gem.rubyforge_project  = nil

  gem.author = "Dan Wanek"
  gem.email = "dan.wanek@gmail.com"
  gem.homepage = "http://github.com/zenchild/Viewpoint"

  gem.summary = "A Ruby client access library for Microsoft Exchange Web Services (EWS)"
  gem.description	= <<-EOF
  	A Ruby client access library for Microsoft Exchange Web Services (EWS).  It is a work in progress.  Methods are still being added from the EWS API docs.  Please see them for further information: http://msdn.microsoft.com/en-us/library/bb204119.aspx
  EOF

  gem.files = `git ls-files`.split(/\n/)
  gem.require_path = "lib"
  gem.rdoc_options	= %w(-x wsdl/ -x test/ -x examples/)
  gem.extra_rdoc_files = %w(README COPYING.txt)

  gem.required_ruby_version	= '>= 1.8.7'
  gem.requirements			= []
  #gem.add_runtime_dependency  ''
  gem.post_install_message	= "Don't forget to create .viewpointrc.  See README"
end
 
Rake::GemPackageTask.new(GEMSPEC) do |pkg|
  pkg.need_tar = true
end

task :default => [:clean, :repackage]
