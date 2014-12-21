module Citrix
  module Training
    module Serializer
      class Training
        include Helpers::Initializer

        # Set attributes that can be (de)serialized.
        attr_accessor :attributes

        def serialize
          {
            name: attributes[:name],
            description: attributes[:description],
            timeZone: attributes[:timezone],
            times: (attributes[:dates] || []).map(&:serialize),
            organizers: (attributes[:organizers] || []).map(&:key),
            registrationSettings: {
              disableWebRegistration: !attributes.fetch(:web_registration, true),
              disableConfirmationEmail: !attributes.fetch(:confirmation_email, true),
            }
          }
        end
      end
    end
  end
end
