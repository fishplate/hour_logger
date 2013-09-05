class ApprovesController < ApplicationController
  before_filter :authenticate_user!, :check_user_mentor

  def create
    mentor = User.find(params[:id])
    user =  mentor.review_users.find(params[:user])
    hour = user.user_hours.find(params[:hour])
    hour.update_attributes(confirmed: true)
    redirect_to mentor_path(user)
  end
end
