module Citrix
  module Training
    class Client
      include Helpers::Initializer

      # Set credentials.
      attr_accessor :credentials

      # Initialize a client with provided credentials.
      # The credentials must be a instance of or
      # a Hash accepted by `Citrix::Training::Credentials`.
      #
      #   client = Citrix::Training::Client.build(
      #     oauth_token: ENV.fetch('CITRIX_OAUTH_TOKEN'),
      #     organizer_key: ENV.fetch('CITRIX_ORGANIZER_KEY'),
      #     account_key: ENV.fetch('CITRIX_ACCOUNT_KEY')
      #   )
      #
      def self.build(credentials)
        new(credentials: Credentials.build(credentials))
      end
    end
  end
end
