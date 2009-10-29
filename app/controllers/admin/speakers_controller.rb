class Admin::SpeakersController < Admin::AdminController
  before_filter :only_admin
  
  def new
    @speaker = Speaker.new
  end

  def edit
    @speaker = Speaker.find(params[:id])
  end

  def create
    @speaker = Speaker.new(params[:speaker])

    if @speaker.save
      flash[:notice] = 'Speaker was successfully created.'
      redirect_to(speakers_url) and return
    else
      render :action => "new"
    end
  end

  def update
    @speaker = Speaker.find(params[:id])

    if @speaker.update_attributes(params[:speaker])
      flash[:notice] = 'Speaker was successfully updated.'
      redirect_to(speakers_url) and return
    else
      render :action => "edit"
    end
  end

  def destroy
    @speaker = Speaker.find(params[:id])
    @speaker.destroy
    
    redirect_to(speakers_path)
  end
end
