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

      # Find folders of type Folder (message folders)
      # @see GenericFolder.find_folders
      # @param [String,Symbol] root An folder id, either a DistinguishedFolderId (must me a Symbol)
      #   or a FolderId (String)
      # @param [String] traversal Shallow/Deep/SoftDeleted
      # @param [String] shape the shape to return IdOnly/Default/AllProperties
      # @param [optional, String] folder_type an optional folder type to limit the search to like 'IPF.Task'
      # @return [Array] Returns an Array of Folder or subclasses of Folder
      def self.find_folders(root = :msgfolderroot, traversal = 'Deep', shape = 'Default', folder_type = 'IPF.Note')
        super(root, traversal, shape, folder_type)
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
