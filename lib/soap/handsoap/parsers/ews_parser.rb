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

        def find_folder_response(opts)
          folders = []
          (resp/'//m:RootFolder/t:Folders/t:Folder').each do |f|
            parms = {}
            parms[:id] = (f/('t:FolderId')).first['Id']
            parms[:parent_id] = (f/('t:ParentFolderId')).first['Id']
            parms[:disp_name] = (f/('t:DisplayName')).first.to_s
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
          rclass = (@response/'//m:SubscribeResponseMessage').first['ResponseClass']
          if rclass == 'Success'
            return {:subscription_id => (@response/'//m::SubscriptionId').first.to_s,
              :watermark => (@response/'//m:Watermark').first.to_s}
          else
            raise EwsError.new((@response/'//m:MessageText').first.to_s)
          end
        end

        # @todo Better handle error messages
        #   Like a response object with methods
        #   #success? (boolean)
        #   #message (String) text message
        def unsubscribe_response(opts)
          rclass = (@response/'//m:UnsubscribeResponseMessage').first['ResponseClass']
          if rclass == 'Success'
            return true
          else
            raise EwsError.new((@response/'//m:MessageText').first.to_s)
          end
        end


        def get_item_response(opts)
          @response
        end

        # @todo need to find out out to us XPath to get ItemId.  It doesn't seem to work now.
        def create_item_response(opts)
          if ((@response/'//m:UnsubscribeResponseMessage').first['ResponseClass']) == 'Success'
            return {:id => (@response/'//@Id').first.to_s, :change_key => (@response/'//@ChangeKey').first.to_s }
          else
            raise EwsError.new((@response/'//m:MessageText').first.to_s)
          end
        end

      end # EwsParser
    end # SOAP
  end # EWS
end # Viewpoint
