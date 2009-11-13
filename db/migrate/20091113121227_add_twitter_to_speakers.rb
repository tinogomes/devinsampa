class AddTwitterToSpeakers < ActiveRecord::Migration
  def self.up
    add_column :speakers, :twitter, :string
  end

  def self.down
    remove_column :speakers, :twitter
  end
end
