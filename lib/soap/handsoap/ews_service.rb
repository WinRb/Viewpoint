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
$: << File.dirname(__FILE__)
require 'handsoap'
require 'builder'
require 'parser'


Handsoap.http_driver = :http_client

module Viewpoint
  module EWS
    module SOAP
      class ExchangeWebService < Handsoap::Service

        SOAP_ACTION_PREFIX = "http://schemas.microsoft.com/exchange/services/2006/messages"

        @@raw_soap = false

        def initialize()
          if $DEBUG
            @debug = File.new('ews_debug.out', 'w')
            @debug.sync = true
          end
        end

        def self.set_auth(user,pass)
          @@user = user
          @@pass = pass
        end

        # Turn off parsing and just return the soap response
        def self.raw_soap!
          @@raw_soap = true
        end

        # ********* Begin Hooks *********
        def on_create_document(doc)
          doc.alias NS_EWS_TYPES, 'http://schemas.microsoft.com/exchange/services/2006/types'
          doc.alias NS_EWS_MESSAGES, 'http://schemas.microsoft.com/exchange/services/2006/messages'
          header = doc.find('Header')
          header.add("#{NS_EWS_TYPES}:RequestServerVersion") { |rsv| rsv.set_attr('Version','Exchange2007_SP1') }
        end

        # Adds knowledge of namespaces to the response object.  These have to be identical to the 
        # URIs returned in the XML response.  For example, I had some issues with the 'soap'
        # namespace because my original URI did not end in a '/'
        # @example
        #   Won't work: http://schemas.xmlsoap.org/soap/envelope
        #   Works: http://schemas.xmlsoap.org/soap/envelope/
        def on_response_document(doc)
          doc.add_namespace NS_SOAP, 'http://schemas.xmlsoap.org/soap/envelope/'
          doc.add_namespace NS_EWS_TYPES, 'http://schemas.microsoft.com/exchange/services/2006/types'
          doc.add_namespace NS_EWS_MESSAGES, 'http://schemas.microsoft.com/exchange/services/2006/messages'
        end

        def on_after_create_http_request(req)
          req.set_auth @@user, @@pass
        end
        # ********** End Hooks **********


        # Resolve ambiguous e-mail addresses and display names
        # @see http://msdn.microsoft.com/en-us/library/aa565329.aspx ResolveNames
        # @see http://msdn.microsoft.com/en-us/library/aa581054.aspx UnresolvedEntry
        #
        # @param [String] name an unresolved entry
        # @param [Boolean] full_contact_data whether or not to return full contact info
        # @param [Hash] opts optional parameters to this method
        # @option opts [String] :search_scope where to seach for this entry, one of
        #   SOAP::Contacts, SOAP::ActiveDirectory, SOAP::ActiveDirectoryContacts (default),
        #   SOAP::ContactsActiveDirectory
        # @option opts [String, FolderId] :parent_folder_id either the name of a folder or
        #   it's numerical ID.  @see http://msdn.microsoft.com/en-us/library/aa565998.aspx
        def resolve_names(name, full_contact_data = true, opts = {})
          action = "#{SOAP_ACTION_PREFIX}/ResolveNames"
          resp = invoke("#{NS_EWS_MESSAGES}:ResolveNames", :soap_action => action) do |root|
            build!(root) do
              resolve_names!(name,full_contact_data, opts)
            end
          end
          parse!(resp)
        end


        def expand_dl
          action = "#{SOAP_ACTION_PREFIX}/ExpandDL"
          resp = invoke("#{NS_EWS_MESSAGES}:ExpandDL", :soap_action => action) do |expand_dl|
            build_expand_dl!(expand_dl)
          end
          parse_expand_dl(resp)
        end


        # Find subfolders of an identified folder
        # @see http://msdn.microsoft.com/en-us/library/aa563918.aspx
        #
        # @param [Array] parent_folder_ids An Array of folder ids, either a
        #   DistinguishedFolderId (must me a Symbol) or a FolderId (String)
        # @param [String] traversal Shallow/Deep/SoftDeleted
        # @param [Hash] folder_shape defines the FolderShape node
        #   See: http://msdn.microsoft.com/en-us/library/aa494311.aspx
        # @option folder_shape [String] :base_shape IdOnly/Default/AllProperties
        # @option folder_shape :additional_properties
        #   See: http://msdn.microsoft.com/en-us/library/aa563810.aspx
        # @param [Hash] opts optional parameters to this method
        def find_folder(parent_folder_ids = [:root], traversal = 'Shallow', folder_shape = {:base_shape => 'Default'}, opts = {})
          action = "#{SOAP_ACTION_PREFIX}/FindFolder"
          resp = invoke("#{NS_EWS_MESSAGES}:FindFolder", :soap_action => action) do |root|
            build!(root) do
              find_folder!(parent_folder_ids, traversal, folder_shape, opts)
            end
          end
          parse!(resp)
        end


        # Identifies items that are located in a specified folder
        # @see http://msdn.microsoft.com/en-us/library/aa566107.aspx
        #
        # @param [Array] parent_folder_ids An Array of folder ids, either a
        #   DistinguishedFolderId (must me a Symbol) or a FolderId (String)
        # @param [String] traversal Shallow/Deep/SoftDeleted
        # @param [Hash] item_shape defines the FolderShape node
        #   See: http://msdn.microsoft.com/en-us/library/aa494311.aspx
        # @option item_shape [String] :base_shape IdOnly/Default/AllProperties
        # @option item_shape :additional_properties
        #   See: http://msdn.microsoft.com/en-us/library/aa563810.aspx
        # @param [Hash] opts optional parameters to this method
        def find_item(parent_folder_ids, traversal = 'Shallow', item_shape = {:base_shape => 'Default'})
          action = "#{SOAP_ACTION_PREFIX}/FindItem"
          resp = invoke("#{NS_EWS_MESSAGES}:FindItem", :soap_action => action) do |root|
            build!(root) do
              find_item!(parent_folder_ids, traversal, item_shape)
            end
          end
          parse!(resp)
        end


        # Gets folders from the Exchange store
        # @see http://msdn.microsoft.com/en-us/library/aa580274.aspx
        #
        # @param [Array] folder_ids An Array of folder ids, either a
        #   DistinguishedFolderId (must me a Symbol) or a FolderId (String)
        # @param [Hash] folder_shape defines the FolderShape node
        #   See: http://msdn.microsoft.com/en-us/library/aa494311.aspx
        # @option folder_shape [String] :base_shape IdOnly/Default/AllProperties
        # @option folder_shape :additional_properties
        #   See: http://msdn.microsoft.com/en-us/library/aa563810.aspx
        # @param [Hash] opts optional parameters to this method
        def get_folder(folder_ids, folder_shape = {:base_shape => 'Default'})
          action = "#{SOAP_ACTION_PREFIX}/GetFolder"
          resp = invoke("#{NS_EWS_MESSAGES}:GetFolder", :soap_action => action) do |root|
            build!(root) do
              get_folder!(folder_ids, folder_shape)
            end
          end
          parse!(resp)
        end


        def convert_id
          action = "#{SOAP_ACTION_PREFIX}/ConvertId"
          resp = invoke("#{NS_EWS_MESSAGES}:ConvertId", :soap_action => action) do |convert_id|
            build_convert_id!(convert_id)
          end
          parse_convert_id(resp)
        end

        def create_folder
          action = "#{SOAP_ACTION_PREFIX}/CreateFolder"
          resp = invoke("#{NS_EWS_MESSAGES}:CreateFolder", :soap_action => action) do |create_folder|
            build_create_folder!(create_folder)
          end
          parse_create_folder(resp)
        end

        def delete_folder
          action = "#{SOAP_ACTION_PREFIX}/DeleteFolder"
          resp = invoke("#{NS_EWS_MESSAGES}:DeleteFolder", :soap_action => action) do |delete_folder|
            build_delete_folder!(delete_folder)
          end
          parse_delete_folder(resp)
        end

        def update_folder
          action = "#{SOAP_ACTION_PREFIX}/UpdateFolder"
          resp = invoke("#{NS_EWS_MESSAGES}:UpdateFolder", :soap_action => action) do |update_folder|
            build_update_folder!(update_folder)
          end
          parse_update_folder(resp)
        end

        def move_folder
          action = "#{SOAP_ACTION_PREFIX}/MoveFolder"
          resp = invoke("#{NS_EWS_MESSAGES}:MoveFolder", :soap_action => action) do |move_folder|
            build_move_folder!(move_folder)
          end
          parse_move_folder(resp)
        end

        def copy_folder
          action = "#{SOAP_ACTION_PREFIX}/CopyFolder"
          resp = invoke("#{NS_EWS_MESSAGES}:CopyFolder", :soap_action => action) do |copy_folder|
            build_copy_folder!(copy_folder)
          end
          parse_copy_folder(resp)
        end

        # Used to subscribe client applications to either push or pull notifications.
        # @see http://msdn.microsoft.com/en-us/library/aa566188.aspx Subscribe on MSDN
        #
        # @param [Array] folder_ids An Array of folder ids, either a
        #   DistinguishedFolderId (must me a Symbol) or a FolderId (String)
        # @param [Array] event_types An Array of EventTypes that we should track.
        #   Available types are, CopiedEvent, CreatedEvent, DeletedEvent, ModifiedEvent,
        #   MovedEvent, NewMailEvent, FreeBusyChangedEvent
        # @param [Integer] timeout The number of minutes in which the subscription
        #   will timeout after not receiving a get_events operation.
        # @todo Decide how/if to handle the optional SubscribeToAllFolders attribute of
        #   the PullSubscriptionRequest element.
        def subscribe(folder_ids, event_types, timeout = 10)
          action = "#{SOAP_ACTION_PREFIX}/Subscribe"
          resp = invoke("#{NS_EWS_MESSAGES}:Subscribe", :soap_action => action) do |root|
            build!(root) do
              pull_subscription_request!(folder_ids, event_types, timeout)
            end
          end
          parse!(resp)
        end

        def unsubscribe(subscription_id)
          action = "#{SOAP_ACTION_PREFIX}/Unsubscribe"
          resp = invoke("#{NS_EWS_MESSAGES}:Unsubscribe", :soap_action => action) do |root|
            build!(root) do
              subscription_id!(root, subscription_id)
            end
          end
          parse!(resp)
        end

        # Used by pull subscription clients to request notifications from the Client Access server
        # @see http://msdn.microsoft.com/en-us/library/aa566199.aspx GetEvents on MSDN
        #
        # @param [String] subscription_id Subscription identifier
        # @param [String] watermark Event bookmark in the events queue
        def get_events(subscription_id, watermark)
          action = "#{SOAP_ACTION_PREFIX}/GetEvents"
          resp = invoke("#{NS_EWS_MESSAGES}:GetEvents", :soap_action => action) do |root|
            build!(root) do
              get_events!(subscription_id, watermark)
            end
          end
          parse!(resp)
        end

        def sync_folder_hierarchy
          action = "#{SOAP_ACTION_PREFIX}/SyncFolderHierarchy"
          resp = invoke("#{NS_EWS_MESSAGES}:SyncFolderHierarchy", :soap_action => action) do |sync_folder_hierarchy|
            build_sync_folder_hierarchy!(sync_folder_hierarchy)
          end
          parse_sync_folder_hierarchy(resp)
        end

        # Synchronizes items between the Exchange server and the client
        # @see http://msdn.microsoft.com/en-us/library/aa563967.aspx
        #
        # @param [String, Symbol] folder_id either a DistinguishedFolderId
        #   (must me a Symbol) or a FolderId (String)
        # @param [String] sync_state Base-64 encoded string used to determine
        #   where we are in the sync process.
        # @param [Integer] max_changes The amount of items to sync per call
        #   to SyncFolderItems
        # @param [Hash] item_shape defines the ItemShape node
        #   See: http://msdn.microsoft.com/en-us/library/aa565261.aspx
        # @option item_shape [String] :base_shape IdOnly/Default/AllProperties
        # @option item_shape :additional_properties
        #   See: http://msdn.microsoft.com/en-us/library/aa565261.aspx
        # @param [Hash] opts optional parameters to this method
        def sync_folder_items(folder_id, sync_state = nil, max_changes = 256, item_shape = {:base_shape => 'Default'}, opts = {})
          action = "#{SOAP_ACTION_PREFIX}/SyncFolderItems"
          resp = invoke("#{NS_EWS_MESSAGES}:SyncFolderItems", :soap_action => action) do |root|
            build!(root) do
              sync_folder_items!(folder_id, sync_state, max_changes, item_shape, opts)
            end
          end
          parse!(resp)
        end

        # Gets items from the Exchange store
        # @see http://msdn.microsoft.com/en-us/library/aa565934.aspx
        #
        # @param [Array] item_ids An Array of item ids
        # @param [Hash] item_shape defines the ItemShape node
        #   See: http://msdn.microsoft.com/en-us/library/aa565261.aspx
        # @option item_shape [String] :base_shape ('Default') IdOnly/Default/AllProperties
        # @option item_shape :additional_properties
        #   See: http://msdn.microsoft.com/en-us/library/aa563810.aspx
        # @param [Hash] opts optional parameters to this method
        def get_item(item_ids, item_shape = {:base_shape => 'Default'})
          action = "#{SOAP_ACTION_PREFIX}/GetItem"
          resp = invoke("#{NS_EWS_MESSAGES}:GetItem", :soap_action => action) do |root|
            build!(root) do
              get_item!(item_ids, item_shape)
            end
          end
          parse!(resp)
        end


        # Operation is used to create e-mail messages
        # This is actually a CreateItem operation but they differ for different types
        # of Exchange objects so it is named appropriately here.
        # @see http://msdn.microsoft.com/en-us/library/aa566468.aspx
        #
        # @param [String, Symbol] folder_id The folder to save this message in. Either a
        #   DistinguishedFolderId (must me a Symbol) or a FolderId (String)
        # @param [Hash, Array] items An array of item Hashes or a single item Hash. Hash
        #   values should be based on values found here: http://msdn.microsoft.com/en-us/library/aa494306.aspx
        # @param [String] message_disposition "SaveOnly/SendOnly/SendAndSaveCopy"
        #   See: http://msdn.microsoft.com/en-us/library/aa565209.aspx
        def create_message_item(folder_id, items, message_disposition = 'SaveOnly')
          action = "#{SOAP_ACTION_PREFIX}/CreateItem"
          resp = invoke("#{NS_EWS_MESSAGES}:CreateItem", :soap_action => action) do |node|
            build!(node) do
              create_item!(folder_id, items, message_disposition, send_invites=false, 'message')
            end
          end
          parse!(resp)
        end

        # Operation is used to create calendar items
        # @see http://msdn.microsoft.com/en-us/library/aa564690.aspx
        #
        # @param [String, Symbol] folder_id The folder to create this item in. Either a
        #   DistinguishedFolderId (must me a Symbol) or a FolderId (String)
        # @param [Hash, Array] items An array of item Hashes or a single item Hash. Hash
        #   values should be based on values found here: http://msdn.microsoft.com/en-us/library/aa564765.aspx
        # @param [String] send_invites "SendToNone/SendOnlyToAll/SendToAllAndSaveCopy"
        def create_calendar_item(folder_id, items, send_invites = 'SendToAllAndSaveCopy')
          action = "#{SOAP_ACTION_PREFIX}/CreateItem"
          resp = invoke("#{NS_EWS_MESSAGES}:CreateItem", :soap_action => action) do |node|
            build!(node) do
              create_item!(folder_id, items, message_disposition=false, send_invites, 'calendar')
            end
          end
          parse!(resp)
        end
        
        # Operation is used to create task items
        # This is actually a CreateItem operation but they differ for different types
        # of Exchange objects so it is named appropriately here.
        # @see http://msdn.microsoft.com/en-us/library/aa563439.aspx
        #
        # @param [String, Symbol] folder_id The folder to save this task in. Either a
        #   DistinguishedFolderId (must me a Symbol) or a FolderId (String)
        # @param [Hash, Array] items An array of item Hashes or a single item Hash. Hash
        #   values should be based on values found here: http://msdn.microsoft.com/en-us/library/aa494306.aspx
        # @param [String] message_disposition "SaveOnly/SendOnly/SendAndSaveCopy"
        #   See: http://msdn.microsoft.com/en-us/library/aa565209.aspx
        def create_task_item(folder_id, items, message_disposition = 'SaveOnly')
          action = "#{SOAP_ACTION_PREFIX}/CreateItem"
          resp = invoke("#{NS_EWS_MESSAGES}:CreateItem", :soap_action => action) do |node|
            build!(node) do
              create_item!(folder_id, items, message_disposition, send_invites=false, 'task')
            end
          end
          parse!(resp)
        end

        # Delete an item from a mailbox in the Exchange store
        # @see http://msdn.microsoft.com/en-us/library/aa562961.aspx
        # @param [Array] item_ids An Array of item ids
        # @param [String] delete_type Type of deletion: "HardDelete/SoftDelete/MoveToDeletedItems"
        # @param [String, nil] send_meeting_cancellations "SendToNone/SendOnlyToAll/SendToAllAndSaveCopy"
        #   This is only applicable to CalendarItems and should be nil otherwise, which is the default
        # @param [String, nil] affected_task_occurrences "AllOccurrences/SpecifiedOccurrenceOnly"
        #   This is really only related to tasks and can be nil otherwise, which is the default.
        def delete_item(item_ids, delete_type, send_meeting_cancellations = nil, affected_task_occurrences = nil)
          action = "#{SOAP_ACTION_PREFIX}/DeleteItem"
          resp = invoke("#{NS_EWS_MESSAGES}:DeleteItem", :soap_action => action) do |root|
            build!(root) do
              delete_item!(item_ids, delete_type, send_meeting_cancellations, affected_task_occurrences)
            end
          end
          parse!(resp)
        end

        def update_item
          action = "#{SOAP_ACTION_PREFIX}/UpdateItem"
          resp = invoke("#{NS_EWS_MESSAGES}:UpdateItem", :soap_action => action) do |update_item|
            build_update_item!(update_item)
          end
          parse_update_item(resp)
        end

        def send_item
          action = "#{SOAP_ACTION_PREFIX}/SendItem"
          resp = invoke("#{NS_EWS_MESSAGES}:SendItem", :soap_action => action) do |send_item|
            build_send_item!(send_item)
          end
          parse_send_item(resp)
        end

        def move_item
          action = "#{SOAP_ACTION_PREFIX}/MoveItem"
          resp = invoke("#{NS_EWS_MESSAGES}:MoveItem", :soap_action => action) do |move_item|
            build_move_item!(move_item)
          end
          parse_move_item(resp)
        end

        def copy_item
          action = "#{SOAP_ACTION_PREFIX}/CopyItem"
          resp = invoke("#{NS_EWS_MESSAGES}:CopyItem", :soap_action => action) do |copy_item|
            build_copy_item!(copy_item)
          end
          parse_copy_item(resp)
        end

        def create_attachment
          action = "#{SOAP_ACTION_PREFIX}/CreateAttachment"
          resp = invoke("#{NS_EWS_MESSAGES}:CreateAttachment", :soap_action => action) do |create_attachment|
            build_create_attachment!(create_attachment)
          end
          parse_create_attachment(resp)
        end

        def delete_attachment
          action = "#{SOAP_ACTION_PREFIX}/DeleteAttachment"
          resp = invoke("#{NS_EWS_MESSAGES}:DeleteAttachment", :soap_action => action) do |delete_attachment|
            build_delete_attachment!(delete_attachment)
          end
          parse_delete_attachment(resp)
        end

        def get_attachment
          action = "#{SOAP_ACTION_PREFIX}/GetAttachment"
          resp = invoke("#{NS_EWS_MESSAGES}:GetAttachment", :soap_action => action) do |get_attachment|
            build_get_attachment!(get_attachment)
          end
          parse_get_attachment(resp)
        end

        def create_managed_folder
          action = "#{SOAP_ACTION_PREFIX}/CreateManagedFolder"
          resp = invoke("#{NS_EWS_MESSAGES}:CreateManagedFolder", :soap_action => action) do |create_managed_folder|
            build_create_managed_folder!(create_managed_folder)
          end
          parse_create_managed_folder(resp)
        end

        def get_delegate
          action = "#{SOAP_ACTION_PREFIX}/GetDelegate"
          resp = invoke("#{NS_EWS_MESSAGES}:GetDelegate", :soap_action => action) do |get_delegate|
            build_get_delegate!(get_delegate)
          end
          parse_get_delegate(resp)
        end

        def add_delegate
          action = "#{SOAP_ACTION_PREFIX}/AddDelegate"
          resp = invoke("#{NS_EWS_MESSAGES}:AddDelegate", :soap_action => action) do |add_delegate|
            build_add_delegate!(add_delegate)
          end
          parse_add_delegate(resp)
        end

        def remove_delegate
          action = "#{SOAP_ACTION_PREFIX}/RemoveDelegate"
          resp = invoke("#{NS_EWS_MESSAGES}:RemoveDelegate", :soap_action => action) do |remove_delegate|
            build_remove_delegate!(remove_delegate)
          end
          parse_remove_delegate(resp)
        end

        def update_delegate
          action = "#{SOAP_ACTION_PREFIX}/UpdateDelegate"
          resp = invoke("#{NS_EWS_MESSAGES}:UpdateDelegate", :soap_action => action) do |update_delegate|
            build_update_delegate!(update_delegate)
          end
          parse_update_delegate(resp)
        end

        def get_user_availability
          action = "#{SOAP_ACTION_PREFIX}/GetUserAvailability"
          resp = invoke("#{NS_EWS_MESSAGES}:GetUserAvailability", :soap_action => action) do |get_user_availability|
            build_get_user_availability!(get_user_availability)
          end
          parse_get_user_availability(resp)
        end

        def get_user_oof_settings
          action = "#{SOAP_ACTION_PREFIX}/GetUserOofSettings"
          resp = invoke("#{NS_EWS_MESSAGES}:GetUserOofSettings", :soap_action => action) do |get_user_oof_settings|
            build_get_user_oof_settings!(get_user_oof_settings)
          end
          parse_get_user_oof_settings(resp)
        end

        def set_user_oof_settings
          action = "#{SOAP_ACTION_PREFIX}/SetUserOofSettings"
          resp = invoke("#{NS_EWS_MESSAGES}:SetUserOofSettings", :soap_action => action) do |set_user_oof_settings|
            build_set_user_oof_settings!(set_user_oof_settings)
          end
          parse_set_user_oof_settings(resp)
        end



        # Private Methods (Builders and Parsers)
        private


        def build!(node, opts = {}, &block)
          EwsBuilder.new(node, opts, &block)
        end

        def parse!(response, opts = {})
          return response if @@raw_soap
          EwsParser.new(response).parse(opts)
        end

      end # class ExchangeWebService
    end # module SOAP
  end # EWS
end # Viewpoint
