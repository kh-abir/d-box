Rails.application.configure do

  config.cache_classes = true
  config.eager_load = true

  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  config.public_file_server.enabled = true

  config.assets.compile = false
  config.active_storage.service = :local
  config.log_level = :debug

  config.consider_all_requests_local = true
  config.log_tags = [:request_id]
  config.action_mailer.perform_caching = false
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new
  config.active_record.dump_schema_after_migration = false
  config.action_mailer.perform_deliveries = true
  config.action_mailer.default_url_options = { host: 'https://d--box.herokuapp.com/'}
  config.action_mailer.delivery_method = :letter_opener_web

  config.stripe.secret_key = Rails.application.credentials.stripe[:development][:secret_key]
  config.stripe.publishable_key = Rails.application.credentials.stripe[:development][:publishable_key]

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end
end
