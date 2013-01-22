class UserHour < ActiveRecord::Base
  attr_accessible :hours, :placement_id, :date_occurred

  belongs_to :user
end
