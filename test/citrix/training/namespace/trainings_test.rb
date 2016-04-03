require "test_helper"

module TrainingsTest
  class NamespaceCreateTest < Minitest::Test
    let(:client) { build_client }
    let(:serializer) { Citrix::Training::Serializer::Training }

    test "performs request" do
      stub_request(:post, /.+/)
        .to_return(body: "[]", headers: {"Content-Type" => "application/json"})

      url = url_for("organizers", client.credentials.organizer_key, "trainings")
      attrs = build_training_attributes
      serialized_attrs = serialize(attrs)
      client.trainings.create(attrs)

      assert_equal :post, last_request.method
      assert_equal url, last_request.uri.normalize.to_s
      assert_equal JSON.dump(serialized_attrs), last_request.body
    end

    test "returns response" do
      stub_request(:post, /.+/)
      response, training = client.trainings.create({})
      assert_kind_of Aitch::Response, response
    end

    test "returns training instance" do
      stub_request(:post, /.+/)
      response, training = client.trainings.create({})
      assert_kind_of Citrix::Training::Resource::Training, training
    end

    test "sets training key" do
      stub_request(:post, /.+/).to_return(body: %["1234"], status: 201)
      response, training = client.trainings.create({})
      assert_equal "1234", training.key
    end
  end

  class NamespaceAllTest < Minitest::Test
    let(:client) { build_client }

    test "performs request" do
      stub_request(:get, /.+/).to_return(body: "[]", headers: {"Content-Type" => "application/json"})

      url = url_for("organizers", client.credentials.organizer_key, "trainings")
      client.trainings.all

      assert_equal :get, last_request.method
      assert_equal url, last_request.uri.normalize.to_s
    end

    test "returns trainings" do
      stub_request(:get, /.+/)
        .to_return(status: 200, body: fixtures.join("trainings.json").read, headers: {"Content-Type" => "application/json"})

      response, trainings = client.trainings.all

      assert_equal 1, trainings.size
      assert_kind_of Citrix::Training::Resource::Training, trainings.first
    end
  end

  class NamespaceFindTest < Minitest::Test
    let(:client) { build_client }

    test "performs request" do
      stub_request(:get, /.+/)
        .to_return(status: 200, body: fixtures.join("training.json").read, headers: {"Content-Type" => "application/json"})
      client.trainings.find("1234")

      url = url_for("organizers", client.credentials.organizer_key, "trainings", "1234")

      assert_equal :get, last_request.method
      assert_equal url, last_request.uri.normalize.to_s
    end

    test "returns training" do
      stub_request(:get, /.+/)
        .to_return(status: 200, body: fixtures.join("training.json").read, headers: {"Content-Type" => "application/json"})

      response, training = client.trainings.find("1234")

      assert_kind_of Citrix::Training::Resource::Training, training
    end
  end

  class NamespaceRemoveTest < Minitest::Test
    let(:client) { build_client }

    test "performs request" do
      stub_request(:delete, /.+/)

      training = build_training
      url = url_for("organizers", client.credentials.organizer_key, "trainings", training.key)
      client.trainings.remove(training)

      assert_equal :delete, last_request.method
      assert_equal url, last_request.uri.normalize.to_s
    end

    test "returns response" do
      stub_request(:delete, /.+/)
      training = build_training
      response = client.trainings.remove(training)

      assert_kind_of Aitch::Response, response
    end
  end
end
