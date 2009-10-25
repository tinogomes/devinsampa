require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin_speakers/edit.html.erb" do
  include Admin::SpeakersHelper

  before(:each) do
    assigns[:speaker] = @speaker = stub_model(Admin::Speaker,
      :new_record? => false,
      :name => "value for name",
      :bio => "value for bio",
      :presentation => "value for presentation",
      :description => "value for description"
    )
  end

  it "renders the edit speaker form" do
    render

    response.should have_tag("form[action=#{speaker_path(@speaker)}][method=post]") do
      with_tag('input#speaker_name[name=?]', "speaker[name]")
      with_tag('textarea#speaker_bio[name=?]', "speaker[bio]")
      with_tag('input#speaker_presentation[name=?]', "speaker[presentation]")
      with_tag('textarea#speaker_description[name=?]', "speaker[description]")
    end
  end
end
