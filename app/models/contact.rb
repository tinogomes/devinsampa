class Contact < ActionMailer::Base
  
  def from_site(contact, receive_a_copy = false)
    recipients    "devinsampa@gmail.com"
    cc            contact.email if receive_a_copy
    from          "devinsampa@gmail.com"
    subject       contact.subject || "Contato via Dev in Sampa"
    body          :contact => contact
  end
  
  def attendee_created(attendee)
    default_url_options[:host] = "http://www.devinsampa.com.br"
    recipients   attendee.email
    from         "devinsampa@gmail.com"
    subject      "[devinsampa] Confirmação de inscrição"
    body         :name => attendee.name, :link => payment_url(:token => attendee.token)
  end

end
