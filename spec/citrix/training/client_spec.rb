require 'spec_helper'

describe Citrix::Training::Client do
  describe '.build' do
    it 'returns client' do
      client = Citrix::Training::Client.build({})
      expect(client).to be_a(Citrix::Training::Client)
    end

    it 'sets credentials' do
      client = Citrix::Training::Client.build({})
      expect(client.credentials).to be_a(Citrix::Training::Credentials)
    end
  end
end
