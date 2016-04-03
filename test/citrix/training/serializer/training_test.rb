require "test_helper"

module TrainingTest
  class SerializerTest < Minitest::Test
    let(:serializer) { Citrix::Training::Serializer::Training }

    test "returns name" do
      assert_equal "NAME", serialize(name: "NAME")[:name]
    end

    test "returns description" do
      assert_equal "DESCRIPTION", serialize(description: "DESCRIPTION")[:description]
    end

    test "returns time zone" do
      assert_equal "TZ", serialize(timezone: "TZ")[:timeZone]
    end

    test "returns registration settings (web registration)" do
      params = serialize(web_registration: true)
      assert_equal false, params[:registrationSettings][:disableWebRegistration]
    end

    test "returns registration settings (confirmation email)" do
      params = serialize(confirmation_email: true)
      assert_equal false, params[:registrationSettings][:disableConfirmationEmail]
    end

    test "returns dates" do
      date = Citrix::Training::Resource::TrainingDate.new(Time.now, Time.now + 3600)
      params = serialize(dates: [date])

      assert_equal 1, params[:times].size
      assert_equal date.starts_at.iso8601, params[:times].first[:startDate]
      assert_equal date.ends_at.iso8601, params[:times].first[:endDate]
    end
  end

  class DeserializerTest < Minitest::Test
    let(:serializer) { Citrix::Training::Serializer::Training }
    let(:attrs) {
      JSON.load(fixtures.join("training.json").read)
    }

    test "returns name" do
      assert_equal attrs["name"], deserialize(attrs)[:name]
    end

    test "returns description" do
      assert_equal attrs["description"], deserialize(attrs)[:description]
    end

    test "returns time zone" do
      assert_equal attrs["timeZone"], deserialize(attrs)[:timezone]
    end

    test "returns key" do
      assert_equal attrs["trainingKey"], deserialize(attrs)[:key]
    end

    test "returns dates" do
      params = deserialize(attrs)

      starts_at = Time.parse(attrs["times"][0]["startDate"])
      ends_at = Time.parse(attrs["times"][0]["endDate"])

      assert_equal 1, params[:dates].size
      assert_equal starts_at.to_i, params[:dates].first.starts_at.to_i
      assert_equal ends_at.to_i, params[:dates].first.ends_at.to_i
    end

    test "returns web registration" do
      params = deserialize(attrs)
      assert_equal true, params[:web_registration]
    end

    test "returns confirmation e-mail" do
      params = deserialize(attrs)
      assert_equal true, params[:confirmation_email]
    end
  end
end
