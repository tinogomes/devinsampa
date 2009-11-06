class CreateAgendas < ActiveRecord::Migration
  def self.up
    create_table :agendas do |t|
      t.string :start_time
      t.string :end_time
      t.string :event
      t.integer :speaker_id

      t.timestamps
    end
    
    add_index :agendas, :start_time
  end

  def self.down
    drop_table :agendas
  end
end
