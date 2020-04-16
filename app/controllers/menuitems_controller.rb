class MenuitemsController < ApplicationController
  def index
  end

  def create
    active_menu.create!(name: "Idly", price: "10.4")
    redirect_to menuitems_path
  end
end
