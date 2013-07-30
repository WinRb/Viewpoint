require_relative '../spec_helper'

describe Viewpoint::EWS::MailboxAccessors do
  let(:ecli) { Viewpoint::EWSClient.new('dontcare', 'dontcare', 'dontcare') }
  let(:recipients) { ['anyrecipient'] }
  let(:timezone_request) do
"<t:TimeZone>
  <t:Bias>0</t:Bias>
  <t:StandardTime>
    <t:Bias>0</t:Bias>
    <t:Time>02:00:00</t:Time>
    <t:DayOrder>5</t:DayOrder>
    <t:Month>10</t:Month>
    <t:DayOfWeek>Sunday</t:DayOfWeek>
  </t:StandardTime>
  <t:DaylightTime>
    <t:Bias>0</t:Bias>
    <t:Time>02:00:00</t:Time>
    <t:DayOrder>1</t:DayOrder>
    <t:Month>4</t:Month>
    <t:DayOfWeek>Sunday</t:DayOfWeek>
  </t:DaylightTime>
</t:TimeZone>"
  end

  let(:default_parameters) do
    {
      :start_time => (Time.now - 1).iso8601,
      :end_time => Time.now.iso8601,
      :requested_view => :detailed
    }
  end

  context "#get_user_availability" do

    it "should care about timezones" do
      Viewpoint::EWS::SOAP::ExchangeWebService.any_instance.
        should_receive(:do_soap_request) do |request_document|
          request_document.at_xpath('//soap:Envelope/soap:Body//t:TimeZone').to_s.should eq timezone_request
        end.
        and_return(double(:resp, :status => 'Success'))

      ecli.get_user_availability(
        recipients,
        default_parameters.merge(
          :time_zone => {
            :bias => 0,
            :standard_time => {:bias => 0},
            :daylight_time => {:bias => 0}
          }
        )
      )
    end

  end

end
