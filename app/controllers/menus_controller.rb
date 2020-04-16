class MenusController < ApplicationController
  before_action :ensure_owner_logged_in
  skip_before_action :verify_authenticity_token

  def index
    render plain: Menu.all.join("\n")
  end

  def create
    new_menu = Menu.new(name: params[:name])
    if new_menu.save
      redirect_to menus_path
    else
      flash[:error] = new_menu.errors.full_messages.join(", ")
    end
  end
end
