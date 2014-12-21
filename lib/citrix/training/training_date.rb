module Citrix
  module Training
    class TrainingDate
      # The starting datetime.
      attr_reader :starts_at

      # The ending datetime.
      attr_reader :ends_at

      def initialize(starts_at, ends_at)
        @starts_at = starts_at
        @ends_at = ends_at
      end

      def serialize
        Serializer::TrainingDate.new(attributes: {
          starts_at: starts_at,
          ends_at: ends_at
        }).serialize
      end
    end
  end
end
