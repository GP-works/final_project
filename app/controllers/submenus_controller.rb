class SubmenusController < ApplicationController
  before_action :ensure_owner_logged_in

  def create
    menu = Menu.find(params[:menu_id])
    new_submenu = menu.submenus.new(name: params[:name])
    if new_submenu.save
      flash[:success] = "#{params[:name]} added to #{menu.name} menu"
      if @menu == menu
        redirect_to menus_path
      else
        redirect_to menus_edit_path(menu_id: menu.id)
      end
    else
      flash[:error] = new_submenu.errors.full_messages.join(", ")
      if @menu == menu
        redirect_to menus_path
      else
        redirect_to menus_edit_path(menu_id: menu.id)
      end
    end
  end
end
