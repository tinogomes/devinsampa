require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin_speakers/show.html.erb" do
  include Admin::SpeakersHelper
  before(:each) do
    assigns[:speaker] = @speaker = stub_model(Admin::Speaker,
      :name => "value for name",
      :bio => "value for bio",
      :presentation => "value for presentation",
      :description => "value for description"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ bio/)
    response.should have_text(/value\ for\ presentation/)
    response.should have_text(/value\ for\ description/)
  end
end
