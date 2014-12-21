require 'spec_helper'

describe Citrix::Training::Serializer::Training do
  describe '#serialize' do
    it 'returns name' do
      expect(serialize(name: 'NAME')).to include(name: 'NAME')
    end

    it 'returns description' do
      expect(serialize(description: 'DESCRIPTION')).to include(description: 'DESCRIPTION')
    end

    it 'returns time zone' do
      expect(serialize(timezone: 'TZ')).to include(timeZone: 'TZ')
    end

    it 'returns registration settings (web registration)' do
      params = serialize(web_registration: true)
      expect(params[:registrationSettings]).to include(disableWebRegistration: false)
    end

    it 'returns registration settings (confirmation email)' do
      params = serialize(confirmation_email: true)
      expect(params[:registrationSettings]).to include(disableConfirmationEmail: false)
    end

    it 'returns dates' do
      date = Citrix::Training::Resource::TrainingDate.new(Time.now, Time.now + 3600)
      params = serialize(dates: [date])

      expect(params[:times].size).to eq(1)
      expect(params[:times].first).to include(startDate: date.starts_at.iso8601)
      expect(params[:times].first).to include(endDate: date.ends_at.iso8601)
    end
  end

  describe '#deserialize' do
    let(:attrs) {
      JSON.load(fixtures.join('training.json').read)
    }

    it 'returns name' do
      expect(deserialize(attrs)).to include(name: attrs['name'])
    end

    it 'returns description' do
      expect(deserialize(attrs)).to include(description: attrs['description'])
    end

    it 'returns time zone' do
      expect(deserialize(attrs)).to include(timezone: attrs['timeZone'])
    end

    it 'returns key' do
      expect(deserialize(attrs)).to include(key: attrs['trainingKey'])
    end

    it 'returns dates' do
      params = deserialize(attrs)

      starts_at = Time.parse(attrs['times'][0]['startDate'])
      ends_at = Time.parse(attrs['times'][0]['endDate'])

      expect(params[:dates].size).to eq(1)
      expect(params[:dates].first.starts_at.to_i).to eq(starts_at.to_i)
      expect(params[:dates].first.ends_at.to_i).to eq(ends_at.to_i)
    end

    it 'returns web registration' do
      params = deserialize(attrs)
      expect(params).to include(web_registration: true)
    end

    it 'returns confirmation e-mail' do
      params = deserialize(attrs)
      expect(params).to include(confirmation_email: true)
    end
  end
end
