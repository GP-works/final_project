class Order < ActiveRecord::Base
  has_many :orderitems, dependent: :destroy
  belongs_to :user

  def self.not_delivered
    where(delivered_at: nil).order(id: :asc)
  end

  def not_delivered
    delivered_at == nil
  end

  def self.delivered
    where.not(delivered_at: nil).order(delivered_at: :desc)
  end

  def self.today
    where("date = ?", Date.today)
  end

  def get_total_price
    price = 0
    orderitems_array = self.orderitems.getqty
    orderitems_array.each do |name, quantity|
      order_item = self.orderitems.find_by("menu_item_name = ?", name)
      price = price + quantity * order_item.menu_item_price
    end
    price
  end

  def self.cart_order
    order = find_by("status = ?", "cart")
    if order == nil
      order = create!(date: DateTime.now, status: "cart")
    end
    order
  end

  def self.confirmed_orders
    where("ordered = ?", true)
  end

  def self.get_orders(from_date, to_date)
    all.where("date >= ? AND date <= ? ", from_date, to_date)
  end
end
