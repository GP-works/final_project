class OrdersController < ApplicationController
  def index
    if current_user.role == "customer"
      render :index, locals: { all_orders: current_user.orders.all,
                               hidden_status: true,
                               second_title: "Previous orders" }
    else
      render :index, locals: { all_orders: Order.all.today,
                               hidden_status: false,
                               second_title: "Orders delivered today" }
    end
  end

  def create
    @new_order = Order.create!(date: DateTime.now, user_id: current_user.id)
    @menu.menuitems.each do |menuitem|
      quantity = params[menuitem.id.to_s.to_sym].to_i
      if quantity != 0
        for _ in 1..quantity
          @new_order.orderitems.create!(menu_item_name: menuitem.name,
                                        menu_item_price: menuitem.price,
                                        menuitem_id: menuitem.id)
        end
      end
    end
    redirect_to bill_path
  end

  def bill
    render :bill
  end

  def update
    order = Order.find(params[:id])
    order.delivered_at = (order.delivered_at == nil) ? DateTime.now : nil
    order.save
    redirect_to orders_path
  end
end
