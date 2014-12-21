require 'spec_helper'

describe Citrix::Training::Serializer::Registrant do
  describe '#serialize' do
    it 'returns first name' do
      expect(serialize(first_name: 'NAME')).to include(givenName: 'NAME')
    end

    it 'returns last name' do
      expect(serialize(last_name: 'NAME')).to include(surname: 'NAME')
    end

    it 'returns email' do
      expect(serialize(email: 'EMAIL')).to include(email: 'EMAIL')
    end
  end

  describe '#deserialize' do
    it 'returns first name' do
      expect(deserialize('givenName' => 'NAME')).to include(first_name: 'NAME')
    end

    it 'returns last name' do
      expect(deserialize('surname' => 'NAME')).to include(last_name: 'NAME')
    end

    it 'returns email' do
      expect(deserialize('email' => 'EMAIL')).to include(email: 'EMAIL')
    end

    it 'returns join url' do
      expect(deserialize('joinUrl' => 'URL')).to include(join_url: 'URL')
    end

    it 'returns confirmation url' do
      expect(deserialize('confirmationUrl' => 'URL')).to include(confirmation_url: 'URL')
    end

    it 'returns registrant key' do
      expect(deserialize('registrantKey' => 'KEY')).to include(key: 'KEY')
    end
  end
end
