require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SpeakersController do

  def mock_speaker(stubs={})
    @mock_speaker ||= mock_model(Speaker, stubs)
  end

  describe "GET index" do
    it "assigns all speakers as @speakers" do
      Speaker.stub!(:all).and_return([mock_speaker])
      get :index
      assigns[:speakers].should == [mock_speaker]
    end
  end
end
