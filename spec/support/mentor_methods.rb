def mentor_params
  {
    email: "testmentor@example.com",
    last_name: "mentor",
    first_name: "mister",
  }
end

def given_mentor
  @mentor ||= Mentor.create!(mentor_params)
end