require 'spec_helper'

describe Citrix::Training::Namespace::Registrants do
  describe '#create' do
    let(:client) { build_client }
    let(:training) { build_training }

    it 'performs request' do
      stub_request(:post, /.+/).to_return(
        body: '{}',
        headers: {'Content-Type' => 'application/json'}
      )

      url = url_for('organizers', client.credentials.organizer_key, 'trainings', training.key, 'registrants')
      attrs = build_registrant_attributes
      serialized_attrs = serialize(attrs, Citrix::Training::Serializer::Registrant)
      client.registrants(training).create(attrs)

      expect(last_request.method).to eq(:post)
      expect(last_request.uri.normalize.to_s).to eq(url)
      expect(last_request.body).to eq(JSON.dump(serialized_attrs))
    end

    it 'updates registrant with additional attributes' do
      attrs = JSON.load(fixtures.join('register.json').read)

      stub_request(:post, /.+/).to_return(
        body: JSON.dump(attrs),
        headers: {'Content-Type' => 'application/json'}
      )

      response, registrant = client.registrants(training).create({first_name: 'John'})

      expect(registrant.first_name).to eq('John')
      expect(registrant.join_url).to eq(attrs['joinUrl'])
      expect(registrant.confirmation_url).to eq(attrs['confirmationUrl'])
      expect(registrant.key).to eq(attrs['registrantKey'])
    end
  end

  describe '#all' do
    let(:client) { build_client }
    let(:training) { build_training }

    it 'performs request' do
      stub_request(:get, /.+/).to_return(
        body: '[]',
        headers: {'Content-Type' => 'application/json'}
      )

      url = url_for('organizers', client.credentials.organizer_key, 'trainings', training.key, 'registrants')
      client.registrants(training).all

      expect(last_request.method).to eq(:get)
      expect(last_request.uri.normalize.to_s).to eq(url)
    end

    it 'returns registrants' do
      stub_request(:get, /.+/).to_return(
        status: 200,
        body: fixtures.join('registrants.json').read,
        headers: {'Content-Type' => 'application/json'}
      )

      response, registrants = client.registrants(training).all

      expect(registrants.size).to eq(3)
      expect(registrants.first).to be_a(Citrix::Training::Resource::Registrant)
    end
  end

  describe '#remove' do
    let(:client) { build_client }
    let(:training) { build_training }
    let(:registrant) { build_registrant }

    it 'performs request' do
      stub_request(:delete, /.+/)

      url = url_for('organizers', client.credentials.organizer_key, 'trainings', training.key, 'registrants', registrant.key)
      client.registrants(training).remove(registrant)

      expect(last_request.method).to eq(:delete)
      expect(last_request.uri.normalize.to_s).to eq(url)
    end

    it 'returns response' do
      stub_request(:delete, /.+/)
      response = client.registrants(training).remove(registrant)

      expect(response).to be_a(Aitch::Response)
    end
  end
end
