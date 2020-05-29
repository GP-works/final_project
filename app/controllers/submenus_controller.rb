class SubmenusController < ApplicationController
  before_action :ensure_owner_logged_in

  def create
    new_submenu = Submenu.new(name: params[:name], menu_id: params[:menu_id])
    if new_submenu.save
      redirect_to menus_path
    else
      flash[:error] = new_submenu.errors.full_messages.join(", ")
      redirect_to menus_path
    end
  end
end
