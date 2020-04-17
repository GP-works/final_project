require "date"

class OrdersController < ApplicationController
  def index
    render plain: @menu.id
  end

  def create
    new_order = Order.create!(date: DateTime.now, user_id: current_user.id)
    @menu.menuitems.each do |menuitem|
      if params[menuitem.id] != 0
        orderitem_details = {
          name: menuitem.name,
          price: menuitem.price,
          menuitemid: menuitem.id,
          orderid: new_order.id,
        }
        for quantity in 0..params[menuitem.id]
          # new_order.orderitems.create!(menu_item_name: menuitem.name,
          #                             menu_item_price: menuitem.price,
          #                            menuitem_id: menuitem.id)
          Orderitem.create_orderitem(orderitem_details)
        end
      end
    end

    redirect_to menuitems_path
  end

  def update
    order = Order.find(id: params[:id])
    order.delivered_at = DateTime.now
  end
end
