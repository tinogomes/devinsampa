class Speaker < ActiveRecord::Base
  default_scope :order => 'name'

  has_attached_file :avatar

  validates_presence_of :name
  validates_presence_of :bio
  validates_presence_of :email
  validates_format_of :email, :with => User::EMAIL_REGEX, :if => proc { |obj| !obj.email.blank? }

  def presentations
    Presentation.all :conditions => ["principal_speaker_id = :speaker_id OR other_speaker_id = :speaker_id", {:speaker_id => self}]
  end
end
