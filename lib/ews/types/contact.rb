module Viewpoint::EWS::Types
  class Contact
    include Viewpoint::EWS
    include Viewpoint::EWS::Types
    include Viewpoint::EWS::Types::Item

    CONTACT_KEY_PATHS = {
      given_name:         [:given_name, :text],
      surname:            [:surname, :text],
      yomi_given_name:    [:yomi_given_name, :text],
      yomi_surname:       [:yomi_surname, :text],
      display_name:       [:display_name, :text],
      company_name:       [:company_name, :text],
      yomi_company_name:  [:yomi_company_name, :text],
      email_addresses:    [:email_addresses, :elems],
      physical_addresses: [:physical_addresses, :elems],
      phone_numbers:      [:phone_numbers, :elems],
      department:         [:department, :text],
      job_title:          [:job_title, :text],
      office_location:    [:office_location, :text],
    }

    CONTACT_KEY_TYPES = {
      email_addresses:    :build_email_addresses,
      physical_addresses: :build_physical_addresses
    }

    CONTACT_KEY_ALIAS = {
      first_name:      :given_name,
      last_name:       :surname,
      yomi_first_name: :yomi_given_name,
      yomi_last_name:  :yomi_surname,
      emails:          :email_addresses,
      addresses:       :physical_addresses,
      job:             :job_title,
      company:         :company_name,
      office:          :office_location,
    }


    private


    def build_email_address(email)
      Types::EmailAddress.new(ews, email)
    end

    def build_email_addresses(users)
      return [] if users.nil?
      users.collect { |u| build_email_address(u[:entry]) }
    end

    def build_physical_address(address_ews)
      Types::PhysicalAddress.new(ews, address_ews)
    end

    def build_physical_addresses(addresses)
      return [] if addresses.nil?
      addresses.collect { |a| build_physical_address(a[:entry]) }
    end

    def key_paths
      super.merge(CONTACT_KEY_PATHS)
    end

    def key_types
      super.merge(CONTACT_KEY_TYPES)
    end

    def key_alias
      super.merge(CONTACT_KEY_ALIAS)
    end


  end
end
