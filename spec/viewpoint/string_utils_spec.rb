# frozen_string_literal: true

require 'spec_helper'

describe Viewpoint::StringUtils do
  before do
    extend Viewpoint::StringUtils
  end

  describe '#ruby_case' do
    it 'transforms RubyCase to ruby_case' do
      expect(send(:ruby_case, 'RubyCase')).to eql('ruby_case')
    end

    it 'transforms ruby_case to ruby_case' do
      expect(send(:ruby_case, 'ruby_case')).to eql('ruby_case')
    end

    it 'transforms ThisIsATest to this_is_a_test' do
      expect(send(:ruby_case, 'ThisIsATest')).to eql('this_is_a_test')
    end
  end

  describe '#camel_case' do
    it 'transforms camel_case to CamelCase' do
      expect(send(:camel_case, 'camel_case')).to eql('CamelCase')
    end

    it 'transforms CamelCase to CamelCase' do
      expect(send(:camel_case, 'CamelCase')).to eql('CamelCase')
    end

    it 'transforms this_is_a_test to ThisIsATest' do
      expect(send(:camel_case, 'this_is_a_test')).to eql('ThisIsATest')
    end
  end

  describe '#iso8601_duration_to_seconds' do
    it 'returns nil if the input is nil' do
      expect(send(:iso8601_duration_to_seconds, nil)).to be_nil
    end

    it 'returns nil if the input is empty' do
      expect(send(:iso8601_duration_to_seconds, '')).to be_nil
    end

    it 'parses P4D' do
      expect(send(:iso8601_duration_to_seconds, 'P4D')).to eql(345_600)
    end

    it 'parses P2DT4H1M23S' do
      expect(send(:iso8601_duration_to_seconds, 'P2DT4H1M23S')).to eql(187_283)
    end

    it 'parses P15DT5H0M20S' do
      expect(send(:iso8601_duration_to_seconds, 'P15DT5H0M20S')).to eql(1_314_020)
    end

    it 'parses P2DT4H1M23S' do
      expect(send(:iso8601_duration_to_seconds, 'P2DT4H1M23S')).to eql(187_283)
    end

    it 'parses P7W' do
      expect(send(:iso8601_duration_to_seconds, 'P7W')).to eql(4_233_600)
    end
  end
end
