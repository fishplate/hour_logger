require 'spec_helper'

describe MainsController do

  it "should be able to view the main screen" do
    get :index
    response.should be_success
  end

end
