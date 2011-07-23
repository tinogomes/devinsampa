# encoding: utf-8
class ApplicationController < ActionController::Base
  # include ExceptionNotifiable

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  helper_method :admin?
  helper_method :current_user
  helper_method :class_selected

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation

  private
    def class_selected(current_controller_name, current_action_name)
      return "selected" if current_controller_and_action(current_controller_name, current_action_name)
    end

    def current_controller_and_action(current_controller_name, current_action_name)
      current_controller_name.to_s === controller_name.to_s && current_action_name.to_s === action_name.to_s
    end

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end

    def admin?
      return current_user.role == "admin" if current_user
      false
    end

    def logged?
      return true if current_user
      false
    end
end
