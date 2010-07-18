class CreatePresentationSpeakers < ActiveRecord::Migration
  def self.up
    create_table :presentation_speakers do |t|
      t.integer :presentation_id
      t.integer :speaker_id

      t.timestamps
    end
  end

  def self.down
    drop_table :presentation_speakers
  end
end
