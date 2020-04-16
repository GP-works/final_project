class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
  end

  def create
    new_user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
    )
    if new_user.save
      flash[:success] = "signed up successfully and logged in automatically,please use your credentails for logging in next time :)"
      session[:current_user_id] = new_user.id
      redirect_to menuitems_path
    else
      flash[:error] = new_user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end
end
