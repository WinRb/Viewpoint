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

  FOLDER_TYPE_MAP = {
    :mail     => 'IPF.Note',
    :calendar => 'IPF.Appointment',
    :task     => 'IPF.Task',
  }

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
  def folders(opts={})
    opts = opts.clone
    args = find_folders_args(opts)
    resp = ews.find_folder( args )
    find_folders_parser(resp)
  end
  alias :find_folders :folders

  # Get a specific folder by id or symbol
  # @param [String,Symbol,Hash] folder_id Either a FolderId(String) or a
  #   DistinguishedFolderId(Symbol).
  # @param [Hash] opts Misc options to control request
  # @option opts [String] :base_shape :id_only/:default/:all_properties
  # @option opts [String,nil] :act_as User to act on behalf as. This user must
  #   have been given delegate access to the folder or this operation will fail.
  # @raise [EwsError] raised when the backend SOAP method returns an error.
  def get_folder(folder_id, opts = {})
    opts = opts.clone
    args = get_folder_args(folder_id, opts)
    resp = ews.get_folder(args)
    get_folder_parser(resp)
  end

  # Get a specific folder by its name
  # @param [String] name The folder name
  # @param [Hash] opts Misc options to control request
  # @option opts [String,Symbol] :parent Either a FolderId(String) or a
  #   DistinguishedFolderId(Symbol) . This is the parent folder.
  # @option opts [String] :base_shape :id_only/:default/:all_properties
  # @option opts [String,nil] :act_as User to act on behalf as. This user must
  #   have been given delegate access to the folder or this operation will fail.
  # @raise [EwsError] raised when the backend SOAP method returns an error.
  def get_folder_by_name(name, opts={})
    opts = opts.clone
    opts[:root] = opts[:parent] || :msgfolderroot
    opts[:restriction] = {:is_equal_to => [
      {:field_uRI => {:field_uRI=>'folder:DisplayName'}},
      {:field_uRI_or_constant => {:constant => {:value=>name}}}
    ]}
    args = find_folders_args(opts)
    args[:restriction] = opts[:restriction]
    resp = ews.find_folder args
    find_folders_parser(resp).first
  end

  # @param [String] name The name of the new folder
  # @param [Hash] opts
  # @option opts [String,Symbol] :parent Either a FolderId(String) or a
  #   DistinguishedFolderId(Symbol) . This is the parent folder.
  # @see http://msdn.microsoft.com/en-us/library/aa580808.aspx
  def make_folder(name, opts={})
    parent = opts[:parent] || :msgfolderroot
    resp = ews.create_folder :parent_folder_id => {:id => parent},
      :folders => [:folder => {:display_name => name}]
    create_folder_parser(resp).first
  end
  alias :mkfolder :make_folder


private

  # Build up the arguements for #find_folders
  def find_folders_args(opts)
    opts[:root] = opts[:root] || :msgfolderroot
    opts[:traversal] = normalize(opts[:traversal] || 'Shallow')
    opts[:shape] = normalize(opts[:shape] || 'Default')
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

  # Normalize the passed in args for proper EWS names, ex :id_only to IdOnly
  def normalize(sym)
    if sym.is_a?(String)
      sym.downcase.capitalize
    else
      sym.to_s.camel_case
    end
  end

  # @param [Viewpoint::EWS::SOAP::EwsSoapResponse] resp
  def find_folders_parser(resp)
    if resp.status == 'Success'
      folders = resp.response_message[:elems][:root_folder][:elems][0][:folders][:elems]
      return [] if folders.nil?
      folders.collect do |f|
        ftype = f.keys.first
        class_by_name(ftype).new(ews, f[ftype])
      end
    else
      raise EwsError, "Could not retrieve folders. #{resp.code}: #{resp.message}"
    end
  end

  def create_folder_parser(resp)
    if resp.status == 'Success'
      folders = resp.response_message[:elems][:folders][:elems]
      folders.collect do |f|
        ftype = f.keys.first
        class_by_name(ftype).new(ews, f[ftype])
      end
    else
      raise EwsError, "Could not create folder. #{resp.code}: #{resp.message}"
    end
  end

  # Build up the arguements for #get_folder
  def get_folder_args(folder_id, opts)
    opts[:base_shape] = normalize(opts[:base_shape] || 'Default')
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
