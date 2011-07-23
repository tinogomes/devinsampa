# encoding: utf-8
class Admin::AgendasController < Admin::AdminController
  before_filter :set_presentation, :only => [:new, :edit]
  before_filter :set_agenda, :only => [:edit, :update]

  def index
    @agendas = Agenda.all
  end

  def new
    @agenda = Agenda.new
    @agenda.attributes = params[:agenda] if params[:agenda]
  end

  def create
    @agenda = Agenda.new(params[:agenda])

    if @agenda.valid? && @agenda.save
      flash[:notice] = "#{@agenda.event} cadastrado"
      redirect_to admin_agenda_path
    else
      set_presentation
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
      redirect_to admin_agenda_path
    else
      set_presentation
      render :action => "edit"
    end
  end

  private
    def set_agenda
      @agenda = Agenda.find(params[:id])
    end

    def set_presentation
      @presentations = Presentation.all :select => "id, title", :order => "title"
    end
end