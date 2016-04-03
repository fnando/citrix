require "test_helper"

module RegistrantsTest
  class NamespaceCreateTest < Minitest::Test
    let(:client) { build_client }
    let(:training) { build_training }
    let(:serializer) { Citrix::Training::Serializer::Registrant }

    test "performs request" do
      stub_request(:post, /.+/).to_return(
        body: "{}",
        headers: {"Content-Type" => "application/json"}
      )

      url = url_for("organizers", client.credentials.organizer_key, "trainings", training.key, "registrants")
      attrs = build_registrant_attributes
      serialized_attrs = serialize(attrs)
      client.registrants(training).create(attrs)

      assert_equal :post, last_request.method
      assert_equal url, last_request.uri.normalize.to_s
      assert_equal JSON.dump(serialized_attrs), last_request.body
    end

    test "updates registrant with additional attributes" do
      attrs = JSON.load(fixtures.join("register.json").read)

      stub_request(:post, /.+/).to_return(
        body: JSON.dump(attrs),
        headers: {"Content-Type" => "application/json"}
      )

      response, registrant = client.registrants(training).create({first_name: "John"})

      assert_equal "John", registrant.first_name
      assert_equal attrs["joinUrl"], registrant.join_url
      assert_equal attrs["confirmationUrl"], registrant.confirmation_url
      assert_equal attrs["registrantKey"], registrant.key
    end
  end

  class NamespaceAllTest < Minitest::Test
    let(:client) { build_client }
    let(:training) { build_training }

    test "performs request" do
      stub_request(:get, /.+/).to_return(
        body: "[]",
        headers: {"Content-Type" => "application/json"}
      )

      url = url_for("organizers", client.credentials.organizer_key, "trainings", training.key, "registrants")
      client.registrants(training).all

      assert_equal :get, last_request.method
      assert_equal url, last_request.uri.normalize.to_s
    end

    test "returns registrants" do
      stub_request(:get, /.+/).to_return(
        status: 200,
        body: fixtures.join("registrants.json").read,
        headers: {"Content-Type" => "application/json"}
      )

      response, registrants = client.registrants(training).all

      assert_equal 3, registrants.size
      assert_kind_of Citrix::Training::Resource::Registrant, registrants.first
    end
  end

  class NamespaceRemoveTest < Minitest::Test
    let(:client) { build_client }
    let(:training) { build_training }
    let(:registrant) { build_registrant }

    test "performs request" do
      stub_request(:delete, /.+/)

      url = url_for("organizers", client.credentials.organizer_key, "trainings", training.key, "registrants", registrant.key)
      client.registrants(training).remove(registrant)

      assert_equal :delete, last_request.method
      assert_equal url, last_request.uri.normalize.to_s
    end

    test "returns response" do
      stub_request(:delete, /.+/)
      response = client.registrants(training).remove(registrant)

      assert_kind_of Aitch::Response, response
    end
  end
end
