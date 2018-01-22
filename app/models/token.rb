class Token
  include Mongoid::Document
  attr_accessor :clear_token
  field :hashed_token, type: String
  field :name, type: String
  field :email, type: String
  field :hashed, type: Boolean, default: true

  before_validation :create_hashed_token, on: :create

  def create_hashed_token
    self.hashed_token = hashed_token.blank? ? SecureRandom.hex : hashed_token
    self.clear_token = hashed_token
    self.hashed_token = Digest::SHA512.hexdigest(hashed_token)
  end

  validates_presence_of :name, :email
  validates_uniqueness_of :hashed_token
end
