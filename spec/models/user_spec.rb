require 'spec_helper'

describe User do

  describe "with valid attributes" do
    before(:each) do
      @user = User.new(user_params)
    end

    it "should be abe to create a user if in whitelist" do
      UserWhiteList.create!(email: user_params[:email])
      @user.save.should == true
    end

    it "should not be able to create a user not in whitelist" do
      @user.save.should == false
      @user.errors.full_messages.first.should == "Email not authorised"
    end

    it "should be able to update a user" do
      UserWhiteList.create!(email: user_params[:email])
      new_number =  "555555555"
      @user.update_attributes(contact_number: new_number).should == true
      @user.reload
      @user.contact_number.should == new_number
    end

    it "should be able to destroy a user" do
      @user.save
      @user.destroy
      User.count.should == 0
    end

    it "should be able to get mentor" do
      @user.mentor_id = given_mentor.id
      @user.save
      @user.mentor.should == given_mentor
    end

  end

  context "User as a mentor" do
    before(:each) do
      UserWhiteList.create!(email: user_params[:email])
      @user = User.create!(user_params)
    end
    it "should be able to create a mentor from user" do
      @user.make_mentor.should == true
      Mentor.count.should == 1
      Mentor.first.first_name.should == @user.first_name
    end

    it "should not be able to create mentor if no attributes" do
      @user.update_attributes(first_name: nil)
      @user.make_mentor.should == false
      Mentor.count.should == 0
    end

    it "should be able to review hours if a mentor" do
      UserWhiteList.create!(email: user_params[:email])
      UserWhiteList.create!(email: "test@example.com")
      @user.make_mentor
      @norm_user = User.create!(
        email: "test@example.com",
        password: "password",
        mentor_id: Mentor.find_by_email(@user.email).id
        )
      @norm_user.user_hours.create!(
        hours: 1.5,
        placement_id: given_placement.id,
        date_occurred: Date.today
        )
      @user.review_hours.should == @norm_user.user_hours
    end

    it "should be able to review users if a mentor" do
      UserWhiteList.create!(email: user_params[:email])
      UserWhiteList.create!(email: "test@example.com")
      @user.make_mentor
      @norm_user = User.create!(
        email: "test@example.com",
        password: "password",
        mentor_id: Mentor.find_by_email(@user.email).id
        )
      @user.review_users.first.should == @norm_user
    end
  end
end
