class ChangeUserAttributesForAuthentication < ActiveRecord::Migration
  def self.up
    add_column :users, :password_hash, :string

    remove_column :users, :persistence_token
    remove_column :users, :crypted_password
  end

  def self.down
    add_column :users, :crypted_password, :string
    add_column :users, :persistence_token, :string

    remove_column :users, :password_hash
  end
end