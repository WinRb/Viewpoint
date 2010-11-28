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
    # Represents a Contact Item in the Exchange datastore.
    class Contact < Item

      # This is a class method that creates a new Contact in the Exchange Data Store.
      # @param [Hash] item A Hash of values based on values found here:
      #   http://msdn.microsoft.com/en-us/library/aa581315.aspx
      # @param [String, Symbol] folder_id The folder to create this item in. Either a
      #   DistinguishedFolderId (must me a Symbol) or a FolderId (String)
      # @param [String] send_invites "SendToNone/SendOnlyToAll/SendToAllAndSaveCopy"
      #   See:  http://msdn.microsoft.com/en-us/library/aa565209.aspx
      # @example Typical Usage
      #   item = {
      #     :file_as => {:text => 'Dan Wanek'},
      #     :given_name => {:text => 'Dan Wanek'},
      #     :company_name => {:text => 'Test Company'},
      #     :email_addresses => [
      #       {:entry => {:key => 'EmailAddress1', :text => 'myemail@work.com'}},
      #       {:entry => {:key => 'EmailAddress2', :text => 'myemail@home.com'}}
      #     ],
      #     :physical_addresses => [
      #       {:entry => {:key => 'Business', :sub_elements => {:street => {:text => '6343 N Baltimore'}, :city => {:text => 'Bismarck'}, :state => {:text => 'ND'} }}}
      #     ],
      #     :phone_numbers => [
      #       {:entry => {:key => 'BusinessPhone', :text => '7012220000'}}
      #     ],
      #     :job_title => {:text => 'Systems Architect'}
      #   }
      # @example Minimal Usage
      def self.create_item_from_hash(item, folder_id = :contacts)
        conn = Viewpoint::EWS::EWS.instance
        resp = conn.ews.create_contact_item(folder_id, item)
        if(resp.status == 'Success')
          resp = resp.items.shift
          self.new(resp[resp.keys.first])
        else
          raise EwsError, "Could not create Contact. #{resp.code}: #{resp.message}"
        end
      end



      # Create a Contact in the Exchange Data Store
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
