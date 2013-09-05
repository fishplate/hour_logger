module MentorsHelper

  def hours_status?(user)
    case
    when all_approved?(user.user_hours)
      return "btn-success"
    when user.user_hours
      return "btn-danger"
    end
  end

  def hours_present?(user)
    return unless user
    return true unless user.user_hours.empty?
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

  def all_approved?(user_hours)
    return unless user_hours
    unconfirmed = user_hours.map {|hour| hour if !hour.confirmed}
    unconfirmed.delete_if {|x| x == nil}
    if unconfirmed.empty?
      return true
    else
      return false
    end
  end

end