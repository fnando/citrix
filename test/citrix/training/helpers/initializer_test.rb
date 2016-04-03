require "test_helper"

class InitializerTest < Minitest::Test
  test "assigns properties" do
    klass = Class.new do
      include Citrix::Training::Helpers::Initializer
      attr_accessor :name, :email
    end

    instance = klass.new(name: "John", email: "john@example.com")

    assert_equal "John", instance.name
    assert_equal "john@example.com", instance.email
  end
end
