#############################################################################
# Copyright © 2009 Dan Wanek <dan.wanek@gmail.com>
#
#
# This file is part of Viewpoint.
# 
# Viewpoint is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published
# by the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.
# 
# Viewpoint is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
# Public License for more details.
# 
# You should have received a copy of the GNU General Public License along
# with Viewpoint.  If not, see <http://www.gnu.org/licenses/>.
#############################################################################
require 'fusefs'
include FuseFS
require File.dirname(__FILE__) + '/../lib/viewpoint'
require File.dirname(__FILE__) + '/../lib/folder'


class EWSFuse < FuseDir

	@@maildir_dirs = ['cur','new', 'tmp']
	@@ewsfuse_dir = "#{ENV['HOME']}/.ewsfuse"

	def initialize(mountpoint)
		@vp = Viewpoint.instance
		@vp.find_folders
		@mf = MailFolder.all
		@messages = {}    # Message objects
		@open_files = {}  # Files open for RAW IO
		@mountpoint = mountpoint

		File::umask(0077)
		if( !File.directory?(@@ewsfuse_dir) )
			Dir.mkdir(@@ewsfuse_dir)
		end
	end

	# ----- FuserFS Methods ----- #
	def contents(path)
		puts "--- IN: contents ---"
		if (local_path?(path))
			puts "--- IN: contents: if ---"
			Dir.entries(local_path(path))
		else
			puts "--- IN: contents: else ---"
			parts = scan_path(path)
			case parts.pop
			when nil
				output = @mf.map do |m|
					m.display_name
				end
				output + Dir.entries(local_path(path))
			when 'cur'
				np = parts.pop
				puts "folder: #{np}"
				mdir = MailFolder.first(:display_name => np)
				if( mdir == nil )
					[]
				else
					mdir.get_todays_messages.map do |msg|
						msg_hash = msg.item_id.hash.abs
						@messages[msg_hash.to_s] = msg
						"#{msg.date_time_recieved.to_time.to_i}_#{msg_hash}"
					end
				end
			when 'new','tmp'
				[]
			else
				['cur','new','tmp']
			end
		end
	end

	def directory?(path)
		if( local_path?(path) )
			puts "Checking for Local_dir?"
			File.directory?( local_path(path) )
		else
			parts = scan_path(path)
			part = parts.pop
			case part
			when /^[0-9]{10,}_/
				puts "NOT DIR: #{path}"
				return false
			when nil, 'cur','new','tmp'
				puts "IS DIR: #{path}"
				return true
			else
				if( (MailFolder.first(:display_name => part )) != nil )
					puts "IS DIR: #{path}"
					return true
				else
					puts "NOT DIR: #{path}"
					return false
				end
			end
		end
	end
	
	def file?(path)
		if( local_path?(path) )
			if(File.exists?(local_path(path)))
				ans = !directory?(path)
			else
				ans = false
			end
		else
			ans = !directory?(path)
		end
		puts "=> file?(#{path}) ... " + (ans ? "yes" : "no")
		return ans
	end

	def executable?(path)
		return false
	end
	
	def read_file(path)
		if( local_path?(path) )
			IO.read(local_path(path))
		else
			parts = scan_path(path)
			msg_hash = parts.last.split('_').last
			@messages[msg_hash.to_s].to_rfc822
		end
	end
	
    def can_write?(path)
		ans = local_path?(path)
		puts "=> can_write?(#{path}) ... " + (ans ? "yes" : "no")
		return ans
	end

	def write_to(path, str)
		puts "=> write_to(#{path}, str...)"
		io = File.open(local_path(path),'w+')
		io.write(str)
		io.close
	end

    def can_delete?(path)
		ans = local_path?(path)
		puts "=> can_delete?(#{path}) ... " + (ans ? "yes" : "no")
		ans
	end

    def delete(path)
		puts "=> delete(#{path})"
		lpath = local_path(path)
		if( File.directory?(lpath) )
			puts "Removing local directory #{lpath}"
		else
			puts "Removing local file #{lpath}"
			File.unlink(lpath)
		end
	end
	
    def can_mkdir?(path)
		ans = local_path?(path)
		puts "=> can_mkdir?(#{path}) ... " + (ans ? "yes" : "no")
		ans
	end

	def mkdir(path)
		puts "=> mkdir(#{path})"
		lpath = local_path(path)
		Dir.mkdir lpath
	end

    def can_rmdir?(path)
		puts "=> can_rmdir?(#{path})"
		local_path?(path)
	end
	
	def rmdir(path)
		lpath = local_path(path)
		puts "=> rmdir(#{lpath})"
		Dir.rmdir(lpath)
	end
	
	def size(path)
		if(local_path?(path))
			File.size(local_path(path))
		end
	end

	# --- RAW FuserFS Methods --- #
    def raw_open(path,mode)   # mode is "r" "w" or "rw", with "a" if the file
		return false
		puts "** => raw_open(#{path}, '#{mode}')"

		if( !local_path?(path) )
			return false
		end

		case mode
		when /^r$/
			mode = 'r'
			puts "Setting mode to 'r'"
		when /^w$/
			mode = 'a'
			puts "Setting mode to 'a'"
		when /^[wr]{2}$/, /a/
			mode = 'a+'
			puts "Setting mode to 'r+'"
		else
			raise "Unknown mode error #{mode}"
		end

		return true if @open_files.has_key?(path)
		begin
			puts "Raw opening.... File.open(#{local_path(path)}, #{mode})" 
			@open_files[path] = File.open(local_path(path), mode)
			return true
		rescue => error
			puts "Error opening raw file: #{error}"
			return false
		end
	end

    def raw_read(path,offset,size)
		begin
			puts "** => raw_read(#{path}, #{offset}, #{size})"
			file = @open_files[path]
			return unless file
			file.seek(offset, File::SEEK_SET)
			file.read(size)
		rescue => error
			puts "Error reading raw file: #{error}"
			nil
		end
	end

    def raw_write(path,offset,size,buf)
		begin
			puts "** => raw_write(#{path}, #{offset}, #{size}, #{buf})"
			file = @open_files[path]
			return unless file
			file.seek(offset, File::SEEK_SET)
			file.write(buf[0, size])
		rescue => error
			puts "Error writing to raw file: #{error}"
		end
	end

    def raw_close(path)
		begin
			puts "** => raw_close(#{path})"
			file = @open_files[path]
			return unless file
			file.close
			@open_files.delete path
		rescue => error
			puts "Error closing raw file: #{error}"
		end
	end


	# --- End FuserFS Methods --- #
	
	# Is this a virtual dir/file or a local file
	def local_path?(path)
		return false
		puts "==> local_path?(#{path})"
		parts = scan_path(path)

		if parts.empty?
			return false
		else
			ans = ((!@@maildir_dirs.include? parts.last) &&
					parts.last !~ /^[0-9]{10,}_/ &&
					((MailFolder.first(:display_name => parts.last )) == nil)
					)
			return ans
		end
	end

	# Return local path as a string
	def local_path(path)
		puts "==> local_path(#{path})"
		#lpath = path.gsub(/#{@mountpoint}\/?/,'')
		lpath = path.gsub(/^\/?/,'')
		return "#{@@ewsfuse_dir}/#{lpath}"
	end
end

# FuserFS set-up
if (File.basename($0) == File.basename(__FILE__))
	if (ARGV.size != 1)
		puts "Usage: #{$0} <directory>"
		exit
	end
	
	dirname = ARGV.shift
	
	unless File.directory?(dirname)
		puts "Usage: #{dirname} is not a directory."
		exit
	end
	
	root = EWSFuse.new(dirname)

	# Set the root FuseFS
	FuseFS.set_root(root)
	FuseFS.mount_under(dirname)
	FuseFS.run # This doesn't return until we're unmounted.
end
