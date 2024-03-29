Anonymail::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  ENV["REDISTOGO_URL"] = 'redis://localhost:6379' 

  ENV['HOOK_URL'] = 'http://bosonstudios.com:19999/api/mail'
  ENV['MANDRILL_AUTH_KEY'] = "DQ9S63FpFBFr5mCJiAXvtw"
  ENV['EMAIL_DOMAIN'] = "test.bosonstudios.com"

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  config.from_address = "admin@test.bosonstudios.com"
  config.host = 'localhost:14000'
  config.domain = "test.bosonstudios.com"

  config.action_mailer.default_url_options = {:host => config.host}
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.default_options = {:from => config.from_address}
  config.action_mailer.smtp_settings = {
    :address => "smtp.mandrillapp.com",
    :port    => "587",
    :domain  => config.domain,
    :user_name => "ray@thelondonvandal.com",
    :password => "3h1ixEfqtEcLWAlTES9VZw"
  }

#  config.action_mailer.default_url_options = { :host => 'localhost:14000' }
#  config.action_mailer.delivery_method = :smtp
#  config.action_mailer.default_options = {:from => "admin@anonymail.com"}
#  config.action_mailer.smtp_settings = {:address => "127.0.0.1", :port => 1025}

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :debug

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
end
