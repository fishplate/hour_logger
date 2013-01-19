class UserHour < ActiveRecord::Base
  attr_accessible :hours, :placement_id

  belongs_to :user
end
