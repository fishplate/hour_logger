module UserHoursHelper

  def confirmation(state)
    message = state ? "confirmed" : "unconfirmed"
    message
  end

end