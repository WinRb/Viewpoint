$: << File.dirname(__FILE__) + '/../../lib/'
require 'viewpoint'

describe "Test the basic features of Viewpoint" do
	before(:all) do
		@vp = Viewpoint::ExchWebServ.instance
	end

	it "should have set authenticated to true" do
		@vp.authenticate.should be_true
	end

	it "should find all the EWS folders" do
		@vp.find_folders.should be_an_instance_of(Hash)
	end

	it "should resolve the name" do
		# Most systems have some sort of admin user defined.
		# Change this to suit your needs.
		name = "admin"
		@vp.resolve_name(name).should be_an_instance_of(ResolveNamesResponseMessageType)
	end

	it "should retrieve all of todays messages" do
		inbox = @vp.get_folder("Inbox")
		messages = inbox.get_todays_messages
		messages.should be_an_instance_of(Array)
	end

	it "should take the last message of the day and output it in rfc822" do
		inbox = @vp.get_folder("Inbox")
		messages = inbox.get_todays_messages
		messages.should be_an_instance_of(Array)
		messages.last.to_rfc822.should be_an_instance_of(String)
	end
end

