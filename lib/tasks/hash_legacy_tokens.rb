module Tasks
  class HashLegacyTokens
    attr_reader :hashed_tokens, :old_tokens
    def initialize(tokens)
      @hashed_tokens = tokens.select(&:hashed)
      @old_tokens =  tokens.reject(&:hashed)
    end

    def hashed_old_tokens
      res = []
      old_tokens.each do |old_token|
        res << {
            'hashed_token' => Digest::SHA512.hexdigest(old_token['_id'].to_s),
            'name' => old_token['name'],
            'email' => old_token['email'],
            'hashed' => true
          }
      end
      res
    end

    def duplicate_old_tokens
      hashed_old_tokens.map do |token|
        Token.create!(token)
      end
      tag_legacy
    end

    private

    def tag_legacy
      old_tokens.map { |e| e.update_attribute(:hashed, true) }
    end
  end
end
