class AddEmailToSpeakers < ActiveRecord::Migration
  def self.up
    add_column :speakers, :email, :string
  end

  def self.down
    remove_column :speakers, :email
  end
end
