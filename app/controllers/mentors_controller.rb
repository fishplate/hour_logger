class MentorsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = current_user.review_users
    @user_hours = current_user.review_hours
  end
end
