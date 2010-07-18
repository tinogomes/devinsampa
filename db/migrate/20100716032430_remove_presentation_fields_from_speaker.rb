class RemovePresentationFieldsFromSpeaker < ActiveRecord::Migration
  def self.up
    remove_column :speakers, :presentation
    remove_column :speakers, :description
  end

  def self.down
    add_column :speakers, :description, :text
    add_column :speakers, :presentation, :string
  end
end
