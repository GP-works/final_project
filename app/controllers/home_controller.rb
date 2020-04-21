class HomeController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def index
    if current_user
      redirect_to menuitems_path
    else
      redirect_to sessions_path
    end
  end
end
