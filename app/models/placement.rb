class Placement < ActiveRecord::Base
  attr_accessible :name, :area
  validates_presence_of :name, :area
end