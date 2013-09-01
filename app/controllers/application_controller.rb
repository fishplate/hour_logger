class ApplicationController < ActionController::Base
  protect_from_forgery

  def check_user_mentor
    if current_user
      redirect_to root_path unless current_user.is_mentor
    end
  end
end
