module Viewpoint::EWS::SOAP

  # Exchange Availability operations as listed in the EWS Documentation.
  # @see http://msdn.microsoft.com/en-us/library/bb409286.aspx
  module ExchangeAvailability
    include Viewpoint::EWS::SOAP

    # -------------- Availability Operations -------------

    # Gets a mailbox user's Out of Office (OOF) settings and messages.
    # @see http://msdn.microsoft.com/en-us/library/aa563465.aspx
    # @param [Hash] opts
    # @option opts [String] :address the email address of the user
    # @option opts [String] :name the user display name (optional)
    # @option opts [String] :routing_type the routing protocol (optional and stupid)
    def get_user_oof_settings(opts)
      opts = opts.clone
      [:address].each do |k|
        validate_param(opts, k, true)
      end
      req = build_soap! do |type, builder|
        if(type == :header)
        else
        builder.nbuild.GetUserOofSettingsRequest {|x|
          x.parent.default_namespace = @default_ns
          builder.mailbox!(opts)
        }
        end
      end
      resp = do_soap_request(req, raw_response: true)
      parse!(resp, response_class: EwsSoapAvailabilityResponse)
    end

    # Sets a mailbox user's Out of Office (OOF) settings and message.
    # @see http://msdn.microsoft.com/en-us/library/aa580294.aspx
    def set_user_oof_settings(mailbox, oof_state, ext_audience, dt_start, dt_end, int_msg, ext_mg)
      action = "#{SOAP_ACTION_PREFIX}/SetUserOofSettings"
      resp = invoke("#{NS_EWS_MESSAGES}:SetUserOofSettings", action) do |root|
        build!(root)
      end
      parse!(resp)
    end

  end #ExchangeAvailability
end
