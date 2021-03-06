require 'rails_helper'
require 'digest'

RSpec.describe Token, type: :model do
  it "sets the _id if not provided" do
    token = Token.create!(name: 'test', email: 'test@test.test')

    expect(token.id).to be_present
  end

  describe "I have a token" do
    let(:id) { SecureRandom.hex }
    let(:token) { Token.create!(name: 'test', email: 'test@test.test',  clear_token: id) }

    it "keeps the id if provided" do
      token_hash = Digest::SHA512.hexdigest(id)
      expect(token.hashed_token).to eq(token_hash)
    end

    it "stores the SHA512 as token_hash if not hashed" do
      token = Token.create!(
        name: 'test',
        email: 'test@test.test',
        clear_token: id
      )
      token_hash = Digest::SHA512.hexdigest(id)
      expect(token.hashed_token).to eq(token_hash)
    end

    it "returns the id in clear" do
      expect(token.clear_token).to eq(id)
    end

    it "do not store the clear_id" do
      token
      token = Token.last
      expect(token.clear_token).to be_nil
    end
  end
end
