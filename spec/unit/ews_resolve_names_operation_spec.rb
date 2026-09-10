require_relative '../spec_helper'

describe "Resolve Names operation on Exchange Data Services" do

  #let(:ecli) { Viewpoint::EWSClient.new('dontcare', 'dontcare', 'dontcare') }
  before do
    con = double('Connection')
    @ews = Viewpoint::EWS::SOAP::ExchangeWebService.new con,
      {:server_version => Viewpoint::EWS::SOAP::VERSION_2010_SP2}
    @ews.stub(:do_soap_request)
  end

  it "generates ResolveNames XML" do
    @ews.should_receive(:do_soap_request) do |request_document|
      doc = request_document.to_s.gsub(%r{>\s+}, '>')
      doc.should eq load_soap("resolve_names", :request)
    end.and_return(double(:resp))
    @ews.resolve_names('TestName@test.microsoft.com', true)
  end

end
