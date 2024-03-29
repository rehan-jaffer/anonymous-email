Anonymail::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = false

  # Configure static asset server for tests with Cache-Control for performance.
  config.serve_static_assets  = true
  config.static_cache_control = "public, max-age=3600"

  ENV["REDISTOGO_URL"] = 'redis://localhost:6379'

  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  ENV['HOOK_URL'] = 'http://bosonstudios.com:19999/api/mail'
  ENV['MANDRILL_AUTH_KEY'] = "DQ9S63FpFBFr5mCJiAXvtw"
  ENV['EMAIL_DOMAIN'] = "test.bosonstudios.com"


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


  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :smtp

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr
end
