require 'spec_helper'

describe User do

  describe "with valid attributes" do
    before(:each) do
      @user = User.new(user_params)
    end

    it "should be abe to create a user" do
      @user.save.should == true
    end

    it "should be able to update a user" do
      new_number =  "555555555"
      @user.update_attributes(contact_number: new_number).should == true
      @user.reload
      @user.contact_number.should == new_number
    end

    it "should be able to destroy a user" do
      @user.destroy
      User.count.should == 0
    end
  end

end
