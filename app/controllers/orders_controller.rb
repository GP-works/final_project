require "date"

class OrdersController < ApplicationController
  def index
    render plain: @menu.id
  end

  def create
    new_order = Order.create!(date: DateTime.now, user_id: current_user.id)
    @menu.menuitems.each do |menuitem|
      q = params[menuitem.id].to_i
      if q != 0
        for quantity in 0..q
          new_order.orderitems.create!(menu_item_name: menuitem.name,
                                       menu_item_price: menuitem.price,
                                       menuitem_id: menuitem.id)
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
