require 'rubygems'
require 'bundler'

require 'bundler/gem_tasks'
require 'date'

task :default => [:gem]

desc "Build the gem without a version change"
task :gem do
    system "gem build viewpoint.gemspec"
end

desc "Clean the build environment"
task :clean do
    system "rm -f viewpoint*.gem"
end

desc "Build the gem, but increment the version first"
task :newrelease => [:versionup, :clean, :gem]


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
  f.close
	ver
end
