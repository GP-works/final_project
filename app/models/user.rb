class User < ActiveRecord::Base
  has_secure_password
  has_many :orders, dependent: :destroy
  validates :name, presence: true, length: { minimum: 4 }
  validates :email, presence: true, uniqueness: true
  validates :password, length: { in: 6..20 }

  def self.customers
    where("role = ?", "customer")
  end
  def self.admin_requests
    where("request_status = ? ", "owner")
  end
  def self.clerk_requests
    where("request_status = ? ", "billclerk")
  end
  def self.clerks
    where("role = ?", "billclerk")
  end
end
