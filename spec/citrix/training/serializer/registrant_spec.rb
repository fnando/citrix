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
    let(:raw_attrs) { JSON.load(fixtures.join('registrant.json').read) }
    let(:attrs) { deserialize(raw_attrs) }

    it 'returns first name' do
      expect(attrs).to include(first_name: raw_attrs['givenName'])
    end

    it 'returns last name' do
      expect(attrs).to include(last_name: raw_attrs['surname'])
    end

    it 'returns email' do
      expect(attrs).to include(email: raw_attrs['email'])
    end

    it 'returns join url' do
      expect(attrs).to include(join_url: raw_attrs['joinUrl'])
    end

    it 'returns confirmation url' do
      expect(attrs).to include(confirmation_url: raw_attrs['confirmationUrl'])
    end

    it 'returns registrant key' do
      expect(attrs).to include(key: raw_attrs['registrantKey'])
    end

    it 'returns status' do
      expect(attrs).to include(status: raw_attrs['status'].downcase)
    end
  end
end
