require File.expand_path('../boot', __FILE__)

require 'csv'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsApp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    #config.time_zone = 'Santiago'
    config.active_record.default_timezone = :utc

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}').to_s]
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.default_locale = 'es-CL'
    config.i18n.available_locales = [:en, 'es-CL', 'pt-BR']

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # Change default Devise layout
    config.to_prepare do
      Devise::SessionsController.layout "auth/application.html.erb"
      Devise::RegistrationsController.layout proc{ |controller| user_signed_in? ? "application" : "auth/application.html.erb" }
      Devise::ConfirmationsController.layout "auth/application.html.erb"
      Devise::UnlocksController.layout "auth/application.html.erb"
      Devise::PasswordsController.layout "auth/application.html.erb"
    end

    config.generators do |g|
      #g.templates.unshift File::expand_path('../templates', __FILE__)
      g.orm               :active_record
      g.template_engine   :erb
      g.javascript_engine :js
      g.test_framework    :test_unit, fixture: true
    end

    # Configure Rake CORS
    config.middleware.insert_before 0, "Rack::Cors", logger: (-> { Rails.logger }) do
      allow do
        origins '*'

        resource '/api/web/v1/*',
          headers: :any,
          methods: [:get, :post, :delete, :put, :options, :head],
          max_age: 0
      end
    end
  end
end
