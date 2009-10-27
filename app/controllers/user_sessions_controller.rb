class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Seja bem vindo #{current_user.name}"
      redirect_to home_url
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @user_session = UserSession.find
    flash[:notice] = "Volte sempre #{current_user.name}."
    @user_session.destroy
    redirect_to home_url
  end
end
