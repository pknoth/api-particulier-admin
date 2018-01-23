require 'rails_helper'

RSpec.describe Logstash do
  it "should initialize" do
    expect(described_class.new).to be_instance_of(Logstash)
  end
end
