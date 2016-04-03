require "test_helper"

class CredentialsTest < Minitest::Test
  test "initializes credentials" do
    credentials = Citrix::Training::Credentials.new(
      oauth_token: "OAUTH_TOKEN",
      organizer_key: "ORGANIZER_KEY",
      account_key: "ACCOUNT_KEY"
    )

    assert_equal "OAUTH_TOKEN", credentials.oauth_token
    assert_equal "ORGANIZER_KEY", credentials.organizer_key
    assert_equal "ACCOUNT_KEY", credentials.account_key
  end

  test "builds a new instance" do
    credentials = Citrix::Training::Credentials.build({})
    assert_kind_of Citrix::Training::Credentials, credentials
  end

  test "builds a new credentials instance" do
    credentials = Citrix::Training::Credentials.new
    new_credentials = Citrix::Training::Credentials.build(credentials)

    assert_equal credentials, new_credentials
  end
end
