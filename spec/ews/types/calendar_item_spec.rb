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

end
