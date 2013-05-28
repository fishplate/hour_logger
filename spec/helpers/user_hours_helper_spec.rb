require 'spec_helper'

describe UserHoursHelper do

  it "should return placeholder name or nil dependant on whats is given" do
    placement_name(given_placement).should == given_placement.name
    placement_name(nil).should == nil
  end

  it "should return placeholder areaor nil dependant on whats is given" do
    placement_area(given_placement).should == given_placement.area
    placement_area(nil).should == nil
  end
end