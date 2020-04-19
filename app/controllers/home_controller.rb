class HomeController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def index
    if current_user
      if current_user.role == "owner"
        redirect_to menus_path
      else
        redirect_to menuitems_path
      end
    else
      redirect_to sessions_path
    end
  end
end
