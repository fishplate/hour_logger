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
  belongs_to :mentor

  def make_mentor
    required = [self.first_name, self.last_name, self.email]
    required.each {|x| return if x.nil?}
    @mentor = Mentor.new(
      first_name: self.first_name,
      last_name: self.last_name,
      email: self.email
      )
    if @mentor.save
      self.is_mentor = true
      self.save
    end
  end

  def review_hours
    return unless self.is_mentor
    mentor = Mentor.find_by_email(self.email)
    mentor.user_hours
  end

  def review_users
    return unless self.is_mentor
    mentor = Mentor.find_by_email(self.email)
    mentor.users
  end
end
