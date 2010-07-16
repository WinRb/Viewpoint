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

        def folder_ids!(node, folder_ids, element_name='ewssoap:FolderIds')
          node.add(element_name) do |p|
            folder_ids.each do |id|
              if( id.is_a?(Symbol) )
                # @todo add change_key support to DistinguishedFolderId
                p.add('t:DistinguishedFolderId') do |df|
                  df.set_attr('Id', id.to_s)
                end
              else
                # @todo add change_key support to FolderId
                p.add('t:FolderId',id)
              end
            end
          end
        end

        # For now this is the same as folder_ids! so just use that method
        def parent_folder_ids!(node, folder_ids)
          folder_ids!(node, folder_ids, 'ewssoap:ParentFolderIds')
        end


        def item_ids!(node, item_ids)
          node.add('ewssoap:ItemIds') do |ids|
            item_ids.each do |id|
              ids.add('t:ItemId') do |iid|
                iid.set_attr('Id',id)
              end
            end
          end
        end


        def saved_item_folder_id!(node, folder_id)
          node.add('ewssoap:SavedItemFolderId') do |sfid|
            if( folder_id.is_a?(Symbol) )
              # @todo add change_key support to DistinguishedFolderId
              sfid.add('t:DistinguishedFolderId') do |df|
                df.set_attr('Id', folder_id.to_s)
              end
            else
              # @todo add change_key support to FolderId
              sfid.add('t:FolderId',folder_id)
            end
          end
        end


        # @todo This only supports the FieldURI extended property right now
        def folder_shape!(node, folder_shape)
          node.add('ewssoap:FolderShape') do |fshape|
            fshape.add('t:BaseShape', folder_shape[:base_shape])

            unless( folder_shape[:additional_props].nil? )
              unless( folder_shape[:additional_props][:FieldURI].nil? )
                fshape.add('t:AdditionalProperties') do |addprops|
                  folder_shape[:additional_props][:FieldURI].each do |uri|
                    addprops.add('t:FieldURI') { |furi| furi.set_attr('FieldURI', uri) }
                  end
                end
              end
            end
          end
        end

        # @todo Finish AdditionalProperties implementation
        def item_shape!(node, item_shape)
          node.add('ewssoap:ItemShape') do |is|
            is.add('t:BaseShape', item_shape[:base_shape])
          end
          
          unless( item_shape[:additional_props].nil? )
          end
        end

        def items!(node, items)
          node.add('ewssoap:Items') do |i|
            if items.is_a? Hash
              item!(i, items)
            else
              items.each do |item|
                item!(i,item)
              end
            end
          end
        end

        def item!(node, item)
          node.add('t:Message') do |msg|
            add_hierarchy!(msg, item, 't:')
          end
        end

        def event_types!(node, event_types)
          node.add('t:EventTypes') do |ets|
            event_types.each do |event_type|
              ets.add('t:EventType', event_type)
            end
          end
        end

        def subscription_id!(node, subscription_id)
          node.add('ewssoap:SubscriptionId', subscription_id)
        end

        def watermark!(node, watermark)
          node.add('ewssoap:Watermark', watermark)
        end

        # Add a hierarchy of elements from hash data
        # @example Hash to XML
        #   {'this' => 'that','top' => {'middle' => 'bottom'}}
        #   becomes...
        #   <this>that</this>
        #   <top>
        #     <middle>bottom</middle>
        #   </top>
        def add_hierarchy!(node,e_hash,prefix)
          e_hash.each_pair do |k,v|
            if v.is_a? Hash
              node.add("#{prefix}#{k}") do |n|
                add_hierarchy!(n,v,prefix)
              end
            else
              node.add("#{prefix}#{k}", v)
            end
          end
        end

      end # EwsBuildHelpers
    end # SOAP
  end # EWS
end # Viewpoint
