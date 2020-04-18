class Order < ActiveRecord::Base
  has_many :orderitems
  belongs_to :user
  def self.not_delivered
    where(delivered_at: nil).order(id: :asc)
  end
  def self.delivered
    where.not(delivered_at: nil).order(id: :desc)
  end
  def self.today
    where("date = ?", Date.today)
  end
end
