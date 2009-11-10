class AttendeesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :pagseguro
  
  # GET /attendees
  # GET /attendees.xml
  def index
  end

  # GET /attendees/1
  # GET /attendees/1.xml
  def payment
    @attendee = Attendee.find_by_token(params[:token])
    
    if @attendee && @attendee.completed?
      flash[:notice] = "Pagamento da inscrição já confirmado."
      redirect_to(register_path)
    elsif @attendee
      # Instanciando o objeto para geração do formulário
      @order = PagSeguro::Order.new(@attendee.token)
      @order.add :id => 1, :price => 35, :describe => "Inscrição do devinsampa"
      session[:token] = @attendee.token
    else
      flash[:error] = "Inscrição não encontrada"
      redirect_to(register_path)
    end
  end

  # GET /attendees/new
  # GET /attendees/new.xml
  def new
    @attendee = Attendee.new
  end

  # POST /attendees
  # POST /attendees.xml
  def create
    unless Attendee.overload?
      @attendee = Attendee.new(params[:attendee])

      if @attendee.save
        spawn do
          Contact.deliver_attendee_created(@attendee)
        end
        flash[:notice] = 'Inscrição efetuado com sucesso.'
        redirect_to(payment_path(:token => @attendee.token))
      else
        render :action => "new"
      end
    else
      flash[:error] = "Não insista. Vagas encerradas, seu bobão!!"
      redirect_to(home_path)
    end
  end

  # POST /attendees/pagseguro
  def pagseguro
    unless request.post?
      @attendee = Attendee.find_by_token(session[:token])
      if @attendee.completed?
        flash[:notice] = "Pagamento da inscrição já confirmado."
        redirect_to(register_path) and return
      elsif @attendee.canceled?
        flash[:error] = "Hove algum problema no processo de pagamento. Tente novamente."
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
