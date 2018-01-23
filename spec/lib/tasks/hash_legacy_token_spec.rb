require 'rails_helper'

RSpec.describe Tasks::HashLegacyTokens do
  describe 'I have some tokens' do
    let(:old_tokens) { FactoryGirl.create_list(:token, 9, *Array.new(8, :old)) }
    let(:hashed_tokens) { FactoryGirl.create_list(:token, 8, *Array.new(8, :legacy)) }
    let(:tokens) { hashed_tokens.dup.concat(old_tokens) }

    it 'initialize with some tokens' do
      described_class.new(tokens)
    end

    describe 'I have a hasher' do
      let(:hasher) { described_class.new(tokens) }

      it 'has legacy tokens' do
        expect(hasher.hashed_tokens).to eq(hashed_tokens)
      end

      it 'has old tokens' do
        expect(hasher.old_tokens).to eq(old_tokens)
      end

      it 'should hash tokens' do
        hasher = described_class.new(tokens)
        hashed_tokens = old_tokens.map do |token|
          token.attributes.dup.tap do |token|
            token['clear_token'] = token['_id']
            token['hashed_token'] = Digest::SHA512.hexdigest(token['_id'].to_s)
            token.delete('_id')
            token['hashed'] = true
          end
        end
        expect(hasher.hashed_old_tokens).to eq(hashed_tokens)
      end

      it 'should duplicate tokens' do
        hasher = described_class.new(tokens)
        old_tokens_count = hasher.old_tokens.count
        expect do
          hasher.duplicate_old_tokens
        end.to change { Token.count }.by old_tokens_count
      end

      it 'should mark old tokens as hashed' do
        hasher = described_class.new(tokens)

        hasher.duplicate_old_tokens

        expect(old_tokens.map(&:reload).map(&:hashed)).to all(be_present)
      end

      it 'should be idempotent' do
        hasher = described_class.new(tokens)
        hasher.duplicate_old_tokens
        tokens = Token.all

        new_hasher = described_class.new(tokens)
        new_hasher.duplicate_old_tokens

        expect(Token.all).to eq(tokens)
      end

      it 'should have all token to hashed to true' do
        hasher = described_class.new(tokens)

        hasher.duplicate_old_tokens

        expect(Token.all).to all(be_hashed)
      end
    end
  end
end
