class OrderitemsController < ApplicationController
  def destroy
    orderitem = Orderitem.find(params[:id])
    order = orderitem.order
    orderitem.destroy
    redirect_to bill_path(id: order.id)
  end

  def create
    order = Order.find(params[:order_id])
    order.orderitems.create(menu_item_name: params[:menu_item_name],
                            menu_item_price: params[:menu_item_price],
                            menuitem_id: params[:menuitem_id])
    redirect_to bill_path(id: order.id)
  end
end
