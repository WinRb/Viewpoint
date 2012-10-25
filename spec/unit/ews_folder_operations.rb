require_relative '../spec_helper'

describe "Operations on Exchange Data Services" do

  before do
    con = double('Connection')
    @ews = Viewpoint::EWS::SOAP::ExchangeWebService.new con,
      {:server_version => Viewpoint::EWS::SOAP::VERSION_2010_SP2}
    @ews.stub(:do_soap_request)
  end

  it "generates CreateFolder XML" do
    @ews.should_receive(:do_soap_request).
      with(xml_matcher(RequestXml::CREATE_FOLDER))

    fname = "Test Folder"
    opts = {:parent_folder_id => {:id => :msgfolderroot},
      :folders => [ :folder => {:display_name => fname} ] }
    @ews.create_folder opts
  end

  it "generates DeleteFolder XML" do
    @ews.should_receive(:do_soap_request).
      with(xml_matcher(RequestXml::DELETE_FOLDER))

    fid = "test_folder_id"
    opts = {:folder_ids => [id: fid]}
    opts[:delete_type] = 'HardDelete'
    @ews.delete_folder opts
  end

  it "generates FindFolder XML" do
    @ews.should_receive(:do_soap_request).
      with(xml_matcher(RequestXml::FIND_FOLDER))

    fname = "Test Folder"
    opts = {:restriction =>
      {:is_equal_to => [
        {:field_uRI => {:field_uRI=>'folder:DisplayName'}},
        {:field_uRI_or_constant => {:constant => {:value=>fname}}}
      ]}
    }
    opts[:parent_folder_ids] = [{id: :msgfolderroot}]
    opts[:traversal] = 'Deep'
    opts[:folder_shape] = {:base_shape => 'Default'}
    @ews.find_folder opts
  end

  it "generates EmptyFolder XML" do
    @ews.should_receive(:do_soap_request).
      with(xml_matcher(RequestXml::EMPTY_FOLDER))

    fid = "test_folder_id"
    opts = {:folder_ids => [id: fid]}
    opts[:delete_type] = Viewpoint::EWS::SOAP::MOVE_TO_DELETED_ITEMS
    opts[:delete_sub_folders] = false
    @ews.empty_folder opts
  end

  context "failing EmptyFolder XML" do
    it "fails with EwsServerVersionError" do
      @ews.server_version = Viewpoint::EWS::SOAP::VERSION_2010

      fid = "test_folder_id"
      opts = {:folder_ids => [id: fid]}
      opts[:delete_type] = Viewpoint::EWS::SOAP::MOVE_TO_DELETED_ITEMS
      opts[:delete_sub_folders] = false
      expect {
        @ews.empty_folder(opts)
      }.to raise_error(Viewpoint::EWS::EwsServerVersionError)
    end

    it "fails with missing key" do
      fid = "test_folder_id"
      opts = {:folder_ids => [id: fid]}
      opts[:delete_type] = Viewpoint::EWS::SOAP::MOVE_TO_DELETED_ITEMS
      expect {
        @ews.empty_folder(opts)
      }.to raise_error(Viewpoint::EWS::EwsBadArgumentError)
    end
  end

end
