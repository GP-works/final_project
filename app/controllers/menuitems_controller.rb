class MenuitemsController < ApplicationController
  def index
  end

  def create
    ensure_owner_logged_in
    menu = Menu.find(params[:id])
    new_menuitem = menu.menuitems.new(name: params[:name],
                                      price: params[:price],
                                      image_url: params[:image_url],
                                      description: params[:description],
                                      submenu_id: params[:submenu_id])
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

  def new
    submenu = Submenu.find(params[:submenu_id])
    render :new, locals: { menu: submenu.menu, submenu: submenu }
  end

  def edit
    menuitem = Menuitem.find(params[:id])
    render :edit, locals: { menuitem: menuitem }
  end

  def update
    menuitem = Menuitem.find(params[:id])
    menuitem.name = params[:name].presence || menuitem.name
    menuitem.price = params[:price].presence || menuitem.price
    menuitem.image_url = params[:image_url].presence || menuitem.image_url
    menuitem.description = params[:description].presence || menuitem.description
    menuitem.save
    if @menu == menuitem.menu
      redirect_to menus_path
    else
      redirect_to menus_edit_path(menu_id: menuitem.menu.id)
    end
  end

  def available
    menuitem = Menuitem.find(params[:id])
    menuitem.available = params[:available]
    menuitem.save
    menuitem_status = menuitem.available ? "marked available" : "marked not available"
    flash[:success] = "Menuitem #{menuitem.name} is #{menuitem_status}"
    if @menu == menuitem.menu
      redirect_to menus_path
    else
      redirect_to menus_edit_path(menu_id: menuitem.menu.id)
    end
  end
end
