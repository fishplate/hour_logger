class MainsController < ApplicationController
  before_filter :check_mentor
  def index

  end

private

  def check_mentor
    if current_user
      redirect_to mentors_path if current_user.is_mentor
    end
  end
end
