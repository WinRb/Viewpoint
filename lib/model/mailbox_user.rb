#############################################################################
# Copyright © 2010 Dan Wanek <dan.wanek@gmail.com>
#
#
# This file is part of Viewpoint.
# 
# Viewpoint is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published
# by the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.
# 
# Viewpoint is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
# Public License for more details.
# 
# You should have received a copy of the GNU General Public License along
# with Viewpoint.  If not, see <http://www.gnu.org/licenses/>.
#############################################################################

module Viewpoint
  module EWS

    # This represents a Mailbox object in the Exchange data store
    # @see http://msdn.microsoft.com/en-us/library/aa565036.aspx MSDN docs
    # @todo Design a Class method that resolves to an Array of MailboxUsers
    class MailboxUser
      include Model

      # Resolve a user in the Exchange Data Store
      # @param [String] A user to resolve to.
      # @return [MailboxUser,Array] If it resolves to one user then it returns a MailboxUser.
      #   If it resolves to more than one user an Array of MailboxUsers are returned.  If an
      #   error ocurrs an exception is raised.
      def self.find_user(resolve)
        resp = (Viewpoint::EWS::EWS.instance).ews.resolve_names(resolve)
        if(resp.status == 'Success')
          return self.new(resp.items.first[:mailbox])
        elsif(resp.code == 'ErrorNameResolutionMultipleResults')
          users = []
          resp.items.each do |u|
            users << self.new(u[:mailbox])
          end
          return users
        else
          raise EwsError, "Find User produced an error: #{resp.code}: #{resp.message}"
        end
      end

      def initialize(mbox_user)
        super() # Calls initialize in Model (creates @ews_methods Array)
        @ews_item = mbox_user
        define_str_var :name, :email_address, :routing_type, :mailbox_type, :item_id
      end

      def get_oof
        mailbox = {:mailbox => {:address => {:text => email_address}}}
        resp = (Viewpoint::EWS::EWS.instance).ews.get_user_oof_settings(mailbox)
        s = resp[:oof_settings]
        @oof_state = s[:oof_state][:text]
        @oof_ext_audience = s[:external_audience][:text]
        @oof_start = DateTime.parse(s[:duration][:start_time][:text])
        @oof_end = DateTime.parse(s[:duration][:end_time][:text])
        @oof_internal_reply = s[:internal_reply][:message][:text]
        @oof_external_reply = s[:internal_reply][:message][:text]
        true
      end
      
      # Adds one or more delegates to a principal's mailbox and sets specific access permissions
      # @see http://msdn.microsoft.com/en-us/library/bb856527.aspx
      #
      # @param [String,MailboxUser] delegate_email The user you would like to give delegate access to.
      #   This can either be a simple String e-mail address or you can pass in a MailboxUser object.
      # @param [Hash] permissions A hash of folder type keys and permission type values. An example
      #   would be {:calendar_folder_permission_level => 'Editor'}.  Possible keys are:
      #   :calendar_folder_permission_level, :tasks_folder_permission_level, :inbox_folder_permission_level
      #   :contacts_folder_permission_level, :notes_folder_permission_level, :journal_folder_permission_level
      #   and possible values are:  None/Editor/Reviewer/Author/Custom
      # @return [true] This method either returns true or raises an error with the message
      #   as to why this operation did not succeed.
      def add_delegate!(delegate_email, permissions)
        # Modify permissions so we can pass it to the builders
        permissions.each_pair do |k,v|
          permissions[k] = {:text => v}
        end

        resp = (Viewpoint::EWS::EWS.instance).ews.add_delegate(self.email_address, delegate_email, permissions)
        if(resp.status == 'Success')
          return true
        else
          raise EwsError, "Could not add delegate access for user #{delegate_email}: #{resp.code}, #{resp.message}"
        end
      end

      def update_delegate!(delegate_email, permissions)
        # Modify permissions so we can pass it to the builders
        permissions.each_pair do |k,v|
          permissions[k] = {:text => v}
        end

        resp = (Viewpoint::EWS::EWS.instance).ews.update_delegate(self.email_address, delegate_email, permissions)
        if(resp.status == 'Success')
          return true
        else
          raise EwsError, "Could not update delegate access for user #{delegate_email}: #{resp.code}, #{resp.message}"
        end
      end

      def get_delegate_info()
        resp = (Viewpoint::EWS::EWS.instance).ews.get_delegate(self.email_address)
       # if(resp.status == 'Success')
       #   return true
       # else
       #   raise EwsError, "Could not update delegate access for user #{delegate_email}: #{resp.code}, #{resp.message}"
       # end
      end

    end # MailboxUser
  end # EWS
end # Viewpoint
