class ApplicationController < ActionController::Base
  before_action :ensure_user_logged_in
  before_action :active_menu

  def ensure_user_logged_in
    unless current_user
      redirect_to "/"
    end
  end

  def ensure_owner_logged_in
    unless current_user.role == "owner"
      redirect_to "/"
    end
  end

  def ensure_ownerorclerk_logged_in
    unless current_user.role == "owner" || current_user.role == "billclerk"
      redirect_to "/"
    end
  end

  def current_user
    return @current_user if @current_user

    current_user_id = session[:current_user_id]
    if current_user_id
      @current_user = User.find(current_user_id)
    else
      nil
    end
  end

  def active_menu
    if Rails.cache.fetch("active_menu_id")
      active_menu_id = Rails.cache.read("active_menu_id")
      @menu = Menu.find(active_menu_id)
    else
      Rails.cache.write("active_menu_id", Menu.first.id)
      active_menu_id = Rails.cache.read("active_menu_id")
      @menu = Menu.find(active_menu_id)
    end
  end
end
