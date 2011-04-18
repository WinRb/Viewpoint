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
    # An attachment that represents an attachment to another Exchange Item.
    # This is not yet implemented.
    class ItemAttachment < Attachment

      # @param [String] attachment_id The unique ID for the attachment.
      def initialize(attachment_id)
        #raise EwsNotImplemented, "ItemAttachments are not yet implemented in Viewpoint"
        warn "ItemAttachments are not yet implemented in Viewpoint"
      end

    end # ItemAttachment
  end # EWS
end # Viewpoint
