class Contact < ActionMailer::Base

  def from_site(contact, receive_a_copy = false)
    reply_to      contact.email
    recipients    "contato@devinsampa.com.br"
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
    body         :name => attendee.name, :link => payment_url(:token => attendee.token), :free => attendee.free?
  end

  def attendee_confirmation(attendee)
    default_url_options[:host] = "www.devinsampa.com.br"
    recipients   attendee.email
    from         "devinsampa@gmail.com"
    subject      "[devinsampa] Confirmação de pagamento"
    body         :name => attendee.name, :doc => attendee.doc
  end

  def attendee_pending(attendee)
    default_url_options[:host] = "www.devinsampa.com.br"
    recipients   attendee.email
    from         "devinsampa@gmail.com"
    subject      "[devinsampa] Aguardando confirmação de pagamento pelo PagSeguro"
    status       = {:pending => "Aguardando pagamento", :verifying => "Em análise"}
    body         :status => status[attendee.status], :name => attendee.name, :link => payment_url(:token => attendee.token)
  end

  def attendee_problem(attendee)
    default_url_options[:host] = "www.devinsampa.com.br"
    recipients   attendee.email
    from         "devinsampa@gmail.com"
    subject      "[devinsampa] Problemas no pagamento da inscrição"
    status       = {:canceled => "Cancelado", :refunded => "Devolvido"}
    body         :status => status[attendee.status], :name => attendee.name, :link => payment_url(:token => attendee.token)
  end

  def attendee_unregister(attendee)
    default_url_options[:host] = "www.devinsampa.com.br"
    recipients   attendee.email
    from         "devinsampa@gmail.com"
    subject      "[devinsampa] Cancelamento de inscrição"
    body         :attendee => attendee
  end

  def attendee_will_unregister(attendee)
    default_url_options[:host] = "www.devinsampa.com.br"
    recipients   attendee.email
    from         "devinsampa@gmail.com"
    subject      "[devinsampa] Sua inscrição será cancelada"
    body         :name => attendee.name, :link => payment_url(:token => attendee.token)
  end

  def alert_us(notification, request, params)
    default_url_options[:host] = "www.devinsampa.com.br"
    recipients   "tinorj@gmail.com, lfcipriani@gmail.com, nuxlli@gmail.com"
    from         "devinsampa@gmail.com"
    subject      "[devinsampa] Algum esperado querendo fazer baixa em nome do PagSeguro"
    body         :notification => notification.inspect, :request => request.inspect, :params => params.inspect
  end
end
