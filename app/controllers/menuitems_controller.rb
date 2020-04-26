class MenuitemsController < ApplicationController
  def index
  end

  def create
    ensure_owner_logged_in
    menu = Menu.find(params[:id])
    new_menuitem = menu.menuitems.new(name: params[:name],
                                      price: params[:price],
                                      image_url: params[:image_url],
                                      description: params[:description])
    if new_menuitem.save
      flash[:success] = "#{params[:name]} added to #{menu.name} menu"
      if @menu == menu
        redirect_to menus_path
      else
        redirect_to menus_edit_path(menu_id: menu.id)
      end
    else
      flash[:error] = new_menuitem.errors.full_messages.join(", ")
      if @menu == menu
        redirect_to menus_path
      else
        redirect_to menus_edit_path(menu_id: menu.id)
      end
    end
  end

  def destroy
    ensure_owner_logged_in
    menuitem_id = params[:id]
    menuitem = Menuitem.find(menuitem_id)
    menu = menuitem.menu
    name = menuitem.name
    menuitem.destroy
    flash[:success] = "menuitem #{name} is deleted from menu #{@menu.name} successfully"
    if @menu == menu
      redirect_to menus_path
    else
      redirect_to menus_edit_path(menu_id: menu.id)
    end
  end
end
