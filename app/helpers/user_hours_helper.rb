module UserHoursHelper

  def confirmation(state)
    message = state ? "confirmed" : "unconfirmed"
    message
  end

  def placement_name(placement)
    placement.nil? ? nil : placement.name
  end

  def placement_area(placement)
    placement.nil? ? nil : placement.area
  end

end