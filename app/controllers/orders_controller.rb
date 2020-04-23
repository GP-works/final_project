class OrdersController < ApplicationController
  def index
    if current_user.role == "customer"
      render :index, locals: { all_orders: current_user.orders.all.confirmed_orders,
                               hidden_status: true,
                               second_title: "Previous orders" }
    else
      render :index, locals: { all_orders: Order.all.confirmed_orders,
                               hidden_status: false,
                               second_title: "Orders delivered today" }
    end
  end

  def pay
    order = Order.find(params[:id])
    order.ordered = true
    order.status = "ordered"
    order.save
    redirect_to orders_path
  end

  def cart
    render :cart
  end

  def update
    ensure_ownerorclerk_logged_in
    order = Order.find(params[:id])
    order.delivered_at = (order.delivered_at == nil) ? DateTime.now : nil
    order.save
    redirect_to orders_path
  end

  def destroy
    order = current_user.orders.find(params[:id])
    order.destroy
    params.delete(:id)
    redirect_to action: "index"
  end
end
