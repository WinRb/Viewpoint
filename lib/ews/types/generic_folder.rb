require 'ews/item_accessors'
module Viewpoint::EWS::Types
  module GenericFolder
    include Viewpoint::EWS
    include Viewpoint::EWS::Types
    include Viewpoint::EWS::ItemAccessors

    GFOLDER_KEY_PATHS = {
      :id               => [:folder_id, :attribs, :id],
      :change_key       => [:folder_id, :attribs, :change_key],
      :parent_folder_id => [:parent_folder_id, :attribs, :id],
      :parent_folder_change_key => [:parent_folder_id, :attribs, :change_key],
      :folder_class     => [:folder_class, :text],
      :total_count      => [:total_count, :text],
      :child_folder_count => [:child_folder_count, :text],
      :display_name     => [:display_name, :text],
    }

    GFOLDER_KEY_TYPES = {
      :total_count        => ->(str){str.to_i},
      :child_folder_count => ->(str){str.to_i},
    }

    GFOLDER_KEY_ALIAS = {
      :name   => :display_name,
      :ckey   => :change_key,
    }

    # @param [SOAP::ExchangeWebService] ews the EWS reference
    # @param [Hash] ews_item the EWS parsed response document
    def initialize(ews, ews_item)
      super
      simplify!
    end

    def delete!
      opts = {
        :folder_ids   => [:id => id],
        :delete_type  => 'HardDelete'
      }
      resp = @ews.delete_folder(opts)
      if resp.success?
        true
      else
        raise EwsError, "Could not delete folder. #{resp.code}: #{resp.message}"
      end
    end

    def items(opts = {})
      args = items_args(opts.clone)
      obj = OpenStruct.new(opts: args, restriction: {})
      yield obj if block_given?
      merge_restrictions! obj
      resp = ews.find_item(args)
      items_parser resp
    end

    # Fetch items since a give DateTime
    # @param [DateTime] date_time the time to fetch Items since.
    def items_since(date_time, opts = {})
      opts = opts.clone
      unless date_time.kind_of?(Date)
        raise EwsBadArgumentError, "First argument must be a Date or DateTime"
      end
      restr = {:restriction =>
        {:is_greater_than_or_equal_to =>
          [{:field_uRI => {:field_uRI=>'item:DateTimeReceived'}},
            {:field_uRI_or_constant =>{:constant => {:value=>date_time.to_datetime}}}]
        }}
        items(opts.merge(restr))
    end

    # Fetch only items from today (since midnight)
    def todays_items(opts = {})
      items_since(Date.today)
    end

    # Fetch items between a given time period
    # @param [DateTime] start_date the time to start fetching Items from
    # @param [DateTime] end_date the time to stop fetching Items from
    def items_between(start_date, end_date, opts={})
      items do |obj|
        obj.restriction = { :and =>
          [
            {:is_greater_than_or_equal_to =>
              [
                {:field_uRI => {:field_uRI=>'item:DateTimeReceived'}},
                {:field_uRI_or_constant=>{:constant => {:value =>start_date}}}
              ]
            },
            {:is_less_than_or_equal_to =>
              [
                {:field_uRI => {:field_uRI=>'item:DateTimeReceived'}},
                {:field_uRI_or_constant=>{:constant => {:value =>end_date}}}
              ]
            }
          ]
        }
      end
    end

    # Search on the item subject
    # @param [String] match_str A simple string paramater to match against the
    #   subject.  The search ignores case and does not accept regexes... only strings.
    # @param [String,nil] exclude_str A string to exclude from matches against
    #   the subject.  This is optional.
    def search_by_subject(match_str, exclude_str = nil)
      items do |obj|
        match = {:contains => {
          :containment_mode => 'Substring',
          :containment_comparison => 'IgnoreCase',
          :field_uRI => {:field_uRI=>'item:Subject'},
          :constant => {:value =>match_str}
        }}
        unless exclude_str.nil?
          excl = {:not =>
            {:contains => {
              :containment_mode => 'Substring',
              :containment_comparison => 'IgnoreCase',
              :field_uRI => {:field_uRI=>'item:Subject'},
              :constant => {:value =>exclude_str}
            }}
          }

          match[:and] = [{:contains => match.delete(:contains)}, excl]
        end
        obj.restriction = match
      end
    end

    def get_all_properties!
      @ews_item = get_folder(:base_shape => 'AllProperties')
      simplify!
    end

    def available_categories
      opts = {
        user_config_name: {
          name: 'CategoryList',
          distinguished_folder_id: {id: :calendar}
        },
        user_config_props: 'XmlData'
      }
      resp = ews.get_user_configuration(opts)
      #txt = resp.response_message[:elems][:get_user_configuration_response_message][:elems][1][:user_configuration][:elems][1][:xml_data][:text]
      #Base64.decode64 txt
    end


    private


    def key_paths
      @key_paths ||= super.merge(GFOLDER_KEY_PATHS)
    end

    def key_types
      @key_types ||= super.merge(GFOLDER_KEY_TYPES)
    end

    def key_alias
      @key_alias ||= super.merge(GFOLDER_KEY_ALIAS)
    end

    def simplify!
      @ews_item = @ews_item[:elems].inject({}) do |o,i|
        key = i.keys.first
        if o.has_key?(key)
          if o[key].is_a?(Array)
            o[key] << i[key]
          else
            o[key] = [o.delete(key), i[key]]
          end
        else
          o[key] = i[key]
        end
        o
      end
    end

    # Get a specific folder by its ID.
    # @param [Hash] opts Misc options to control request
    # @option opts [String] :base_shape IdOnly/Default/AllProperties
    # @raise [EwsError] raised when the backend SOAP method returns an error.
    def get_folder(opts = {})
      args = get_folder_args(opts)
      resp = ews.get_folder(args)
      get_folder_parser(resp)
    end

    # Build up the arguements for #get_folder
    # @todo: should we really pass the ChangeKey or do we want the freshest obj?
    def get_folder_args(opts)
      opts[:base_shape] ||= 'Default'
      default_args = {
        :folder_ids   => [{:id => self.id, :change_key => self.change_key}],
        :folder_shape => {:base_shape => opts[:base_shape]}
      }
      default_args.merge(opts)
    end

    def get_folder_parser(resp)
      if(resp.status == 'Success')
        f = resp.response_message[:elems][:folders][:elems][0]
        f.values.first
      else
        raise EwsError, "Could not retrieve folder. #{resp.code}: #{resp.message}"
      end
    end

    def items_args(opts)
      default_args = {
        :parent_folder_ids => [{:id => self.id}],
        :traversal => 'Shallow',
        :item_shape  => {:base_shape => 'Default'}
      }.merge(opts)
    end

    def items_parser(resp)
      rm = resp.response_messages[0]
      if(rm.status == 'Success')
        items = []
        rm.root_folder.items.each do |i|
          type = i.keys.first
          items << class_by_name(type).new(ews, i[type])
        end
        items
      else
        raise EwsError, "Could not retrieve folder. #{rm.code}: #{rm.message_text}"
      end
    end

    def merge_restrictions!(obj, merge_type = :and)
      if obj.opts[:restriction] && !obj.opts[:restriction].empty? && !obj.restriction.empty?
        obj.opts[:restriction] = {
          merge_type => [
            obj.opts.delete(:restriction),
            obj.restriction
        ]
        }
      elsif !obj.restriction.empty?
        obj.opts[:restriction] = obj.restriction
      end
    end

  end
end
