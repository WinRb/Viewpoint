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
          @node.add("#{NS_EWS_MESSAGES}:UnresolvedEntry",name)
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
        def get_folder!(folder_ids, folder_shape, act_as)
          folder_shape!(@node, folder_shape)
          folder_ids!(@node, folder_ids, act_as)
        end


        # @see ExchangeWebService#subscribe
        def pull_subscription_request!(folder_ids, event_types, timeout)
          @node.add("#{NS_EWS_MESSAGES}:PullSubscriptionRequest") do |ps|
            folder_ids!(ps, folder_ids, "#{NS_EWS_TYPES}:FolderIds")
            event_types!(ps, event_types)
            ps.add("#{NS_EWS_TYPES}:Timeout", timeout)
          end
        end


        # @see ExchangeWebService#get_events
        def get_events!(subscription_id, watermark)
          subscription_id!(@node, subscription_id)
          watermark!(@node, watermark)
        end


        def get_item!(item_ids, item_shape)
          item_shape!(@node, item_shape)
          item_ids!(@node, item_ids)
        end


        # @param [String] type The type of items in the items array message/calendar
        # @todo Fix max_changes_returned to be more flexible
        def create_item!(folder_id, items, message_disposition, send_invites, type)
          @node.set_attr('MessageDisposition', message_disposition) if message_disposition
          @node.set_attr('SendMeetingInvitations', send_invites) if send_invites

          saved_item_folder_id!(@node, folder_id) unless folder_id.nil?
          items!(@node, items, type)
        end

        def delete_item!(item_ids, delete_type, send_meeting_cancellations, affected_task_occurrences)
          @node.set_attr('DeleteType', delete_type)
          @node.set_attr('SendMeetingCancellations', send_meeting_cancellations) unless send_meeting_cancellations.nil?
          @node.set_attr('AffectedTaskOccurrences', affected_task_occurrences) unless affected_task_occurrences.nil?
          item_ids!(@node, item_ids)
        end

        def sync_folder_items!(folder_id, sync_state, max_changes, item_shape, opts)
          item_shape!(@node, item_shape)
          @node.add("#{NS_EWS_MESSAGES}:SyncFolderId") do |sfid|
            folder_id!(sfid, folder_id)
          end
          sync_state!(@node, sync_state) unless sync_state.nil?
          @node.add("#{NS_EWS_MESSAGES}:MaxChangesReturned", max_changes)
        end

        def add_delegate!(owner, delegate, permissions)
          d_user = {
            :user_id => {:primary_smtp_address => {:text => delegate}},
            :delegate_permissions => permissions
          }
          
          mailbox!(@node, {:email_address => {:text => owner}})
          delegate_users!(@node, [d_user])
        end

        def remove_delegate!(owner, delegate)
          mailbox!(@node, {:email_address => {:text => owner}})
          @node.add("#{NS_EWS_MESSAGES}:UserIds") do |uids|
            user_id!(uids, {:user_id => {:primary_smtp_address => {:text => delegate}}})
          end
        end

      end # EwsBuilder
    end # SOAP
  end # EWS
end # Viewpoint
