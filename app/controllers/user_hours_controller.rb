class UserHoursController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user_hours = current_user.user_hours
  end

  def new
    @user_hour = current_user.user_hours.new
  end

  def create
    placement = Placement.find_or_create_by_name_and_area(params[:placement][:name], params[:placement][:area])
    @user_hours = current_user.user_hours.new(params[:user_hour])
    @user_hours.placement_id = placement.id
    if @user_hours.save
      redirect_to user_hours_path, :notice => "hours have been logged"
    else
      flash[:alert] = "there was a problem with logging your hours"
      render :new
    end
  end

  def destroy
    user_hour = current_user.user_hours.find(params[:id])
    if user_hour.destroy
      redirect_to user_hours_path, :notice => "hours have been deleted"
    else
      redirect_to user_hours_path, :alert => "there was a problem with deleting your hours"
    end
  end
end
