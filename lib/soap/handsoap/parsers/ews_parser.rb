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
          @response_message.items = resolution_set
        end

        def get_folder_response(opts)
          @response_message.items = folders
        end

        def find_folder_response(opts)
          folders = []
          (@response/"//#{NS_EWS_MESSAGES}:FindFolderResponseMessage//#{NS_EWS_TYPES}:Folders/*").each do |f|
            folders << xml_to_hash!(f.native_element)
          end
          @response_message.items = folders
        end

        def get_events_response(opts)
          if @response_message.status == 'Success'
            events = []
            events << {}
            events.first[:subscription_id] = (@response/"//#{NS_EWS_MESSAGES}:Notification/#{NS_EWS_TYPES}:SubscriptionId").first.to_s
            events.first[:more_events] = (@response/"//#{NS_EWS_MESSAGES}:Notification/#{NS_EWS_TYPES}:SubscriptionId").first.to_boolean

            (@response/"//#{NS_EWS_MESSAGES}:Notification/*[position()>3]").each do |e|
              events << xml_to_hash!(e.native_element)
              events.first[:watermark] = events.last[events.last.keys.first][:watermark][:text]
            end

            @response_message.items = events
          else
            raise EwsSubscriptionTimeout.new("#{@response_message.code}: #{@response_message.message}")
          end
        end

        def find_item_response(opts)
          items = []
          items << {}
          items.first[:total_items_in_view] = (@response/"//#{NS_EWS_MESSAGES}:FindItemResponseMessage/#{NS_EWS_MESSAGES}:RootFolder/@TotalItemsInView").first.to_i

          (@response/"//#{NS_EWS_MESSAGES}:FindItemResponseMessage//#{NS_EWS_TYPES}:Items/*").each do |i|
            items << xml_to_hash!(i.native_element)
          end

          @response_message.items = items
        end

        # Parsers the response from the SOAP Subscribe operation
        # @see http://msdn.microsoft.com/en-us/library/aa566188.aspx
        #
        # @return [Hash] A hash with the keys :watermark and :subscription_id
        # @raise [EwsError] Raise an error if the ResponseClass is not Success
        def subscribe_response(opts)
          subscription = []
          sid = xml_to_hash!((@response/"//#{NS_EWS_MESSAGES}:SubscriptionId").first.native_element)
          wmk = xml_to_hash!((@response/"//#{NS_EWS_MESSAGES}:Watermark").first.native_element)
          subscription << sid.merge(wmk)
          @response_message.items = subscription
        end

        # @todo Better handle error messages
        def unsubscribe_response(opts)
          @response_message
        end

        def get_item_response(opts)
          if(@response_message.status == 'Success')
            @response_message.items << xml_to_hash!((@response/"//#{NS_EWS_MESSAGES}:Items/*").first.native_element)
          else
            raise EwsError, "#{@response_message.code}: #{@response_message.message}"
          end
        end

        def copy_item_response(opts)
          if(@response_message.status == 'Success')
            @response_message.items << xml_to_hash!((@response/"//#{NS_EWS_MESSAGES}:Items/*").first.native_element)
          else
            raise EwsError, "#{@response_message.code}: #{@response_message.message}"
          end
        end
        
        def move_item_response(opts)
          if(@response_message.status == 'Success')
            @response_message.items << xml_to_hash!((@response/"//#{NS_EWS_MESSAGES}:Items/*").first.native_element)
          else
            raise EwsError, "#{@response_message.code}: #{@response_message.message}"
          end
        end

        # @todo need to find out out to us XPath to get ItemId.  It doesn't seem to work now.
        def create_item_response(opts)
          if(@response_message.status == 'Success')
            items = []
            (@response/"//#{NS_EWS_MESSAGES}:Items/*").each do |i|
              items << xml_to_hash!(i.native_element)
            end
            @response_message.items = items
          else
            raise EwsError, "#{@response_message.code}: #{@response_message.message}"
          end
        end
        
        def send_item_response(opts)
          if(@response_message.status == 'Success')
            items = []
            (@response/"//#{NS_EWS_MESSAGES}:Items/*").each do |i|
              items << xml_to_hash!(i.native_element)
            end
            @response_message.items = items
          else
            raise EwsError, "#{@response_message.code}: #{@response_message.message}"
          end
        end

        def create_attachment_response(opts)
          if(@response_message.status == 'Success')
            att_id = (@response/"//#{NS_EWS_TYPES}:FileAttachment/*").last
            att_id = xml_to_hash!(att_id.native_element)
            @response_message.items = [att_id]
          else
            raise EwsError, "#{@response_message.code}: #{@response_message.message}"
          end
        end

        def sync_folder_items_response(opts)
          if(@response_message.status == 'Success')
            sync = []
            sync << {}
            sync.first[:sync_state] = (@response/"//#{NS_EWS_MESSAGES}:SyncState").first.to_s
            sync.first[:includes_last_item_in_range] = (@response/"//#{NS_EWS_MESSAGES}:IncludesLastItemInRange").first.to_boolean
            (@response/"//m:Changes/*").each do |c|
              sync << xml_to_hash!(c.native_element)
            end
            @response_message.items = sync
          else
            raise EwsError, "#{@response_message.code}: #{@response_message.message}"
          end
        end

        def get_user_oof_settings_response(opts)
          @response_message.items = xml_to_hash!((@response/"//#{NS_EWS_TYPES}:OofSettings").first.native_element)
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
          (@response/"//#{NS_EWS_MESSAGES}:ResolutionSet/*").each do |r|
            mbox_hash    = mailbox((r/"#{NS_EWS_TYPES}:Mailbox").first)
            contact_hash = contact((r/"#{NS_EWS_TYPES}:Contact").first)
            resolution_set << mbox_hash.merge(contact_hash)
          end
          resolution_set
        end

        def folders
          folders = []
          (@response/"//#{NS_EWS_MESSAGES}:Folders/*").each do |f|
            folders << xml_to_hash!(f.native_element)
          end
          folders
        end

      end # EwsParser
    end # SOAP
  end # EWS
end # Viewpoint
