def given_hour(user, placement_id)
  @hour ||= user.user_hours.create!(hours: 1.5, placement_id: placement_id, date_occurred: Date.today)
end