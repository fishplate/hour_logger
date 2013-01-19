require 'spec_helper'

describe Mentor do

  describe "with valid attributes" do
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

end
