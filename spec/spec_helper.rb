require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'bundler/setup'
require 'citrix'
require 'webmock/rspec'
require 'ostruct'

WebMock.disable_net_connect!(allow: %w{codeclimate.com})

def WebMock.requests
  @requests ||= []
end

WebMock.after_request do |request, response|
  WebMock.requests << request
end

RSpec.configure do |config|
  config.before do
    WebMock.requests.clear
    $DEBUG = false
  end

  config.include Module.new {
    def serialize(attributes, serializer = described_class)
      serializer.new(attributes: attributes).serialize
    end

    def build_credentials(credentials = {})
      Citrix::Training::Credentials.build({
        oauth_token: credentials.fetch(:oauth_token, 'OAUTH_TOKEN'),
        organizer_key: credentials.fetch(:organizer_key, 'ORGANIZER_KEY'),
        account_key: credentials.fetch(:account_key, 'ACCOUNT_KEY')
      })
    end

    def build_client(credentials = {})
      Citrix::Training::Client.build(build_credentials(credentials))
    end

    def build_training_attributes(attributes = {})
      {
        name: 'NAME',
        description: 'DESCRIPTION',
        timezone: 'TIMEZONE',
        web_registration: false,
        confirmation_email: false,
        organizers: [],
        dates: [build_date]
      }.merge(attributes)
    end

    def build_date(starts_at = Time.now, ends_at = starts_at + 3600)
      Citrix::Training::TrainingDate.new(starts_at, ends_at)
    end

    def url_for(*args)
      File.join(Citrix::Training::API_ENDPOINT, *args)
    end

    def last_request
      WebMock.requests.last
    end
  }
end
