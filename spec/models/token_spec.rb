require 'rails_helper'

RSpec.describe Token, type: :model do
  it "sets the _id if not provided" do
    token = Token.create!(name: 'test', email: 'test@test.test')
    expect(token.id).to be_present
  end

  it "keeps the id if provided" do
    id = SecureRandom.hex
    token = Token.create!(name: 'test', email: 'test@test.test', id: id)

    expect(token.id).to eq(id)
  end
end
