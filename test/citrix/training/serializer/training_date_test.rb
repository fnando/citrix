require "test_helper"

class SerializerTrainingDateTest < Minitest::Test
  let(:serializer) { Citrix::Training::Serializer::TrainingDate }

  test "returns starting date" do
    starting = Time.now
    ending = starting + 3600
    params = serialize(starts_at: starting, ends_at: ending)

    assert_equal starting.iso8601, params[:startDate]
  end

  test "returns ending date" do
    starting = Time.now
    ending = starting + 3600
    params = serialize(starts_at: starting, ends_at: ending)

    assert_equal ending.iso8601, params[:endDate]
  end
end
