module Citrix
  module Training
    module Resource
      class Training
        include Helpers::Initializer

        # Set the name of the training.
        attr_accessor :name

        # Set the description of the training.
        attr_accessor :description

        # Set the timezone.
        attr_accessor :timezone

        # Set the dates.
        attr_accessor :dates

        # Set the organizers.
        attr_accessor :organizers

        # Set confirmation e-mail delivery.
        attr_accessor :confirmation_email

        # Set web registration.
        attr_accessor :web_registration

        # Set the training key.
        attr_accessor :key

        ATTRIBUTES = %i[
          name
          description
          timezone
          web_registration
          confirmation_email
          organizers
          dates
        ]

        # Convert `attributes` into parameters that
        # Citrix API can understand.
        def self.serialize(attributes)
          Serializer::Training.new(attributes: attributes).serialize
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
