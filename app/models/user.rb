class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :is_mentor
  attr_accessible :last_name, :first_name, :gender, :date_of_birth, :contact_number, :mentor_id

  has_many :user_hours, :dependent => :destroy
  belongs_to :mentor

  def display_name
    self.email
  end

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

  def remove_mentor
    mentor = Mentor.find_by_email(self.email)
    if mentor
      self.is_mentor = false if mentor.destroy
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

  def hours_to_confirm
    return unless self.is_mentor
    result = review_users.map {|user| user if unconfirmed_hours?(user)}
    result.delete_if {|x| x == nil}
  end

  def hours_processed
    return unless self.is_mentor
    result = review_users.map {|user| user if confirmed_hours(user)}
    result.delete_if {|x| x == nil}
  end

  def users_no_hours
    return unless self.is_mentor
    result = review_users.map {|user| user if user.user_hours.empty?}
    result.delete_if {|x| x == nil}
  end

private

  def unconfirmed_hours?(user)
    return unless user.user_hours
    unconfirmed = user.user_hours.map {|hour| hour if !hour.confirmed}
    unconfirmed.delete_if {|x| x == nil}
    if unconfirmed.empty?
      return false
    else
      return true
    end
  end

  def confirmed_hours(user)
    return unless user.user_hours
    confirmed = user.user_hours.map {|hour| hour if hour.confirmed}
    confirmed.delete_if {|x| x == nil}
    if confirmed.empty?
      return false
    else
      return true
    end
  end

end
