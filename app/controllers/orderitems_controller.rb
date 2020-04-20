class OrderitemsController < ApplicationController
  def destroy
    orderitem = Orderitem.find(params[:id])
    order = orderitem.order
    orderitem.destroy
    params.delete(:id)
    redirect_to bill_path(id: order.id)
  end

  def create
    order = Order.find(params[:order_id])
    menuitem = Menuitem.find(params[:menuitem_id])
    order.orderitems.create(menu_item_name: menuitem.name,
                            menu_item_price: menuitem.price,
                            menuitem_id: menuitem.id)
    params.delete(:order_id)
    params.delete(:menuitem_id)
    redirect_to bill_path(id: order.id)
  end
end
