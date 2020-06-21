class User < ActiveRecord::Base
  has_secure_password
  has_many :orders, dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

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
  def self.owners(user_id)
    where("role = ? and id != ?", "owner", user_id)
  end
end
