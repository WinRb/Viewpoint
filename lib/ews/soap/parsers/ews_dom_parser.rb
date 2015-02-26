module Viewpoint::EWS::SOAP
  class EwsDomParser
    include Viewpoint::EWS
    include Viewpoint::StringUtils

    # For each node:
    # * Create a hash with the follow format:
    # {
    #   node_name: {
    #     elems: [ children_hash_like_this ],
    #     attribs: { attr_name1, attr_value1, attr_name2, attr_value2 },
    #     text: node_value
    #   }
    # }
    def self.parse(soap_resp)
      doc = Nokogiri::XML soap_resp
      node_hash doc.root
    end

    def self.node_hash(node)
      node_hash_value = {}
      node_hash_value[:elems] = node.element_children.map { |child_element| node_hash child_element } unless node.element_children.empty?
      node_hash_value[:attribs] = attributes_hash(node) unless node.attributes.empty?
      node_hash_value[:text] = node.children.first.content if !node.children.empty? && node.children.first.text?
      { ruby_case(node.name).to_sym => node_hash_value }
    end

    def self.attributes_hash(node)
      attr_hash = {}
      node.attributes.each do |attr|
        attr_hash[ruby_case(attr.first).to_sym] = attr[1].value
      end

      attr_hash
    end
  end
end
