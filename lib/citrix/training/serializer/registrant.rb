module Citrix
  module Training
    module Serializer
      class Registrant
        include Helpers::Initializer

        # Set attributes that can be (de)serialized.
        attr_accessor :attributes

        def serialize
          {
            givenName: attributes[:first_name],
            surname: attributes[:last_name],
            email: attributes[:email]
          }
        end

        def deserialize
          {
            first_name: attributes["givenName"],
            last_name: attributes["surname"],
            email: attributes["email"],
            join_url: attributes["joinUrl"],
            confirmation_url: attributes["confirmationUrl"],
            key: attributes["registrantKey"],
            status: attributes["status"] ? attributes["status"].downcase : nil
          }
        end
      end
    end
  end
end
