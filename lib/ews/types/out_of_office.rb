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

module Viewpoint::EWS::Types

    OOF_KEY_PATHS = {
      :enabled?   => [:oof_settings, :oof_state, :text],
      :scheduled? => [:oof_settings, :oof_state, :text],
      :duration   => [:oof_settings, :duration],
    }

    OOF_KEY_TYPES = {
      :enabled?   => ->(str){str == 'Enabled'},
      :scheduled? => ->(str){str == 'Scheduled'},
      :duration   => ->(hsh){
        { start_time: DateTime.iso8601(hsh[:start_time][:text]),
          end_time: DateTime.iso8601(hsh[:end_time][:text])
        }
      },
    }

    OOF_KEY_ALIAS = {}

  # This represents OutOfOffice settings
  # @see http://msdn.microsoft.com/en-us/library/aa563465.aspx
  class OutOfOffice
    include Viewpoint::EWS
    include Viewpoint::EWS::Types

    # @param [MailboxUser] user
    # @param [Hash] ews_item
    def initialize(user, ews_item)
      @ews =  user.ews
      @user = user
      @ews_item = ews_item
      simplify!
    end

    def enable!
    end

    def disable!
    end

private

    def key_paths
      @key_paths ||= super.merge(OOF_KEY_PATHS)
    end

    def key_types
      @key_types ||= super.merge(OOF_KEY_TYPES)
    end

    def key_alias
      @key_alias ||= super.merge(OOF_KEY_ALIAS)
    end

    def simplify!
      oof_settings = @ews_item[:oof_settings][:elems].inject(:merge)
      if oof_settings[:duration]
        oof_settings[:duration] = oof_settings[:duration][:elems].inject(:merge)
      end
      @ews_item[:oof_settings] = oof_settings
      @ews_item[:allow_external_oof] = @ews_item[:allow_external_oof][:text]
    end

  end #OutOfOffice

end
