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
    module SOAP
      class EwsParser
        include Parser

        # Parsing Methods
        # ---------------

        def resolve_names_response(opts)
          @response_message.items << resolution_set
        end

        def find_folder_response(opts)
          folders = []
          (resp/"//#{NS_EWS_MESSAGES}:RootFolder/#{NS_EWS_TYPES}:Folders/#{NS_EWS_TYPES}:Folder").each do |f|
            parms = {}
            parms[:id] = (f/("#{NS_EWS_TYPES}:FolderId")).first['Id']
            parms[:parent_id] = (f/("#{NS_EWS_TYPES}:ParentFolderId")).first['Id']
            parms[:disp_name] = (f/("#{NS_EWS_TYPES}:DisplayName")).first.to_s
            folders << parms
          end
          folders
        end


        # Parsers the response from the SOAP Subscribe operation
        # @see http://msdn.microsoft.com/en-us/library/aa566188.aspx
        #
        # @return [Hash] A hash with the keys :watermark and :subscription_id
        # @raise [EwsError] Raise an error if the ResponseClass is not Success
        def subscribe_response(opts)
          rclass = (@response/"//#{NS_EWS_MESSAGES}:SubscribeResponseMessage").first['ResponseClass']
          if rclass == 'Success'
            return {:subscription_id => (@response/"//#{NS_EWS_MESSAGES}::SubscriptionId").first.to_s,
              :watermark => (@response/"//#{NS_EWS_MESSAGES}:Watermark").first.to_s}
          else
            raise EwsError.new((@response/"//#{NS_EWS_MESSAGES}:MessageText").first.to_s)
          end
        end

        # @todo Better handle error messages
        #   Like a response object with methods
        #   #success? (boolean)
        #   #message (String) text message
        def unsubscribe_response(opts)
          rclass = (@response/"//#{NS_EWS_MESSAGES}:UnsubscribeResponseMessage").first['ResponseClass']
          if rclass == 'Success'
            return true
          else
            raise EwsError.new((@response/"//#{NS_EWS_MESSAGES}:MessageText").first.to_s)
          end
        end


        def get_item_response(opts)
          @response
        end

        # @todo need to find out out to us XPath to get ItemId.  It doesn't seem to work now.
        def create_item_response(opts)
          if ((@response/"//#{NS_EWS_MESSAGES}:UnsubscribeResponseMessage").first['ResponseClass']) == 'Success'
            return {:id => (@response/'//@Id').first.to_s, :change_key => (@response/'//@ChangeKey').first.to_s }
          else
            raise EwsError.new((@response/"//#{NS_EWS_MESSAGES}:MessageText").first.to_s)
          end
        end

        # Parse out a Mailbox element
        # @param [XML] mbox The <t:Mailbox> element
        # @return [Hash] Values of EWS Mailbox type :name, :email_address, :routing_type, :mailbox_type, :item_id
        def mailbox(mbox_xml)
          xml_to_hash!(mbox_xml.native_element)
        end

        def contact(contact_xml)
          xml_to_hash!(contact_xml.native_element)
        end

        # Parse out Resolutions from a ResolutionSet from the ResolveNames operation
        # @return [Array] An array of :mailbox,:contact Hashes that resolved.
        def resolution_set
          resolution_set = []
          (@response/'//m:ResolutionSet/*').each do |r|
            mbox_hash    = mailbox((r/'t:Mailbox').first)
            contact_hash = contact((r/'t:Contact').first)
            resolution_set << mbox_hash.merge(contact_hash)
          end
          resolution_set
        end

      end # EwsParser
    end # SOAP
  end # EWS
end # Viewpoint
