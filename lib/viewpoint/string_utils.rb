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

module Viewpoint
  # Collection of utility methods for working with Strings
  module StringUtils

    def self.included(klass)
      klass.extend StringUtils
    end

    private

    # Change CamelCased strings to ruby_cased strings
    # It uses the lookahead assertion ?=  In this case it basically says match
    # anything followed by a capital letter, but not the capital letter itself.
    # @see http://www.pcre.org/pcre.txt The PCRE guide for more details
    def ruby_case(input)
      input.to_s.split(/(?=[A-Z])/).join('_').downcase
    end

    # Change a ruby_cased string to CamelCased
    def camel_case(input)
      input.to_s.split(/_/).map { |i|
        i.sub(/^./) { |s| s.upcase }
      }.join
    end
  end # StringUtils
end # Viewpoint
