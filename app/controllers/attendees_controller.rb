class AttendeesController < ApplicationController
  # GET /attendees
  # GET /attendees.xml
  def index
  end

  # GET /attendees/1
  # GET /attendees/1.xml
  def payment
    @attendee = Attendee.find_by_token(params[:token])
    
    if @attendee
      # Instanciando o objeto para geração do formulário
      @order = PagSeguro::Order.new(@attendee.token)
      @order.add :id => 1, :price => 35, :describe => "Inscrição do devinsampa"
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
  end
  
  # POST /attendees/pagseguro
  def pagseguro
  end
end
