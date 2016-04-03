require "test_helper"

module RegistrantTest
  class SerializerTest < Minitest::Test
    let(:serializer) { Citrix::Training::Serializer::Registrant }

    test "returns first name" do
      assert_equal "NAME", serialize(first_name: "NAME")[:givenName]
    end

    test "returns last name" do
      assert_equal "NAME", serialize(last_name: "NAME")[:surname]
    end

    test "returns email" do
      assert_equal "EMAIL", serialize(email: "EMAIL")[:email]
    end
  end

  class DeserializerTest < Minitest::Test
    let(:serializer) { Citrix::Training::Serializer::Registrant }
    let(:raw_attrs) { JSON.load(fixtures.join("registrant.json").read) }
    let(:attrs) { deserialize(raw_attrs) }

    test "returns first name" do
      assert_equal raw_attrs["givenName"], attrs[:first_name]
    end

    test "returns last name" do
      assert_equal raw_attrs["surname"], attrs[:last_name]
    end

    test "returns email" do
      assert_equal raw_attrs["email"], attrs[:email]
    end

    test "returns join url" do
      assert_equal raw_attrs["joinUrl"], attrs[:join_url]
    end

    test "returns confirmation url" do
      assert_equal raw_attrs["confirmationUrl"], attrs[:confirmation_url]
    end

    test "returns registrant key" do
      assert_equal raw_attrs["registrantKey"], attrs[:key]
    end

    test "returns status" do
      assert_equal raw_attrs["status"].downcase, attrs[:status]
    end
  end
end
