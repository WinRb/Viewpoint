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

      @@distinguished_folder_ids = %w{ calendar contacts deleteditems drafts
        inbox journal notes outbox sentitems tasks msgfolderroot root
        junkemail searchfolders voicemail recoverableitemsroot recoverableitemsdeletions
        recoverableitemsversions recoverableitemspurges archiveroot archivemsgfolderroot
        archivedeleteditems archiverecoverableitemsroot archiverecoverableitemsdeletions
        archiverecoverableitemsversions archiverecoverableitemspurges}

        @@event_types = %w{CopiedEvent CreatedEvent DeletedEvent ModifiedEvent
        MovedEvent NewMailEvent FreeBusyChangedEvent}


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
        def subscribe(event_types = @@event_types)
          # Refresh the subscription if already subscribed
          unsubscribe if subscribed?

          begin
            resp = (Viewpoint::EWS::EWS.instance).ews.subscribe([folder_id],event_types)

            @subscription_id = resp[:subscription_id]
            @watermark = resp[:watermark]
            return true
          rescue
            return false
          end
        end

        # Check if there is a subscription for this folder.
        # @return [Boolean] Are we subscribed to this folder?
        def subscribed?
          ( @subscription_id.nil? or @watermark.nil? )? false : true
        end


        # Unsubscribe this folder from further Exchange events.
        # @return [Boolean] Did we unsubscribe successfully?
        def unsubscribe
          begin
            return true if @subscription_id.nil?

            (Viewpoint::EWS::EWS.instance).ews.unsubscribe(@subscription_id)
          rescue
            return false
          end
        end


        # Fetch events with the subscription_id.  If one does not exists or is expired,
        # call subscribe.
        # Returns a hash with the event type as the key and an Array of Hashes that
        # represent each event's data
        # An :error key is set if there is a problem
#        def check_subscription
#          if subscribed?
#          end
#        end

    end # Folder
  end # EWS
end # Viewpoint
