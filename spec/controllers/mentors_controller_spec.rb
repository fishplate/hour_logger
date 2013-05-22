require 'spec_helper'

describe MentorsController do

  context "with valid login" do
    before(:each) do
      @user = given_user
      @user.make_mentor
      sign_in @user
      @user2 = User.create!(
        first_name: "test",
        last_name: "user",
        mentor_id: Mentor.first.id,
        email: "test.user@example.com",
        password: "password")
    end

    it "should be able to view mentor page and review users" do
      get :index
      response.should be_success
      assigns(:users).should == @user.review_users.order(:last_name)
    end

    it "should be able to check user hours" do
      get :show, :id => @user2.id
      response.should be_success
      assigns(:user).should == @user2
    end

  end

end
