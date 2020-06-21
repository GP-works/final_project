class ReportsController < ApplicationController
  before_action :ensure_owner_logged_in

  def index
    from_date = params[:from_date].presence || DateTime.now - 30
    end_date = params[:end_date].presence || DateTime.now
    if from_date.to_date > end_date.to_date
      from_date = end_date.to_date - 30
    end
    render :index, locals: { from_date: from_date,
                             end_date: end_date }
  end

  def display_orders
    from_date = params[:from_date].presence || DateTime.now - 30
    end_date = params[:end_date].presence || DateTime.now
    if from_date.to_date > end_date.to_date
      from_date = end_date.to_date - 30
    end
    render :order_reports, locals: { from_date: from_date,
                                     end_date: end_date }
  end

  def display_users
    from_date = params[:from_date].presence || DateTime.now - 30
    end_date = params[:end_date].presence || DateTime.now
    if from_date.to_date > end_date.to_date
      from_date = end_date.to_date - 30
    end
    render :user_reports, locals: { from_date: from_date,
                                    end_date: end_date }
  end
end
