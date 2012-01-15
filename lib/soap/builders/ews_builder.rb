module Viewpoint::EWS::SOAP
  module XmlBuilder

    # Build XML from a passed in Hash or Array in a specified format.
    # @param [Nokogiri::XML::Builder] builder The builder we are using to construct the XML
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
    def build_xml!(builder, elems)
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
        ns = vals.delete(:xmlns)

        builder.send(keys.first.to_s, txt, vals) {
          builder.parent.default_namespace = ns if ns
          build_xml!(builder, se) if se
        }
      when 'Array'
        elems.each do |e|
          build_xml!(builder, e)
        end
      else
        raise "Unsupported type: #{elems.class.name}"
      end
    end

  end
end

