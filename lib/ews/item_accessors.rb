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
    args = get_item_args(item_id, opts)
    resp = ews.get_item(args)
    get_item_parser(resp)
  end


  private

  def get_item_args(item_id, opts)
    opts[:base_shape] ||= 'Default'
    default_args = {
      :item_ids => [{:item_id => {:id => item_id}}],
      :item_shape => {:base_shape => opts[:base_shape]}
    }
    default_args.merge opts
  end

  def get_item_parser(resp)
    if(resp.status == 'Success')
      i = resp.response_message[:elems][:items][:elems][0]
      itype = i.keys.first
      class_by_name(itype).new(ews, i[itype])
    else
      raise EwsError, "Could not retrieve item. #{resp.code}: #{resp.message}"
    end
  end

end # Viewpoint::EWS::ItemAccessors
