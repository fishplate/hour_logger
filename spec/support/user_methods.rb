def given_user
  @user ||= User.create!(user_params)
end

def user_params
  {
    email: "testuser@example.com",
    password: "password",
    last_name: "bloggs",
    first_name: "joe",
    gender: "male",
    date_of_birth: Date.parse("01/01/1981"),
    contact_number: "123456789011"
  }
end