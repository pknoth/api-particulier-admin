class Token
  include Mongoid::Document
  field :_id, type: String
  field :name, type: String
  field :email, type: String

  before_create do
    self.id = id.blank? ? SecureRandom.hex : id
  end

  validates_presence_of :name, :email
  validates_uniqueness_of :id
end
