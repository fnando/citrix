require "test_helper"

module RegistrantTest
  class ResourceTest < Minitest::Test
    let(:attributes) {
      JSON.load(fixtures.join("registrant.json").read)
    }

    test "loads all attributes" do
      resource = Citrix::Training::Resource::Registrant.new(
        Citrix::Training::Resource::Registrant.deserialize(attributes)
      )

      assert_equal "Charley", resource.first_name
      assert_equal "Waters", resource.last_name
      assert_equal "c.waters@test.com", resource.email
      assert_equal "https://global.gototraining.com/join/training/3480581380460709633/107445004", resource.join_url
      assert_equal "https://attendee.gototraining.com/registration/confirmation.tmpl?registrant=5646167387902096129&training=3480581380460709633", resource.confirmation_url
      assert_equal "5646167387902096129", resource.key
      assert_equal "approved", resource.status
    end
  end
end
