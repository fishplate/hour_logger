class UserHour < ActiveRecord::Base
  attr_accessible :hours, :placement_id, :date_occurred, :archived,
  :confirmed, :number_participants, :new_participants

  validates_presence_of :placement_id, :hours, :date_occurred
  validates_uniqueness_of :date_occurred, :scope => :user_id
  validate :valid_hours?

  belongs_to :user

  def placement
    return unless self.placement_id
    Placement.find_by_id(placement_id)
  end

  def self.get_date(date_arg = nil)
    desired_date = date_arg.nil? ? Date.today : Date.parse(date_arg)
    self.where(["EXTRACT(MONTH from date_occurred) = ? AND EXTRACT(YEAR from date_occurred) = ?", desired_date.month, desired_date.year])
  end

  def self.archived
    self.where(archived: true)
  end

private

  def valid_hours?
    self.hours.is_a?(Float)
  end

end
