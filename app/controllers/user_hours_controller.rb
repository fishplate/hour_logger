class UserHoursController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_details
  autocomplete :placement, :name, :extra_data => [:area]

  def index
    @user_hours = current_user.user_hours
  end

  def new
    @user_hour = current_user.user_hours.new
  end

  def create
    placement = Placement.find_or_create_by_name_and_area(params[:placement][:name], params[:placement][:area])
    @user_hour = current_user.user_hours.new(params[:user_hour])
    @user_hour.placement_id = placement.id
    if @user_hour.save
      redirect_to user_hours_path, :notice => "hours have been logged"
    else
      render :new
    end
  end

  def edit
    @user_hour = current_user.user_hours.find(params[:id])
    @placement_name = @user_hour.placement.name
    @placement_area = @user_hour.placement.area
  end

  def update
    @user_hour = current_user.user_hours.find(params[:id])
    placement = Placement.find_or_create_by_name_and_area(params[:placement][:name], params[:placement][:area])
    new_params = params[:user_hour].merge!({placement_id: placement.id})
    if @user_hour.update_attributes(new_params)
      redirect_to user_hours_path, :notice => "hours updated"
    else
      if @user_hour.placement.nil?
        @placement_name = nil
        @placement_area = nil
      end
      render :edit
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

private

  def check_details
    alert_message = "please fill in your details in the account section before logging hours."
    redirect_to root_path, :alert => alert_message unless user_details?
  end

  def user_details?
    args = ["", nil]
    response = true
    details = current_user.as_json :except => [:created_at, :id, :updated_at]
    args.each do |arg|
      response = false if details.values.include?(arg)
    end
    return response
  end

end
