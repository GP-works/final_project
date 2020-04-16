class OrdersController < ApplicationController
  def index
    render plain: current_user.orders
  end

  def create
    Order.create!(date: Date.now)
    redirect_to menuitems_path
  end

  def update
    order = Order.find(id: params[:id])
    order.delivered_at = Time.now
  end
end