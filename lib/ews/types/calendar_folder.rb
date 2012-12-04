module Viewpoint::EWS::Types
  class CalendarFolder
    include Viewpoint::EWS
    include Viewpoint::EWS::Types
    include Viewpoint::EWS::Types::GenericFolder

    @@calendar_key_paths = GenericFolder::KEY_PATHS.merge(
      {}
    )

    @@calendar_key_types = GenericFolder::KEY_TYPES.merge(
      {}
    )

    @@calendar_key_alias = GenericFolder::KEY_ALIAS.merge(
      {}
    )

    def self.key_paths
      @@calendar_key_paths
    end

    def self.key_types
      @@calendar_key_types
    end

    def self.key_alias
      @@calendar_key_alias
    end

  end
end
