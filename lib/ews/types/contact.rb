module Viewpoint::EWS::Types
  class Contact
    include Viewpoint::EWS
    include Viewpoint::EWS::Types
    include Viewpoint::EWS::Types::Item

    CONTACT_ITEM_KEY_PATHS = {
      email_addresses: [ :email_addresses, :elems ],
      phone_numbers: [ :phone_numbers, :elems ],
      physical_addresses: [ :physical_addresses, :elems ],
      complete_name: [ :complete_name, :elems ],
      company_name: [ :company_name, :text ],
      department: [ :department, :text ],
      job_title: [ :job_title, :text ],
      birthday: [ :birthday, :text ],
      wedding_anniversary: [ :wedding_anniversary, :text ],
      business_home_page: [ :business_home_page, :text ],
      generation: [ :generation, :text ],
      spouse_name: [ :spouse_name, :text ],
      surname: [ :surname, :text ]

    }

    CONTACT_ITEM_KEY_TYPES = {
      email_addresses: :build_email_addresses,
      physical_addresses: :build_addresses, 
      phone_numbers: :build_phone_numbers,
      complete_name: ->(str){ 
        str.inject({}){|m,o|
          m[o.keys.first] = o.values.first[:text];
          m
        }
      },
      birthday: ->(str){ Date.parse(str) },
      wedding_anniversary: ->(str){ Date.parse(str) },
    }

    private 

    def build_addresses(addresses)
      return [] if addresses.nil?
      elems = addresses.collect do |addrs| 
        addrs[:entry][:elems] << { address_type: addrs[:entry][:attribs] }
      end
      build_contact_entity(PhysicalAddress, elems)
    end

    def build_email_addresses(emails)
      return [] if emails.nil?
      elems = emails.collect{ |ele| ele[:entry] }
      build_contact_entity(EmailAddress, elems)
    end

    def build_phone_numbers(numbers)
      return [] if numbers.nil?
      elems = numbers.collect{ |ele| ele[:entry] }
      build_contact_entity(PhoneNumber, elems)
    end

    def build_contact_entity(klass, elems)
      elems.collect{ |elem| klass.new(ews, elem) }
    end

    def key_types
      super.merge(CONTACT_ITEM_KEY_TYPES)
    end

    def key_paths
      super.merge(CONTACT_ITEM_KEY_PATHS)
    end
  end
end
