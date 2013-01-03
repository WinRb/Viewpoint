=begin
  This file is part of Viewpoint; the Ruby library for Microsoft Exchange Web Services.

  Copyright © 2011 Dan Wanek <dan.wanek@gmail.com>

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
=end
module Viewpoint::EWS::FolderAccessors
  include Viewpoint::EWS

  FOLDER_MAP = {
    '/'       => :msgfolderroot,
    '/public' => :publicfoldersroot,
    '/inbox'  => :inbox
  }

  FOLDER_TYPE_MAP = {
    :mail     => 'IPF.Note',
    :calendar => 'IPF.Appointment',
    :task     => 'IPF.Task',
  }


  # @param [String] name The name of the new folder
  # @param [String,Symbol] parent The parent folder, either a String
  #   representing the path or a symbol that represents the Exchange
  #   DistinguishedFolderName.
  # @see http://msdn.microsoft.com/en-us/library/aa580808.aspx
  def mkfolder(name, parent = '/', opts={})
    parent = resolve_folder(parent)
    resp = ews.create_folder :parent_folder_id => {:id => parent},
      :folders => [:folder => {:display_name => name}]

    if resp.success?
      f = resp.items.first
      class_by_name(f.keys.first).new(ews, f)
    else
      raise EwsError, "Could not create folder. #{resp.code}: #{resp.message}"
    end
  end

  def delfolder(fid)
    opts = {:folder_ids => [id: fid]}
    opts[:delete_type] = 'HardDelete'
    resp = ews.delete_folder(opts)
    resp.success?
  end

  def find_by_name(name, parent = '/', opts={})
    parent = resolve_folder(parent)
    opts = {:restriction =>
      {:is_equal_to => [
        {:field_uRI => {:field_uRI=>'folder:DisplayName'}},
        {:field_uRI_or_constant => {:constant => {:value=>name}}}
      ]},
      :parent_folder_ids => [{:id => parent}],
      :traversal => 'Deep',
      :folder_shape => {:base_shape => 'Default'}
    }
    resp = ews.find_folder opts
    if resp.success?
      folders = []

      if resp.respond_to?('items')
        resp.items.each do |f|
          folders << class_by_name(f.keys.first).new(ews, f)
        end
      else
          folders = find_folders_parser(resp)
      end

      folders
    else
      raise EwsError, "Could not retrieve folders. #{resp.code}: #{resp.message}"
    end
  end

  def resolve_folder(folder)
    if folder.instance_of?(String)
      folder = FOLDER_MAP[folder]
    end
    folder
  end


  # Return a list of folder names
  # @param [String,Symbol] root A DistinguishedFolderId(symbol) or
  #   FolderId(string). This is where we'll start the search from. Usually
  #   :root, :msgfolderroot, or :publicfoldersroot
  # @return [Array<String>] Return an Array of folder names.
  # @raise [EwsError] raised when the backend SOAP method returns an error.
  def folder_names(root = :msgfolderroot)
    resp = ews.find_folder( {
      :parent_folder_ids  => [{:id => root}],
      :traversal          => 'Deep',
      :folder_shape       => {
        :base_shape => 'IdOnly',
        :additional_properties => {:FieldURI => ['folder:DisplayName']}
      }
    })
    if resp.success?
      flds = []
      resp.items.each do |f|
        flds << f[f.keys.first][:display_name][:text]
      end
      flds
    else
      raise EwsError, "Could not retrieve folders. #{resp.code}: #{resp.message}"
    end
  end

  # Find subfolders of the passed root folder.  If no parameters are passed this
  # method will search from the Root folder.
  # @param [Hash] opts Misc options to control request
  # @option opts [String,Symbol] :root Either a FolderId(String) or a
  #   DistinguishedFolderId(Symbol) . This is where to start the search from.
  #   Usually :root,:msgfolderroot, or :publicfoldersroot
  # @option opts [String] :traversal Shallow/Deep/SoftDeleted
  # @option opts [String] :shape shape to return IdOnly/Default/AllProperties
  # @option opts [optional, String] :folder_type an optional folder type to
  #   limit the search to like 'IPF.Task'
  # @return [Array] Returns an Array of Folder or subclasses of Folder
  # @raise [EwsError] raised when the backend SOAP method returns an error.
  def find_folders(opts={})
    args = find_folders_args(opts)
    resp = ews.find_folder( args )
    find_folders_parser(resp)
  end
  alias :folders :find_folders

  # Get a specific folder by its ID.
  # @param [String,Symbol] folder_id Either a FolderId(String) or a
  #   DistinguishedFolderId(Symbol).
  # @param [Hash] opts Misc options to control request
  # @option opts [String] :base_shape IdOnly/Default/AllProperties
  # @option opts [String,nil] :act_as User to act on behalf as. This user must
  #   have been given delegate access to the folder or this operation will fail.
  # @raise [EwsError] raised when the backend SOAP method returns an error.
  def get_folder(folder_id, opts = {})
    args = get_folder_args(folder_id, opts)
    resp = ews.get_folder(args)
    get_folder_parser(resp)
  end

  private

  # Build up the arguements for #find_folders
  def find_folders_args(opts)
    opts[:root] = :msgfolderroot unless opts[:root]
    opts[:traversal] = 'Shallow' unless opts[:traversal]
    opts[:shape] = 'Default' unless opts[:shape]
    if( opts[:folder_type] )
      restr = { :is_equal_to => 
        [
          {:field_uRI => {:field_uRI=>'folder:FolderClass'}},
          {:field_uRI_or_constant=>{:constant =>
            {:value => map_folder_type(opts[:folder_type])}}},
        ]
      }
    end
    args = {
      :parent_folder_ids => [{:id => opts[:root]}],
      :traversal => opts[:traversal],
      :folder_shape => {:base_shape => opts[:shape]}
    }
    args[:restriction] = restr if restr
    args
  end

  # @param [Viewpoint::EWS::SOAP::EwsSoapResponse] resp
  def find_folders_parser(resp)
    if resp.status == 'Success'
      rfolders = resp.response_message[:elems][:root_folder][:elems][0][:folders][:elems]
      folders = []
      rfolders.each do |f|
        ftype = f.keys.first
        folders << class_by_name(ftype).new(ews, f[ftype])
      end
      folders
    else
      raise EwsError, "Could not retrieve folders. #{resp.code}: #{resp.message}"
    end
  end

  # Build up the arguements for #get_folder
  def get_folder_args(folder_id, opts)
    opts[:base_shape] ||= 'Default'
    default_args =  {
      :folder_ids   => [{:id => folder_id}],
      :folder_shape => {:base_shape => opts[:base_shape]}
    }
    default_args.merge opts
  end

  # @param [Viewpoint::EWS::SOAP::EwsSoapResponse] resp
  def get_folder_parser(resp)
    if(resp.status == 'Success')
      f = resp.response_message[:elems][:folders][:elems][0]
      ftype = f.keys.first
      class_by_name(ftype).new(ews, f[ftype])
    else
      raise EwsError, "Could not retrieve folder. #{resp.code}: #{resp.message}"
    end
  end

  # Map a passed parameter to a know folder type mapping. If no mapping
  # exits simply allow the passed in type to be passed to the SOAP call.
  # @param [Symbol] type a symbol in FOLDER_TYPE_MAP
  def map_folder_type(type)
    FOLDER_TYPE_MAP[type] || type
  end

end
