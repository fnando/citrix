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

        def deserialize
          {
            key: attributes['trainingKey'],
            name: attributes['name'],
            description: attributes['description'],
            timezone: attributes['timeZone'],
            dates: deserialize_dates(attributes['times'] || []),
            web_registration: !attributes['registrationSettings']['disableWebRegistration'],
            confirmation_email: !attributes['registrationSettings']['disableConfirmationEmail']
          }
        end

        private

        def deserialize_dates(dates)
          dates.map do |date|
            Resource::TrainingDate.new(
              Time.parse(date['startDate']),
              Time.parse(date['endDate'])
            )
          end
        end
      end
    end
  end
end
