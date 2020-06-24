class OrderitemsController < ApplicationController
  def destroy
    orderitem = Orderitem.find(params[:id])
    order = orderitem.order
    orderitem.destroy
    if params[:from] == "cart"
      redirect_to cart_path(id: order.id)
    else
      redirect_to menuitems_path
    end
  end

  def create
    order = current_user.orders.cart_order
    order.orderitems.create!(menu_item_name: params[:menu_item_name],
                             menu_item_price: params[:menu_item_price],
                             menuitem_id: params[:menuitem_id])
    if params[:from] == "cart"
      redirect_to cart_path(id: order.id)
    else
      flash[:success] = "#{params[:menu_item_name].capitalize} is added to cart successfully"
      redirect_to menuitems_path
    end
  end
end
