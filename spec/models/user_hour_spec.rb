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

    it "should save a new user hour with archived and confirmed set to false" do
      @user_hour = given_user.user_hours.new(@user_hour_params)
      @user_hour.save
      @user_hour.archived.should == false
      @user_hour.confirmed.should == false
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

    it "should be able to find correct dates default this month" do
      given_user.user_hours.create!(@user_hour_params)
      given_user.user_hours.get_date.should == given_user.user_hours.to_a
    end

    it "should be able to find correct dates when arg is provided" do
      given_user.user_hours.create!(@user_hour_params)
      given_user.user_hours.create!(hours: 1.5, placement_id: given_placement.id, date_occurred: Date.parse("04/02/2013"))
      given_user.user_hours.get_date("01/02/2013").count.should == 1
      given_user.user_hours.get_date("01/02/2013").last.date_occurred.should == Date.parse("04/02/2013")
    end

    it "should be able to get al archived hours" do
      given_user.user_hours.create!(@user_hour_params)
      given_user.user_hours.create!(hours: 1.5, placement_id: given_placement.id, date_occurred: Date.parse("04/02/2013"), archived: true)
      given_user.user_hours.archived.count.should == 1
      given_user.user_hours.archived.first.date_occurred.should == Date.parse("04/02/2013")
    end

  end
end
