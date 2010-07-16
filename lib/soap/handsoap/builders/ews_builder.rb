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
require 'builders/ews_build_helpers.rb'
module Viewpoint
  module EWS
    module SOAP
      class EwsBuilder
        include EwsBuildHelpers

        def initialize(node, opts, &block)
          @node, @opts = node, opts
          instance_eval(&block) if block_given?
        end

        def resolve_names!(name, full_contact_data, opts)
          @node.set_attr('ReturnFullContactData',full_contact_data)
          @node.add('ewssoap:UnresolvedEntry',name)
          puts @node
        end

        def expand_dl!(expand_dl)
        end


        def find_folder!(parent_folder_ids, traversal, folder_shape, opts)
          @node.set_attr('Traversal', traversal)
          folder_shape!(@node, folder_shape)
          parent_folder_ids!(@node, parent_folder_ids)
        end


        def find_item!(parent_folder_ids, traversal, item_shape)
          @node.set_attr('Traversal', traversal)
          item_shape!(@node, item_shape)
          parent_folder_ids!(@node, parent_folder_ids)
        end


        # @todo refactor so DistinguishedFolderId and FolderId have their own builders
        def get_folder!(folder_ids, folder_shape)
          folder_shape!(@node, folder_shape)
          folder_ids!(@node, folder_ids)
        end


        def convert_id!(convert_id)
        end


        def create_folder!(create_folder)
        end


        def delete_folder!(delete_folder)
        end


        def update_folder!(update_folder)
        end


        def move_folder!(move_folder)
        end


        def copy_folder!(copy_folder)
        end


        def subscribe!(subscribe)
        end


        def unsubscribe!(unsubscribe)
        end


        def get_events!(get_events)
        end


        def sync_folder_hierarchy!(sync_folder_hierarchy)
        end


        def sync_folder_items!(sync_folder_items)
        end


        def get_item!(item_ids, item_shape)
          item_shape!(@node, item_shape)
          item_ids!(@node, item_ids)
        end


        def create_item!(folder_id, items, message_disposition, send_invites)
          @node.set_attr('MessageDisposition', message_disposition)
          @node.set_attr('SendMeetingInvitations', send_invites) if send_invites

          saved_item_folder_id!(@node, folder_id)
          items!(node, items)
        end


        def delete_item!(delete_item)
        end


        def update_item!(update_item)
        end


        def send_item!(send_item)
        end


        def move_item!(move_item)
        end


        def copy_item!(copy_item)
        end


        def create_attachment!(create_attachment)
        end


        def delete_attachment!(delete_attachment)
        end


        def get_attachment!(get_attachment)
        end


        def create_managed_folder!(create_managed_folder)
        end


        def get_delegate!(get_delegate)
        end


        def add_delegate!(add_delegate)
        end


        def remove_delegate!(remove_delegate)
        end


        def update_delegate!(update_delegate)
        end


        def get_user_availability!(get_user_availability)
        end


        def get_user_oof_settings!(get_user_oof_settings)
        end


        def set_user_oof_settings!(set_user_oof_settings)
        end


      end # EwsBuilder
    end # SOAP
  end # EWS
end # Viewpoint
