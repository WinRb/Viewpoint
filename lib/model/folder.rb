#############################################################################
# Copyright © 2010 Dan Wanek <dan.wanek@gmail.com>
#
#
# This file is part of Viewpoint.
# 
# Viewpoint is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published
# by the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.
# 
# Viewpoint is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
# Public License for more details.
# 
# You should have received a copy of the GNU General Public License along
# with Viewpoint.  If not, see <http://www.gnu.org/licenses/>.
#############################################################################

module Viewpoint
  module EWS
    # This class represents a FolderType object in the Exchange Data store.
    # This is the type of folder that mail messages will be found in.
    class Folder < GenericFolder

      # Find Message subfolders of the passed root folder.  If no parameters are passed
      # this method will search from the Root folder.
      # @param [Str] root An folder id, either a DistinguishedFolderId (must me a Symbol)
      #   or a FolderId (String)
      # @param [String] traversal Shallow/Deep/SoftDeleted
      # @return [Array] Returns an Array of Folder or subclasses of Folder
      def self.find_folders(root = :msgfolderroot, traversal = 'Deep', shape = 'Default')
        restr = {:restriction => 
          {:is_equal_to => {:field_uRI => {:field_uRI=>'folder:FolderClass'},:field_uRI_or_constant=>{:constant => {:value => 'IPF.Note'}}}}
        }
        resp = (Viewpoint::EWS::EWS.instance).ews.find_folder( [normalize_id(root)], traversal, {:base_shape => shape}, restr)
        if(resp.status == 'Success')
          folders = []
          resp.items.each do |f|
            f_type = f.keys.first.to_s.camel_case
            folders << (eval "#{f_type}.new(f[f.keys.first])")
          end
          return folders
        else
          raise EwsError, "Could not retrieve folders. #{resp.code}: #{resp.message}"
        end
      end


      # Initialize with an item of FolderType.  This is typically the folder
      # used to house mail messages.
      def initialize(folder)
        super(folder)
        define_int_var :unread_count
      end

    end # Folder
  end # EWS
end # Viewpoint
