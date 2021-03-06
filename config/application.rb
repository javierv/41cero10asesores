require File.expand_path('../boot', __FILE__)

require 'yajl/json_gem'
require 'yaml'
APP_CONFIG =  YAML.load(File.read(File.expand_path('../app_config.yml', __FILE__)))
APP_CONFIG["company"] = "41cero10 Asesores"
APP_CONFIG["domain"] = "41cero10.com"

require 'rails/all'
require "goalie/rails"

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require *Rails.groups(:assets => %w(development test))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module Calesur
  class Application < Rails::Application
    # Enable the asset pipeline
    config.assets.enabled = true
    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    config.generators do |g|
      g.stylesheets false
      g.helper false
      g.template_engine :haml
      g.test_framework :rspec
      g.fixture_replacement :factory_girl
      g.form_builder :simple_form
      g.fallbacks[:rspec] = :test_unit
    end
    config.i18n.default_locale = :es
    # Para que funcione Faker
    # Otra opción es config.i18n.locale = :es, y quitar default_locale.
    config.i18n.locale = :es
    config.i18n.fallbacks.defaults = [:en]
    config.time_zone  = 'Madrid'
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address:               "mail.#{APP_CONFIG["domain"]}",
      port:                  26,
      domain:                APP_CONFIG["domain"],
      user_name:             APP_CONFIG["email"].sub("@", "+"),
      password:              APP_CONFIG["password"],
      authentication:        'plain',
      enable_starttls_auto:  false
    }
  end
end
