class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :last_name, :first_name, :gender, :date_of_birth, :contact_number, :mentor_id

  has_many :user_hours, :dependent => :destroy

  def mentor
    return unless self.mentor_id
    Mentor.find_by_id(self.mentor_id)
  end
end
