class Presentation < ActiveRecord::Base
  has_many :presentation_speakers, :dependent => :destroy
  has_many :speakers, :through => :presentation_speakers

  validates_presence_of :title
  validates_presence_of :description
end
