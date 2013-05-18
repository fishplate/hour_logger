class Mentor < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email
  has_many :users
  has_many :user_hours, :through => :users
end
