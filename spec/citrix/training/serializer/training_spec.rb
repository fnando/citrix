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
      date = Citrix::Training::TrainingDate.new(Time.now, Time.now + 3600)
      params = serialize(dates: [date])

      expect(params[:times].size).to eq(1)
      expect(params[:times].first).to include(startDate: date.starts_at.iso8601)
      expect(params[:times].first).to include(endDate: date.ends_at.iso8601)
    end
  end
end
