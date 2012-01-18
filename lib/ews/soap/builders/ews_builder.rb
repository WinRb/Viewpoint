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

  # This class includes the element builders. The idea is that each element should
  # know how to build themselves so each parent element can delegate creation of
  # subelements to a method of the same name with a '!' after it.
  class XmlBuilder


    attr_reader :nbuild
    def initialize
      @nbuild = Nokogiri::XML::Builder.new
    end

    # Build the SOAP envelope and yield this object so subelements can be built. Once
    # you have the XmlBuilder object you can use the nbuild object like shown in the
    # example for the Header section. The nbuild object is the underlying
    # Nokogiri::XML::Builder object.
    # @example
    #   xb = XmlBuilder.new
    #   xb.build! do |part, b|
    #     if(part == :header)
    #       b.nbuild.MyVar('blablabla')
    #     else
    #       b.folder_shape!({:base_shape => 'Default'})
    #     end
    #   end
    def build!(&block)
      @nbuild.Envelope(NAMESPACES) do |node|
        node.parent.namespace = node.parent.namespace_definitions.find{|ns|ns.prefix==NS_SOAP}
        node.Header {
          yield(:header, self) if block_given?
        }
        node.Body {
          yield(:body, self) if block_given?
        }
      end
      @nbuild.doc
    end

    # Build XML from a passed in Hash or Array in a specified format.
    # @param [Nokogiri::XML::Builder] nbuild The builder we are using to construct the XML
    # @param [Array,Hash] elems The elements to add to the Builder. They must be specified
    #   like so:
    #   {:top =>
    #     { :xmlns => 'http://stonesthrow/soap',
    #       :sub_elements => [
    #         {:elem1 => {:text => 'inside'}},
    #         {:elem2 => {:text => 'inside2'}}
    #       ],
    #       :id => '3232', :tx_dd => 23, :asdf => 'turkey'
    #     }
    #   }
    #   or
    #   [ {:first => {:text => 'hello'}},
    #     {:second => {:text => 'world'}}
    #   ]
    #
    #   NOTE: there are specialized keys for text (:text), child elements (:sub_elements) and
    #   namespaces (:xmlns).
    def build_xml!(elems)
      case elems.class.name
      when 'Hash'
        keys = elems.keys
        vals = elems.values
        if(keys.length > 1 && !vals.is_a?(Hash))
          raise "invalid input: #{elems}"
        end
        vals = vals.first.clone
        se = vals.delete(:sub_elements)
        txt = vals.delete(:text)

        @nbuild.send(keys.first.to_s.camel_case, txt, vals) {
          build_xml!(se) if se
        }
      when 'Array'
        elems.each do |e|
          build_xml!(e)
        end
      else
        raise "Unsupported type: #{elems.class.name}"
      end
    end

    # Build the FolderShape element
    # @see http://msdn.microsoft.com/en-us/library/aa494311.aspx
    # @param [Hash] folder_shape The folder shape structure to build from
    # @todo need fully support all options
    def folder_shape!(folder_shape)
      @nbuild.FolderShape {
        @nbuild.parent.default_namespace = @default_ns
        base_shape!(folder_shape[:base_shape])
        additional_properties!(folder_shape[:additional_properties]) if(folder_shape[:additional_properties])
      }
    end

    # Build the ItemShape element
    # @see http://msdn.microsoft.com/en-us/library/aa565261.aspx
    # @param [Hash] item_shape The item shape structure to build from
    # @todo need fully support all options
    def item_shape!(item_shape)
      @nbuild[NS_EWS_MESSAGES].ItemShape {
        @nbuild.parent.default_namespace = @default_ns
        base_shape!(item_shape[:base_shape])
        additional_properties!(item_shape[:additional_properties]) if(item_shape[:additional_properties])
      }
    end

    # Build the BaseShape element
    # @see http://msdn.microsoft.com/en-us/library/aa580545.aspx
    def base_shape!(base_shape)
      @nbuild[NS_EWS_TYPES].BaseShape(base_shape)
    end

    # Build the ParentFolderIds element
    # @see http://msdn.microsoft.com/en-us/library/aa565998.aspx
    def parent_folder_ids!(pfids)
      @nbuild[NS_EWS_MESSAGES].ParentFolderIds {
        pfids.each do |pfid|
          dispatch_folder_id!(pfid)
        end
      }
    end

    # Build the ParentFolderId element
    # @see http://msdn.microsoft.com/en-us/library/aa563268.aspx
    def parent_folder_id!(pfid)
      @nbuild.ParentFolderId {
        dispatch_folder_id!(pfid)
      }
    end

    # Build the FolderIds element
    # @see http://msdn.microsoft.com/en-us/library/aa580509.aspx
    def folder_ids!(fids, act_as=nil)
      @nbuild.FolderIds {
        @nbuild.parent.default_namespace = @default_ns
        fids.each do |fid|
          dispatch_folder_id!(fid)
        end
      }
    end

    # Build the SyncFolderId element
    # @see http://msdn.microsoft.com/en-us/library/aa580296.aspx
    def sync_folder_id!(fid)
      @nbuild.SyncFolderId {
        dispatch_folder_id!(fid)
      }
    end

    # Build the DistinguishedFolderId element
    # @see http://msdn.microsoft.com/en-us/library/aa580808.aspx
    # @todo add support for the Mailbox child object
    def distinguished_folder_id!(dfid, change_key = nil, act_as = nil)
      attribs = {'Id' => dfid.to_s}
      attribs['ChangeKey'] = change_key if change_key
      @nbuild[NS_EWS_TYPES].DistinguishedFolderId(attribs) {
        mailbox!({:email_address => {:text => act_as}}, NS_EWS_TYPES) unless act_as.nil?
      }
    end

    # Build the FolderId element
    # @see http://msdn.microsoft.com/en-us/library/aa579461.aspx
    def folder_id!(fid, change_key = nil)
      attribs = {'Id' => fid}
      attribs['ChangeKey'] = change_key if change_key
      @nbuild[NS_EWS_TYPES].FolderId(attribs)
    end

    # @see http://msdn.microsoft.com/en-us/library/aa563525(v=EXCHG.140).aspx
    def item_ids!(item_ids)
      @nbuild.ItemIds {
        item_ids.each do |iid|
          dispatch_item_id!(iid)
        end
      }
    end

    # @see http://msdn.microsoft.com/en-us/library/aa580234(v=EXCHG.140).aspx
    def item_id!(iid, change_key = nil)
      attribs = {'Id' => iid}
      attribs['ChangeKey'] = change_key if change_key
      @nbuild[NS_EWS_TYPES].ItemId(attribs)
    end

    # @see http://msdn.microsoft.com/en-us/library/aa580744(v=EXCHG.140).aspx
    def occurrence_item_id!(rmid, change_key, instance_index)
      attribs = {'RecurringMasterId' => rmid}
      attribs['ChangeKey'] = change_key if change_key
      attribs['InstanceIndex'] = instance_index
      @nbuild[NS_EWS_TYPES].OccurrenceItemId(attribs)
    end

    # @see http://msdn.microsoft.com/en-us/library/aa581019(v=EXCHG.140).aspx
    def recurring_master_item_id!(oid, change_key = nil)
      attribs = {'OccurrenceId' => oid}
      attribs['ChangeKey'] = change_key if change_key
      @nbuild[NS_EWS_TYPES].RecurringMasterItemId(attribs)
    end

    # @see http://msdn.microsoft.com/en-us/library/aa565020(v=EXCHG.140).aspx
    def to_folder_id!(to_fid)
      @nbuild[NS_EWS_MESSAGES].ToFolderId {
        dispatch_folder_id!(to_fid)
      }
    end

    # @see http://msdn.microsoft.com/en-us/library/aa564009.aspx
    def folders!(folders)
      @nbuild[NS_EWS_TYPES].Folders {
        build_xml!(folders)
      }
    end

    # Build the AdditionalProperties element
    # @see http://msdn.microsoft.com/en-us/library/aa563810.aspx
    def additional_properties!(addprops)
      @nbuild[NS_EWS_TYPES].AdditionalProperties {
        if(folder_shape[:additional_properties][:FieldURI])
          folder_shape[:additional_properties][:FieldURI].each do |uri|
            @nbuild[NS_EWS_TYPES].FieldURI('FieldURI' => uri)
          end
        end
      }
    end

    # Build the Mailbox element.
    # This element is commonly used for delegation. Typically passing an email_address is sufficient
    # @see http://msdn.microsoft.com/en-us/library/aa565036.aspx
    # @param [Hash] mailbox A well-formated hash that can be passed to build_xml!
    #   For example: {:email_address => {:text => 'test@test.com'}, :name => {:text => 'Test User'}}
    # @todo support the rest of the child elements
    def mailbox!(mbox)
      @nbuild[NS_EWS_MESSAGES].Mailbox {
        build_xml!(mbox)
      }
    end

    # Build the Restriction element
    # @see http://msdn.microsoft.com/en-us/library/aa563791.aspx
    # @param [Hash] restriction a well-formatted Hash that can be fed to #build_xml!
    def restriction!(restriction)
      bhash = {:Restriction =>
        { :xmlns => NAMESPACES[NS_EWS_TYPES],
          :sub_elements => [restriction]}
      }
      build_xml!(restriction)
    end

    # Build the CalendarView element
    def calendar_view!(cal_view)
      attribs = {}
      cal_view.each_pair {|k,v| attribs[k.to_s.camel_case] = v.to_s}
      @nbuild[NS_EWS_MESSAGES].CalendarView(attribs)
    end

    # Build the ContactsView element
    def contacts_view!(con_view)
      attribs = {}
      con_view.each_pair {|k,v| attribs[k.to_s.camel_case] = v.to_s}
      @nbuild[NS_EWS_MESSAGES].ContactsView(attribs)
    end

    # @see http://msdn.microsoft.com/en-us/library/aa579678(v=EXCHG.140).aspx
    def event_types!(evtypes)
      @nbuild[NS_EWS_TYPES].EventTypes {
        evtypes.each do |et|
          @nbuild[NS_EWS_TYPES].EventType(et)
        end
      }
    end

    # @see http://msdn.microsoft.com/en-us/library/aa565886(v=EXCHG.140).aspx
    def watermark!(wmark)
      @nbuild[NS_EWS_TYPES].Watermark(wmark)
    end

    # @see http://msdn.microsoft.com/en-us/library/aa565201(v=EXCHG.140).aspx
    def timeout!(tout)
      @nbuild[NS_EWS_TYPES].Timeout(tout)
    end

    # @see http://msdn.microsoft.com/en-us/library/aa564048(v=EXCHG.140).aspx
    def status_frequency!(freq)
      @nbuild[NS_EWS_TYPES].StatusFrequency(freq)
    end

    # @see http://msdn.microsoft.com/en-us/library/aa566309(v=EXCHG.140).aspx
    def uRL!(url)
      @nbuild[NS_EWS_TYPES].URL(url)
    end

    # @see http://msdn.microsoft.com/en-us/library/aa563790(v=EXCHG.140).aspx
    def subscription_id!(subid)
      @nbuild.SubscriptionId(subid)
    end

    # @see http://msdn.microsoft.com/en-us/library/aa563455(v=EXCHG.140).aspx
    def pull_subscription_request(subopts)
      subscribe_all = subopts[:subscribe_to_all_folders] ? 'True' : 'False'
      @nbuild.PullSubscriptionRequest('SubscribeToAllFolders' => subscribe_all) {
        folder_ids!(subopts[:folder_ids]) if subopts[:folder_ids]
        event_types!(subopts[:event_types]) if subopts[:event_types]
        watermark!(subopts[:watermark]) if subopts[:watermark]
        timeout!(subopts[:timeout]) if subopts[:timeout]
      }
    end

    # @see http://msdn.microsoft.com/en-us/library/aa563599(v=EXCHG.140).aspx
    def push_subscription_request(subopts)
      subscribe_all = subopts[:subscribe_to_all_folders] ? 'True' : 'False'
      @nbuild.PushSubscriptionRequest('SubscribeToAllFolders' => subscribe_all) {
        folder_ids!(subopts[:folder_ids]) if subopts[:folder_ids]
        event_types!(subopts[:event_types]) if subopts[:event_types]
        watermark!(subopts[:watermark]) if subopts[:watermark]
        status_frequency!(subopts[:status_frequency]) if subopts[:status_frequency]
        uRL!(subopts[:uRL]) if subopts[:uRL]
      }
    end

    # @see http://msdn.microsoft.com/en-us/library/ff406182(v=EXCHG.140).aspx
    def streaming_subscription_request(subopts)
      subscribe_all = subopts[:subscribe_to_all_folders] ? 'True' : 'False'
      @nbuild.StreamingSubscriptionRequest('SubscribeToAllFolders' => subscribe_all) {
        folder_ids!(subopts[:folder_ids]) if subopts[:folder_ids]
        event_types!(subopts[:event_types]) if subopts[:event_types]
      }
    end

    # @see http://msdn.microsoft.com/en-us/library/aa565970(v=EXCHG.140).aspx
    def sync_state!(syncstate)
      @nbuild.SyncState(syncstate)
    end

    # @see http://msdn.microsoft.com/en-us/library/aa563785(v=EXCHG.140).aspx
    def ignore!(item_ids)
      @nbuild.Ignore {
        item_ids.each do |iid|
          item_id!(iid)
        end
      }
    end

    # @see http://msdn.microsoft.com/en-us/library/aa566325(v=EXCHG.140).aspx
    def max_changes_returned!(cnum)
      @nbuild[NS_EWS_TYPES].MaxChangesReturned(cnum)
    end

    # @see http://msdn.microsoft.com/en-us/library/dd899531(v=EXCHG.140).aspx
    def sync_scope!(scope)
      @nbuild.SyncScope(scope)
    end

    # @see http://msdn.microsoft.com/en-us/library/aa580758(v=EXCHG.140).aspx
    def saved_item_folder_id!(fid)
      @nbuild.SavedItemFolderId {
        dispatch_folder_id!(fid)
      }
    end

    # @see http://msdn.microsoft.com/en-us/library/aa565428(v=exchg.140).aspx
    def item_changes!(changes)
      @nbuild.ItemChanges {
        changes.each do |chg|
          item_change!(chg)
        end
      }
    end

    # @see http://msdn.microsoft.com/en-us/library/aa581081(v=exchg.140).aspx
    def item_change!(change)
      @nbuild[NS_EWS_TYPES].ItemChange {
        chg = change.clone
        updates = chg.delete(:updates) # Remove updates so dispatch_item_id works correctly
        dispatch_item_id!(chg)
        updates!(updates)
      }
    end

    # @see http://msdn.microsoft.com/en-us/library/aa581074(v=exchg.140).aspx
    def updates!(updates)
      @nbuild[NS_EWS_TYPES].Updates {
        updates.each do |update|
          dispatch_update_type!(update)
        end
      }
    end

    # @see http://msdn.microsoft.com/en-us/library/aa581317(v=exchg.140).aspx
    def append_to_item_field!(upd)
      upd = upd.clone
      uri = upd.select {|k,v| k =~ /_uri/i}
      raise EwsBadArgumentError, "Bad argument given for AppendToItemField." if uri.keys.length != 1
      upd.delete(uri.keys.first)
      @nbuild.AppendToItemField {
        dispatch_field_uri!(uri)
        dispatch_field_item!(upd)
      }
    end

    # @see http://msdn.microsoft.com/en-us/library/aa581487(v=exchg.140).aspx
    def set_item_field!(upd)
      upd = upd.clone
      uri = upd.select {|k,v| k =~ /_uri/i}
      raise EwsBadArgumentError, "Bad argument given for SetItemField." if uri.keys.length != 1
      upd.delete(uri.keys.first)
      @nbuild.SetItemField {
        dispatch_field_uri!(uri)
        dispatch_field_item!(upd)
      }
    end

    # @see http://msdn.microsoft.com/en-us/library/aa580330(v=exchg.140).aspx
    def delete_item_field!(upd)
      uri = upd.select {|k,v| k =~ /_uri/i}
      raise EwsBadArgumentError, "Bad argument given for SetItemField." if uri.keys.length != 1
      @nbuild.DeleteItemField {
        dispatch_field_uri!(uri)
      }
    end
    
    # @see http://msdn.microsoft.com/en-us/library/ff709497(v=exchg.140).aspx
    def return_new_item_ids!(retval)
      @nbuild.ReturnNewItemIds(retval)
    end

    # ---------------------- Helpers -------------------- #

    # A helper method to dispatch to a FolderId or DistinguishedFolderId correctly
    # @param [Hash] fid A folder_id
    #   Ex: {:id => myid, :change_key => ck}
    def dispatch_folder_id!(fid)
      if(fid[:id].is_a?(String))
        folder_id!(fid[:id], fid[:change_key])
      elsif(fid[:id].is_a?(Symbol))
        distinguished_folder_id!(fid[:id], fid[:change_key], fid[:act_as])
      else
        raise EwsBadArgumentError, "Bad argument given for a FolderId. #{fid[:id].class}"
      end
    end

    # A helper method to dispatch to an ItemId, OccurrenceItemId, or a RecurringMasterItemId
    # @param [Hash] iid The item id of some type
    def dispatch_item_id!(iid)
      type = iid.keys.first
      item = iid[type]
      case type
      when :item_id
        item_id!(item[:id], item[:change_key])
      when :occurrence_item_id
        occurrence_item_id!(item[:recurring_master_id], item[:change_key], item[:instance_index])
      when :recurring_master_item_id
        recurring_master_item_id!(item[:occurrence_id], item[:change_key])
      else
        raise EwsBadArgumentError, "Bad ItemId type. #{type}"
      end
    end
          
    # A helper method to dispatch to a AppendToItemField, SetItemField, or DeleteItemField
    # @param [Hash] update An update of some type
    def dispatch_update_type!(update)
      type = update.keys.first
      upd  = update[type]
      case type
      when :append_to_item_field
        append_to_item_field!(upd)
      when :set_item_field
        set_item_field!(upd)
      when :delete_item_field
        delete_item_field!(upd)
      else
        raise EwsBadArgumentError, "Bad Update type. #{type}"
      end
    end

    # A helper to dispatch to a FieldURI, IndexedFieldURI, or an ExtendedFieldURI
    # @todo Implement ExtendedFieldURI
    def dispatch_field_uri!(uri)
      type = uri.keys.first
      val  = uri[type]
      case type
      when :field_uRI
        @nbuild.FieldURI('FieldURI' => val[:field_uRI])
      when :indexed_field_uRI
        @nbuild.IndexedFieldURI('FieldURI' => val[:field_uRI], 'FieldIndex' => val[:field_index])
      when :extended_field_uRI
        raise EwsNotImplemented, 'This functionality has not yet been implemented.'
      else
        raise EwsBadArgumentError, "Bad URI type. #{type}"
      end

    end
        
    def dispatch_field_item!(item)
      build_xml!(item)
    end

  end # XmlBuilder
end # Viewpoint::EWS::SOAP
