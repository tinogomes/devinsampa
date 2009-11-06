require 'spec_helper'

describe Agenda do
  before(:each) do
    @valid_attributes = {
      :start_time => "value for start_time",
      :end_time => "value for end_time",
      :event => "value for event",
      :speaker_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Agenda.create!(@valid_attributes)
  end
end
