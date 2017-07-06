require 'rails_helper'

RSpec.describe Logstash do
  it "should initialize" do
    expect(described_class.new).to be_instance_of(Logstash)
  end

  it "returns a number for count" do
    expect(Logstash.new.count_by_name('test')).to be_kind_of(Fixnum)
  end
end
