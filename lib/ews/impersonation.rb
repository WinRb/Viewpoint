# frozen_string_literal: true

module Viewpoint
  module EWS
    ConnectingSID = {
      UPN: 'PrincipalName',
      SID: 'SID',
      PSMTP: 'PrimarySmtpAddress',
      SMTP: 'SmtpAddress'
    }

    # @param connecting_type [String] should be one of the ConnectingSID variables
    #   ConnectingSID[:UPN] - use User Principal Name method
    #   ConnectingSID[:SID] - use Security Identifier method
    #   ConnectingSID[:PSMTP] - use primary Simple Mail Transfer Protocol method
    #   ConnectingSID[:SMTP] - use Simple Mail Transfer Protocol method
    #   you can add any other string, it will be converted into xml tag on soap request
    # @param address [String] an address to include to requests for impersonation
    def set_impersonation(connecting_type, address)
      unless ConnectingSID.has_value? connecting_type or connecting_type.is_a? String
        raise EwsBadArgumentError, "Not a proper connecting method: #{connecting_type.class}"
      end

      ews.impersonation_type = connecting_type
      ews.impersonation_address = address
    end

    def remove_impersonation
      ews.impersonation_type = ''
      ews.impersonation_address = ''
    end
  end
end
