module Viewpoint::EWS::Types
  class Contact
    include Viewpoint::EWS
    include Viewpoint::EWS::Types
    include Viewpoint::EWS::Types::Item


    CONTACT_KEY_PATHS = {
      complete_name: [:complete_name, :elems],
      email_addresses: [:email_addresses, :elems],
      physical_addresses: [:physical_addresses, :elems],
      phone_numbers: [:phone_numbers, :elems]
    }

    CONTACT_KEY_TYPES = {
      email_addresses: :build_email_addresses,
      complete_name: :build_complete_name,
      physical_addresses: :build_physical_addresses,
      phone_numbers: :build_phone_numbers
    }

    CONTACT_KEY_ALIAS = {}

    private

    # @return Array of email addresses
    def build_email_addresses(emails)
      emails.collect{|e| (e[:entry][:text] rescue nil)}.compact
    end

    # @return Hash of names
    def build_complete_name(elems)
      ret = nil
      els = {}
      elems.each{|e| 
        if e.keys && e.values && e.values.first && e.values.first[:text]
          els[e.keys.first] = e.values.first[:text]
        end
      }
      if els && els.any?
        first_name = els[:first_name]
        last_name = els[:last_name]
        full_name = els[:full_name]
        ret = {:first_name => first_name, :last_name => last_name, :full_name => full_name}
      end
      ret
    end


    # @return Array of Hashes of each address
    def build_physical_addresses(elems)
      ret = []
      if elems
        elems.each{|e|
          addresstype = e[:entry][:attribs][:key] rescue nil
          if addresstype
            addr = {:address_type => addresstype}
            e[:entry][:elems].each{|a| 
              if a.keys && a.keys.first && a.values && a.values.first && a.values.first[:text]
                addr[a.keys.first] = a.values.first[:text]
              end
            } rescue addr = nil
            ret << addr if addr
          end
        }
      end
      ret
    end

    # @return Array of Hashes of each phone number
    def build_phone_numbers(elems)
      ret = []
      if elems
        elems.each{|e|
          phonetype = e[:entry][:attribs][:key] rescue nil
          if phonetype && (e[:entry][:text].length > 0 rescue false)
            phone = {:phone_type => phonetype, :number => e[:entry][:text]}
            ret << phone
          end
        }
      end
      ret
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
