class Admin::SpeakersController < ApplicationController
  def index
    @speakers = Speaker.all :select => "id, name, presentation"

    respond_to do |format|
      format.html
    end
  end

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
      redirect_to(admin_speakers_path)
    else
      render :action => "new"
    end
  end

  def update
    @speaker = Speaker.find(params[:id])

    if @speaker.update_attributes(params[:speaker])
      flash[:notice] = 'Speaker was successfully updated.'
      redirect_to(admin_speakers_path)
    else
      render :action => "edit"
    end
  end

  def destroy
    @speaker = Speaker.find(params[:id])
    @speaker.destroy
    
    redirect_to(admin_speakers_url)
  end
end
