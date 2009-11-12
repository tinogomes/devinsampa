class UserSessionsController < ApplicationController
  layout 'admin/admin'
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_to admin_url
    else
      render :action => 'new'
    end
  end
  
  def destroy
    if current_user
      @user_session = UserSession.find
      @user_session.destroy
    end
    
    redirect_to home_url
  end
end
