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
require 'rubygems'
require 'handsoap'
require 'builder'
require 'parser'


Handsoap.http_driver = :http_client

module Viewpoint
  module EWS
    module SOAP
      class ExchangeWebService < Handsoap::Service
        #endpoint :uri => Viewpoint::EWS::EWS.endpoint, :version => 1

        SOAP_ACTION_PREFIX = "http://schemas.microsoft.com/exchange/services/2006/messages"

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

        # ********* Begin Hooks *********
        def on_create_document(doc)
          doc.alias 't', 'http://schemas.microsoft.com/exchange/services/2006/types'
          doc.alias 'ewssoap', 'http://schemas.microsoft.com/exchange/services/2006/messages'
          header = doc.find('Header')
          header.add('t:RequestServerVersion') { |rsv| rsv.set_attr('Version','Exchange2007_SP1') }
        end

        def on_response_document(doc)
          doc.add_namespace 't', 'http://schemas.microsoft.com/exchange/services/2006/types'
          doc.add_namespace 'm', 'http://schemas.microsoft.com/exchange/services/2006/messages'
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
        # @option opts [String] :search_scope where to seach for this entry, one of SOAP::Contacts, SOAP::ActiveDirectory, SOAP::ActiveDirectoryContacts (default), SOAP::ContactsActiveDirectory
        # @option opts [String, FolderId] :parent_folder_id either the name of a folder or it's numerical ID.  @see http://msdn.microsoft.com/en-us/library/aa565998.aspx
        # @todo handle soap faults like this: Handsoap::Fault: Handsoap::Fault { :code => 'soap11:Client', :reason => 'The request failed schema validation: The required attribute 'ReturnFullContactData' is missing.' }
        def resolve_names(name, full_contact_data = true, opts = {})
          action = "#{SOAP_ACTION_PREFIX}/ResolveNames"
          resp = invoke('ewssoap:ResolveNames', :soap_action => action) do |root|
            build!(root) do
              resolve_names!(name,full_contact_data, opts)
            end
          end
          resp
          #parse!(resp)
        end


        def expand_dl
          action = "#{SOAP_ACTION_PREFIX}/ExpandDL"
          resp = invoke('ewssoap:ExpandDL', :soap_action => action) do |expand_dl|
            build_expand_dl!(expand_dl)
          end
          parse_expand_dl(resp)
        end

        # Find subfolders of an identified folder
        # @see http://msdn.microsoft.com/en-us/library/aa563918.aspx
        #
        # @param [Array] parent_folder_ids An Array of folder ids, either a DistinguishedFolderId (must me a Symbol) or a FolderId (String)
        # @param [String] traversal Shallow/Deep/SoftDeleted
        # @param [Hash] folder_shape defines the FolderShape node @see http://msdn.microsoft.com/en-us/library/aa494311.aspx
        # @option folder_shape [String] :base_shape IdOnly/Default/AllProperties
        # @option folder_shape :additional_properties @see http://msdn.microsoft.com/en-us/library/aa563810.aspx
        # @param [Hash] opts optional parameters to this method
        def find_folder(parent_folder_ids = [:root], traversal = 'Shallow', folder_shape = {:base_shape => 'Default'}, opts = {})
          action = "#{SOAP_ACTION_PREFIX}/FindFolder"
          resp = invoke('ewssoap:FindFolder', :soap_action => action) do |root|
            build!(root) do
              find_folder!(parent_folder_ids, traversal, folder_shape, opts)
            end
          end
          resp
          #parse!(resp)
        end


        # Identifies items that are located in a specified folder
        # @see http://msdn.microsoft.com/en-us/library/aa566107.aspx
        #
        # @param [Array] parent_folder_ids An Array of folder ids, either a DistinguishedFolderId (must me a Symbol) or a FolderId (String)
        # @param [String] traversal Shallow/Deep/SoftDeleted
        # @param [Hash] item_shape defines the FolderShape node @see http://msdn.microsoft.com/en-us/library/aa494311.aspx
        # @option item_shape [String] :base_shape IdOnly/Default/AllProperties
        # @option item_shape :additional_properties @see http://msdn.microsoft.com/en-us/library/aa563810.aspx
        # @param [Hash] opts optional parameters to this method
        def find_item(parent_folder_ids, traversal = 'Shallow', item_shape = {:base_shape => 'Default'})
          action = "#{SOAP_ACTION_PREFIX}/FindItem"
          resp = invoke('ewssoap:FindItem', :soap_action => action) do |root|
            build!(root) do
              find_item!(parent_folder_ids, traversal, item_shape)
            end
          end
          resp
          #parse!(resp)
        end

        # Gets folders from the Exchange store
        # @see http://msdn.microsoft.com/en-us/library/aa580274.aspx
        #
        # @param [Array] folder_ids An Array of folder ids, either a DistinguishedFolderId (must me a Symbol) or a FolderId (String)
        # @param [Hash] folder_shape defines the FolderShape node @see http://msdn.microsoft.com/en-us/library/aa494311.aspx
        # @option folder_shape [String] :base_shape IdOnly/Default/AllProperties
        # @option folder_shape :additional_properties @see http://msdn.microsoft.com/en-us/library/aa563810.aspx
        # @param [Hash] opts optional parameters to this method
        def get_folder(folder_ids, folder_shape = {:base_shape => 'Default'})
          action = "#{SOAP_ACTION_PREFIX}/GetFolder"
          resp = invoke('ewssoap:GetFolder', :soap_action => action) do |root|
            build!(root) do
              get_folder!(folder_ids, folder_shape)
            end
          end
          resp
          #parse!(resp)
        end

        def convert_id
          action = "#{SOAP_ACTION_PREFIX}/ConvertId"
          resp = invoke('ewssoap:ConvertId', :soap_action => action) do |convert_id|
            build_convert_id!(convert_id)
          end
          parse_convert_id(resp)
        end

        def create_folder
          action = "#{SOAP_ACTION_PREFIX}/CreateFolder"
          resp = invoke('ewssoap:CreateFolder', :soap_action => action) do |create_folder|
            build_create_folder!(create_folder)
          end
          parse_create_folder(resp)
        end

        def delete_folder
          action = "#{SOAP_ACTION_PREFIX}/DeleteFolder"
          resp = invoke('ewssoap:DeleteFolder', :soap_action => action) do |delete_folder|
            build_delete_folder!(delete_folder)
          end
          parse_delete_folder(resp)
        end

        def update_folder
          action = "#{SOAP_ACTION_PREFIX}/UpdateFolder"
          resp = invoke('ewssoap:UpdateFolder', :soap_action => action) do |update_folder|
            build_update_folder!(update_folder)
          end
          parse_update_folder(resp)
        end

        def move_folder
          action = "#{SOAP_ACTION_PREFIX}/MoveFolder"
          resp = invoke('ewssoap:MoveFolder', :soap_action => action) do |move_folder|
            build_move_folder!(move_folder)
          end
          parse_move_folder(resp)
        end

        def copy_folder
          action = "#{SOAP_ACTION_PREFIX}/CopyFolder"
          resp = invoke('ewssoap:CopyFolder', :soap_action => action) do |copy_folder|
            build_copy_folder!(copy_folder)
          end
          parse_copy_folder(resp)
        end

        def subscribe
          action = "#{SOAP_ACTION_PREFIX}/Subscribe"
          resp = invoke('ewssoap:Subscribe', :soap_action => action) do |subscribe|
            build_subscribe!(subscribe)
          end
          parse_subscribe(resp)
        end

        def unsubscribe
          action = "#{SOAP_ACTION_PREFIX}/Unsubscribe"
          resp = invoke('ewssoap:Unsubscribe', :soap_action => action) do |unsubscribe|
            build_unsubscribe!(unsubscribe)
          end
          parse_unsubscribe(resp)
        end

        def get_events
          action = "#{SOAP_ACTION_PREFIX}/GetEvents"
          resp = invoke('ewssoap:GetEvents', :soap_action => action) do |get_events|
            build_get_events!(get_events)
          end
          parse_get_events(resp)
        end

        def sync_folder_hierarchy
          action = "#{SOAP_ACTION_PREFIX}/SyncFolderHierarchy"
          resp = invoke('ewssoap:SyncFolderHierarchy', :soap_action => action) do |sync_folder_hierarchy|
            build_sync_folder_hierarchy!(sync_folder_hierarchy)
          end
          parse_sync_folder_hierarchy(resp)
        end

        def sync_folder_items
          action = "#{SOAP_ACTION_PREFIX}/SyncFolderItems"
          resp = invoke('ewssoap:SyncFolderItems', :soap_action => action) do |sync_folder_items|
            build_sync_folder_items!(sync_folder_items)
          end
          parse_sync_folder_items(resp)
        end

        # Gets items from the Exchange store
        # @see http://msdn.microsoft.com/en-us/library/aa565934.aspx
        #
        # @param [Array] item_ids An Array of item ids
        # @param [Hash] item_shape defines the ItemShape node @see http://msdn.microsoft.com/en-us/library/aa565261.aspx
        # @option item_shape [String] :base_shape IdOnly/Default/AllProperties
        # @option item_shape :additional_properties @see http://msdn.microsoft.com/en-us/library/aa563810.aspx
        # @param [Hash] opts optional parameters to this method
        def get_item(item_ids, item_shape = {:base_shape => 'Default'})
          action = "#{SOAP_ACTION_PREFIX}/GetItem"
          resp = invoke('ewssoap:GetItem', :soap_action => action) do |root|
            build!(root) do
              get_item!(item_ids, item_shape)
            end
          end
          resp
          #parse!(resp)
        end


        # Operation is used to create e-mail messages
        # This is actually a CreateItem operation but they differ for different types of Exchange objects so
        # it is named appropriately here.
        # @see http://msdn.microsoft.com/en-us/library/aa566468.aspx
        #
        # @param [String, Symbol] folder_id The folder to create this item in. Either a DistinguishedFolderId (must me a Symbol) or a FolderId (String)
        # @param [Hash, Array] items An array of item Hashes or a single item Hash. Hash values should be based on values found here: http://msdn.microsoft.com/en-us/library/aa494306.aspx
        # @param [String] message_disposition "SaveOnly/SendOnly/SendAndSaveCopy" See: http://msdn.microsoft.com/en-us/library/aa565209.aspx
        def create_mail_item(folder_id, items, message_disposition = 'SaveOnly')
          action = "#{SOAP_ACTION_PREFIX}/CreateItem"
          resp = invoke('ewssoap:CreateItem', :soap_action => action) do |node|
            build!(node) do
              create_item!(folder_id, items, message_disposition, send_invites=false)
            end
          end
          resp
          #parse!(resp)
        end

        # @param [String] send_invites "SendToNone/SendOnlyToAll/SendToAllAndSaveCopy
        def create_meeting_item
        end

        def delete_item
          action = "#{SOAP_ACTION_PREFIX}/DeleteItem"
          resp = invoke('ewssoap:DeleteItem', :soap_action => action) do |delete_item|
            build_delete_item!(delete_item)
          end
          parse_delete_item(resp)
        end

        def update_item
          action = "#{SOAP_ACTION_PREFIX}/UpdateItem"
          resp = invoke('ewssoap:UpdateItem', :soap_action => action) do |update_item|
            build_update_item!(update_item)
          end
          parse_update_item(resp)
        end

        def send_item
          action = "#{SOAP_ACTION_PREFIX}/SendItem"
          resp = invoke('ewssoap:SendItem', :soap_action => action) do |send_item|
            build_send_item!(send_item)
          end
          parse_send_item(resp)
        end

        def move_item
          action = "#{SOAP_ACTION_PREFIX}/MoveItem"
          resp = invoke('ewssoap:MoveItem', :soap_action => action) do |move_item|
            build_move_item!(move_item)
          end
          parse_move_item(resp)
        end

        def copy_item
          action = "#{SOAP_ACTION_PREFIX}/CopyItem"
          resp = invoke('ewssoap:CopyItem', :soap_action => action) do |copy_item|
            build_copy_item!(copy_item)
          end
          parse_copy_item(resp)
        end

        def create_attachment
          action = "#{SOAP_ACTION_PREFIX}/CreateAttachment"
          resp = invoke('ewssoap:CreateAttachment', :soap_action => action) do |create_attachment|
            build_create_attachment!(create_attachment)
          end
          parse_create_attachment(resp)
        end

        def delete_attachment
          action = "#{SOAP_ACTION_PREFIX}/DeleteAttachment"
          resp = invoke('ewssoap:DeleteAttachment', :soap_action => action) do |delete_attachment|
            build_delete_attachment!(delete_attachment)
          end
          parse_delete_attachment(resp)
        end

        def get_attachment
          action = "#{SOAP_ACTION_PREFIX}/GetAttachment"
          resp = invoke('ewssoap:GetAttachment', :soap_action => action) do |get_attachment|
            build_get_attachment!(get_attachment)
          end
          parse_get_attachment(resp)
        end

        def create_managed_folder
          action = "#{SOAP_ACTION_PREFIX}/CreateManagedFolder"
          resp = invoke('ewssoap:CreateManagedFolder', :soap_action => action) do |create_managed_folder|
            build_create_managed_folder!(create_managed_folder)
          end
          parse_create_managed_folder(resp)
        end

        def get_delegate
          action = "#{SOAP_ACTION_PREFIX}/GetDelegate"
          resp = invoke('ewssoap:GetDelegate', :soap_action => action) do |get_delegate|
            build_get_delegate!(get_delegate)
          end
          parse_get_delegate(resp)
        end

        def add_delegate
          action = "#{SOAP_ACTION_PREFIX}/AddDelegate"
          resp = invoke('ewssoap:AddDelegate', :soap_action => action) do |add_delegate|
            build_add_delegate!(add_delegate)
          end
          parse_add_delegate(resp)
        end

        def remove_delegate
          action = "#{SOAP_ACTION_PREFIX}/RemoveDelegate"
          resp = invoke('ewssoap:RemoveDelegate', :soap_action => action) do |remove_delegate|
            build_remove_delegate!(remove_delegate)
          end
          parse_remove_delegate(resp)
        end

        def update_delegate
          action = "#{SOAP_ACTION_PREFIX}/UpdateDelegate"
          resp = invoke('ewssoap:UpdateDelegate', :soap_action => action) do |update_delegate|
            build_update_delegate!(update_delegate)
          end
          parse_update_delegate(resp)
        end

        def get_user_availability
          action = "#{SOAP_ACTION_PREFIX}/GetUserAvailability"
          resp = invoke('ewssoap:GetUserAvailability', :soap_action => action) do |get_user_availability|
            build_get_user_availability!(get_user_availability)
          end
          parse_get_user_availability(resp)
        end

        def get_user_oof_settings
          action = "#{SOAP_ACTION_PREFIX}/GetUserOofSettings"
          resp = invoke('ewssoap:GetUserOofSettings', :soap_action => action) do |get_user_oof_settings|
            build_get_user_oof_settings!(get_user_oof_settings)
          end
          parse_get_user_oof_settings(resp)
        end

        def set_user_oof_settings
          action = "#{SOAP_ACTION_PREFIX}/SetUserOofSettings"
          resp = invoke('ewssoap:SetUserOofSettings', :soap_action => action) do |set_user_oof_settings|
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
          EwsParser.new(response).parse(opts)
        end

      end # class ExchangeWebService
    end # module SOAP
  end # EWS
end # Viewpoint
