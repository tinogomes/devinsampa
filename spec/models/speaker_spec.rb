require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Speaker do
  it "should create a new instance given valid attributes" do
    Speaker.create!(Factory.attributes_for(:speaker))
  end
end
