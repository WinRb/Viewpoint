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
module Viewpoint
  module EWS
    module SOAP
      class EwsBuilder
        def initialize(node, opts, &block)
          @node, @opts = node, opts
          instance_eval(&block) if block_given?
        end

        def resolve_names!(name, full_contact_data, opts)
          @node.set_attr('ReturnFullContactData',full_contact_data)
          @node.add('ewssoap:UnresolvedEntry',name)
        end

        def expand_dl!(expand_dl)
        end


        def find_folder!(parent_folder_ids, traversal, folder_shape, opts)
          @node.set_attr('Traversal', traversal)
          @node.add('ewssoap:FolderShape') do |fs|
            fs.add('t:BaseShape',folder_shape[:base_shape])
          end
          @node.add('ewssoap:ParentFolderIds') do |p|
            parent_folder_ids.each do |id|
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


        def find_item!(find_item)
        end


        
        # @todo refactor so DistinguishedFolderId and FolderId have their own builders
        def get_folder!(folder_ids, folder_shape)
          @node.add('ewssoap:FolderShape') do |fs|
            fs.add('t:BaseShape',folder_shape[:base_shape])
          end
          @node.add('ewssoap:FolderIds') do |p|
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


        def get_item!(get_item)
        end


        def create_item!(create_item)
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



        # General Purpose Builders
        # These are builder methods that are called from multiple other builder methods

        def folder_shape!(element, folder_shape)
          element.add('tns:FolderShape') do |fshape|
            fshape.add('t:BaseShape', folder_shape[:base_shape])

            # TODO: This only supports the FieldURI extended property right now
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

        # http://msdn.microsoft.com/en-us/library/aa565998.aspx
        # Used by: find_folder, find_item, resolve_names
        # If the parent_folder param is a Symbol it is assumed to be a DistinguishedFolderId
        # otherwise it is a FolderId.
        def parent_folder_ids!(element, parent_folder_ids)
          build_gen_folder_ids!(element,parent_folder_ids,'tns:ParentFolderIds')
        end

        # http://msdn.microsoft.com/en-us/library/aa580509.aspx
        # Used by: get_folder, delete_folder, move_folder, copy_folder, push_subscription_request, pull_subscription_request
        # If the parent_folder param is a Symbol it is assumed to be a DistinguishedFolderId
        # otherwise it is a FolderId.
        def folder_ids!(element, folder_ids)
          build_gen_folder_ids!(element,folder_ids,'tns:FolderIds')
        end

        # Generic build function used by build_parent_folder_ids! and build_folder_ids!
        def gen_folder_ids!(element,folder_ids,elem_name)
          element.add(elem_name) do |fids|
            folder_ids.each do |id|
              if( id.is_a?(Symbol) )
                build_distinguished_folder_id!(fids, id)
              else
                build_folder_id!(fids, id)
              end
            end
          end
        end

        # http://msdn.microsoft.com/en-us/library/aa580808.aspx
        def distinguished_folder_id!(element, id)
          element.add('t:DistinguishedFolderId') { |dfid| dfid.set_attr('Id', id) }
        end

        # http://msdn.microsoft.com/en-us/library/aa579461.aspx
        def folder_id!(element, id)
          element.add('t:FolderId') { |fid| fid.set_attr('Id', id) }
        end

      end # EwsBuilder
    end # SOAP
  end # EWS
end # Viewpoint
