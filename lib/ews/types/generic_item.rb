# Generic folder item (specified by tag "item").
# Nothing is implemented on top of it but it's needed for correct parsing
# of the sync response in some cases.
module Viewpoint::EWS::Types
  class GenericItem
    include Viewpoint::EWS
    include Viewpoint::EWS::Types
    include Viewpoint::EWS::Types::Item
    include Viewpoint::StringUtils
  end
end
