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

# This class is inherited by all folder subtypes such as Mail, Calendar,
# Tasks and Search.  It will serve as the brain for all of the methods that
# each of these folder types have in common.
module Viewpoint
  module EWS
    class Folder

      @@distinguished_folder_ids = %w{calendar contacts deleteditems drafts inbox journal
      notes outbox sentitems tasks msgfolderroot root junkemail searchfolders voicemail
      recoverableitemsroot recoverableitemsdeletions recoverableitemsversions
      recoverableitemspurges archiveroot archivemsgfolderroot archivedeleteditems
      archiverecoverableitemsroot archiverecoverableitemsdeletions
      archiverecoverableitemsversions archiverecoverableitemspurges}

      @@event_types = %w{CopiedEvent CreatedEvent DeletedEvent ModifiedEvent MovedEvent NewMailEvent}


      def self.get_folder(folder_id)
        tfolder_id = folder_id.downcase
        # If the folder_id is a DistinguishedFolderId change it to a symbol so our SOAP
        # method does the right thing.
        folder_id = @@distinguished_folder_ids.find_index(tfolder_id) ? tfolder_id.to_sym : folder_id
        (Viewpoint::EWS::EWS.instance).get_folder(folder_id)
      end

      def self.delete_folder(folder_id)
        # @todo Implement Folder::delete_folder
      end

      attr_accessor :folder_id, :change_key, :parent_id, :display_name
      attr_reader :subscription_id, :watermark
      alias :id :folder_id

      def initialize(folder)
        @folder_id = folder[:folder_id][:id]
        @change_key = folder[:folder_id][:change_key]
        @parent_id = folder[:parent_folder_id] unless folder[:parent_folder_id].nil?
        @display_name = folder[:display_name][:text]

        @sync_state = nil
        @subscription_id = nil
        @watermark = nil
        @shallow = true
      end

      # Subscribe this folder to events.  This method initiates an Exchange pull
      # type subscription.
      #
      # @param [Array] event_types Which event types to subscribe to.  By default
      #   we subscribe to all Exchange event types: CopiedEvent, CreatedEvent,
      #   DeletedEvent, ModifiedEvent, MovedEvent, NewMailEvent, FreeBusyChangedEvent
      # @return [Boolean] Did the subscription happen successfully?
      # @todo Add custom Exception for EWS
      def subscribe(event_types = @@event_types)
        # Refresh the subscription if already subscribed
        unsubscribe if subscribed?

        resp = (Viewpoint::EWS::EWS.instance).ews.subscribe([folder_id],event_types)
        if(resp.status == 'Success')
          @subscription_id = resp.items.first[:subscription_id][:text]
          @watermark = resp.items.first[:watermark][:text]
          return true
        else
          raise StandardError, "Error: #{resp.message}"
        end
      end

      # Check if there is a subscription for this folder.
      # @return [Boolean] Are we subscribed to this folder?
      def subscribed?
        ( @subscription_id.nil? or @watermark.nil? )? false : true
      end


      # Unsubscribe this folder from further Exchange events.
      # @return [Boolean] Did we unsubscribe successfully?
      # @todo Add custom Exception for EWS
      def unsubscribe
        return true if @subscription_id.nil?

        resp = (Viewpoint::EWS::EWS.instance).ews.unsubscribe(@subscription_id)
        if(resp.status == 'Success')
          @subscription_id, @watermark = nil, nil
          return true
        else
          raise StandardError, "Error: #{resp.message}"
        end
      end

      # Checks a subscribed folder for events
      # @returns [Array] An array of Event items
      # @todo check for subscription expiry
      def get_events
        begin
          if(subscribed?)
            resp = (Viewpoint::EWS::EWS.instance).ews.get_events(@subscription_id, @watermark)
            parms = resp.items.shift
            @watermark = parms[:watermark]
            # @todo if parms[:more_events] # get more events
            return resp.items
          else
            raise StandardError, "Folder <#{self.display_name}> not subscribed to. Issue a Folder#subscribe before checking events."
          end
        rescue EwsSubscriptionTimeout => e
          @subscription_id, @watermark = nil, nil
          raise e
        end
      end

      # Find Items
      def find_items
        resp = (Viewpoint::EWS::EWS.instance).ews.find_item([@folder_id])
        parms = resp.items.shift
        resp.items
      end

      # Get Item
      def get_item(item_id, change_key = nil)
        resp = (Viewpoint::EWS::EWS.instance).ews.get_item([item_id])
        if(resp.status == 'Success')
          return resp.items.shift
        else
          raise EwsError, "Could not retrieve item. #{resp.code}: #{resp.message}"
        end
      end

    end # Folder
  end # EWS
end # Viewpoint
