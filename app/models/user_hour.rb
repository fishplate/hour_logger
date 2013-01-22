class UserHour < ActiveRecord::Base
  attr_accessible :hours, :placement_id, :date_occurred

  belongs_to :user

  def placement
    return unless self.placement_id
    Placement.find_by_id(placement_id)
  end

end
