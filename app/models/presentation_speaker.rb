class PresentationSpeaker < ActiveRecord::Base
  belongs_to :speaker
  belongs_to :presentation
end
