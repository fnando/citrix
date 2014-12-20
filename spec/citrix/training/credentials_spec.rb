require 'spec_helper'

describe Citrix::Training::Credentials do
  describe '#initialize' do
    subject(:credentials) {
      Citrix::Training::Credentials.new(
        oauth_token: 'OAUTH_TOKEN',
        organizer_key: 'ORGANIZER_KEY',
        account_key: 'ACCOUNT_KEY'
      )
    }

    it { expect(credentials.oauth_token).to eq('OAUTH_TOKEN') }
    it { expect(credentials.organizer_key).to eq('ORGANIZER_KEY') }
    it { expect(credentials.account_key).to eq('ACCOUNT_KEY') }
  end

  describe '.build' do
    it 'returns new instance' do
      credentials = Citrix::Training::Credentials.build({})
      expect(credentials).to be_a(Citrix::Training::Credentials)
    end

    it 'returns credentials' do
      credentials = Citrix::Training::Credentials.new
      new_credentials = Citrix::Training::Credentials.build(credentials)

      expect(new_credentials).to eq(credentials)
    end
  end
end
