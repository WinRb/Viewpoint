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

    # This represents a Mailbox object in the Exchange data store
    # @see http://msdn.microsoft.com/en-us/library/aa565036.aspx MSDN docs
    # @todo Design a Class method that resolves to an Array of MailboxUsers
    class MailboxUser

      attr_reader :name, :email, :routing_type, :mailbox_type, :item_id

      def initialize(name, email=nil, routing_type = nil, mailbox_type = nil, item_id=nil)
        @name, @email = name, email
        @routing_type, @mailbox_type = routing_type, mailbox_type
        @item_id = item_id
      end

    end # MailboxUser
  end # EWS
end # Viewpoint
