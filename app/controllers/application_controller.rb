# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  helper_method :class_selected

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  private
    def class_selected(current_controller_name, current_action_name)
      return 'class="selected"' if current_controller_name.to_s === controller_name.to_s && 
                                   current_action_name.to_s === action_name.to_s
    end
end
