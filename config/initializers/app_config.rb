AppConfig.setup do |config|
  config[:env] = Rails.env || "development"
  config[:path] = Rails.root.join("config/app_config.yml")
end
