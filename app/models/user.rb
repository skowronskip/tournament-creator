class User < ApplicationRecord
  #Validations
  validates_presence_of :login, :email, :password_digest
  validates :email, uniqueness: true
  has_many :tournaments

  #encrypt password
  has_secure_password
end
