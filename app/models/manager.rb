class Manager
  include ActiveModel::SecurePassword
  include Mongoid::Document
  field :name, type: String
  field :password_digest, type: String

  validates_uniqueness_of :name

  has_secure_password
end
