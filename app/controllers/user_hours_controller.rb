class UserHoursController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_details
  autocomplete :placement, :name, :extra_data => [:area]

# Not sure why I'm doing this crazines 
# - could just have an index for archived?
  def index
    month = params[:month]
    year = params[:year]
    if [month, year].include?(nil)
      @archived = false
      @user_hours = current_user.user_hours.get_date
      @total = calculate_totals(@user_hours)
    else
      @archived = true
      @user_hours = current_user.user_hours.archived.get_date("01/#{month}/#{year}")
      @total = calculate_totals(@user_hours)
    end
  end

  def new
    @user_hour = current_user.user_hours.new
    @day_options = sort_days(current_user.user_hours.get_date)
  end

  def create
    day = params[:user_hour][:date_occurred].to_s
    month = Date.today.month
    year = Date.today.year
    @placement = Placement.find_or_create_by_name_and_area(params[:placement][:name], params[:placement][:area])
    @user_hour = current_user.user_hours.new(params[:user_hour])
    @user_hour.placement_id = @placement.id
    @user_hour.date_occurred = Date.parse("#{day}/#{month}/#{year}")
    if @user_hour.save
      redirect_to user_hours_path, :notice => "hours have been logged"
    else
      @day_options = sort_days(current_user.user_hours.get_date)
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

  def sort_days(user_dates)
    days_month = Time.days_in_month(Date.today.month, Date.today.year)
    days_excluded = user_dates.map {|d| d.date_occurred.day}
    days = Array(1..days_month)
    days_excluded.each {|x| days.delete(x)}
    days
  end

  def calculate_totals(hours)
    return unless hours
    unless hours.empty?
      hours.map {|a| a.hours}.sum
    end
  end

end
