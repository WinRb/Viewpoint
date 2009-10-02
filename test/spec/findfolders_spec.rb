require File.dirname(__FILE__) + '/../../lib/viewpoint'
$DEBUG = true

describe "Fetch folders for EWS connection" do
	before(:all) do
		@vp = Viewpoint.instance
	end

	it "" do
		@vp.get_folders
		true.should be_true
	end
end

