require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  it "should not be valid" do
    Factory.build(:user).should be_valid
  end
end
