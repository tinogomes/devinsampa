class Admin::SpeakersController < Admin::AdminController

  before_filter :set_speaker, :only => [:edit, :update, :destroy]

  def index
    @speakers = Speaker.all :order => "name", :select => 'id, name, email, twitter', :include => [:presentations]
  end

  def report
    @speakers = Speaker.all :order => "name", :select => 'name, doc'
    render :layout => false
  end

  def new
    @speaker = Speaker.new
  end

  def create
    @speaker = Speaker.new(params[:speaker])
    if @speaker.valid? && @speaker.save
      flash[:notice] = "#{@speaker.name} cadastrado"
      redirect_to admin_speakers_path
    else
      render :action => "new"
    end

  end

  def edit
  end

  def update
    @speaker.attributes = params[:speaker]
    if @speaker.valid? && @speaker.save
      flash[:notice] = "Os dados de #{@speaker.name} foram atualizados"
      redirect_to admin_speakers_path
    else
      render :action => "edit"
    end
  end

  def destroy
    @speaker.destroy
    redirect_to(admin_speakers_url)
  end

  private
    def set_speaker
      @speaker = Speaker.find(params[:id])
    end
end