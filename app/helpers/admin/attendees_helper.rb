module Admin::AttendeesHelper
  # include ActionView::Helpers::UrlHelper
  
  def current_admin_attendee_order(order)
    if order === session[:admin_attendee_order]
      order
    else
      link_to(order, admin_attendees_path(:o => order))
    end
  end
end
