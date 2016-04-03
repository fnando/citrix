require "test_helper"

class HttpClientTest < Minitest::Test
  let(:helper) { Object.new.extend(Citrix::Training::Helpers::HttpClient) }
  let(:config) { helper.http_client.configuration }

  test "returns json parser" do
    assert_equal Aitch::ResponseParser::JSONParser.engine, helper.json_parser
  end

  test "returns url" do
    url = helper.url_for("trainings", 1234)
    assert_equal File.join(Citrix::Training::API_ENDPOINT, "trainings", "1234"), url
  end

  test "enabled debug mode" do
    $DEBUG = true
    assert_kind_of Logger, config.logger
  end

  test "skips debug mode" do
    $DEBUG = false
    refute config.logger
  end

  test "sets user agent" do
    assert_equal "Citrix::Rubygems/#{Citrix::VERSION}", config.user_agent
  end

  test "sets content type" do
    assert_equal "application/json", config.default_headers["Content-Type"]
  end

  test "sets accept" do
    assert_equal "application/json", config.default_headers["Accept"]
  end

  test "sets authorization" do
    credentials = mock(oauth_token: "OAUTH_TOKEN")
    helper.expects(:credentials).returns(credentials)
    auth_header = config.default_headers["Authorization"].call

    assert_equal "OAuth oauth_token=OAUTH_TOKEN", auth_header
  end
end
