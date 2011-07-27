class AttendeesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :pagseguro

  helper_method :can_register_new_attendees?, :cannot_register_new_attendees?

  def payment
    @attendee = Attendee.find_by_token(params[:token])

    if @attendee && @attendee.completed?
      flash[:notice] = "#{@attendee.name}, o pagamento da sua inscrição foi confirmada"
      redirect_to(register_path)
    elsif @attendee
      flash[:notice] = "#{@attendee.name}, estamos esperando a confirmação de pagamento pelo PagSeguro" if @attendee.really_pending?

      # Instanciando o objeto para geração do formulário
      @order = PagSeguro::Order.new(@attendee.token)
      @order.add :id => 11, :price => 7500, :description => "Inscrição para o Dev in Sampa 2011"
      session[:token] = @attendee.token
    else
      flash[:error] = "Não encontramos seu cadastro, sua chave está correta?"
      redirect_to(register_path)
    end
  end

  def new
    @attendee = Attendee.new unless Attendee.overload?
  end

  def create
    if ( cannot_register_new_attendees? )
      flash[:error] = no_time_message
      @attendee = Attendee.new(params[:attendee])
      render :action => "new" and return
    end

    Attendee.transaction do
      if Attendee.overload?
        flash[:error] = "Vagas encerradas, mas tenha esperança ;)"
        redirect_to(home_path) and return
      else
        @attendee = Attendee.new(params[:attendee])
        if @attendee.save
          redirect_to(payment_path(:token => @attendee.token))
        else
          render :action => "new"
        end
      end
    end

  end

  def pagseguro
    if request.post?
      capture_information and render :nothing => true
    else
      begin
        @attendee = Attendee.find_by_token!(session[:token])
      rescue
        redirect_to(register_path) and return
      end

      if @attendee.completed?
        flash[:notice] = "#{@attendee.name}, o pagamento da sua inscrição foi confirmada."
        session[:token] = nil
        redirect_to(register_path) and return
      elsif @attendee.canceled?
        flash[:error] = "#{@attendee.name}, ocorreu algum problema no processo de pagamento. Tente novamente."
        redirect_to(payment_path(:token => @attendee.token)) and return
      else
        return true
      end
    end
  end

  private

    def capture_information
      notification = PagSeguro::Notification.new(params)
      begin
        if notification.valid?(true)
          attendee = Attendee.find_by_token!(notification.order_id)
          attendee.update_payment_data!(notification)
        else
          spawn do
            Contact.alert_us(notification, request, params)
          end
          RAILS_DEFAULT_LOGGER.error("Alguém tentou simular um POST do PagSeguro: #{notification.inspect}")
        end
      rescue Exception => e
        RAILS_DEFAULT_LOGGER.error("Ocorreu um erro no processo de captura da compra, error: #{e}, notification data: #{notification.inspect}")
      end
    end

    def can_register_new_attendees?
      SystemConfiguration.can_register_attendee
    end

    def cannot_register_new_attendees?
      !can_register_new_attendees?
    end

    def no_time_message
      messages = [
        "Apressado você hein!?",
        "De novo? Paciência.",
        "Já vi que você não sabe esperar.",
        "Ainda não deu a hora.",
        "Rails não escala?",
        "Quer <a href='http://piadas-infames.blogspot.com/' title='Site do Piadas Infames'>uma piada</a> para descontrair?"
      ]
      messages[rand(messages.size)]
    end
end
