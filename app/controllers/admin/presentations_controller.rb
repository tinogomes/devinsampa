# encoding: utf-8
class Admin::PresentationsController < Admin::AdminController
  before_filter :set_presentation, :only => [:edit, :update, :destroy]
  before_filter :load_speakers, :only => [:new, :edit]

  def index
    @presentations = Presentation.all
  end

  def new
    @presentation = Presentation.new()
  end

  def create
    @presentation = Presentation.new(params[:presentation])

    if @presentation.valid? && @presentation.save
      flash[:notice] = "#{@presentation.title} cadastrado"
      redirect_to admin_presentations_path
    else
      load_speakers
      render :action => :new
    end
  end

  def edit
  end

  def update
    @presentation.attributes = params[:presentation]

    if @presentation.valid? && @presentation.save
      flash[:notice] = "Os dados de #{@presentation.title} foram atualizados"
      redirect_to admin_presentations_path
    else
      load_speakers
      render :action => "edit"
    end
  end


  def destroy
    @presentation.destroy
    redirect_to(admin_presentations_url)
  end

  private
    def set_presentation
      @presentation = Presentation.find params[:id]
    end

    def load_speakers
      @speakers = Speaker.all :select => 'id, name'
    end

end
