class Contact < ActionMailer::Base
  
  def from_site(contact, receive_a_copy = false)
    recipients    "devinsampa@gmail.com"
    cc            contact.email if receive_a_copy
    from          "devinsampa@gmail.com"
    subject       contact.subject || "Contato via Dev in Sampa"
    body          :contact => contact
  end

end
