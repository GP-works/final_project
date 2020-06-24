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

  def edit
    submenu = Submenu.find(params[:id])
    render :edit, locals: { submenu: submenu }
  end

  def update
    submenu = Submenu.find(params[:id])
    submenu.name = params[:name].presence || submenu.name
    submenu.save
    redirect_to "/submenus/#{submenu.id}/edit"
  end

  def destroy
    submenu = Submenu.find(params[:id])
    menu = submenu.menu
    flash[:success] = "Submenu #{submenu.name} deleted successfully"
    submenu.destroy
    if @menu == menu
      redirect_to menus_path
    else
      redirect_to menus_edit_path(menu_id: menu.id)
    end
  end
end
