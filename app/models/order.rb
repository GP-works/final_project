class Order < ActiveRecord::Base
  has_many :orderitems
  belongs_to :user

  def self.get_total_price
    price = 0
    orderitems = order.orderitems.getqty
    orderitems.each do |name, quantity|
      order_item = Orderitem.find_by(menu_item_name: name)
      price = price + quantity * order_item.menu_item_price
    end
    price
  end
end
