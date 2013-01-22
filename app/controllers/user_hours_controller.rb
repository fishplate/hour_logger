class UserHoursController < ApplicationController
  before_filter :authenticate_user!

  def index

  end

  def create
    placement = Placement.find_or_create_by_name_and_area(params[:placement][:name], params[:placement][:area])
    @user_hours = current_user.user_hours.new(params[:user_hours])
    @user_hours.placement_id = placement.id
    if @user_hours.save
      redirect_to root_path, :notice => "hours have been logged"
    else
      flash[:alert] = "there was a problem with logging your hours"
      render :new
    end
  end
end
