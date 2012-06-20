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

module Viewpoint::EWS::MailboxAccessors
  include Viewpoint::EWS

  # Resolve contacts in the Exchange Data Store
  # @param [String] ustring A string to resolve contacts to.
  # @return [Array<MailboxUser>] It returns an Array of MailboxUsers.
  def search_contacts(ustring)
    resp = ews.resolve_names(:name => ustring)
    users = []
    if(resp.status == 'Success')
      users << MailboxUser.new(ews, resp.items.first[:mailbox])
    elsif(resp.code == 'ErrorNameResolutionMultipleResults')
      resp.items.each do |u|
        users << MailboxUser.new(ews, u[:mailbox])
      end
    else
      raise EwsError, "Find User produced an error: #{resp.code}: #{resp.message}"
    end
    users
  end

  # Get information about when the user with the given email address is available.
  # @param [String] email_address The email address of the person to find availability for.
  # @param [String] start_time The start of the time range to check as an xs:dateTime.
  # @param [String] end_time The end of the time range to check as an xs:dateTime.
  # @see http://msdn.microsoft.com/en-us/library/aa563800(v=exchg.140)
  def get_user_availability(email_address, start_time, end_time)
    resp = ews.get_user_availability(email_address, start_time, end_time)
    if(resp.status == 'Success')
      return resp.items
    else
      raise EwsError, "GetUserAvailability produced an error: #{resp.code}: #{resp.message}"
    end
  end

end # Viewpoint::EWS::MailboxAccessors
