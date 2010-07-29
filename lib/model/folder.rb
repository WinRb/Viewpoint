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
      include Viewpoint
      include Model

      @@distinguished_folder_ids = %w{calendar contacts deleteditems drafts inbox journal
      notes outbox sentitems tasks msgfolderroot root junkemail searchfolders voicemail
      recoverableitemsroot recoverableitemsdeletions recoverableitemsversions
      recoverableitemspurges archiveroot archivemsgfolderroot archivedeleteditems
      archiverecoverableitemsroot archiverecoverableitemsdeletions
      archiverecoverableitemsversions archiverecoverableitemspurges}

      @@event_types = %w{CopiedEvent CreatedEvent DeletedEvent ModifiedEvent MovedEvent NewMailEvent}


      def self.get_folder(folder_id)
        (Viewpoint::EWS::EWS.instance).ews.get_folder( normalize_id(folder_id) )
      end

      def self.delete_folder(folder_id)
        # @todo Implement Folder::delete_folder
      end

      # Find subfolders of the passed root folder.  If no parameters are passed
      # this method will search from the Root folder.
      # @param [Array] root An folder id, either a DistinguishedFolderId (must me a Symbol)
      #   or a FolderId (String)
      # @param [String] traversal Shallow/Deep/SoftDeleted
      # @return [Array] Returns an Array of Folder or subclasses of Folder
      def self.find_folders(root = :root, traversal = 'Shallow')
        (Viewpoint::EWS::EWS.instance).ews.find_folder( [normalize_id(root)], traversal )
      end

      attr_accessor :folder_id, :change_key, :parent_id
      attr_reader :subscription_id, :watermark
      alias :id :folder_id

      def initialize(ews_item)
        super() # Calls initialize in Model (creates @ews_methods Array)
        @ews_item = ews_item
        @folder_id = ews_item[:folder_id][:id]
        @ews_methods << :folder_id
        @ews_methods << :id
        @change_key = ews_item[:folder_id][:change_key]
        @ews_methods << :change_key
        unless ews_item[:parent_folder_id].nil?
          @parent_id = ews_item[:parent_folder_id]
          @ews_methods << :parent_id
        end
        define_str_var :display_name

        @sync_state = nil # Base-64 encoded sync data
        @synced = false   # Whether or not the synchronization process is complete
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
        items = []
        resp.items.each do |i|
          i_type = i.keys.first
          items << (eval "#{camel_case(i_type)}.new(i[i_type])")
        end
        items
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

      # Syncronize Items in this folder. If this method is issued multiple
      # times it will continue where the last sync completed.
      # @param [Integer] sync_amount The number of items to synchronize per sync
      # @param [Boolean] sync_all Whether to sync all the data by looping through.
      #   The default is to just sync the first set.  You can manually loop through
      #   with multiple calls to #sync_items!
      def sync_items!(sync_amount = 256, sync_all = false)
        resp = (Viewpoint::EWS::EWS.instance).ews.sync_folder_items(@folder_id, @sync_state, sync_amount)
        parms = resp.items.shift
        @sync_state = parms[:sync_state]
        @synced = parms[:includes_last_item_in_range]
        items = {}
        resp.items.each do |i|
          key = i.keys.first
          items[key] = [] unless items[key].is_a?(Array)
          i_type = i[key].keys.first
          items[key] << (eval "#{camel_case(i_type)}.new(i[key][i_type])")
        end
        items
      end

      private

      # Return the appropriate id based on whether it is a DistinguishedFolderId or
      # simply just a FolderId
      def self.normalize_id(folder_id)
        tfolder_id = folder_id.downcase
        # If the folder_id is a DistinguishedFolderId change it to a symbol so our SOAP
        # method does the right thing.
        @@distinguished_folder_ids.find_index(tfolder_id) ? tfolder_id.to_sym : folder_id
      end

    end # Folder
  end # EWS
end # Viewpoint
