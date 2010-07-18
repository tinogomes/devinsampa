class Speaker < ActiveRecord::Base
  has_many :presentation_speakers, :dependent => :destroy
  has_many :presentations, :through => :presentation_speakers

  has_attached_file :avatar

  validates_presence_of :name
  validates_presence_of :bio
  validates_presence_of :email
  validates_format_of :email, :with => User::EMAIL_REGEX, :if => proc { |obj| !obj.email.blank? }
end
