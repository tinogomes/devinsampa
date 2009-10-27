class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :email
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.string :role, :default => "attendee"
      t.timestamps
    end
    
    add_index :users, :email, :unique => true
    add_index :users, :username, :unique => true
  end
  
  def self.down
    remove_index :users, :column => :email
    remove_index :users, :column => :username
    drop_table :users
  end
end
