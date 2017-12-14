module Viewpoint::EWS::SOAP
  class GetStreamingEventResponse

    attr_reader :response

    def initialize(response_hash)
      @response = response_hash
    end

    def type
      response.keys.first
    end

    def watermark
      @watermark ||= find_element(:watermark) ? find_element(:watermark)[:watermark][:text] : nil
    end

    def time_stamp
      @time_stamp ||= find_element(:time_stamp) ? find_element(:time_stamp)[:time_stamp][:text] : nil
    end

    def item_id
      @item_id ||= find_element(:item_id) ? find_element(:item_id)[:item_id][:attribs] : nil
    end

    def id
      item_id ? item_id[:id] : nil
    end

    def change_key
      item_id ? item_id[:change_key] : nil
    end

    def folder_id
      @folder_id ||= find_element(:folder_id) ? find_element(:folder_id)[:folder_id][:attribs] : nil
    end

    def parent_folder_id
      @parent_folder_id ||= find_element(:parent_folder_id) ? find_element(:parent_folder_id)[:parent_folder_id][:attribs] : nil
    end

    def item?
      not folder?
    end

    def folder?
      id.nil?
    end

    private

    def elements
      response[type][:elems]
    end

    def find_element(key)
      elements.find { |element| element.keys.first == key }
    end

  end
end
