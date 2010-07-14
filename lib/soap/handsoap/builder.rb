# Exchange Web Service Builders
require 'builders/ews_builder.rb'


module Viewpoint
  class HandsoapBuilders


    ## Helper methods (builders and parsers)
    private

    def build_resolve_names!(resolve_names)
    end

    def parse_resolve_names()
    end

    def build_expand_dl!(expand_dl)
    end

    def parse_expand_dl()
    end

    def build_find_folder!(find_folder, _traversal, folder_shape, parent_folder_ids, adv_opts)
      find_folder.set_attr('Traversal', _traversal)
      build_folder_shape!(find_folder, folder_shape)
      build_parent_folder_ids!(find_folder, parent_folder_ids)
    end

    def parse_find_folder(resp)
      folders = []
      (resp/'//m:RootFolder/t:Folders/t:Folder').each do |f|
        parms = {}
        parms[:id] = (f/('t:FolderId')).first['Id']
        parms[:parent_id] = (f/('t:ParentFolderId')).first['Id']
        parms[:disp_name] = (f/('t:DisplayName')).first.to_s
        folders << parms
      end
      folders
    end


    def build_find_item!(find_item)
    end

    def parse_find_item()
    end

    def build_get_folder!(get_folder, folder_shape, folder_ids)
      build_folder_shape!(get_folder, folder_shape)
      build_folder_ids!(get_folder, folder_ids)
    end

    def parse_get_folder()
    end

    def build_convert_id!(convert_id)
    end

    def parse_convert_id()
    end

    def build_create_folder!(create_folder)
    end

    def parse_create_folder()
    end

    def build_delete_folder!(delete_folder)
    end

    def parse_delete_folder()
    end

    def build_update_folder!(update_folder)
    end

    def parse_update_folder()
    end

    def build_move_folder!(move_folder)
    end

    def parse_move_folder()
    end

    def build_copy_folder!(copy_folder)
    end

    def parse_copy_folder()
    end

    def build_subscribe!(subscribe)
    end

    def parse_subscribe()
    end

    def build_unsubscribe!(unsubscribe)
    end

    def parse_unsubscribe()
    end

    def build_get_events!(get_events)
    end

    def parse_get_events()
    end

    def build_sync_folder_hierarchy!(sync_folder_hierarchy)
    end

    def parse_sync_folder_hierarchy()
    end

    def build_sync_folder_items!(sync_folder_items)
    end

    def parse_sync_folder_items()
    end

    def build_get_item!(get_item)
    end

    def parse_get_item()
    end

    def build_create_item!(create_item)
    end

    def parse_create_item()
    end

    def build_delete_item!(delete_item)
    end

    def parse_delete_item()
    end

    def build_update_item!(update_item)
    end

    def parse_update_item()
    end

    def build_send_item!(send_item)
    end

    def parse_send_item()
    end

    def build_move_item!(move_item)
    end

    def parse_move_item()
    end

    def build_copy_item!(copy_item)
    end

    def parse_copy_item()
    end

    def build_create_attachment!(create_attachment)
    end

    def parse_create_attachment()
    end

    def build_delete_attachment!(delete_attachment)
    end

    def parse_delete_attachment()
    end

    def build_get_attachment!(get_attachment)
    end

    def parse_get_attachment()
    end

    def build_create_managed_folder!(create_managed_folder)
    end

    def parse_create_managed_folder()
    end

    def build_get_delegate!(get_delegate)
    end

    def parse_get_delegate()
    end

    def build_add_delegate!(add_delegate)
    end

    def parse_add_delegate()
    end

    def build_remove_delegate!(remove_delegate)
    end

    def parse_remove_delegate()
    end

    def build_update_delegate!(update_delegate)
    end

    def parse_update_delegate()
    end

    def build_get_user_availability!(get_user_availability)
    end

    def parse_get_user_availability()
    end

    def build_get_user_oof_settings!(get_user_oof_settings)
    end

    def parse_get_user_oof_settings()
    end

    def build_set_user_oof_settings!(set_user_oof_settings)
    end

    def parse_set_user_oof_settings()
    end


    # General Purpose Builders
    # These are builder methods that are called from multiple other builder methods

    def build_folder_shape!(element, folder_shape)
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
    def build_parent_folder_ids!(element, parent_folder_ids)
      build_gen_folder_ids!(element,parent_folder_ids,'tns:ParentFolderIds')
    end
    
    # http://msdn.microsoft.com/en-us/library/aa580509.aspx
    # Used by: get_folder, delete_folder, move_folder, copy_folder, push_subscription_request, pull_subscription_request
    # If the parent_folder param is a Symbol it is assumed to be a DistinguishedFolderId
    # otherwise it is a FolderId.
    def build_folder_ids!(element, folder_ids)
      build_gen_folder_ids!(element,folder_ids,'tns:FolderIds')
    end

    # Generic build function used by build_parent_folder_ids! and build_folder_ids!
    def build_gen_folder_ids!(element,folder_ids,elem_name)
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
    def build_distinguished_folder_id!(element, id)
      element.add('t:DistinguishedFolderId') { |dfid| dfid.set_attr('Id', id) }
    end

    # http://msdn.microsoft.com/en-us/library/aa579461.aspx
    def build_folder_id!(element, id)
      element.add('t:FolderId') { |fid| fid.set_attr('Id', id) }
    end

  end
end
