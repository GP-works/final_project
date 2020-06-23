class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
  end

  def index
    ensure_owner_logged_in
  end

  def destroy
    user = User.find(params[:id])
    return_status = user == current_user
    user.destroy
    if return_status
      session[:current_user_id] = nil
      redirect_to "/" and return
    else
      redirect_to users_path
    end
  end

  def show
    user = User.find(params[:id])
    from_date = params[:from_date].presence || DateTime.now - 30
    end_date = params[:end_date].presence || DateTime.now
    if from_date.to_date > end_date.to_date
      from_date = end_date.to_date - 30
    end
    render :show, locals: { all_orders: user.orders.confirmed_orders.get_orders(from_date.to_date, end_date.to_date),
                            hidden_status: false,
                            second_title: "Previous Orders",
                            from_date: from_date,
                            end_date: end_date,
                            id: params[:id] }
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
    else
      flash[:error] = user.errors.full_messages.join(", ")
      redirect_to edit_user_path(id: params[:id])
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
      redirect_to users_path
      flash[:success] = "updated successfully"
    else
      flash[:error] = user.errors.full_messages.join(", ")
      redirect_to edit_user_path(id: params[:id])
    end
  end

  def role_request
    user = User.find(params[:id])
    user.request_status = params[:role]
    if user.save
      flash[:success] = "role requested successfully"
      redirect_to users_path
    else
      flash[:error] = user.errors.full_messages.join(", ")
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
