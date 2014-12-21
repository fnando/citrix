require 'spec_helper'

describe Citrix::Training::Serializer::TrainingDate do
  describe '#serialize' do
    it 'returns starting date' do
      starting = Time.now
      ending = starting + 3600
      params = serialize(starts_at: starting, ends_at: ending)

      expect(params).to include(startDate: starting.iso8601)
    end

    it 'returns ending date' do
      starting = Time.now
      ending = starting + 3600
      params = serialize(starts_at: starting, ends_at: ending)

      expect(params).to include(endDate: ending.iso8601)
    end
  end
end
