class MenuitemsController < ApplicationController
  def index
  end

  def create
    ensure_owner_logged_in
    @menu.menuitems.create!(name: params[:name], price: params[:price])
    redirect_to menus_path
  end

  def destroy
    ensure_owner_logged_in
    menuitem_id = params[:id]
    menuitem = Menuitem.find(menuitem_id)
    name = menuitem.name
    menuitem.destroy
    flash[:success] = "menuitem #{name} is deleted from menu #{@menu.name} successfully"
    redirect_to menus_path
  end
end
