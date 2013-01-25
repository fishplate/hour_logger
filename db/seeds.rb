# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)


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

if User.find_by_email(user_params[:email]).nil?
  User.create!(user_params)
end

placement_id = Placement.create!(name: "blackwood", area: "caerphilly").id
100.times do
  User.find_by_email(user_params[:email]).user_hours.create!(hours: 1.5, placement_id: placement_id, date_occurred: Date.today)
end
