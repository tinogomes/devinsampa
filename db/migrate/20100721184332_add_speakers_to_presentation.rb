class AddSpeakersToPresentation < ActiveRecord::Migration
  def self.up
    add_column :presentations, :principal_speaker_id, :integer
    add_column :presentations, :other_speaker_id, :integer
  end

  def self.down
    remove_column :presentations, :other_speaker
    remove_column :presentations, :principal_speaker
  end
end
