require 'spec_helper'

describe Viewpoint::EWS::SOAP::ExchangeNotification do
  class TestIncludeExchangeNotification
    include Viewpoint::EWS::SOAP::ExchangeNotification
  end

  let(:test_instance) { TestIncludeExchangeNotification.new }
  let(:folder) { { id: "some_id", change_key: "some_change_key" } }
  let(:anchor_mailbox) { "mailbox@example.com" }
  let(:prefer_server_affinity) { true }
  let(:backend_override_cookie) { "cookie" }
  let(:evtypes) { double(:evtypes) }
  let(:subscriptions) {
    {
      anchor_mailbox: anchor_mailbox,
      prefer_server_affinity: prefer_server_affinity,
      backend_override_cookie: backend_override_cookie,
      subscribe_to_all_folders: false,
      folder_ids: [ { id: folder[:id], change_key: folder[:change_key] } ],
      event_types: evtypes,
      timeout: 30
    }
  }

  describe "#stream_subscribe_folder" do
    let(:options) {
      {
        anchor_mailbox: anchor_mailbox,
        prefer_server_affinity: prefer_server_affinity,
        backend_override_cookie: backend_override_cookie
      }
    }

    subject { test_instance.stream_subscribe_folder(folder, evtypes, options: options) }

    context "when options are passed in" do
      it "includes anchor_mailbox, prefer_server_affinity and backend_override_cookie when calling the subscribe method" do
        expect(test_instance).to receive(:subscribe).with([{streaming_subscription_request: subscriptions}])

        subject
      end
    end
  end

  describe "#subscribe" do

    subject { test_instance.subscribe(subscriptions) }

    context "when anchor_mailbox is passed in" do

      it "sets the anchor_mailbox header" do

      end
    end

    context "when anchor_mailbox is not passed in" do

      it "doesn't set the anchor_mailbox header" do
        
      end
    end

    context "when the prefer_server_affinity is passed in" do

    end

    context "when backend_override_cookie is passed in" do

    end
  end
end
