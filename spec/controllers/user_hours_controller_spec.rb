require 'spec_helper'

describe UserHoursController do

  describe "with valid login" do
    before(:each) do
      sign_in given_user
    end

    it "should get index" do
      pending ("needs template")
      get :index
      response.should be_success
    end

    it "should create user hours and new placement" do
      post :create, {user_hours: {hours: 1.5, date_occurred: Date.today}, placement: {name: "some_name", area: "some_area"}}
      flash[:notice].should == "hours have been logged"
      given_user.user_hours.count.should == 1
      Placement.count.should == 1
      given_user.user_hours.first.placement.should == Placement.first
      response.should redirect_to root_path
    end

    it "should create user hours and placement should be existing" do
      post :create, {user_hours: {hours: 1.5, date_occurred: Date.today}, placement: {name: given_placement.name, area: given_placement.area}}
      flash[:notice].should == "hours have been logged"
      given_user.user_hours.count.should == 1
      Placement.count.should == 1
      given_user.user_hours.first.placement.should == Placement.first
      response.should redirect_to root_path
    end

    it "should create user hours and new placement if new name" do
      post :create, {user_hours: {hours: 1.5, date_occurred: Date.today}, placement: {name: "new_name", area: given_placement.area}}
      flash[:notice].should == "hours have been logged"
      given_user.user_hours.count.should == 1
      Placement.count.should == 2
      given_user.user_hours.first.placement.should == Placement.last
      response.should redirect_to root_path
    end
  end

  describe "without valid login" do

    it "should be re-directed to login page on index" do
      get :index
      response.should redirect_to new_user_session_path
    end

    it "should be re-directed to login page on create" do
      post :create, {user_hours: {hours: 1.5, date_occurred: Date.today}, placement: {name: given_placement.name, area: given_placement.area}}
      response.should redirect_to new_user_session_path
    end

  end

end
