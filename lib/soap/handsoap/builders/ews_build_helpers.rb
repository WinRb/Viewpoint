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
# This is a module that is included in the main Builder that has sub builders
# that are used from multiple root nodes.  It is basically just a way to do
# code reuse in a more natural way.  The one difference between these functions
# and the builder functions in the EwsBuilder class is that the first parameter
# is of node type.  We use that parameter to build subnodes in this module.

module Viewpoint
  module EWS
    module SOAP
      module EwsBuildHelpers

        def folder_ids!(node, folder_ids, element_name="#{NS_EWS_MESSAGES}:FolderIds")
          node.add(element_name) do |p|
            folder_ids.each do |id|
              folder_id!(p,id)
            end
          end
        end

        def folder_id!(node, folder_id)
          if( folder_id.is_a?(Symbol) )
            # @todo add change_key support to DistinguishedFolderId
            node.add("#{NS_EWS_TYPES}:DistinguishedFolderId") do |df|
              df.set_attr('Id', folder_id.to_s)
            end
          else
            # @todo add change_key support to FolderId
            node.add("#{NS_EWS_TYPES}:FolderId") do |fi|
              fi.set_attr('Id', folder_id)
            end
          end
        end


        # For now this is the same as folder_ids! so just use that method
        def parent_folder_ids!(node, folder_ids)
          folder_ids!(node, folder_ids, "#{NS_EWS_MESSAGES}:ParentFolderIds")
        end


        def item_ids!(node, item_ids)
          node.add("#{NS_EWS_MESSAGES}:ItemIds") do |ids|
            item_ids.each do |id|
              ids.add("#{NS_EWS_TYPES}:ItemId") do |iid|
                iid.set_attr('Id',id)
              end
            end
          end
        end


        def saved_item_folder_id!(node, folder_id)
          node.add("#{NS_EWS_MESSAGES}:SavedItemFolderId") do |sfid|
            if( folder_id.is_a?(Symbol) )
              # @todo add change_key support to DistinguishedFolderId
              sfid.add("#{NS_EWS_TYPES}:DistinguishedFolderId") do |df|
                df.set_attr('Id', folder_id.to_s)
              end
            else
              # @todo add change_key support to FolderId
              sfid.add("#{NS_EWS_TYPES}:FolderId",folder_id)
            end
          end
        end


        # @todo This only supports the FieldURI extended property right now
        def folder_shape!(node, folder_shape)
          node.add("#{NS_EWS_MESSAGES}:FolderShape") do |fshape|
            fshape.add("#{NS_EWS_TYPES}:BaseShape", folder_shape[:base_shape])

            unless( folder_shape[:additional_props].nil? )
              unless( folder_shape[:additional_props][:FieldURI].nil? )
                fshape.add("#{NS_EWS_TYPES}:AdditionalProperties") do |addprops|
                  folder_shape[:additional_props][:FieldURI].each do |uri|
                    addprops.add("#{NS_EWS_TYPES}:FieldURI") { |furi| furi.set_attr('FieldURI', uri) }
                  end
                end
              end
            end
          end
        end

        # @todo Finish AdditionalProperties implementation
        def item_shape!(node, item_shape)
          node.add("#{NS_EWS_MESSAGES}:ItemShape") do |is|
            is.add("#{NS_EWS_TYPES}:BaseShape", item_shape[:base_shape])
          end
          
          unless( item_shape[:additional_props].nil? )
          end
        end

        def items!(node, items, type)
          node.add("#{NS_EWS_MESSAGES}:Items") do |i|
            if items.is_a? Hash
              method("#{type}_item!").call(i, items)
            else
              items.each do |item|
                method("#{type}_item!").call(i, item)
              end
            end
          end
        end

        def message_item!(node, item)
          node.add("#{NS_EWS_TYPES}:Message") do |msg|
            add_hierarchy!(msg, item)
          end
        end

        def calendar_item!(node, item)
          node.add("#{NS_EWS_TYPES}:CalendarItem") do |msg|
            add_hierarchy!(msg, item)
          end
        end

        def event_types!(node, event_types)
          node.add("#{NS_EWS_TYPES}:EventTypes") do |ets|
            event_types.each do |event_type|
              ets.add("#{NS_EWS_TYPES}:EventType", event_type)
            end
          end
        end

        def subscription_id!(node, subscription_id)
          node.add("#{NS_EWS_MESSAGES}:SubscriptionId", subscription_id)
        end

        def watermark!(node, watermark)
          node.add("#{NS_EWS_MESSAGES}:Watermark", watermark)
        end

        def sync_state!(node, sync_state)
          node.add("#{NS_EWS_MESSAGES}:SyncState", sync_state)
        end

        # Add a hierarchy of elements from hash data
        # @example Hash to XML
        #   {:this => {:text =>'that'},'top' => {:id => '32fss', :text => 'TestText', {'middle' => 'bottom'}}}
        #   becomes...
        #   <this>that</this>
        #   <top Id='32fss'>
        #     TestText
        #     <middle>bottom</middle>
        #   </top>
        def add_hierarchy!(node, e_hash, prefix = NS_EWS_TYPES)
          e_hash.each_pair do |k,v|
            if v.is_a? Hash
              node.add("#{prefix}:#{k.to_s.camel_case}", v[:text]) do |n|
                add_hierarchy!(n, v)
              end
            else
              node.set_attr(k.to_s.camel_case, v) unless k == :text
            end
          end
        end

      end # EwsBuildHelpers
    end # SOAP
  end # EWS
end # Viewpoint
