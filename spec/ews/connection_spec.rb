# frozen_string_literal: true

require 'spec_helper'

describe Viewpoint::EWS::Connection do
  let(:endpoint) { 'https://example.com/ews/Exchange.asmx' }

  def ssl_config_for(opts)
    described_class.new({ endpoint: endpoint, type: 'basic' }, opts).instance_variable_get(:@httpcli).ssl_config
  end

  describe ':cert_store option' do
    it 'assigns a custom OpenSSL::X509::Store to the http client' do
      store = OpenSSL::X509::Store.new
      store.set_default_paths
      expect(ssl_config_for(cert_store: store).cert_store).to be(store)
    end

    it 'skips :trust_ca handling when a custom store is given' do
      store = OpenSSL::X509::Store.new
      # A bogus :trust_ca path would raise if it were processed.
      config = ssl_config_for(cert_store: store, trust_ca: ['/definitely/not/a/ca/path'])
      expect(config.cert_store).to be(store)
    end

    it 'ignores a :cert_store value that is not an OpenSSL::X509::Store' do
      config = ssl_config_for(cert_store: 'not-a-store')
      expect(config.cert_store).not_to be('not-a-store')
    end
  end

  describe 'oauth bearer token' do
    let(:ok_response) { double('response', status: 200, body: 'ok') }

    def posted_headers(auth)
      connection = described_class.new(auth)
      httpcli = connection.instance_variable_get(:@httpcli)
      captured = nil
      allow(httpcli).to receive(:post) do |_url, _body, headers|
        captured = headers
        ok_response
      end
      connection.post('<xml/>')
      captured
    end

    it 'sends the Bearer token in the Authorization header' do
      headers = posted_headers({ endpoint: endpoint, type: 'oauth', token: 'sekret' })
      expect(headers['Authorization']).to eq('Bearer sekret')
    end

    it 'omits the Authorization header when no token is given' do
      headers = posted_headers({ endpoint: endpoint, type: 'oauth' })
      expect(headers).not_to have_key('Authorization')
    end

    it 'omits the Authorization header for basic auth' do
      headers = posted_headers({ endpoint: endpoint, type: 'basic', user: 'u', password: 'p' })
      expect(headers).not_to have_key('Authorization')
    end

    it 'still sends the Content-Type header' do
      headers = posted_headers({ endpoint: endpoint, type: 'oauth', token: 'sekret' })
      expect(headers['Content-Type']).to eq('text/xml')
    end
  end
end
