# encoding: utf-8
class Admin::AdminController < ApplicationController
  layout "admin/admin"

  before_filter :should_be_logged, :should_be_logged_as_admin

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

  def should_be_logged
    redirect_to login_url and return unless logged?
  end

  def should_be_logged_as_admin
    redirect_to root_path, :error => t(".you_he_not_permission") and return unless admin_user?
  end
end