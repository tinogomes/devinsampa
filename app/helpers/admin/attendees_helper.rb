module Admin::AttendeesHelper
  def current_admin_attendee_order(order)
    if order === session[:admin_attendee_order]
      order
    else
      link_to(order, admin_attendees_path(:o => order))
    end
  end
  
  def status_or_link(attendee)
    if attendee.will_unregister 
      return "bye?"
    else 
      if attendee.status.nil?
        link_to "wr?", warning_admin_attendee_path(attendee)
      else
        h(attendee.status)
      end
    end
  end
end
