module Citrix
  module Training
    module Serializer
      class TrainingDate
        include Helpers::Initializer

        # Set attributes.
        attr_accessor :attributes

        def serialize
          {
            startDate: attributes[:starts_at].iso8601,
            endDate: attributes[:ends_at].iso8601
          }
        end
      end
    end
  end
end
