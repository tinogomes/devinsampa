require File.dirname(__FILE__) + '/../spec_helper'
 
describe UsersController do
  integrate_views
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    # User.any_instance.stubs(:save?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    post :create, :user => Factory.attributes_for(:user)
    response.should redirect_to(home_url)
  end
  
  it "edit action should render edit template" do
    @controller.stub!(:current_user).and_return(Factory(:user))
    get :edit
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    user = Factory(:user)
    put :update, :user => {:name => ''}
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    user = Factory(:user)
    put :update, :user => {:name => "New Name"}
    response.should redirect_to(home_url)
  end
end
