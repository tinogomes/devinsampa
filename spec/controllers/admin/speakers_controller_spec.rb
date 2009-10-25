require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::SpeakersController do

  def mock_speaker(stubs={})
    @mock_speaker ||= mock_model(Speaker, stubs)
  end

  describe "GET index" do
    it "assigns all admin_speakers as @admin_speakers" do
      Speaker.stub!(:find).with(:all).and_return([mock_speaker])
      get :index
      assigns[:admin_speakers].should == [mock_speaker]
    end
  end

  describe "GET show" do
    it "assigns the requested speaker as @speaker" do
      Speaker.stub!(:find).with("37").and_return(mock_speaker)
      get :show, :id => "37"
      assigns[:speaker].should equal(mock_speaker)
    end
  end

  describe "GET new" do
    it "assigns a new speaker as @speaker" do
      Speaker.stub!(:new).and_return(mock_speaker)
      get :new
      assigns[:speaker].should equal(mock_speaker)
    end
  end

  describe "GET edit" do
    it "assigns the requested speaker as @speaker" do
      Speaker.stub!(:find).with("37").and_return(mock_speaker)
      get :edit, :id => "37"
      assigns[:speaker].should equal(mock_speaker)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created speaker as @speaker" do
        Speaker.stub!(:new).with({'these' => 'params'}).and_return(mock_speaker(:save => true))
        post :create, :speaker => {:these => 'params'}
        assigns[:speaker].should equal(mock_speaker)
      end

      it "redirects to the created speaker" do
        Speaker.stub!(:new).and_return(mock_speaker(:save => true))
        post :create, :speaker => {}
        response.should redirect_to(admin_speaker_url(mock_speaker))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved speaker as @speaker" do
        Speaker.stub!(:new).with({'these' => 'params'}).and_return(mock_speaker(:save => false))
        post :create, :speaker => {:these => 'params'}
        assigns[:speaker].should equal(mock_speaker)
      end

      it "re-renders the 'new' template" do
        Speaker.stub!(:new).and_return(mock_speaker(:save => false))
        post :create, :speaker => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested speaker" do
        Speaker.should_receive(:find).with("37").and_return(mock_speaker)
        mock_speaker.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :speaker => {:these => 'params'}
      end

      it "assigns the requested speaker as @speaker" do
        Speaker.stub!(:find).and_return(mock_speaker(:update_attributes => true))
        put :update, :id => "1"
        assigns[:speaker].should equal(mock_speaker)
      end

      it "redirects to the speaker" do
        Speaker.stub!(:find).and_return(mock_speaker(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(admin_speaker_url(mock_speaker))
      end
    end

    describe "with invalid params" do
      it "updates the requested speaker" do
        Speaker.should_receive(:find).with("37").and_return(mock_speaker)
        mock_speaker.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :speaker => {:these => 'params'}
      end

      it "assigns the speaker as @speaker" do
        Speaker.stub!(:find).and_return(mock_speaker(:update_attributes => false))
        put :update, :id => "1"
        assigns[:speaker].should equal(mock_speaker)
      end

      it "re-renders the 'edit' template" do
        Speaker.stub!(:find).and_return(mock_speaker(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested speaker" do
      Speaker.should_receive(:find).with("37").and_return(mock_speaker)
      mock_speaker.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the admin_speakers list" do
      Speaker.stub!(:find).and_return(mock_speaker(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(admin_speakers_url)
    end
  end

end
