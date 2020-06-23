class User < ActiveRecord::Base
  has_secure_password
  has_many :orders, dependent: :destroy
  validates :name, presence: true, length: { minimum: 4 }
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
  def self.owners_all
    where("role = ?", "owner")
  end
  def self.get_total(from_date, end_date)
    total_price = 0
    Order.all.confirmed_orders.where("date >= ? AND date <= ? ", from_date, end_date).each do |order|
      total_price = total_price + order.get_total_price
    end
    if total_price == 0
      total_price = 1
    end
    sum_hash = {}
    User.all.each do |user|
      sum_hash[user.id] = {}
      sum_hash[user.id][:total_price] = 0
      user.orders.confirmed_orders.where("date>=? AND date <=? ", from_date, end_date).each do |order|
        sum_hash[user.id][:total_price] = sum_hash[user.id][:total_price] + order.get_total_price
      end
      sum_hash[user.id][:percentage] = ((sum_hash[user.id][:total_price] * 100) / total_price)
    end
    sum_hash
  end
end
