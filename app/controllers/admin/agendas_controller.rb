class Admin::AgendasController < Admin::AdminController
  before_filter :set_speakers, :except => [:index, :create, :update]
  before_filter :set_agenda, :only => [:edit, :update]
  
  def index
    @agendas = Agenda.find :all, :select => 'agendas.*, speakers.name', :include => [:speaker], :order => 'start_time'
  end
  
  def new
    @agenda = Agenda.new
    @agenda.attributes = params[:agenda] if params[:agenda]
  end
  
  def create
    @agenda = Agenda.new(params[:agenda])

    if @agenda.valid? && @agenda.save
      flash[:notice] = "#{@agenda.event} cadastrado"
      redirect_to admin_agendas_path
    else
      set_speakers
      render :action => "new", :agenda => params[:agenda]
    end

  end
  
  def edit
    @agenda.attributes = params[:agenda]
  end
  
  def update
    @agenda.attributes = params[:agenda]
    if @agenda.valid? && @agenda.save
      flash[:notice] = "Os dados de #{@agenda.event} foram atualizados"
      redirect_to admin_agendas_path
    else
      set_speakers
      render :action => "edit"
    end
  end
  
  private
    def set_agenda
      @agenda = Agenda.find(params[:id])
    end
    
    def set_speakers
      @speakers = Speaker.all :select => "id, name", :order => "name"
    end
end