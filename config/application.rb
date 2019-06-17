# frozen_string_literal: true

require_relative 'boot'

# Pick the frameworks you want:
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'sprockets/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Dobroserver
  class Application < Rails::Application
    config.time_zone = 'Moscow'
    config.autoload_paths += %W[#{config.root}/lib]
    config.load_defaults 5.2

    routes.default_url_options[:host] = Settings.main.domain

    config.generators do |g|
      g.assets false
      g.helper false

      g.view_specs false
      g.routing_specs false
      g.request_specs false
      g.skip_routes true
    end
  end
end
