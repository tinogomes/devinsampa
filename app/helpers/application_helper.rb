# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def attendee_class_select
     class_selected("attendees", "index") || class_selected("attendees", "new") || class_selected("attendees", "create") || class_selected("attendees", "payment")
  end

  def link_to_back(label = "Back")
    link_to label, "javascript:history.go(-1)"
  end

  def what_happen(presentation)
    return presentation if presentation.kind_of?(String)
    [presentation.title, presentation.speakers.map {|s| s.name }.to_sentence].join(' - ')
  end

  def link_or_name_for(speaker)
    return speaker.name unless speaker.twitter?
    "<a href='http://twitter.com/#{speaker.twitter}' title='Siga #{speaker.name} no twitter'>#{speaker.name}</a>"
  end
end
