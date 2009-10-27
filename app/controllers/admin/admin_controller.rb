class Admin::AdminController < ApplicationController
  before_filter :only_admin
  
  private
    def only_admin
      unless logged?
        redirect_to login_url and return
      end
      unless admin?
        flash[:error] = "Sai daqui, pois você não tem envergadura moral!"
        redirect_to home_path and return
      end
    end
end