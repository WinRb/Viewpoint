module Viewpoint::EWS::Types
  class CalendarFolder
    include Viewpoint::EWS
    include Viewpoint::EWS::Types
    include Viewpoint::EWS::Types::GenericFolder

    # Fetch items between a given time period
    # @param [DateTime] start_date the time to start fetching Items from
    # @param [DateTime] end_date the time to stop fetching Items from
    def items_between(start_date, end_date, opts={})
      items do |obj|
        obj.restriction = { :and =>
          [
            {:is_greater_than_or_equal_to =>
              [
                {:field_uRI => {:field_uRI=>'calendar:Start'}},
                {:field_uRI_or_constant=>{:constant => {:value =>start_date}}}
              ]
            },
            {:is_less_than_or_equal_to =>
              [
                {:field_uRI => {:field_uRI=>'calendar:End'}},
                {:field_uRI_or_constant=>{:constant => {:value =>end_date}}}
              ]
            }
          ]
        }
      end
    end

  end
end
