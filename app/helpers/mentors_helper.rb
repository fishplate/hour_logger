module MentorsHelper

  def hours_present?(user)
    if user.user_hours.empty?
      return
    else
      return "btn-inverse"
    end
  end

end