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
module Viewpoint::EWS::ItemAccessors
  include Viewpoint::EWS

  # This is a class method that fetches an existing Item from the
  #  Exchange Store.
  # @param [String] item_id The id of the item.
  # @param [Symbol] shape The optional shape of the item :id_only/:default/:all_properties
  # @param [Hash] opts Misc options to control request
  # @option opts [String] :base_shape IdOnly/Default/AllProperties

  # @return [Item] Returns an Item or subclass of Item
  # @todo Add support to fetch an item with a ChangeKey
  def get_item(item_id, opts = {})
    opts[:base_shape] = 'Default' unless opts[:base_shape]
    # @todo fix shallow usage
    #   shallow = item_shape[:base_shape] != 'AllProperties'
    resp = ews.get_item(:item_ids => [{:item_id => {:id => item_id}}],
                 :item_shape => {:base_shape => opts[:base_shape]})
    if(resp.status == 'Success')
      item = resp.items.first
      class_by_name(item.keys.first).new(ews, item[item.keys.first])
    else
      raise EwsError, "Could not retrieve item. #{resp.code}: #{resp.message}"
    end
  end
end # Viewpoint::EWS::ItemAccessors
