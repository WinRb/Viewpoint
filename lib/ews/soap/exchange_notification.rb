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

module Viewpoint::EWS::SOAP

  # Exchange Notification operations as listed in the EWS Documentation.
  # @see http://msdn.microsoft.com/en-us/library/bb409286.aspx
  module ExchangeNotification
    include Viewpoint::EWS::SOAP

    # Used to subscribe client applications to either push, pull or stream notifications.
    # @see http://msdn.microsoft.com/en-us/library/aa566188(v=EXCHG.140).aspx
    # @param [Array<Hash>] subscriptions An array of Hash objects that describe each
    #   subscription.
    #   Ex: [ {:pull_subscription_request => {
    #         :subscribe_to_all_folders => false,
    #         :folder_ids => [ {:id => 'id', :change_key => 'ck'} ],
    #         :event_types=> %w{CopiedEvent CreatedEvent},
    #         :watermark  => 'watermark id',
    #         :timeout    => intval
    #       }},
    #       {:push_subscription_request => {
    #         :subscribe_to_all_folders => true,
    #         :event_types=> %w{CopiedEvent CreatedEvent},
    #         :status_frequency => 15,
    #         :uRL => 'http://my.endpoint.for.updates/',
    #       }},
    #       {:streaming_subscription_request => {
    #         :subscribe_to_all_folders => false,
    #         :folder_ids => [ {:id => 'id', :change_key => 'ck'} ],
    #         :event_types=> %w{NewMailEvent DeletedEvent},
    #       }},
    #       ]
    def subscribe(subscriptions, options: {})
      customisable_headers = get_customisable_headers(options) || {}
      customisable_cookies = get_customisable_cookies(options) || {}

      req = build_soap! do |type, builder|
        if(type == :header)
        else
          builder.nbuild.Subscribe {
            builder.nbuild.parent.default_namespace = @default_ns
            subscriptions.each do |sub|
              subtype = sub.keys.first
              if(builder.respond_to?(subtype))
                builder.send subtype, sub[subtype]
              else
                raise EwsBadArgumentError, "Bad subscription type. #{subtype}"
              end
            end
          }
        end
      end

      opts = options.merge({
        response_class: EwsResponse,
        customisable_headers: customisable_headers,
        customisable_cookies: customisable_cookies,
        request_type: 'Subscribe'
      })
      do_soap_request(req, opts)
    end

    def get_customisable_headers(options)
      (options[:customisable_headers]||{}).reject { |option, _| !CUSTOMISABLE_HTTP_HEADERS.include?(option) }
    end

    def get_customisable_cookies(options)
      (options[:customisable_cookies]||{}).reject { |option, _| !CUSTOMISABLE_HTTP_COOKIES.include?(option) }
    end

    # End a pull notification subscription.
    # @see http://msdn.microsoft.com/en-us/library/aa564263.aspx
    #
    # @param [String] subscription_id The Id of the subscription
    def unsubscribe(subscription_id)
      req = build_soap! do |type, builder|
        if(type == :header)
        else
          builder.nbuild.Unsubscribe {
            builder.nbuild.parent.default_namespace = @default_ns
            builder.subscription_id!(subscription_id)
          }
        end
      end
      options = {
          request_type: 'Unsubscribe',
          response_class: EwsResponse
      }
      do_soap_request(req, options)
    end

    # Used by pull subscription clients to request notifications from the Client Access server
    # @see http://msdn.microsoft.com/en-us/library/aa566199.aspx GetEvents on MSDN
    #
    # @param [String] subscription_id Subscription identifier
    # @param [String] watermark Event bookmark in the events queue
    def get_events(subscription_id, watermark)
      req = build_soap! do |type, builder|
        if(type == :header)
        else
          builder.nbuild.GetEvents {
            builder.nbuild.parent.default_namespace = @default_ns
            builder.subscription_id!(subscription_id)
            builder.watermark!(watermark, NS_EWS_MESSAGES)
          }
        end
      end
      options = {
          request_type: 'Get Events',
          uniq_id: SecureRandom.uuid,
          response_class: EwsResponse
      }
      do_soap_request(req, options)
    end

    # Used by stream subscription clients to create connection to the Client Access server
    # @see https://msdn.microsoft.com/en-us/library/office/ff406172(v=exchg.150).aspx GetStreamingEvents on MSDN
    #      https://msdn.microsoft.com/en-us/library/ff406172(v=exchg.140).aspx
    #
    # @param [Array] subscription_ids Subscription identifiers
    # @param [Integer] timeout For streaming connection
    def get_streaming_events(subscription_ids, timeout, options: {})
      req = build_soap! do |type, builder|
        if(type == :header)
        else
          builder.nbuild[NS_EWS_MESSAGES].GetStreamingEvents do
            builder.subscription_ids!(subscription_ids)
            builder.connection_timeout!(timeout)
          end
        end
      end

      # TODO: Once do_soap_request_async support raw_response, returns GetStreamingEventResponse results
      options.merge!({ request_type: 'Get Streaming Events', raw_response: true })
      do_soap_request_async(req, options)
    end


    # ------- convenience methods ------- #

    # Create a pull subscription to a single folder
    # @param folder [Hash] a hash with the folder :id and :change_key
    # @param evtypes [Array] the events you would like to subscribe to.
    # @param timeout [Fixnum] http://msdn.microsoft.com/en-us/library/aa565201.aspx
    # @param watermark [String] http://msdn.microsoft.com/en-us/library/aa565886.aspx
    def pull_subscribe_folder(folder, evtypes, timeout = nil, watermark = nil)
      timeout ||= 240 # 4 hour default timeout
      psr = {
        :subscribe_to_all_folders => false,
        :folder_ids => [ {:id => folder[:id], :change_key => folder[:change_key]} ],
        :event_types=> evtypes,
        :timeout    => timeout
      }
      psr[:watermark] = watermark if watermark
      subscribe([{pull_subscription_request: psr}])
    end

    # Create a push subscription to a single folder
    # @param folder [Hash] a hash with the folder :id and :change_key
    # @param evtypes [Array] the events you would like to subscribe to.
    # @param url [String,URI] http://msdn.microsoft.com/en-us/library/aa566309.aspx
    # @param watermark [String] http://msdn.microsoft.com/en-us/library/aa565886.aspx
    # @param status_frequency [Fixnum] http://msdn.microsoft.com/en-us/library/aa564048.aspx
    def push_subscribe_folder(folder, evtypes, url, status_frequency = nil, watermark = nil)
      status_frequency ||= 30
      psr = {
        :subscribe_to_all_folders => false,
        :folder_ids => [ {:id => folder[:id], :change_key => folder[:change_key]} ],
        :event_types=> evtypes,
        :status_frequency => status_frequency,
        :uRL => url.to_s
      }
      psr[:watermark] = watermark if watermark
      subscribe([{push_subscription_request: psr}])
    end

    # Copied from #pull_subscribe_folder above and changed the request type to streaming_subscription_request
    #
    # Create a streaming subscription to a single folder
    # @param folder [Hash] a hash with the folder :id and :change_key
    # @param evtypes [Array] the events you would like to subscribe to.
    # @param timeout [Fixnum] http://msdn.microsoft.com/en-us/library/aa565201.aspx
    # @param watermark [String] http://msdn.microsoft.com/en-us/library/aa565886.aspx
    # @param options [Hash]
    def stream_subscribe_folder(folder, evtypes, timeout = nil, watermark = nil, options: {})
      timeout ||= 30 # Streaming default timeout 30 mins

      psr = {
        :subscribe_to_all_folders => false,
        :folder_ids => [ {:id => folder[:id], :change_key => folder[:change_key]} ],
        :event_types=> evtypes,
        :timeout    => timeout
      }
      psr[:watermark] = watermark if watermark

      subscribe([{streaming_subscription_request: psr}], options: options)
    end

  end #ExchangeNotification
end
