require 'spec_helper'

describe MentorsController do

  context "with valid login" do
    before(:each) do
      @user = given_user
      @user.make_mentor
      sign_in @user
    end

    it "should be able to view mentor page" do
      get :index
      response.should be_success
    end

  end

end
