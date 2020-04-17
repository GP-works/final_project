class MenuitemsController < ApplicationController
  def index
  end

  def create
    @menu.menuitems.create!(name: params[:name], price: params[:price])
    redirect_to menus_path
  end
end
