class Token
  include Mongoid::Document
  attr_accessor :clear_token
  field :hashed_token, type: String
  field :name, type: String
  field :email, type: String
  field :hashed, type: Boolean, default: true
  field :legacy, type: Boolean

  before_create do
    self.clear_token = clear_token.blank? ? SecureRandom.hex : clear_token
    self.hashed_token = Digest::SHA512.hexdigest(clear_token.to_s) unless hashed_token
  end

  validates_presence_of :name, :email
  validates_uniqueness_of :hashed_token
end
