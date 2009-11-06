class CreateSpeakers < ActiveRecord::Migration
  def self.up
    create_table :speakers do |t|
      t.string :name
      t.text :bio
      t.string :presentation
      t.text :description
      t.string :filename
      t.integer :size
      t.string :content_type

      t.timestamps
    end
    
    add_index :speakers, :name
  end

  def self.down
    drop_table :speakers
  end
end
