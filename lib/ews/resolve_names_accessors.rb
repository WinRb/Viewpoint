=begin
  This file is part of Viewpoint; the Ruby library for Microsoft Exchange Web Services.

  Copyright © 2013 Camille Baldock <viewpoint@camillebaldock.co.uk>

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

module Viewpoint::EWS::ResolveNamesAccessors
  include Viewpoint::EWS

  # Resolves a contact's name given an email address.
  # @see https://docs.microsoft.com/en-us/exchange/client-developer/web-service-reference/resolvenames-operation
  def resolve_names(name, full_contact_data = true)
    resp = ews.resolve_names(name, full_contact_data)
    resp
  end

  def mailbox(resolved)
    resolved.response_message[:elems][:resolution_set][:elems].first[:resolution][:elems][0][:mailbox][:elems]
  end

  def contact(resolved)
    resolved.response_message[:elems][:resolution_set][:elems].first[:resolution][:elems][1][:contact][:elems]
  end

  [:display_name, :given_name, :initials, :office_location, :department, :surname, :job_title].each do |item_sym|
    define_method(item_sym) do |resolved|
      contact_item(contact(resolved), item_sym)
    end
  end

  private

  def contact_item(contact, sym)
    contact.find{|h| h.first.first == sym}[sym][:text]
  end

  def get_resolve_names_parser(resp)
    if resp.success?
      resp
    else
      raise EwsError, "ResolveNames produced an error: #{resp.code}: #{resp.message}"
    end
  end

end # Viewpoint::EWS::ResolveNamesAccessors