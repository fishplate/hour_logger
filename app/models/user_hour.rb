class UserHour < ActiveRecord::Base
  attr_accessible :hours, :placement_id, :date_occurred

  validates_presence_of :placement_id, :hours, :date_occurred
  validate :valid_hours?

  belongs_to :user

  def placement
    return unless self.placement_id
    Placement.find_by_id(placement_id)
  end

private

  def valid_hours?
    self.hours.is_a?(Float)
  end

end
