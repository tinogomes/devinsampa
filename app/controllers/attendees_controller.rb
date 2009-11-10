class AttendeesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :pagseguro
  
  def payment
    @attendee = Attendee.find_by_token(params[:token])
    
    if @attendee && @attendee.completed?
      flash[:notice] = "#{@attendee.name}, o pagamento da sua inscrição foi confirmada"
      redirect_to(register_path)
    elsif @attendee
      flash[:notice] = "#{@attendee.name}, estamos esperando a confirmação de pagamento pelo PagSeguro" if @attendee.really_pending?
      
      # Instanciando o objeto para geração do formulário
      @order = PagSeguro::Order.new(@attendee.token)
      @order.add :id => 1, :price => 3500, :description => "Inscrição do devinsampa"
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
    attendee_saved = false
    Attendee.transaction do
      if Attendee.overload?
        flash[:error] = "Vagas encerradas, mas tenha esperança ;)"
        redirect_to(home_path) and return
      else
        attendee_saved = (@attendee = Attendee.new(params[:attendee])).save
      end
    end
    
    if attendee_saved
      spawn do
        Contact.deliver_attendee_created(@attendee)
      end
      redirect_to(payment_path(:token => @attendee.token))
    else
      render :action => "new"
    end
  end

  def pagseguro
    unless request.post?
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
    else
      capture_information and render :nothing => true
    end
  end
  
  private
  
    def capture_information
      pagseguro_notification do |notification|
        begin
          attendee = Attendee.find_by_token!(notification.order_id)
          attendee.update_payment_data(notification)
        rescue Exception => e
          RAILS_DEFAULT_LOGGER.error("Ocorreu um erro no processo de captura da compra, error: #{e}, notification data: #{notification.inspect}")
        end
      end
    end
end
