class AddDocToSpeakers < ActiveRecord::Migration
  def self.up
    add_column :speakers, :doc, :string
  end

  def self.down
    remove_column :speakers, :doc
  end
end
