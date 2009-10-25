class SpeakersController < ApplicationController
  def index
    @speakers = Speaker.all :order => 'name'
  end

end
