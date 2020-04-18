require "date"

class OrdersController < ApplicationController
  def index
    if current_user.role == "customer"
      render :index, locals: { orders: current_user.orders,
                               hidden_status: "hidden" }
    else
      render :index, locals: { orders: Order.all,
                               hidden_status: nil }
    end
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
    order = Order.find(params[:id])
    order.delivered_at = (order.delivered_at == nil) ? DateTime.now : nil
    order.save
    redirect_to orders_path
  end
end
