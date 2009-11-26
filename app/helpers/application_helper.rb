# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def attendee_class_select
     class_selected("attendees", "index") || class_selected("attendees", "new") || class_selected("attendees", "create") || class_selected("attendees", "payment")
  end
  
  def link_to_back(label = "Back")
    link_to label, "javascript:history.go(-1)"
  end
end
