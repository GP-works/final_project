class MenuitemsController < ApplicationController
  def index
  end

  def create
    ensure_owner_logged_in
    menu = Menu.find(params[:id])
    submenu = Submenu.find(params[:submenu_id])
    new_menuitem = menu.menuitems.new(name: params[:name],
                                      price: params[:price],
                                      image_url: params[:image_url],
                                      description: params[:description],
                                      submenu_id: params[:submenu_id],
                                      available: true)
    if new_menuitem.save
      flash[:success] = "#{params[:name]} added to #{menu.name} menu"
      if @menu == menu
        if params[:rendered_from] == "submenu"
          redirect_to "/submenus/#{submenu.id}/edit"
        else
          redirect_to menus_path
        end
      else
        if params[:rendered_from] == "submenu"
          redirect_to "/submenus/#{submenu.id}/edit"
        else
          redirect_to menus_edit_path(menu_id: menu.id)
        end
      end
    else
      flash[:error] = new_menuitem.errors.full_messages.join(", ")
      if @menu == menu
        if params[:rendered_from] == "submenu"
          redirect_to "/submenus/#{submenu.id}/edit"
        else
          redirect_to menus_path
        end
      else
        if params[:rendered_from] == "submenu"
          redirect_to "/submenus/#{submenu.id}/edit"
        else
          redirect_to menus_edit_path(menu_id: menu.id)
        end
      end
    end
  end

  def destroy
    ensure_owner_logged_in
    menuitem_id = params[:id]
    menuitem = Menuitem.find(menuitem_id)
    menu = menuitem.menu
    submenu = menuitem.submenu
    name = menuitem.name
    menuitem.destroy
    flash[:success] = "menuitem #{name} is deleted from menu #{@menu.name} successfully"
    if @menu == menu
      if params[:rendered_from] == "submenu"
        redirect_to "/submenus/#{submenu.id}/edit"
      else
        redirect_to menus_path
      end
    else
      if params[:rendered_from] == "submenu"
        redirect_to "/submenus/#{submenu.id}/edit"
      else
        redirect_to menus_edit_path(menu_id: menu.id)
      end
    end
  end

  def new
    submenu = Submenu.find(params[:submenu_id])
    render :new, locals: { menu: submenu.menu, submenu: submenu, rendered_from: params[:rendered_from] }
  end

  def edit
    menuitem = Menuitem.find(params[:id])
    render :edit, locals: { menuitem: menuitem, rendered_from: params[:rendered_from] }
  end

  def update
    menuitem = Menuitem.find(params[:id])
    menuitem.name = params[:name].presence || menuitem.name
    menuitem.price = params[:price].presence || menuitem.price
    menuitem.image_url = params[:image_url].presence || menuitem.image_url
    menuitem.description = params[:description].presence || menuitem.description
    menuitem.save
    submenu = menuitem.submenu
    if @menu == menuitem.menu
      if params[:rendered_from] == "submenu"
        redirect_to "/submenus/#{submenu.id}/edit"
      else
        redirect_to menus_path
      end
    else
      if params[:rendered_from] == "submenu"
        redirect_to "/submenus/#{submenu.id}/edit"
      else
        redirect_to menus_edit_path(menu_id: menuitem.menu.id)
      end
    end
  end

  def available
    menuitem = Menuitem.find(params[:id])
    menuitem.available = params[:available]
    menuitem.save
    submenu = menuitem.submenu
    menuitem_status = menuitem.available ? "marked available" : "marked not available"
    flash[:success] = "Menuitem #{menuitem.name} is #{menuitem_status}"
    rendered_from = params[:rendered_from]
    if @menu == menuitem.menu
      if params[:rendered_from] == "submenu"
        redirect_to "/submenus/#{submenu.id}/edit"
      else
        redirect_to menus_path
      end
    else
      if params[:rendered_from] == "submenu"
        redirect_to "/submenus/#{submenu.id}/edit"
      else
        redirect_to menus_edit_path(menu_id: menuitem.menu.id)
      end
    end
  end
end
