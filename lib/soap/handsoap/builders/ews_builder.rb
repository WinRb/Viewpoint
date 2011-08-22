=begin
  This file is part of Viewpoint; the Ruby library for Microsoft Exchange Web Services.

  Copyright © 2011 Dan Wanek <dan.wanek@gmail.com>

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
=end

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
