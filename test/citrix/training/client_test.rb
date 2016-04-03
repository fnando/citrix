require "test_helper"

class ClientTest < Minitest::Test
  test "returns client" do
    client = Citrix::Training::Client.build({})
    assert_kind_of Citrix::Training::Client, client
  end

  test "sets credentials" do
    client = Citrix::Training::Client.build({})
    assert_kind_of Citrix::Training::Credentials, client.credentials
  end

  test "returns namespace" do
    client = Citrix::Training::Client.build({})
    assert_kind_of Citrix::Training::Namespace::Trainings, client.trainings
  end
end
