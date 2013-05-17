require 'spec_helper'

describe ArchivesController do

  context "with valid login" do

    before(:each) do
      sign_in given_user
    end

    it "should redirect to hour path if no archives" do
      get :index
      flash[:alert].should == "You dont have any archived hours"
      response.should redirect_to user_hours_path
    end
  end

  context "without valid login" do

    it "should be re-directed to login page on index" do
      get :index
      response.should redirect_to new_user_session_path
    end

  end
end
