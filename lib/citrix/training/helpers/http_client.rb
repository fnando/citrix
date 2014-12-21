module Citrix
  module Training
    module Helpers
      module HttpClient
        def json_parser
          http_client.configuration.json_parser
        end

        def url_for(*args)
          File.join(API_ENDPOINT, *args.map(&:to_s))
        end

        def http_client
          @http_client ||= Aitch::Namespace.new.tap do |ns|
            ns.configure do |config|
              if $DEBUG
                require 'logger'
                config.logger = Logger.new($stdout)
              end

              config.user_agent = "Citrix::Rubygems/#{Citrix::VERSION}"
              config.default_headers = {
                'Authorization' => -> { "OAuth oauth_token=#{credentials.oauth_token}" },
                'Accept' => 'application/json',
                'Content-Type' => 'application/json'
              }
            end
          end
        end
      end
    end
  end
end
