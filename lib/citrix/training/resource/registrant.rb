module Citrix
  module Training
    module Resource
      class Registrant
        include Helpers::Initializer

        # Set the first name of the user.
        attr_accessor :first_name

        # Set the last name of the user.
        attr_accessor :last_name

        # Set the e-mail.
        attr_accessor :email

        # Set the join url.
        attr_accessor :join_url

        # Set the confirmation url.
        attr_accessor :confirmation_url

        # Set the registrant key.
        attr_accessor :key

        # Set the status.
        attr_accessor :status

        ATTRIBUTES = %i[
          first_name
          last_name
          email
        ]

        # Convert `attributes` into parameters that
        # Citrix API can understand.
        def self.serialize(attributes)
          Serializer::Registrant.new(attributes: attributes).serialize
        end

        # Convert `attributes` into parameters that
        # Citrix::Training::Resource::Registrant can understand.
        def self.deserialize(attributes)
          Serializer::Registrant.new(attributes: attributes).deserialize
        end

        # Return a hash containing all attributes.
        def attributes
          ATTRIBUTES.each_with_object({}) do |name, buffer|
            buffer[name] = public_send(name)
          end
        end

        # Serialize the attributes.
        def serialize
          self.class.serialize(attributes)
        end
      end
    end
  end
end
