module MentorsHelper

  def hours_present?(user)
    if user.user_hours.empty?
      return ""
    else
      return "btn-inverse"
    end
  end

  def ordered_hours(user_hours)
    return [] unless user_hours
    user_hours.order(:confirmed)
  end

  def confirmed_hours?(hour)
    if hour.confirmed?
      return "btn-inverse"
    else
      return "btn-success"
    end
  end

  def aproved?(hour)
    return true if hour.confirmed?
  end

end