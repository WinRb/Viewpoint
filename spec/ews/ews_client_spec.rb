require "spec_helper"

describe Viewpoint::EWSClient do

  describe "#set_auto_deepen" do
    let(:client) { described_class.new "http://www.example.com", "test", "test" }

    it "sets autodeepen to true on the web service" do
      ews = double "ews"
      expect(ews).to receive(:auto_deepen=).with(true) {true}
      expect(client).to receive(:ews) {ews}
      client.set_auto_deepen true
    end

    it "sets autodeepen to false on the web service with a behavior of 'raise'" do
      ews = double "ews"
      expect(ews).to receive(:no_auto_deepen_behavior=).with(:raise) {:raise}
      expect(ews).to receive(:auto_deepen=).with(false) {false}
      expect(client).to receive(:ews).twice {ews}
      client.set_auto_deepen false
    end
  end

  describe '#new' do
    let(:connection)  { instance_double(Viewpoint::EWS::Connection, set_auth: nil, set_bearer: nil) }
    let(:http_class)  { class_double(Viewpoint::EWS::Connection, new: connection) }

    context 'new with basic auth' do
      it do
        described_class.new "http://www.example.com", "username", "password", http_class: http_class

        expect(connection).to have_received(:set_auth).with("username", "password")
      end
    end

    context 'new with token auth' do
      it do
        described_class.new "http://www.example.com", :bearer, "token", http_class: http_class

        expect(connection).not_to have_received(:set_auth)
      end
    end
  end
end
