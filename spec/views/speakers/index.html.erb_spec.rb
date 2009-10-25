require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/speakers/index" do
  before(:each) do
    render 'speakers/index'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('p', %r[de 80 e 90, Rick Astley])
  end
end
