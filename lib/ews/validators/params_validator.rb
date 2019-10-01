module Viewpoint::EWS::Validators
  module ParamsValidator

    private

    # Validate or set default values for options parameters.
    # @param [Hash] opts The options parameter passed to an EWS operation
    # @param [Symbol] key The key in the Hash we are validating
    # @param [Boolean] required Whether or not this key is required
    # @param [Object] default_val If the key is not required use this as a
    #   default value for the operation.
    def validate_param(opts, key, required, default_val = nil)
      if required
        raise EwsBadArgumentError, "Required parameter(#{key}) not passed." unless opts.has_key?(key)
        opts[key]
      else
        raise EwsBadArgumentError, "Default value not supplied." unless default_val
        opts.has_key?(key) ? opts[key] : default_val
      end
    end
  end
end
