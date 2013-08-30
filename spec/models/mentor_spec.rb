require 'spec_helper'

describe Mentor do

  context "with valid attributes" do
    before(:each) do
      @mentor = Mentor.new(mentor_params)
    end

    it "should be abe to create a mentor" do
      @mentor.save.should == true
    end

    it "should be able to update a mentor" do
      last_name =  "motivator"
      @mentor.update_attributes(last_name: last_name).should == true
      @mentor.reload
      @mentor.last_name.should == last_name
    end

    it "should be able to destroy a mentor" do
      @mentor.destroy
      Mentor.count.should == 0
    end
  end

  context "mentor and user_hours" do

    before(:each) do
      @mentor = Mentor.create!(mentor_params)
      @user = User.create!(
        email: "test@example.com",
        password: "password",
        mentor_id: @mentor.id
        )
    end

    it "should be able to return users" do
      @mentor.users.count.should == 1
    end

    it "should be able to see user hours" do
      @user.user_hours.create!(
        hours: 1.5,
        placement_id: given_placement.id,
        date_occurred: Date.today
        )
       @mentor.user_hours.count.should == 1
    end

  end

end
