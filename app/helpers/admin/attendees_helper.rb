# encoding: utf-8
module Admin::AttendeesHelper
  def current_admin_attendee_order(label, order = label.downcase)
    if order === session[:admin_attendee_order]
      label
    else
      link_to(label, admin_attendees_path(:o => order))
    end
  end

  def status_or_link(attendee)
    if attendee.status.nil? && attendee.will_unregister
      return "bye?"
    elsif attendee.status.nil?
        link_to "wr?", warning_admin_attendee_path(attendee)
    else
      h(attendee.status)
    end
  end
end
