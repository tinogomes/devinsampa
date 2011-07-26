# encoding: utf-8
class UserSessionsController < ApplicationController
  layout "admin/admin"

  def new
  end

  def create
    user = User.authenticate(params[:user][:username], params[:user][:password])
    raise unless user
    session[:user_id] = user.id
    return_to = user.admin? ? admin_url : root_path
    redirect_to return_to, :notice => t("user_sessions.logged_successful")
  rescue
    flash.now.alert = t("user_sessions.invalid_username_or_password")
    render "new"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => t("user_sessions.logout_successful")
  end
end
