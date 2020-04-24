class MenuitemsController < ApplicationController
  def index
  end

  def create
    ensure_owner_logged_in
    new_menuitem = @menu.menuitems.new(name: params[:name],
                                       price: params[:price],
                                       image_url: params[:image_url],
                                       description: params[:description])
    if new_menuitem.save
      redirect_to menus_path
    else
      flash[:error] = new_menuitem.errors.full_messages.join(", ")
      redirect_to menus_path
    end
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
