# encoding: utf-8
class Admin::AdminController < ApplicationController
  layout "admin/admin"

  before_filter :only_admin
  
  helper_method :prepare_dashboard
  
  def index
    render :text => prepare_dashboard, :layout => true
  end
  
  private
    def prepare_dashboard
      attendees_count = Attendee.count(:id)
      attendees_resume = Attendee.count(:id, :group => [:status])

      html_result = "<p>Resume of Attendees</p><table><tr><th>status</th><th>count</th></tr>"
      attendees_resume.each do |tr|
        html_result << "<tr>"
        tr.each do |td| 
          html_result << "<td>#{td}</td>"
        end
      end
      html_result << "<tr><td>Total</td><td>#{attendees_count}</td></tr></table>"
    end
    
    def only_admin
      unless logged?
        redirect_to login_url and return
      end
      unless admin?
        flash[:error] = "Sai daqui, pois você não tem envergadura moral!"
        redirect_to root_path and return
      end
    end
end