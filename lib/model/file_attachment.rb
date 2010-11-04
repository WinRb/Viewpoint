#############################################################################
# Copyright © 2010 Dan Wanek <dan.wanek@gmail.com>
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

module Viewpoint
  module EWS
    # This class represents a file attachment item.  You can save this object
    # to a file withthe #save_to_file method.
    class FileAttachment < Attachment

      attr_reader :file_name, :content
      # @param [String] attachment_id The unique ID for the attachment.
      def initialize(attachment_id)
        @id = attachment_id
        conn = Viewpoint::EWS::EWS.instance
        resp = conn.ews.get_attachment([attachment_id])
        @file_name = resp.items.first[:file_attachment][:name][:text]

        # content in Base64
        @content = resp.items.first[:file_attachment][:content][:text]
      end

      # Save this FileAttachment object to a file.  By default it saves
      # it to the original file's name in the current working directory.
      # @param [String,nil] base_dir the directory to save the file to.  Pass nil if you
      #   do not want to specify a directory or you are passing a full path name to file_name
      # @param [String] file_name The name of the file to save the content to.
      #   Leave this blank to use the default attachment name.
      def save_to_file(base_dir = nil, file_name = @file_name)
        base_dir << '/' unless(base_dir.nil? or base_dir.end_with?('/'))
        File.open("#{base_dir}#{file_name}", 'w+') do |f|
          f.write(Base64.decode64(@content))
        end
        true
      end
      
    end # FileAttachment
  end # EWS
end # Viewpoint
