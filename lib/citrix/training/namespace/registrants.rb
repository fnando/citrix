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
        #   response, registrant = client.registrants(training).create({
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
              Resource::Registrant.new Resource::Registrant.deserialize(attrs)
            end
          end

          [response, registrants]
        end

        # This call cancels a registration in a scheduled training for a
        # specific registrant.
        #
        # If the registrant has paid for the training, a cancellation cannot be
        # completed with this method; it must be completed on the Citrix
        # external admin site. No notification is sent to the registrant or
        # the organizer by default. The registrant can re-register if needed.
        #
        # Endpoint: https://developer.citrixonline.com/api/gototraining-rest-api/apimethod/cancel-registration-0
        #
        def remove(registrant)
          url = url_for('organizers', credentials.organizer_key, 'trainings', training.key, 'registrants', registrant.key)
          http_client.delete(url)
        end
      end
    end
  end
end
