require File.dirname(__FILE__) + '/../../lib/viewpoint'

describe "Test Authentication to EWS" do
	before(:all) do
		@vp = Viewpoint.instance
	end

	it "should have set authenticated to true" do
		@vp.authenticated.should be_true
	end
end

