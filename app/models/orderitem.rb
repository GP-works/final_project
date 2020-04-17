class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :menuitem

  def create_orderitem(orderitem_details)
    Orderitem.create!(
      menu_item_name: orderitem_details[:name],
      menu_item_price: orderitem_details[:price],
      order_id: orderitem_details[:orderid],
      menuitem_id: orderitem_details[:menuitemid],
    )
  end
end
