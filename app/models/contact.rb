class Contact < ActionMailer::Base
  def from_site(contact, receive_a_copy = false)
    common_settings(contact.subject || "Contato via Dev in Sampa", contact.email)
    recipients    "contato@devinsampa.com.br"
    cc            contact.email if receive_a_copy
    body          :contact => contact
  end

  def attendee_created(attendee)
    common_settings "Confirmação de inscrição"
    recipients      attendee.email
    from            "devinsampa@gmail.com"
    body            :name => attendee.name, :link => payment_url(:token => attendee.token), :free => attendee.free?, :doc => attendee.doc
  end

  def attendee_confirmation(attendee)
    common_settings "Confirmação de pagamento"
    recipients      attendee.email
    body            :name => attendee.name, :doc => attendee.doc
  end

  def attendee_pending(attendee)
    status = {:pending => "Aguardando pagamento", :verifying => "Em análise"}

    common_settings "Aguardando confirmação de pagamento pelo PagSeguro"
    recipients      attendee.email
    body            :status => status[attendee.status], :name => attendee.name, :link => payment_url(:token => attendee.token)
  end

  def attendee_problem(attendee)
    status = {:canceled => "Cancelado", :refunded => "Devolvido"}

    common_settings "Problemas no pagamento da inscrição"
    recipients      attendee.email
    body            :status => status[attendee.status], :name => attendee.name, :link => payment_url(:token => attendee.token)
  end

  def attendee_unregister(attendee)
    common_settings "Cancelamento de inscrição"
    recipients      attendee.email
    body            :attendee => attendee
  end

  def attendee_will_unregister(attendee)
    common_settings "Sua inscrição será cancelada"
    recipients      attendee.email
    body            :name => attendee.name, :link => payment_url(:token => attendee.token)
  end

  def alert_us(notification, request, params)
    common_settings "Algum esperto querendo fazer baixa em nome do PagSeguro"
    recipients      "all@devinsampa.com.br"
    body            :notification => notification.inspect, :request => request.inspect, :params => params.inspect
  end

  private
  def common_settings(subject_, replying_to = "contato@devinsampa.com.br")
    default_url_options[:host] = "www.devinsampa.com.br"
    from          "devinsampa@gmail.com"
    subject       "[devinsampa] #{subject_}"
    reply_to      replying_to
  end
end
