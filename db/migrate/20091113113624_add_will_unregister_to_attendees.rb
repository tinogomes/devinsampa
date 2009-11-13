class AddWillUnregisterToAttendees < ActiveRecord::Migration
  def self.up
    add_column :attendees, :will_unregister, :boolean, :default => false
  end

  def self.down
    remove_column :attendees, :will_unregister
  end
end
