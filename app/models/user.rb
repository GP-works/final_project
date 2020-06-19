class User < ActiveRecord::Base
  has_secure_password
  has_many :orders, dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true

  def self.customers
    where("role = ?", "customer")
  end
  def self.clerks
    where("role = ?", "billclerk")
  end
end
