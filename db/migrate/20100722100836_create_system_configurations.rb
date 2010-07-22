class CreateSystemConfigurations < ActiveRecord::Migration
  def self.up
    create_table :system_configurations, :force => true do |t|
      t.string :values

      t.timestamps
    end

    SystemConfiguration.create :values => SystemConfiguration::DEFAULT_KEYS
  end

  def self.down
    drop_table :system_configurations
  end
end
