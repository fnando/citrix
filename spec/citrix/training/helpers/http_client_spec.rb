require 'spec_helper'

describe Citrix::Training::Helpers::HttpClient do
  let(:helper) { Object.new.extend(described_class) }

  describe '#json_parser' do
    it 'returns parser' do
      expect(helper.json_parser).to eq(helper.http_client.configuration.json_parser)
    end
  end

  describe '#url_for' do
    it 'returns url' do
      url = helper.url_for('trainings', 1234)
      expect(url).to eq(File.join(Citrix::Training::API_ENDPOINT, 'trainings', '1234'))
    end
  end

  describe '#http_client' do
    let(:config) { helper.http_client.configuration }

    it 'enabled debug mode' do
      $DEBUG = true
      expect(config.logger).to be_a(Logger)
    end

    it 'skips debug mode' do
      $DEBUG = false
      expect(config.logger).to be_falsy
    end

    it 'sets user agent' do
      expect(config.user_agent).to eq("Citrix::Rubygems/#{Citrix::VERSION}")
    end

    context 'default headers' do
      it 'sets content type' do
        expect(config.default_headers['Content-Type']).to eq('application/json')
      end

      it 'sets accept' do
        expect(config.default_headers['Accept']).to eq('application/json')
      end

      it 'sets authorization' do
        credentials = double(oauth_token: 'OAUTH_TOKEN')
        allow(helper).to receive(:credentials).and_return(credentials)
        auth_header = config.default_headers['Authorization'].call

        expect(auth_header).to eq('OAuth oauth_token=OAUTH_TOKEN')
      end
    end
  end
end
