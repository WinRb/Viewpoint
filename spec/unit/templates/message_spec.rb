# frozen_string_literal: true

require_relative '../../spec_helper'

describe Viewpoint::EWS::Template::Message do
  describe '#to_ews' do
    it 'defaults the message disposition from the draft flag' do
      expect(described_class.new.to_ews[:message_disposition]).to eq('SendAndSaveCopy')
      expect(described_class.new(draft: true).to_ews[:message_disposition]).to eq('SaveOnly')
    end

    it 'uses an explicit message disposition' do
      msg = described_class.new(draft: true, message_disposition: 'SendOnly')
      expect(msg.to_ews[:message_disposition]).to eq('SendOnly')
    end

    it 'omits MimeContent unless given' do
      expect(described_class.new.to_ews[:items].first[:message]).not_to have_key(:mime_content)
    end

    it 'includes MimeContent with a UTF-8 character set by default' do
      msg = described_class.new(mime_content: 'TUlNRQ==')
      expect(msg.to_ews[:items].first[:message][:mime_content]).to eq(text: 'TUlNRQ==', character_set: 'UTF-8')
    end

    it 'includes MimeContent set in a block-style assignment with a custom character set' do
      msg = described_class.new
      msg.mime_content = 'TUlNRQ=='
      msg.mime_content_charset = 'ISO-8859-1'
      expect(msg.to_ews[:items].first[:message][:mime_content]).to eq(text: 'TUlNRQ==', character_set: 'ISO-8859-1')
    end
  end
end
