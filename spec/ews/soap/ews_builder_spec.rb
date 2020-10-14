require "spec_helper"

describe Viewpoint::EWS::SOAP::EwsBuilder do
  describe "#build!" do
    let(:builder) { described_class.new }

    it "creates a basic XML" do
      opts = { :server_version => '1.2.3', :impersonation_type => 'type', :impersonation_mail => 'abc@xyz' }
      default_ns = Viewpoint::EWS::SOAP::NAMESPACES["xmlns:#{Viewpoint::EWS::SOAP::NS_EWS_MESSAGES}"]
      shape = {
        :base_shape => :id_only
      }
      parent_folder_ids = [{:id => 'parent-folder-id'}]
      restriction = { or: [
        {
          :contains => {
            :containment_mode => 'Substring',
            :containment_comparison => 'IgnoreCase',
            :field_uRI => {:field_uRI => 'f' },
            :constant => {:value => 'some-value' }
          }
        },
        {
          :contains_recipients => {
            :recipients => ['abc@def.cz', 'ghi@jkl.ch']
          }
        }
      ] }

      req = builder.build!(opts) do |type, builder|
        if(type == :header)
        else
          builder.nbuild.FindItem(:Traversal => 'Shalow') {
            builder.nbuild.parent.default_namespace = default_ns
            builder.item_shape!(shape)
            builder.restriction!(restriction)
            builder.parent_folder_ids!(parent_folder_ids)
          }
        end
      end

      expected_response = load_soap 'find_item', :request
      expected_response = Nokogiri.XML(expected_response).to_xml
      expect(req.to_xml).to eq(expected_response)
    end
  end
end
