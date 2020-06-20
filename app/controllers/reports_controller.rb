class ReportsController < ApplicationController
  def index
    from_date = params[:from_date].presence || DateTime.now - 30
    to_date = params[:from_date].presence || DateTime.now
    if from_date > to_date
      from_date = from_date - 30
    end
  end
end
