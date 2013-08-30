class MentorsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = current_user.review_users.order(:last_name)
  end

  def show
    user = params[:id]
    @user = user_hours_review(user)
  end

private

  def user_hours_review(user)
    return unless user
    current_user.review_users.find(user)
  end
end
