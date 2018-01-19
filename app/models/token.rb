class Token
  include Mongoid::Document
  attr_accessor :clear_id
  field :_id, type: String
  field :name, type: String
  field :email, type: String

  before_create do
    self.id = id.blank? ? SecureRandom.hex : id
    self.clear_id = id
    self.id = Digest::SHA512.hexdigest(id)
  end

  validates_presence_of :name, :email
  validates_uniqueness_of :id, :name
end
