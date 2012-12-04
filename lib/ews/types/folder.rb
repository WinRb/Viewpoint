module Viewpoint::EWS::Types
  class Folder
    include Viewpoint::EWS
    include Viewpoint::EWS::Types
    include Viewpoint::EWS::Types::GenericFolder

    @@folder_key_paths = GenericFolder::KEY_PATHS.merge(
      :unread_count       => [:unread_count, :text],
    )

    @@folder_key_types = GenericFolder::KEY_TYPES.merge(
      :unread_count       => ->(str){str.to_i},
    )

    @@folder_key_alias = GenericFolder::KEY_ALIAS

    def self.key_paths
      @@folder_key_paths
    end

    def self.key_types
      @@folder_key_types
    end

    def self.key_alias
      @@folder_key_alias
    end

  end
end
