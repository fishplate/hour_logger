class MentorsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user_hours = current_user.review_hours
  end
end
