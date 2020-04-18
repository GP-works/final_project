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
    Order.create!(date: Date.now)
    redirect_to menuitems_path
  end

  def update
    order = Order.find(params[:id])
    order.delivered_at = (order.delivered_at == nil) ? DateTime.now : nil
    order.save
    redirect_to orders_path
  end
end
