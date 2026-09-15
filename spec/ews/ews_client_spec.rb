# frozen_string_literal: true

require 'spec_helper'

describe Viewpoint::EWSClient do
  describe '#set_auto_deepen' do
    let(:client) do
      described_class.new({ endpoint: 'http://www.example.com', type: 'basic', user: 'test', password: 'test' })
    end

    it 'sets autodeepen to true on the web service' do
      ews = double 'ews'
      expect(ews).to receive(:auto_deepen=).with(true) { true }
      expect(client).to receive(:ews) { ews }
      client.set_auto_deepen true
    end

    it "sets autodeepen to false on the web service with a behavior of 'raise'" do
      ews = double 'ews'
      expect(ews).to receive(:no_auto_deepen_behavior=).with(:raise) { :raise }
      expect(ews).to receive(:auto_deepen=).with(false) { false }
      expect(client).to(receive(:ews).twice { ews })
      client.set_auto_deepen false
    end
  end

  describe 'oauth authentication' do
    it 'does not call set_auth when the auth type is oauth' do
      connection = double('connection').as_null_object
      allow(Viewpoint::EWS::Connection).to receive(:new).and_return(connection)
      expect(connection).not_to receive(:set_auth)
      described_class.new({ endpoint: 'http://www.example.com', type: 'oauth', token: 'sekret' })
    end

    it 'calls set_auth for basic auth' do
      connection = double('connection').as_null_object
      allow(Viewpoint::EWS::Connection).to receive(:new).and_return(connection)
      expect(connection).to receive(:set_auth).with('test', 'test')
      described_class.new({ endpoint: 'http://www.example.com', type: 'basic', user: 'test', password: 'test' })
    end
  end
end
