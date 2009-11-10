class AddTokenToAttendees < ActiveRecord::Migration
  def self.up
    add_column :attendees, :token, :string
    
    add_index :attendees, :token
  end

  def self.down
    remove_index :attendees, :token
    remove_column :attendees, :token
  end
end
