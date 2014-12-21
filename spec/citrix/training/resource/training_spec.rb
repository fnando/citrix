require 'spec_helper'

describe Citrix::Training::Resource::Training do
  let(:attributes) {
    JSON.load(fixtures.join('training.json').read)
  }

  it 'loads all attributes' do
    described_class.new described_class.deserialize(attributes)
  end
end
