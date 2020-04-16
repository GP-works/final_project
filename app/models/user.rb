class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  validates :name, presence: true
  validates :email, presence: true
end
