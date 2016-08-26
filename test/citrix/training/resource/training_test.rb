require "test_helper"

module TrainingTest
  class ResourceTest < Minitest::Test
    let(:attributes) {
      JSON.parse(fixtures.join("training.json").read)
    }

    test "loads all attributes" do
      resource = Citrix::Training::Resource::Training.new(
        Citrix::Training::Resource::Training.deserialize(attributes)
      )

      assert_equal "Intro to HTML, CSS and JavaScript", resource.name
      assert_equal "Create basic webpages and sites using HTML 5, CSS3 and basic JavaScript.", resource.description
      assert_equal "America/New_York", resource.timezone
      assert_equal "8178251407424893697", resource.key
      assert resource.confirmation_email
      assert resource.web_registration
      assert_equal 1, resource.dates.size
      assert_equal "2014-03-26T15:00:00Z", resource.dates.first.starts_at.iso8601
      assert_equal "2014-03-26T23:00:00Z", resource.dates.first.ends_at.iso8601
    end
  end
end
