class Admin::AgendasController < Admin::AdminController
  before_filter :set_speakers
  
  def new
    @agenda = Agenda.new
  end
  
  def create
    @agenda = Agenda.new(params[:agenda])

    if @agenda.valid? && @agenda.save
      flash[:notice] = "#{@agenda.event} cadastrado"
      redirect_to agenda_path
    else
      render :action => "new"
    end

  end
  
  def edit
    set_agenda
  end
  
  def update
    set_agenda
    @agenda.attributes = params[:agenda]
    if @agenda.valid? && @agenda.save
      flash[:notice] = "Os dados de #{@agenda.event} foram atualizados"
      redirect_to agenda_path
    else
      render :action => "edit"
    end
  end
  
  private
    def set_agenda
      @agenda = Agenda.find(params[:id])
    end
    
    def set_speakers
      @speakers = Speaker.all :order => "name"
    end
end