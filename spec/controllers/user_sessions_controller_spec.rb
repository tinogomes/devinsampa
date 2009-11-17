require File.dirname(__FILE__) + '/../spec_helper'
 
describe UserSessionsController do
  fixtures :all
  integrate_views
  
  before(:each) do
    @user = Factory(:user, :username => "login", :password => "12345")
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    post :create, :user_session => {:username => "login", :password => "12345"}
    response.should redirect_to(admin_url)
  end
  
  it "destroy action should destroy model and redirect to index action" do
    user_session = UserSession.find
    delete :destroy, :id => user_session
    response.should redirect_to(home_url)
    UserSession.find.should be_nil
  end
end
