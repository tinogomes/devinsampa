# encoding: utf-8
mailer_config_file = Rails.root.join("config/mailer.yml")
if File.exists?(mailer_config_file)
  mailer_config = File.open(mailer_config_file)
  mailer_options = YAML.load(mailer_config)
  ActionMailer::Base.smtp_settings = mailer_options.symbolize_keys
else
  puts "I cant load config/mailer.yml file"
end