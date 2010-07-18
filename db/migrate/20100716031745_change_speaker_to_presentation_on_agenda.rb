class ChangeSpeakerToPresentationOnAgenda < ActiveRecord::Migration
  def self.up
    rename_column :agendas, :speaker_id, :presentation_id
  end

  def self.down
    rename_column :agendas, :presentation_id, :speaker_id
  end
end