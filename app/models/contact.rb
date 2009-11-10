class Contact < ActionMailer::Base
  
  def from_site(contact, receive_a_copy = false)
    recipients    "devinsampa@gmail.com"
    cc            contact.email if receive_a_copy
    from          "devinsampa@gmail.com"
    subject       contact.subject || "Contato via Dev in Sampa"
    body          :contact => contact
  end
  
  def attendee_created(attendee)
    default_url_options[:host] = "www.devinsampa.com.br"
    recipients   attendee.email
    from         "devinsampa@gmail.com"
    subject      "[devinsampa] Confirmação de inscrição"
    body         :name => attendee.name, :link => payment_url(:token => attendee.token)
  end
  
  def attendee_confirmation(attendee)
    default_url_options[:host] = "www.devinsampa.com.br"
    recipients   attendee.email
    from         "devinsampa@gmail.com"
    subject      "[devinsampa] Confirmação de pagamento"
    body         :name => attendee.name, :doc => attendee.doc
  end
  
  def attendee_problem(attendee)
    default_url_options[:host] = "www.devinsampa.com.br"
    recipients   attendee.email
    from         "devinsampa@gmail.com"
    subject      "[devinsampa] Problemas no pagamento da inscrição"
    status       = {"canceled" => "Cancelado", "refunded" => "Devolvido"}
    body         :status => status[attendee.status], :name => attendee.name, :link => payment_url(:token => attendee.token)
  end
end
