module Citrix
  module Training
    module Namespace
      class Trainings
        include Helpers::Initializer
        include Helpers::HttpClient

        # Set the credentials.
        attr_accessor :credentials

        # Create a new training.
        #
        #   response, training = client.trainings.create({
        #     name: 'Ruby on Rails',
        #     description: 'Getting started with Ruby on Rails',
        #     timezone: 'America/Sao_Paulo',
        #     dates: [date],
        #     web_registration: false,
        #     confirmation_email: false,
        #     organizers: [organizer]
        #   })
        #
        #   if response.ok?
        #   else
        #   end
        #
        # Options:
        #
        # - `name`: Name of the training. Required.
        # - `description`: Description of the training. Required.
        # - `timezone`: Time zone of the training. Required.
        # - `dates`: Array containing instances of `Citrix::Training::TrainingDate`. Required.
        # - `organizers`: Array containing instances of `Citrix::Training::Organizer`. Optional.
        # - `web_registration`: Disable/Enable web registration. Optional.
        # - `confirmation_email`: Disable/Enable confirmation e-mails. Optional.
        #
        # Endpoint: https://developer.citrixonline.com/api/gototraining-rest-api/apimethod/create-training-0
        #
        def create(attributes)
          training = Resource::Training.new(attributes)

          url = File.join(API_ENDPOINT, 'organizers', credentials.organizer_key, 'trainings')
          response = http_client.post(url, training.serialize)

          training.key = json_parser.load(response.body) if response.ok?

          [response, training]
        end

        # Retrieve information on all scheduled trainings for a given organizer.
        #
        # The trainings are returned in the order in which they were created.
        # Completed trainings are not included; ongoing trainings with past
        # sessions are included along with the past sessions. If the organizer
        # does not have any scheduled trainings, the response will be empty.
        #
        # Endpoint: https://developer.citrixonline.com/api/gototraining-rest-api/apimethod/get-trainings
        #
        def all
          url = File.join(API_ENDPOINT, 'organizers', credentials.organizer_key, 'trainings')
          response = http_client.get(url)

          if response.ok?
            trainings = response.json.map do |attrs|
              Resource::Training.deserialize(attrs)
            end
          end

          [response, trainings]
        end
      end
    end
  end
end
