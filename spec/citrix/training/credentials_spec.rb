require 'spec_helper'

describe Citrix::Training::Credentials do
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
