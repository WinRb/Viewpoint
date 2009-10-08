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


class EWSFuse < FuseFS::FuseDir
  def initialize
	@vp = Viewpoint.instance
	@vp.find_folders
	@mf = MailFolder.all
  end
  def contents(path)
	  paths = scan_path(path)
	  case paths.pop
	  when nil
		  @mf.map do |m|
			  m.display_name
		  end
	  when 'cur'
		  np = paths.pop
		  puts "folder: #{np}"
		  mdir = MailFolder.first(:display_name => np)
		  if( mdir == nil )
			  []
		  else
			  mdir.get_todays_messages.map do |msg|
				  "#{msg.date_time_recieved.to_time.to_i}_#{msg.item_id.hash}_#{msg.subject}"
			  end
		  end
	  when 'new','tmp'
		  []
	  else
		  ['cur','new','tmp']
	  end
  end
  def directory?(path)
	  paths = scan_path(path)
	  path = paths.pop
	  case path
	  when nil, 'cur','new','tmp'
		  true
	  else
		  if( (MailFolder.first(:display_name => path )) != nil )
			  true
		  else
			  false
		  end
	  end
  end

  def file?(path)
	  ! directory?(path)
  end

  def read_file(path)
	  'Go away!  Nothing here.'
  end
end

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

  root = EWSFuse.new

  # Set the root FuseFS
  FuseFS.set_root(root)

  FuseFS.mount_under(dirname)

  FuseFS.run # This doesn't return until we're unmounted.
end
