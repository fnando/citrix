require 'spec_helper'

describe Citrix::Training::Helpers::Initializer do
  it 'assigns properties' do
    klass = Class.new do
      include Citrix::Training::Helpers::Initializer
      attr_accessor :name, :email
    end

    instance = klass.new(name: 'John', email: 'john@example.com')

    expect(instance.name).to eq('John')
    expect(instance.email).to eq('john@example.com')
  end
end
