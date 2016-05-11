module Viewpoint
module EWS
class FolderView < Array
  
  def initialize(root_folder)
    @root_folder = root_folder
  end
  
  def includes_last_item_in_range
    @root_folder.includes_last_item_in_range && @root_folder.includes_last_item_in_range == 'true'
  end
  
  def total_items_in_view
    @root_folder.total_items_in_view && @root_folder.total_items_in_view.to_i
  end
  
  def indexed_paging_offset
    @root_folder.indexed_paging_offset && @root_folder.indexed_paging_offset.to_i
  end
  
end
end
end
