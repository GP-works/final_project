class MenusController < ApplicationController
  before_action :ensure_owner_logged_in
  skip_before_action :verify_authenticity_token

  def index
  end

  def create
    new_menu = Menu.new(name: params[:name])
    if new_menu.save
      redirect_to menus_path
    else
      flash[:error] = new_menu.errors.full_messages.join(", ")
      redirect_to menus_path
    end
  end

  def set
    Rails.cache.write("active_menu_id", params[:menu_id])
    active_menu
    flash[:success] = "setted current menu to #{active_menu.name} successfully"
    redirect_to menus_path
  end
end
