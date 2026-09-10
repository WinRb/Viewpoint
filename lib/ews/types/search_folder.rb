# frozen_string_literal: true

module Viewpoint
  module EWS
    module Types
      class SearchFolder
        include Viewpoint::EWS
        include Viewpoint::EWS::Types
        include Viewpoint::EWS::Types::GenericFolder
      end
    end
  end
end
