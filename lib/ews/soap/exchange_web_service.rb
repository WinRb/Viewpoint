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
  class ExchangeWebService
    include Viewpoint::EWS
    include Viewpoint::EWS::SOAP
    include ExchangeDataServices
    include ExchangeAvailability
    include ExchangeUserConfiguration

    attr_accessor :server_version, :auto_deepen

    # @param [Viewpoint::EWS::Connection] connection the connection object
    # @param [Hash] opts additional options to the web service
    # @option opts [String] :server_version what version to target with the
    #   requests. Must be one of the contants VERSION_2007, VERSION_2007_SP1,
    #   VERSION_2010, VERSION_2010_SP1, VERSION_2010_SP2, or VERSION_NONE. The
    #   default is VERSION_2010.
    def initialize(connection, opts = {})
      super()
      @con = connection
      @server_version = opts[:server_version] ? opts[:server_version] : VERSION_2010
      @auto_deepen    = true
    end

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
    def subscribe(subscriptions)
      req = build_soap! do |type, builder|
        if(type == :header)
        else
          builder.nbuild.Subscribe {
            builder.nbuild.parent.default_namespace = @default_ns
            subscriptions.each do |sub|
              subtype = sub.keys.first
              if(respond_to?(subtype))
                method(subtype).call(builder, sub[subtype])
              else
                raise EwsBadArgumentError, "Bad subscription type. #{subtype}"
              end
            end
          }
        end
      end
      do_soap_request(req)
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
      do_soap_request(req)
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
            builder.watermark!(watermark)
          }
        end
      end
      do_soap_request(req)
    end

    # Defines a request to synchronize a folder hierarchy on a client
    # @see http://msdn.microsoft.com/en-us/library/aa580990.aspx
    # @param [Hash] opts
    # @option opts [Hash] :folder_shape The folder shape properties
    #   Ex: {:base_shape => 'Default', :additional_properties => 'bla bla bla'}
    # @option opts [Hash] :sync_folder_id An optional Hash that represents a FolderId or
    #   DistinguishedFolderId.
    #   Ex: {:id => :inbox}
    # @option opts [Hash] :sync_state The Base64 sync state id. If this is the
    #   first time syncing this does not need to be passed.
    def sync_folder_hierarchy(opts)
      req = build_soap! do |type, builder|
        if(type == :header)
        else
          builder.nbuild.SyncFolderHierarchy {
            builder.nbuild.parent.default_namespace = @default_ns
            builder.folder_shape!(opts[:folder_shape])
            builder.sync_folder_id!(opts[:sync_folder_id]) if opts[:sync_folder_id]
            builder.sync_state!(opts[:sync_state]) if opts[:sync_state]
          }
        end
      end
      do_soap_request(req)
    end

    # Synchronizes items between the Exchange server and the client
    # @see http://msdn.microsoft.com/en-us/library/aa563967(v=EXCHG.140).aspx
    # @param [Hash] opts
    # @option opts [Hash] :item_shape The item shape properties
    #   Ex: {:base_shape => 'Default', :additional_properties => 'bla bla bla'}
    # @option opts [Hash] :sync_folder_id A Hash that represents a FolderId or
    #   DistinguishedFolderId. [ Ex: {:id => :inbox} ] OPTIONAL
    # @option opts [String] :sync_state The Base64 sync state id. If this is the
    #   first time syncing this does not need to be passed. OPTIONAL on first call
    # @option opts [Array <String>] :ignore An Array of ItemIds for items to ignore
    #   during the sync process. Ex: [{:id => 'id1', :change_key => 'ck'}, {:id => 'id2'}]
    #   OPTIONAL
    # @option opts [Integer] :max_changes_returned ('required') The amount of items to sync per call.
    # @option opts [String] :sync_scope specifies whether just items or items and folder associated
    #   information are returned. OPTIONAL
    #   options: 'NormalItems' or 'NormalAndAssociatedItems'
    # @example
    #   { :item_shape => {:base_shape => 'Default'},
    #     :sync_folder_id => {:id => :inbox},
    #     :sync_state => myBase64id,
    #     :max_changes_returned => 256 }
    def sync_folder_items(opts)
      req = build_soap! do |type, builder|
        if(type == :header)
        else
          builder.nbuild.SyncFolderItems {
            builder.nbuild.parent.default_namespace = @default_ns
            builder.item_shape!(opts[:item_shape])
            builder.sync_folder_id!(opts[:sync_folder_id]) if opts[:sync_folder_id]
            builder.sync_state!(opts[:sync_state]) if opts[:sync_state]
            builder.ignore!(opts[:ignore]) if opts[:ignore]
            builder.max_changes_returned!(opts[:max_changes_returned])
            builder.sync_scope!(opts[:sync_scope]) if opts[:sync_scope]
          }
        end
      end
      do_soap_request(req)
    end

    # Used to send e-mail messages that are located in the Exchange store.
    # @see http://msdn.microsoft.com/en-us/library/aa580238(v=exchg.140).aspx
    #
    # @param [Hash] opts
    # @option opts [Boolean] :save_item_to_folder To save or not to save... save! :-)
    # @option opts [Hash] :saved_item_folder_id A well formatted folder_id Hash. Ex: {:id => :sentitems}
    # @option opts [Array<Hash>] :item_ids ItemIds Hash. The keys in these Hashes can be
    #   :item_id, :occurrence_item_id, or :recurring_master_item_id. Please see the
    #   Microsoft docs for more information.
    # @example
    #   opts = {
    #     :save_item_to_folder => true,
    #     :saved_item_folder_id => {:id => :sentitems},
    #     :item_ids => [
    #       {:item_id => {:id => 'id1'}},
    #       {:item_id => {:id => 'id2'}},
    #     ]}
    #   obj.send_item(opts)
    def send_item(opts)
      req = build_soap! do |type, builder|
        attribs = {}
        attribs['SaveItemToFolder'] = opts[:save_item_to_folder]
        if(type == :header)
        else
          builder.nbuild.SendItem(attribs) {
            builder.nbuild.parent.default_namespace = @default_ns
            builder.saved_item_folder_id!(opts[:saved_item_folder_id]) if opts[:saved_item_folder_id]
            builder.item_ids!(opts[:item_ids])
          }
        end
      end
      do_soap_request(req)
    end

    # Used to move one or more items to a single destination folder.
    # @see http://msdn.microsoft.com/en-us/library/aa565781(v=exchg.140).aspx
    #
    # @param [Hash] opts
    # @option opts [Hash] :to_folder_id A well formatted folder_id Hash. Ex: {:id => :inbox}
    # @option opts [Array<Hash>] :item_ids ItemIds Hash. The keys in these Hashes can be
    #   :item_id, :occurrence_item_id, or :recurring_master_item_id. Please see the
    #   Microsoft docs for more information.
    # @option opts [Boolean] :return_new_item_ids Indicates whether the item identifiers of
    #   new items are returned in the response
    # @example
    #   opts = {
    #     :to_folder_id => {:id => :inbox},
    #     :item_ids => [
    #       {:item_id => {:id => 'id1'}},
    #       {:item_id => {:id => 'id2'}},
    #     ],
    #     :return_new_item_ids => true
    #     }
    #   obj.move_item(opts)
    def move_item(opts)
     req = build_soap! do |type, builder|
        if(type == :header)
        else
          builder.nbuild.MoveItem {
            builder.nbuild.parent.default_namespace = @default_ns
            builder.to_folder_id!(opts[:to_folder_id])
            builder.item_ids!(opts[:item_ids])
            builder.return_new_item_ids!(opts[:return_new_item_ids]) if opts[:return_new_item_ids]
          }
        end
      end
      do_soap_request(req)
    end

    # Copies items and puts the items in a different folder
    # @see http://msdn.microsoft.com/en-us/library/aa565012(v=exchg.140).aspx
    #
    # @param [Hash] opts
    # @option opts [Hash] :to_folder_id A well formatted folder_id Hash. Ex: {:id => :inbox}
    # @option opts [Array<Hash>] :item_ids ItemIds Hash. The keys in these Hashes can be
    #   :item_id, :occurrence_item_id, or :recurring_master_item_id. Please see the
    #   Microsoft docs for more information.
    # @option opts [Boolean] :return_new_item_ids Indicates whether the item identifiers of
    #   new items are returned in the response
    # @example
    #   opts = {
    #     :to_folder_id => {:id => :inbox},
    #     :item_ids => [
    #       {:item_id => {:id => 'id1'}},
    #       {:item_id => {:id => 'id2'}},
    #     ],
    #     :return_new_item_ids => true
    #     }
    #   obj.copy_item(opts)
    def copy_item(opts)
      req = build_soap! do |type, builder|
        if(type == :header)
        else
          builder.nbuild.CopyItem {
            builder.nbuild.parent.default_namespace = @default_ns
            builder.to_folder_id!(opts[:to_folder_id])
            builder.item_ids!(opts[:item_ids])
            builder.return_new_item_ids!(opts[:return_new_item_ids]) if opts[:return_new_item_ids]
          }
        end
      end
      do_soap_request(req)
    end

    # Creates either an item or file attachment and attaches it to the specified item.
    # @see http://msdn.microsoft.com/en-us/library/aa565877.aspx
    # @param [String,Hash] parent_id The id of the Item.  If this is a Hash
    #   it should contain the Id and the ChangeKey.
    # @option parent_id [String] :id The item Id
    # @option parent_id [String] :change_key The ChangeKey
    # @param [Array<Hash>] files An Array of Base64 encoded Strings with an associated name
    #   hash format= :name => <name>, :content => <Base64 encoded string>
    # @param [Array] items Exchange Items to attach to this Item
    # @todo Need to implement attachment of Item types
    def create_attachment(parent_id, files = [], items = [])
      action = "#{SOAP_ACTION_PREFIX}/CreateAttachment"
      resp = invoke("#{NS_EWS_MESSAGES}:CreateAttachment", action) do |root|
        build!(root) do
          item_id!(root, parent_id, "#{NS_EWS_MESSAGES}:ParentItemId")
          attachments!(root, files, items)
        end
      end
      parse!(resp)
    end

    def delete_attachment
      action = "#{SOAP_ACTION_PREFIX}/DeleteAttachment"
      resp = invoke("#{NS_EWS_MESSAGES}:DeleteAttachment", action) do |delete_attachment|
        build_delete_attachment!(delete_attachment)
      end
      parse_delete_attachment(resp)
    end

    def create_managed_folder
      action = "#{SOAP_ACTION_PREFIX}/CreateManagedFolder"
      resp = invoke("#{NS_EWS_MESSAGES}:CreateManagedFolder", action) do |create_managed_folder|
        build_create_managed_folder!(create_managed_folder)
      end
      parse_create_managed_folder(resp)
    end

    # Retrieves the delegate settings for a specific mailbox.
    # @see http://msdn.microsoft.com/en-us/library/bb799735.aspx
    #
    # @param [String] owner The user that is delegating permissions
    def get_delegate(owner)
      action = "#{SOAP_ACTION_PREFIX}/GetDelegate"
      resp = invoke("#{NS_EWS_MESSAGES}:GetDelegate", action) do |root|
        root.set_attr('IncludePermissions', 'true')
        build!(root) do
          mailbox!(root, {:email_address => {:text => owner}})
        end
      end
      parse!(resp)
    end

    # Adds one or more delegates to a principal's mailbox and sets specific access permissions.
    # @see http://msdn.microsoft.com/en-us/library/bb856527.aspx
    #
    # @param [String] owner The user that is delegating permissions
    # @param [String] delegate The user that is being given delegate permission
    # @param [Hash] permissions A hash of permissions that will be delegated.
    #   This Hash will eventually be passed to add_hierarchy! in the builder so it is in that format.
    def add_delegate(owner, delegate, permissions)
      action = "#{SOAP_ACTION_PREFIX}/AddDelegate"
      resp = invoke("#{NS_EWS_MESSAGES}:AddDelegate", action) do |root|
        build!(root) do
          add_delegate!(owner, delegate, permissions)
        end
      end
      parse!(resp)
    end

    # Removes one or more delegates from a user's mailbox.
    # @see http://msdn.microsoft.com/en-us/library/bb856564.aspx
    #
    # @param [String] owner The user that is delegating permissions
    # @param [String] delegate The user that is being given delegate permission
    def remove_delegate(owner, delegate)
      action = "#{SOAP_ACTION_PREFIX}/RemoveDelegate"
      resp = invoke("#{NS_EWS_MESSAGES}:RemoveDelegate", action) do |root|
        build!(root) do
          remove_delegate!(owner, delegate)
        end
      end
      parse!(resp)
    end

    # Updates delegate permissions on a principal's mailbox
    # @see http://msdn.microsoft.com/en-us/library/bb856529.aspx
    #
    # @param [String] owner The user that is delegating permissions
    # @param [String] delegate The user that is being given delegate permission
    # @param [Hash] permissions A hash of permissions that will be delegated.
    #   This Hash will eventually be passed to add_hierarchy! in the builder so it is in that format.
    def update_delegate(owner, delegate, permissions)
      action = "#{SOAP_ACTION_PREFIX}/UpdateDelegate"
      resp = invoke("#{NS_EWS_MESSAGES}:UpdateDelegate", action) do |root|
        build!(root) do
          add_delegate!(owner, delegate, permissions)
        end
      end
      parse!(resp)
    end

    # Provides detailed information about the availability of a set of users, rooms, and resources
    # within a specified time window.
    # @see http://msdn.microsoft.com/en-us/library/aa564001.aspx
    # @param [Hash] opts
    # @option opts [Hash] :time_zone The TimeZone data
    #   Example: {:bias => 'UTC offset in minutes',
    #   :standard_time => {:bias => 480, :time => '02:00:00',
    #     :day_order => 5, :month => 10, :day_of_week => 'Sunday'},
    #   :daylight_time => {same options as :standard_time}}
    # @option opts [Array<Hash>] :mailbox_data Data for the mailbox to query
    #   Example: [{:attendee_type => 'Organizer|Required|Optional|Room|Resource',
    #   :email =>{:name => 'name', :address => 'email', :routing_type => 'SMTP'},
    #   :exclude_conflicts => true|false }]
    # @option opts [Hash] :free_busy_view_options
    #   Example: {:time_window => {:start_time => DateTime,:end_time => DateTime},
    #   :merged_free_busy_interval_in_minutes => minute_int,
    #   :requested_view => None|MergedOnly|FreeBusy|FreeBusyMerged|Detailed
    #     |DetailedMerged} (optional)
    # @option opts [Hash] :suggestions_view_options (optional)
    # @todo Finish out :suggestions_view_options
    def get_user_availability(opts)
      opts = opts.clone
      req = build_soap! do |type, builder|
        if(type == :header)
        else
        builder.nbuild.GetUserAvailabilityRequestType {|x|
          x.parent.default_namespace = @default_ns
          builder.time_zone!(opts[:time_zone])
          opts[:mailbox_data].each do |mbd|
            builder.mailbox_data!(mbd)
          end
          builder.free_busy_view_options!(opts[:free_busy_view_options])
          builder.suggestions_view_options!(opts[:suggestions_view_options])
        }
        end
      end
      do_soap_request(req)
    end


    private
    # Private Methods (Builders and Parsers)

    # Validate or set default values for options parameters.
    # @param [Hash] opts The options parameter passed to an EWS operation
    # @param [Symbol] key The key in the Hash we are validating
    # @param [Boolean] required Whether or not this key is required
    # @param [Object] default_val If the key is not required use this as a
    #   default value for the operation.
    def validate_param(opts, key, required, default_val = nil)
      if required
        raise EwsBadArgumentError, "Required parameter(#{key}) not passed." unless opts.has_key?(key)
        opts[key]
      else
        raise EwsBadArgumentError, "Default value not supplied." unless default_val
        opts.has_key?(key) ? opts[key] : default_val
      end
    end

    # Some operations only exist for certain versions of Exchange Server.
    # This method should be called with the required version and we'll throw
    # an exception of the currently set @server_version does not comply.
    def validate_version(exchange_version)
      if server_version < exchange_version
        msg = 'The operation you are attempting to use is not compatible with'
        msg << " your configured Exchange Server version(#{server_version})."
        msg << " You must be running at least version (#{exchange_version})."
        raise EwsServerVersionError, msg
      end
    end

    # @param [String] response the SOAP response string
    # @param [Hash] parse_opts misc options to send to the parser
    # @option parse_opts [Class] :response_class the response class
    def parse!(response, parse_opts = {})
      raise EwsError, "Can't parse an empty response. Please check your endpoint." if(response.nil?)
      parse_opts[:response_class] ||= EwsSoapResponse
      EwsParser.new(response).parse(parse_opts)
    end

    # Build the common elements in the SOAP message and yield to any custom elements.
    def build_soap!(&block)
      opts = { :server_version => server_version }
      EwsBuilder.new.build!(opts, &block)
    end

    # Send the SOAP request to the endpoint and parse it.
    # @param [String] soapmsg an XML formatted string
    # @todo make this work for Viewpoint (imported from SPWS)
    # @param [Hash] opts misc options
    # @option opts [Boolean] :raw_response if true do not parse and return
    #   the raw response string.
    def do_soap_request(soapmsg, opts = {})
      @log.debug <<-EOF
        Sending SOAP Request:
        ----------------
#{soapmsg}
        ----------------
      EOF
      respmsg = @con.post(soapmsg)
      @log.debug <<-EOF
        Received SOAP Response:
        ----------------
        #{Nokogiri::XML(respmsg).to_xml}
        ----------------
      EOF
      opts[:raw_response] ? respmsg : parse!(respmsg)
    end

  end # class ExchangeWebService
end # Viewpoint
