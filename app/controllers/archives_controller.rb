class ArchivesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @archived_hours = current_user.user_hours.archived
    @dates = date_array(@archived_hours)
  end

private

  def date_array(hours)
    return unless hours
    dates = hours.map {|h| h.date_occurred}
    dates.group_by(&:year)
  end

end
