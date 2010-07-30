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
    class Contact < Item

      # Create a Contact in the Exchange Data Store
      #
      # @param [String] subject The task subject
      # @param [String] body The task body
      def self.add_contact()
        item = {}
        
        conn = Viewpoint::EWS::EWS.instance
        resp = conn.ews.create_contact_item()

        if(resp.status == 'Success')
          resp = resp.items.shift
          self.new(resp[resp.keys.first])
        else
          raise EwsError, "Could not add contact. #{resp.code}: #{resp.message}"
        end
      end



      # Initialize an Exchange Web Services item of type Contact
      def initialize(ews_item)
        super(ews_item)
      end

      private

      def init_methods
        super()
      end

    end # Contact
  end # EWS
end # Viewpoint
