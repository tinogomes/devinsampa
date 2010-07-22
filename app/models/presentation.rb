class Presentation < ActiveRecord::Base
  default_scope :order => 'title'

  belongs_to :principal_speaker, :class_name => "Speaker", :foreign_key => "principal_speaker_id"
  belongs_to :other_speaker, :class_name => "Speaker", :foreign_key => "other_speaker_id"

  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :principal_speaker_id, :if => lambda {|p| (p.other_speaker_id || p.other_speaker_id) && p.principal_speaker.nil? }

  validate :validate_speakers

  def speakers
    [self.principal_speaker, self.other_speaker].compact
  end

  private
    def validate_speakers
      errors.add_to_base "principal and other speakers can't be the same" if same_speakers?
    end

    def same_speakers?
      (principal_speaker.not_nil? || principal_speaker.not_nil?) && (principal_speaker == other_speaker)
    end
end
