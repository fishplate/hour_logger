require 'spec_helper'

describe UserHour do
  describe "with valid attributes and user" do
    before(:each) do
      @user_hour_params = {hours: 1.5, placement_id: given_placement.id, date_occurred: Date.today}
    end

    it "should be able to create user hours for user" do
      @user_hour = given_user.user_hours.new(@user_hour_params)
      @user_hour.save.should == true
    end

    it "should be able to get placement if valid" do
      @user_hour = given_user.user_hours.create!(@user_hour_params)
      @user_hour.placement.should == given_placement
    end

    it "should purge user hours for user if user is removed" do
      given_user.user_hours.create!(@user_hour_params)
      given_user.destroy
      UserHour.count.should == 0
    end

  end
end
