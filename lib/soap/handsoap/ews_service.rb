require 'rubygems'
require 'handsoap'

Handsoap.http_driver = :http_client

module Viewpoint
  module EWS
    module SOAP
      class ExchangeWebService < Handsoap::Service
        endpoint :uri => Viewpoint::EWS::EWS.endpoint, :version => 1

        def initialize()
          if $DEBUG
            @debug = File.new('ews_debug.out', 'w')
            @debug.sync = true
          end
        end

        # Begin Hooks
        def on_create_document(doc)
          doc.alias 't', 'http://schemas.microsoft.com/exchange/services/2006/types'
          doc.alias 'tns', 'http://schemas.microsoft.com/exchange/services/2006/messages'
          header = doc.find('Header')
          header.add('t:RequestServerVersion') { |rsv| rsv.set_attr('Version','Exchange2007_SP1') }
        end

        def on_response_document(doc)
          doc.add_namespace 't', 'http://schemas.microsoft.com/exchange/services/2006/types'
          doc.add_namespace 'm', 'http://schemas.microsoft.com/exchange/services/2006/messages'
        end

        def on_after_create_http_request(req)
          req.set_auth @@username, @@password
        end
        # End Hooks

        def resolve_names
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/ResolveNames'
          resp = invoke('tns:ResolveNames', :soap_action => action) do |resolve_names|
            build_resolve_names!(resolve_names)
          end
          parse_resolve_names(resp)
        end

        def expand_dl
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/ExpandDL'
          resp = invoke('tns:ExpandDL', :soap_action => action) do |expand_dl|
            build_expand_dl!(expand_dl)
          end
          parse_expand_dl(resp)
        end

        # http://msdn.microsoft.com/en-us/library/aa563918.aspx
        # parent_folder_ids:  An Array of folder ids, either a DistinguishedFolderId
        # (must me a Symbol) or a FolderId (String)
        #
        # The following extra configuration is available if a block is provided, in
        # this order:
        # _traversal = Shallow/Deep/SoftDeleted
        # folder_shape:  A Hash that contains :base_shape and optionally
        # :additional_props.
        # adv_opts:  A Hash that contains additional elements like paging and
        # restrictions.
        # See the Microsoft docs for more info.
        def find_folder(parent_folder_ids = [:root])
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/FindFolder'
          resp = invoke('tns:FindFolder', :soap_action => action) do |find_folder|
            _traversal = :Deep
            folder_shape = {:base_shape => :AllProperties}
            adv_opts = {}
            yield(_traversal, folder_shape, adv_opts) if block_given?

            # These arguments are in a different order (the way Microsoft documents
            # them).  The above method is in a frequency of
            # use order so you don't have to fill a bunch of uneccessary arguments
            # just to specify folder ids.
            build_find_folder!(find_folder, _traversal, folder_shape, parent_folder_ids, adv_opts)
          end
          parse_find_folder(resp)
        end

        def find_item
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/FindItem'
          resp = invoke('tns:FindItem', :soap_action => action) do |find_item|
            build_find_item!(find_item)
          end
          parse_find_item(resp)
        end

        # http://msdn.microsoft.com/en-us/library/aa580274.aspx
        # folder_ids:  An Array of folder ids, either a DistinguishedFolderId (must
        # me a Symbol) or a FolderId (String)
        #
        # The following extra configuration is available if a block is provided:
        # folder_shape:  A Hash that contains :base_shape and optionally
        # :additional_props.
        def get_folder(folder_ids)
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/GetFolder'
          resp = invoke('tns:GetFolder', :soap_action => action) do |get_folder|
            folder_shape = {:base_shape => :AllProperties}
            build_get_folder!(get_folder, folder_shape, folder_ids)
          end
          #parse_get_folder(resp)
        end

        def convert_id
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/ConvertId'
          resp = invoke('tns:ConvertId', :soap_action => action) do |convert_id|
            build_convert_id!(convert_id)
          end
          parse_convert_id(resp)
        end

        def create_folder
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/CreateFolder'
          resp = invoke('tns:CreateFolder', :soap_action => action) do |create_folder|
            build_create_folder!(create_folder)
          end
          parse_create_folder(resp)
        end

        def delete_folder
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/DeleteFolder'
          resp = invoke('tns:DeleteFolder', :soap_action => action) do |delete_folder|
            build_delete_folder!(delete_folder)
          end
          parse_delete_folder(resp)
        end

        def update_folder
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/UpdateFolder'
          resp = invoke('tns:UpdateFolder', :soap_action => action) do |update_folder|
            build_update_folder!(update_folder)
          end
          parse_update_folder(resp)
        end

        def move_folder
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/MoveFolder'
          resp = invoke('tns:MoveFolder', :soap_action => action) do |move_folder|
            build_move_folder!(move_folder)
          end
          parse_move_folder(resp)
        end

        def copy_folder
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/CopyFolder'
          resp = invoke('tns:CopyFolder', :soap_action => action) do |copy_folder|
            build_copy_folder!(copy_folder)
          end
          parse_copy_folder(resp)
        end

        def subscribe
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/Subscribe'
          resp = invoke('tns:Subscribe', :soap_action => action) do |subscribe|
            build_subscribe!(subscribe)
          end
          parse_subscribe(resp)
        end

        def unsubscribe
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/Unsubscribe'
          resp = invoke('tns:Unsubscribe', :soap_action => action) do |unsubscribe|
            build_unsubscribe!(unsubscribe)
          end
          parse_unsubscribe(resp)
        end

        def get_events
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/GetEvents'
          resp = invoke('tns:GetEvents', :soap_action => action) do |get_events|
            build_get_events!(get_events)
          end
          parse_get_events(resp)
        end

        def sync_folder_hierarchy
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/SyncFolderHierarchy'
          resp = invoke('tns:SyncFolderHierarchy', :soap_action => action) do |sync_folder_hierarchy|
            build_sync_folder_hierarchy!(sync_folder_hierarchy)
          end
          parse_sync_folder_hierarchy(resp)
        end

        def sync_folder_items
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/SyncFolderItems'
          resp = invoke('tns:SyncFolderItems', :soap_action => action) do |sync_folder_items|
            build_sync_folder_items!(sync_folder_items)
          end
          parse_sync_folder_items(resp)
        end

        def get_item
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/GetItem'
          resp = invoke('tns:GetItem', :soap_action => action) do |get_item|
            build_get_item!(get_item)
          end
          parse_get_item(resp)
        end

        def create_item
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/CreateItem'
          resp = invoke('tns:CreateItem', :soap_action => action) do |create_item|
            build_create_item!(create_item)
          end
          parse_create_item(resp)
        end

        def delete_item
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/DeleteItem'
          resp = invoke('tns:DeleteItem', :soap_action => action) do |delete_item|
            build_delete_item!(delete_item)
          end
          parse_delete_item(resp)
        end

        def update_item
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/UpdateItem'
          resp = invoke('tns:UpdateItem', :soap_action => action) do |update_item|
            build_update_item!(update_item)
          end
          parse_update_item(resp)
        end

        def send_item
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/SendItem'
          resp = invoke('tns:SendItem', :soap_action => action) do |send_item|
            build_send_item!(send_item)
          end
          parse_send_item(resp)
        end

        def move_item
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/MoveItem'
          resp = invoke('tns:MoveItem', :soap_action => action) do |move_item|
            build_move_item!(move_item)
          end
          parse_move_item(resp)
        end

        def copy_item
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/CopyItem'
          resp = invoke('tns:CopyItem', :soap_action => action) do |copy_item|
            build_copy_item!(copy_item)
          end
          parse_copy_item(resp)
        end

        def create_attachment
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/CreateAttachment'
          resp = invoke('tns:CreateAttachment', :soap_action => action) do |create_attachment|
            build_create_attachment!(create_attachment)
          end
          parse_create_attachment(resp)
        end

        def delete_attachment
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/DeleteAttachment'
          resp = invoke('tns:DeleteAttachment', :soap_action => action) do |delete_attachment|
            build_delete_attachment!(delete_attachment)
          end
          parse_delete_attachment(resp)
        end

        def get_attachment
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/GetAttachment'
          resp = invoke('tns:GetAttachment', :soap_action => action) do |get_attachment|
            build_get_attachment!(get_attachment)
          end
          parse_get_attachment(resp)
        end

        def create_managed_folder
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/CreateManagedFolder'
          resp = invoke('tns:CreateManagedFolder', :soap_action => action) do |create_managed_folder|
            build_create_managed_folder!(create_managed_folder)
          end
          parse_create_managed_folder(resp)
        end

        def get_delegate
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/GetDelegate'
          resp = invoke('tns:GetDelegate', :soap_action => action) do |get_delegate|
            build_get_delegate!(get_delegate)
          end
          parse_get_delegate(resp)
        end

        def add_delegate
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/AddDelegate'
          resp = invoke('tns:AddDelegate', :soap_action => action) do |add_delegate|
            build_add_delegate!(add_delegate)
          end
          parse_add_delegate(resp)
        end

        def remove_delegate
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/RemoveDelegate'
          resp = invoke('tns:RemoveDelegate', :soap_action => action) do |remove_delegate|
            build_remove_delegate!(remove_delegate)
          end
          parse_remove_delegate(resp)
        end

        def update_delegate
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/UpdateDelegate'
          resp = invoke('tns:UpdateDelegate', :soap_action => action) do |update_delegate|
            build_update_delegate!(update_delegate)
          end
          parse_update_delegate(resp)
        end

        def get_user_availability
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/GetUserAvailability'
          resp = invoke('tns:GetUserAvailability', :soap_action => action) do |get_user_availability|
            build_get_user_availability!(get_user_availability)
          end
          parse_get_user_availability(resp)
        end

        def get_user_oof_settings
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/GetUserOofSettings'
          resp = invoke('tns:GetUserOofSettings', :soap_action => action) do |get_user_oof_settings|
            build_get_user_oof_settings!(get_user_oof_settings)
          end
          parse_get_user_oof_settings(resp)
        end

        def set_user_oof_settings
          action = 'http://schemas.microsoft.com/exchange/services/2006/messages/SetUserOofSettings'
          resp = invoke('tns:SetUserOofSettings', :soap_action => action) do |set_user_oof_settings|
            build_set_user_oof_settings!(set_user_oof_settings)
          end
          parse_set_user_oof_settings(resp)
        end
      end
    end # SOAP
  end # EWS
end # Viewpoint
