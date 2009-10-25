require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin_speakers/index.html.erb" do
  include Admin::SpeakersHelper

  before(:each) do
    assigns[:admin_speakers] = [
      stub_model(Admin::Speaker,
        :name => "value for name",
        :bio => "value for bio",
        :presentation => "value for presentation",
        :description => "value for description"
      ),
      stub_model(Admin::Speaker,
        :name => "value for name",
        :bio => "value for bio",
        :presentation => "value for presentation",
        :description => "value for description"
      )
    ]
  end

  it "renders a list of admin_speakers" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for bio".to_s, 2)
    response.should have_tag("tr>td", "value for presentation".to_s, 2)
    response.should have_tag("tr>td", "value for description".to_s, 2)
  end
end
