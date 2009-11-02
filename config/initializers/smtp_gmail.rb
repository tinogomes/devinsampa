mailer_config = File.open("#{RAILS_ROOT}/config/mailer.yml")
mailer_options = YAML.load(mailer_config)
ActionMailer::Base.smtp_settings = mailer_options.symbolize_keys
