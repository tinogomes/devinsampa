require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'action_controller'
require 'action_controller/test_process.rb'

describe Speaker do
  before(:each) do
    path = "#{Rails.root}/spec/fixtures/rails.png"
    mimetype = "image/png"
    @valid_attributes = {
      :name => "value for name",
      :bio => "value for bio",
      :presentation => "value for presentation",
      :description => "value for description",
      :uploaded_data => ActionController::TestUploadedFile.new(path, mimetype)
    }
  end

  it "should create a new instance given valid attributes" do
    Speaker.create!(@valid_attributes )
  end
end
