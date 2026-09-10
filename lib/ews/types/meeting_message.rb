# frozen_string_literal: true

module Viewpoint
  module EWS
    module Types
      class MeetingMessage
        include Viewpoint::EWS
        include Viewpoint::EWS::Types
        include Viewpoint::EWS::Types::Item
      end
    end
  end
end
