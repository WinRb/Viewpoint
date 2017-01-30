require_relative '../spec_helper'

describe 'building push subscriptions' do
  let(:ecli) { Viewpoint::EWSClient.new('dontcare', 'dontcare', 'dontcare') }

  let(:event_types) { %w{CopiedEvent CreatedEvent DeletedEvent ModifiedEvent MovedEvent } }
  let(:url) { 'http://example.com' }

  context "for all folders" do
    let(:subscription_request) do
      "<soap:Body>
  <Subscribe xmlns=\"http://schemas.microsoft.com/exchange/services/2006/messages\">
    <PushSubscriptionRequest SubscribeToAllFolders=\"true\">
      <t:EventTypes>
        <t:EventType>CopiedEvent</t:EventType>
        <t:EventType>CreatedEvent</t:EventType>
        <t:EventType>DeletedEvent</t:EventType>
        <t:EventType>ModifiedEvent</t:EventType>
        <t:EventType>MovedEvent</t:EventType>
      </t:EventTypes>
      <t:StatusFrequency>30</t:StatusFrequency>
      <t:URL>http://example.com</t:URL>
    </PushSubscriptionRequest>
  </Subscribe>
</soap:Body>"
    end

    it "should form valid subscription item request" do
      Viewpoint::EWS::SOAP::ExchangeWebService.any_instance.
        should_receive(:do_soap_request) do |request_document|
        request_document.at_xpath('//soap:Envelope/soap:Body').to_s.should eq subscription_request
      end.
      and_return(double(:resp, :status => 'Success'))

      ecli.ews.subscribe([
        {
          push_subscription_request: {
            subscribe_to_all_folders: true,
            event_types: event_types,
            status_frequency: 30,
            uRL: url,
          }
        }
      ])
    end

    context "passing specific distributed folder" do
      let(:subscription_request) do
        "<soap:Body>
  <Subscribe xmlns=\"http://schemas.microsoft.com/exchange/services/2006/messages\">
    <PushSubscriptionRequest>
      <t:FolderIds>
        <t:DistinguishedFolderId Id=\"calendar\"/>
      </t:FolderIds>
      <t:EventTypes>
        <t:EventType>CopiedEvent</t:EventType>
        <t:EventType>CreatedEvent</t:EventType>
        <t:EventType>DeletedEvent</t:EventType>
        <t:EventType>ModifiedEvent</t:EventType>
        <t:EventType>MovedEvent</t:EventType>
      </t:EventTypes>
      <t:StatusFrequency>30</t:StatusFrequency>
      <t:URL>http://example.com</t:URL>
    </PushSubscriptionRequest>
  </Subscribe>
</soap:Body>"
      end

      it "should form valid subscription item request" do
        Viewpoint::EWS::SOAP::ExchangeWebService.any_instance.
          should_receive(:do_soap_request) do |request_document|
          request_document.at_xpath('//soap:Envelope/soap:Body').to_s.should eq subscription_request
        end.
        and_return(double(:resp, :status => 'Success'))

        ecli.ews.subscribe([
          {
            push_subscription_request: {
              folder_ids: [ {:id => :calendar} ],
              event_types: event_types,
              status_frequency: 30,
              uRL: url,
            }
          }
        ])
      end
    end
  end
end
