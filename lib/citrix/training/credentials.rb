module Citrix
  module Training
    class Credentials
      include Helpers::Initializer

      # Set the OAuth token.
      # You can use the [Omniauth::Citrix](http://github.com/fnando/omniauth-citrix)
      # for OAuth2 authentication on Rack-based applications.
      attr_accessor :oauth_token

      # Set the organizer key.
      attr_accessor :organizer_key

      # Set the account key.
      attr_accessor :account_key
    end
  end
end
