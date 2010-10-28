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


# This class represents a generic attachment type for Exchange.
module Viewpoint
  module EWS
    class Attachment
      include Model

      attr_reader :id, :ews_item
      # @param [String] attachment_id The unique ID for the attachment.
      def initialize(attachment_id)
        @id = attachment_id
        conn = Viewpoint::EWS::EWS.instance
        resp = conn.ews.get_attachments([attachment_id])
        @file_name = resp.items.first[:file_attachment][:name][:text]

        # content in Base64
        @content = resp.items.first[:file_attachment][:content][:text]
        #@ews_item = resp
      end

      def save_to_file(file_name = @file_name)
        File.open("/tmp/#{file_name}", 'w+') do |f|
          f.write(Base64.decode64(@content))
        end
      end
      
    end # Attachment
  end # EWS
end # Viewpoint
