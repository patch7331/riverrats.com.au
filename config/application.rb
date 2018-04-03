require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RiverratsComAu
  class Application < Rails::Application

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.action_mailer.default_url_options = { host: 'riverrats.com.au' }

    config.active_job.queue_adapter = :sidekiq

    # Add models achievements path
    # noinspection RubyLiteralArrayInspection
    config.autoload_paths += [
      "#{config.root}/app/models/achievements",
      "#{config.root}/app/models/achievements/participation",
      "#{config.root}/app/models/achievements/score",
      "#{config.root}/app/models/achievements/wins"
    ]

    # Register observers
    config.active_record.observers = :game_observer

  end
end
