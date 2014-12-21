module Citrix
  module Training
    module Namespace
      class Registrants
        include Helpers::Initializer
        include Helpers::HttpClient

        # Set the credentials.
        attr_accessor :credentials

        # Set the training.
        attr_accessor :training

        # Register one person, identified by a unique email address, for a training.
        #
        # Approval is automatic unless payment or approval is required. The
        # response contains the Confirmation page URL and Join URL for the
        # registrant.
        #
        # NOTE: If some registrants do not receive a confirmation email, the
        # emails could be getting blocked by their email server due to spam
        # filtering or a grey-listing setting.
        #
        #   response, registrant = client.registrants.create(training, {
        #     first_name: 'John',
        #     last_name: 'Doe',
        #     email: 'john@example.com'
        #   })
        #
        #   if response.ok?
        #     # Do something with registrant
        #   end
        #
        # Options:
        #
        # - `first_name`: First name of user. Required.
        # - `last_name`: Last name of user. Required.
        # - `email`: Email of registrant. Required.
        #
        # Endpoint: https://developer.citrixonline.com/api/gototraining-rest-api/apimethod/register-training-0
        #
        def create(attributes)
          registrant = Resource::Registrant.new(attributes)

          url = url_for('organizers', credentials.organizer_key, 'trainings', training.key, 'registrants')
          response = http_client.post(url, registrant.serialize)

          if response.ok?
            additional_attributes = Serializer::Registrant.new(attributes: response.json).deserialize
            additional_attributes.each do |key, value|
              registrant.public_send("#{key}=", value) if value
            end
          end

          [response, registrant]
        end

        # Retrieve details on all registrants for a specific training.
        #
        # Registrants can be:
        #
        # - UNREGISTERED: registrant withdrew their registration but didn't
        #   opt-out of receiving more training or webinar information
        # - DELETED: registrant withdrew their registration and opted-out of
        #   receiving more information about the training or webinar
        # - WAITING: registrant registered and is awaiting approval (where
        #   organizer has required approval)
        # - APPROVED: registrant registered and is approved
        # - DENIED - registrant registered and was not approved.
        #
        # IMPORTANT: The registrant data caches are typically updated
        # immediately and the data will be returned in the response. However,
        # the update can take as long as two hours.
        #
        # Endpoint: https://developer.citrixonline.com/api/gototraining-rest-api/apimethod/get-training-registrants-0
        #
        def all
          url = url_for('organizers', credentials.organizer_key, 'trainings', training.key, 'registrants')
          response = http_client.get(url)

          if response.ok?
            registrants = response.json.map do |attrs|
              Resource::Registrant.deserialize(attrs)
            end
          end

          [response, registrants]
        end
      end
    end
  end
end
