module Viewpoint::EWS::Types
  class Folder
    include Viewpoint::EWS
    include Viewpoint::EWS::Types
    include Viewpoint::EWS::Types::GenericFolder

    FOLDER_KEY_PATHS = {
      :unread_count       => [:unread_count, :text],
    }
    FOLDER_KEY_TYPES = {
      :unread_count       => ->(str){str.to_i},
    }
    FOLDER_KEY_ALIAS = {}


    private

    def key_paths
      @key_paths ||= super.merge(FOLDER_KEY_PATHS)
    end

    def key_types
      @key_types ||= super.merge(FOLDER_KEY_TYPES)
    end

    def key_alias
      @key_alias ||= super.merge(FOLDER_KEY_ALIAS)
    end

  end
end
