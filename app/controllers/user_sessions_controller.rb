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
      flash[:error] = "Você não está tentando hackear, né?"
      render :action => 'new'
    end
  end
  
  def destroy
    if current_user
      @user_session = UserSession.find
      flash[:notice] = "Volte sempre #{current_user.name}."
      @user_session.destroy
    else
      flash[:notice] = "Você nem estava logado"
    end
    
    redirect_to home_url
  end
end
