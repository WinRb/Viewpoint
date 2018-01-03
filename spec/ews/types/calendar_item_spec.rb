require 'spec_helper'

describe Viewpoint::EWS::Types::CalendarItem do

  describe "#duration" do
    it "returns the duration in seconds" do
      allow_any_instance_of(described_class).to receive(:simplify!)
      calitem = described_class.new(nil, nil)
      allow(calitem).to receive(:duration).and_return("PT0H30M0S")
      expect(calitem.duration_in_seconds).to eql(1800)
    end
  end

  describe '#derive_item_updates' do
    let(:item) { described_class.new(nil, {item_id: {attribs: {id: 'not_used'}}}) }
    subject { item.derive_item_updates(updates) }

    context 'update attribute is invalid' do
      let(:updates) { {not_valid: 'foo'} }

      it 'returns correct updates' do
        expect(subject).to eq([])
      end
    end

    context 'update subject' do
      let(:updates) { {subject: 'new subejct'} }

      it 'returns correct updates' do
        expect(subject).to match_array([
          {:set_item_field=>{:field_uRI=>{:field_uRI=>"item:Subject"}, :calendar_item=>{:subject=>"new subejct"}}}
        ])
      end
    end

    context 'update start' do
      let(:updates) { {start: DateTime.new(2018, 1, 1, 8, 0, 0)} }

      it 'returns correct updates' do
        expect(subject).to match_array([
          {:set_item_field=>{:field_uRI=>{:field_uRI=>"calendar:Start"}, :calendar_item=>{:start=>{:text=>"2018-01-01T08:00:00+00:00"}}}}
        ])
      end
    end

    context 'update required attendees' do
      let(:updates) { {required_attendees: {attendee: {mailbox: {email_address: 'a@foo.com'}}}} }

      it 'returns correct updates' do
        expect(subject).to match_array([
          {:set_item_field=>{:field_uRI=>{:field_uRI=>"calendar:RequiredAttendees"}, :calendar_item=>{:required_attendees=>{:attendee=>{:mailbox=>{:email_address=>"a@foo.com"}}}}}}
        ])
      end
    end

    context 'compound updates' do
      let(:updates) do
        {
          not_valid: 'foo',
          location: nil,
          body: 'foo body'
        }
      end

      it 'returns correct updates' do
        expect(subject).to match_array([
          {:delete_item_field=>{:field_uRI=>{:field_uRI=>"calendar:Location"}}},
          {:set_item_field=>{:field_uRI=>{:field_uRI=>"item:Body"}, :calendar_item=>{:body=>{:body_type=>"Text", :text=>"foo body"}}}}
        ])
      end
    end
  end
end
