class AddNotesToAttendees < ActiveRecord::Migration
  def self.up
    add_column :attendees, :notes, :string
    add_column :attendees, :transaction_id, :string
  end

  def self.down
    remove_column :attendees, :transaction_id
    remove_column :attendees, :notes
  end
end
