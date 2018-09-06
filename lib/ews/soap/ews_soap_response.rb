=begin
  This file is part of Viewpoint; the Ruby library for Microsoft Exchange Web Services.

  Copyright © 2011 Dan Wanek <dan.wanek@gmail.com>

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
=end

module Viewpoint::EWS::SOAP

  # A Generic Class for SOAP returns.
  # @attr_reader [String] :message The text from the EWS element <m:ResponseCode>
  class EwsSoapResponse

    def initialize(sax_hash)
      @resp = sax_hash
      simplify!
    end

    def envelope
      @resp[:envelope][:elems]
    end

    def header
      envelope[0][:header][:elems]
    end

    def body
      envelope[1][:body][:elems]
    end

    def response
      body[0]
    end

    def response_messages
      key = response.keys.first
      response[key][:elems].find{|e| e.keys.include? :response_messages }[:response_messages][:elems]
    end

    def response_message
      key = response_messages[0].keys.first
      response_messages[0][key]
    end

    def response_class
      response_message[:attribs][:response_class]
    end
    alias :status :response_class

    def response_code
      response_message[:elems][:response_code][:text]
    end
    alias :code :response_code

    def response_message_text
      guard_hash response_message[:elems], [:message_text, :text]
    end
    alias :message :response_message_text

    def success?
      response_class == "Success"
    end


    private


    def simplify!
      response_messages.each do |rm|
        key = rm.keys.first
        rm[key][:elems] = rm[key][:elems].inject(&:merge)
      end
    end

    # this is basically the same as Hash#dig in Ruby >= 2.3
    # If the keys don't exist in the Hash return nil
    # @param[Hash, Array, Object] hsh or array which contains an array with the hash we need
    # @param[Array<Symbol,String>] keys keys to follow in the array
    # @return [Object, nil]
    def self.guard_hash(hsh, keys)
      return hsh if keys.empty? # alt the recursion

      key = keys.shift

      # for arrays, search a Hash element which has the key we're looking for
      if hsh.class == Array
        hsh = hsh.select { |h| h.key?(key) }.first
      end

      return nil unless hsh.is_a?(Hash) && hsh.key?(key)

      return guard_hash hsh[key], keys
    end

    # for backward compatibility, also have the same method as an instance method
    # If the keys don't exist in the Hash return nil
    # @param[Hash] hsh
    # @param[Array<Symbol,String>] keys keys to follow in the array
    # @return [Object, nil]
    def guard_hash(hsh, keys)
      self.class.guard_hash(hsh, keys)
    end

    # @param elems [Array[Hash]] in the form >[{:user_setting=>{:attribs=>{:type=>"StringSetting"}, :elems=>[{:name=>{:text=>"GroupingInformation"}}, {:value=>{:text=>"Default-First-Site-Name"}}]}}, {:user_setting=>{:attribs=>{:type=>"StringSetting"}, :elems=>[{:name=>{:text=>"ExternalEwsUrl"}}, {:value=>{:text=>"https://exchange.example.com/ews/exchange.asmx"}}]}
    # @return [Hash] in the form {'GroupingInformation' => 'Default-First-Site-Name', 'ExternalEwsUrl' => 'https://exchange.example.com/ews/exchange.asmx"'}
    def self.string_attribs_array_to_hash(elems)
      hash = {}

      elems.each do |elem|
        elem.each do |subelem_key, subelem_value|
          if guard_hash(subelem_value, [:attribs, :type]) == "StringSetting"

            elems1 = subelem_value[:elems]

            key = elems1.select { |el| el.has_key?(:name) }.first[:name][:text]
            value = elems1.select { |el| el.has_key?(:value) }.first[:value][:text]

            hash[key] = value
          end
        end
      end

      return hash
    end

  end # EwsSoapResponse

end # Viewpoint::EWS::SOAP
