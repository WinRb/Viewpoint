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
      mb = resp.response_message[:elems][:resolution_set][:elems][0][:resolution][:elems][0]
      users << Types::MailboxUser.new(ews, mb[:mailbox][:elems])
    elsif(resp.code == 'ErrorNameResolutionMultipleResults')
      resp.response_message[:elems][:resolution_set][:elems].each do |u|
      if u[:resolution][:elems][0][:mailbox]
        users << Types::MailboxUser.new(ews, u[:resolution][:elems][0][:mailbox][:elems])
      end
      end
    else
      raise EwsError, "Find User produced an error: #{resp.code}: #{resp.message}"
    end
    users
  end
  
  
  #  Get user calendar free/busy with several options for the view to be returned
  # requested_view can be None|MergedOnly|FreeBusy|FreeBusyMerged|Detailed|DetailedMerged} 
  #        
  def get_user_availability(email_address, start_time, end_time, requested_view )
    opts = {
       mailbox_data: [ :email =>{:address => email_address} ],
       free_busy_view_options: {
         time_window: {start_time: start_time, end_time: end_time},
         requested_view: { :requested_free_busy_view => requested_view },
       }
     }
    
     resp = ews.get_user_availability(opts)   
     if(resp.status == 'Success')
       return resp
     else
       raise EwsError, "GetUserAvailability produced an error: #{resp.code}: #{resp.message}"
     end
    
  end


end # Viewpoint::EWS::MailboxAccessors
