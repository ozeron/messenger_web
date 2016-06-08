require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Messenger
  class Application < Rails::Application
    config.middleware.use I18n::JS::Middleware
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Kyiv'
    config.assets.paths << Rails.root.join("vendor/assets/twitter-bootstrap-static/twitter/fonts/")

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*', '*.{rb,yml}').to_s]
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', 'backend', '*', '*.{rb,yml}').to_s]
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', 'backend', '*', '*', '*.{rb,yml}').to_s]
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', 'shared' ,'*', '*.{rb,yml}').to_s]

    config.i18n.enforce_available_locales = true
    I18n.config.enforce_available_locales = true
    config.i18n.default_locale = :uk
    config.i18n.available_locales = [:en, :ru, :uk]
    config.i18n.fallbacks = true

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.autoload_paths += Dir["#{Rails.root}/app/**/**"]
    config.autoload_paths << Rails.root.join('app', 'queries', '**', '**')
    config.autoload_paths += Dir[Rails.root.join('lib')]
    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.active_job.queue_adapter = :resque
  end
end
