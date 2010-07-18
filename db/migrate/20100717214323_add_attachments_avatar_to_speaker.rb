class AddAttachmentsAvatarToSpeaker < ActiveRecord::Migration
  def self.up
    add_column :speakers, :avatar_file_name, :string
    add_column :speakers, :avatar_content_type, :string
    add_column :speakers, :avatar_file_size, :integer
    add_column :speakers, :avatar_updated_at, :datetime

    remove_column :speakers, :filename
    remove_column :speakers, :size
    remove_column :speakers, :content_type
  end

  def self.down
    add_column :speakers, :filename, :string
    add_column :speakers, :size, :integer
    add_column :speakers, :content_type, :string

    remove_column :speakers, :avatar_file_name
    remove_column :speakers, :avatar_content_type
    remove_column :speakers, :avatar_file_size
    remove_column :speakers, :avatar_updated_at
  end
end
