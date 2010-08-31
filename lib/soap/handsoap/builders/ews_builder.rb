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
require 'soap/handsoap/builders/ews_build_helpers.rb'
module Viewpoint
  module EWS
    module SOAP

      # This class includes all the build helpers and also contains some root
      # level methods to help code reuse.  The CreateItem operation is an example
      # of this because the different item types share a lot but have a few subtle
      # differences.
      class EwsBuilder
        include EwsBuildHelpers

        def initialize(node, opts, &block)
          @node, @opts = node, opts
          instance_eval(&block) if block_given?
        end

        # @see ExchangeWebService#subscribe
        def pull_subscription_request!(folder_ids, event_types, timeout)
          @node.add("#{NS_EWS_MESSAGES}:PullSubscriptionRequest") do |ps|
            folder_ids!(ps, folder_ids, nil, "#{NS_EWS_TYPES}:FolderIds")
            event_types!(ps, event_types)
            ps.add("#{NS_EWS_TYPES}:Timeout", timeout)
          end
        end

        # @see ExchangeWebService#subscribe
        def push_subscription_request!(folder_ids, event_types, url, watermark=nil, status_frequency=5)
          @node.add("#{NS_EWS_MESSAGES}:PushSubscriptionRequest") do |ps|
            folder_ids!(ps, folder_ids, nil, "#{NS_EWS_TYPES}:FolderIds")
            event_types!(ps, event_types)
            ps.add("#{NS_EWS_TYPES}:Watermark", watermark) unless watermark.nil?
            ps.add("#{NS_EWS_TYPES}:StatusFrequency", status_frequency)
            ps.add("#{NS_EWS_TYPES}:URL", url)
          end
        end

        # @param [String] type The type of items in the items array message/calendar
        # @todo Fix max_changes_returned to be more flexible
        def create_item!(folder_id, items, message_disposition, send_invites, type)
          @node.set_attr('MessageDisposition', message_disposition) if message_disposition
          @node.set_attr('SendMeetingInvitations', send_invites) if send_invites

          saved_item_folder_id!(@node, folder_id) unless folder_id.nil?
          items!(@node, items, type)
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

        # This is forthcoming in Exchange 2010.  It will replace much of the Restriction
        # based code.
        # @param [Array] An array of query strings
        # @see http://msdn.microsoft.com/en-us/library/ee693615.aspx
        def query_strings!(query_strings)
          query_strings.each do |qs|
            @node.add("#{NS_EWS_MESSAGES}:QueryString", qs)
          end
        end

      end # EwsBuilder
    end # SOAP
  end # EWS
end # Viewpoint
