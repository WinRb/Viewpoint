module Viewpoint::EWS::Types
  class TasksFolder
    include Viewpoint::EWS
    include Viewpoint::EWS::Types
    include Viewpoint::EWS::Types::GenericFolder

    @@tasks_key_paths = GenericFolder::KEY_PATHS.merge(
      {}
    )

    @@tasks_key_types = GenericFolder::KEY_TYPES.merge(
      {}
    )

    @@tasks_key_alias = GenericFolder::KEY_ALIAS.merge(
      {}
    )

    def self.key_paths
      @@tasks_key_paths
    end

    def self.key_types
      @@tasks_key_types
    end

    def self.key_alias
      @@tasks_key_alias
    end

  end
end
