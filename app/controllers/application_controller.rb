# encoding: utf-8
class ApplicationController < ActionController::Base
  # include ExceptionNotifiable

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  helper_method :admin_user?, :current_user, :class_selected, :logged?

  protected
  def class_selected(current_controller_name, current_action_name)
    return "selected" if current_controller_and_action(current_controller_name, current_action_name)
  end

  def current_controller_and_action(current_controller_name, current_action_name)
    current_controller_name.to_s === controller_name.to_s && current_action_name.to_s === action_name.to_s
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def admin_user?
    return current_user.role == "admin" if current_user
    false
  end

  def logged?
    return true if current_user
    false
  end
end
