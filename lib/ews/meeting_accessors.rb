module Viewpoint::EWS::MeetingAccessors
  include Viewpoint::EWS

  def accept_meeting(opts)
    ews.create_item({
      message_disposition: 'SendOnly',
      items: [ { accept_item: opts_to_item(opts) } ]
    })
  end

  def decline_meeting(opts)
    ews.create_item({
      message_disposition: 'SendOnly',
      items: [ { decline_item: opts_to_item(opts) } ]
    })
  end

  def tentatively_accept_meeting(opts)
    ews.create_item({
      message_disposition: 'SendOnly',
      items: [ { tentatively_accept_item: opts_to_item(opts) } ]
    })
  end

  private

  def opts_to_item(opts)
    {
      id: opts[:id],
      change_key: opts[:change_key],
      text: opts[:text],
      sensitivity: opts[:sensitivity]
    }
  end
end
