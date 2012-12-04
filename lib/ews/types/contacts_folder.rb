module Viewpoint::EWS::Types
  class ContactsFolder
    include Viewpoint::EWS
    include Viewpoint::EWS::Types
    include Viewpoint::EWS::Types::GenericFolder

    @@contacts_key_paths = GenericFolder::KEY_PATHS.merge(
      {}
    )

    @@contacts_key_types = GenericFolder::KEY_TYPES.merge(
      {}
    )

    @@contacts_key_alias = GenericFolder::KEY_ALIAS.merge(
      {}
    )

    def self.key_paths
      @@contacts_key_paths
    end

    def self.key_types
      @@contacts_key_types
    end

    def self.key_alias
      @@contacts_key_alias
    end

  end
end
