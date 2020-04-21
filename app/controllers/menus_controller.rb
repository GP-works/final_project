class MenusController < ApplicationController
  before_action :ensure_owner_logged_in

  def index
  end

  def create
    new_menu = Menu.new(name: params[:name])
    if new_menu.save
      Rails.cache.write("active_menu_id", new_menu.id)
      redirect_to menus_path
    else
      flash[:error] = new_menu.errors.full_messages.join(", ")
      redirect_to menus_path
    end
  end

  def set
    Rails.cache.write("active_menu_id", params[:menu_id])
    redirect_to menus_path
  end
end
