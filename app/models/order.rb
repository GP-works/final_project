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

  def get_total_price
    price = 0
    orderitems = self.orderitems.getqty
    orderitems.each do |name, quantity|
      order_item = Orderitem.find_by(menu_item_name: name)
      price = price + quantity * order_item.menu_item_price
    end
    price
  end
end
