class CreateAttendees < ActiveRecord::Migration
  def self.up
    create_table :attendees do |t|
      t.string :name
      t.string :email
      t.string :doc
      t.string :company
      t.string :status
      t.string :payment_method
      t.datetime :processed_at
      t.text :buyer

      t.timestamps
    end
  end

  def self.down
    drop_table :attendees
  end
end
