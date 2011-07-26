# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe UserSessionsController do
  fixtures :all
  render_views

  let(:user) { Factory(:user, :username => "attendee") }
  let(:admin) { Factory(:admin, :username => "admin") }

  it "new action should render new template" do
    get :new

    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    post :create

    response.should render_template(:new)
    flash[:alert].should == "Usuário ou senha inválidos"
  end

  it "create action should redirect admin for admin user" do
    post :create, :user => {:username => admin.username, :password => "test"}

    response.should redirect_to(admin_url)
    flash[:notice].should == "Seja bem vindo!"
  end

  it "create action should redirect root for simple user" do
    post :create, :user => {:username => user.username, :password => "test"}

    response.should redirect_to(root_url)
    flash[:notice].should == "Seja bem vindo!"
  end

  it "destroy action should destroy model and redirect to index action" do
    session[:user_id] = user.id

    delete :destroy

    response.should redirect_to(root_url)
    flash[:notice].should == "Desconectado."
    session[:user_id].should be_nil
  end
end
