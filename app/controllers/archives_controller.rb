class ArchivesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_for_archives, :only => [:index]

  def index
    @archived_hours = current_user.user_hours.archived.order(:date_occurred)
    @dates = date_array(@archived_hours)
  end

private

  def date_array(hours)
    return unless hours
    dates = hours.map {|h| h.date_occurred}
    dates.group_by(&:year)
  end

# This will redirect to root if no metor assigned
# as redirect to user_hour path has the check.
  def check_for_archives
    archived = current_user.user_hours.archived
    if archived.empty?
      alert = "You dont have any archived hours"
      redirect_to user_hours_path, :alert => alert
    else
      return true
    end
  end

end
