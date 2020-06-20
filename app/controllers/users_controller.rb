class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
  end

  def index
    ensure_owner_logged_in
  end

  def destroy
    user = User.find(params[:id])
    if current_user.role == "owner" || user == current_user
      user.destroy
      if user == current_user
        session[:current_user_id] = nil
      end
      redirect_to "/"
    else
      flash[:error] = "you do not have authority"
      redirect_to "/" and return
    end
  end

  def edit
    user = User.find(params[:id])
    unless current_user.role == "owner" || current_user == user
      flash[:error] = "Behave yourself"
      redirect_to "/" and return
    end
    render :edit, locals: { user: user }
  end

  def change_role
    user = User.find(params[:id])
    user.role = params[:role]
    user.request_status = nil
    if user.save
      flash[:success] = "role is changed as requested"
      redirect_to users_path
    end
  end

  def update
    user = User.find(params[:id])
    user.name = params[:name].presence || user.name
    user.email = params[:email].presence || user.email
    if params[:password] != nil
      user.password = params[:password]
    end
    if user.save
      flash[:success] = "updated successfully"
      redirect_to "/"
    end
  end

  def role_request
    user = User.find(params[:id])
    user.request_status = params[:role]
    if user.save
      flash[:success] = "role requested successfully"
      redirect_to users_path
    end
  end

  def create
    new_user = User.new(
      name: params[:name],
      role: "customer",
      email: params[:email],
      request_status: nil,
      password: params[:password],
    )
    if new_user.save
      flash[:success] = "signed up successfully and logged in automatically,please use your credentails for logging in next time :)"
      session[:current_user_id] = new_user.id
      redirect_to "/"
    else
      flash[:error] = new_user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end
end
