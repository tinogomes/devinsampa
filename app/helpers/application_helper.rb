# encoding: utf-8
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

  def metas_tag
    <<-METAS
    <meta name="description" content="Dev in Sampa, que acontece dia 27/08/2011, das 09:00 às 19:00, é o encontro de desenvolvedores de sistemas em São Paulo, Brasil" />
    <meta name="keywords" content="ruby, python, java, .net, visual basic, perl, delphi, goo, desenvolvimento, software, sistemas, conferência, são paulo, encontro, 14/08/2010, brasil" />
    <meta name="copyright" content="2009-2011, Dev in Sampa" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="google-site-verification" content="OfxL2RQU8Zc_5NjaO3bqjvM1H4JoKO5hinLPfMvpDdU" />
    <meta name="URL" content="http://www.devinsampa.com.br" />
    <meta name="language" content="portuguese" />
    <meta name="author" content="Celestino Gomes" />
    <meta name="author" content="Luis Cipriani" />
    <meta name="author" content="Everton Ribeiro" />
    METAS
  end
end
