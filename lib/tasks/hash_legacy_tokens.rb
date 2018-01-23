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
          'clear_token' => old_token['_id'],
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
      tag_old_tokens
    end

    private

    def tag_old_tokens
      old_tokens.map do |e|
        e.update_attribute(:hashed, true)
        e.update_attribute(:legacy, true)
      end
    end
  end
end
