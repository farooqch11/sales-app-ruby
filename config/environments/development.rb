PushvendorPos::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  config.action_mailer.perform_deliveries = true

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # for devise
  # config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  # config.action_mailer.delivery_method = :letter_opener
  # config.action_mailer.delivery_method = :smtp

  config.action_mailer.delivery_method = :smtp
  # SMTP settings for gmail
  config.action_mailer.smtp_settings = {
      :address              => "smtp.gmail.com",
      :port                 => 587,
      :user_name            => "faizuali4@gmail.com",
      :password             => "faizanahmad04",
      :authentication       => "plain",
      :enable_starttls_auto => true
  }

  # config.action_mailer.delivery_method = :mailgun
  # config.action_mailer.mailgun_settings = {
  #     api_key: 'key-bcb280695a70093c5db5a5c044ffed1a',
  #     domain: 'sandboxcc6cca2b2d1049b4a6dc8e2f2757ddf5.mailgun.org'
  # }

  # SMTP settings for gmail
  # config.action_mailer.smtp_settings = {
  #     :address              => "smtp.gmail.com",
  #     :port                 => 587,
  #     :user_name            => 'faizuali4@gmail.com',
  #     :password             => 'f8a1i8z4u',
  #     :authentication       => "plain",
  #     :enable_starttls_auto => true
  # }

  # ActionMailer::Base.smtp_settings = {
  #     :port           => 587,
  #     :address        => "smtp.mailgun.org",
  #     :domain         => ENV['domain'],
  #     :user_name      => ENV['username'],
  #     :password       => ENV['password'],
  #     :authentication => :plain,
  # }

  # config.action_mailer.delivery_method = :mailgun
  # config.action_mailer.mailgun_settings = {
  #     api_key: 'key-bcb280695a70093c5db5a5c044ffed1a',
  #     domain: 'tend360.herokuapp.com'
  # }

  # gmail_username: 'faizuali4@gmail.com'
  # gmail_password: 'f8a1i8z4u'
  # mailgun_api: 'key-bcb280695a70093c5db5a5c044ffed1a'
  # mailgun_domain: 'tend360.herokuapp.com'
  # mailgun_username: 'postmaster@sandboxcc6cca2b2d1049b4a6dc8e2f2757ddf5.mailgun.org'
  # mailgun_password: '5615a125e8ef7aea436e897598e22844'



  config.eager_load = true
  # config.action_mailer.default_url_options = { :host => 'https://tend360.herokuapp.com' }
  # config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.default_url_options = {host: 'lvh.me'}
  #
  # Do not compress assets
  config.assets.compress = false


end
