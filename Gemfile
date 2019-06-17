# frozen_string_literal: true

source 'https://rubygems.org'

gem 'pg'
gem 'rails', '~> 5.0.0'

gem 'coffee-rails'
gem 'foundation-rails', '~> 5'
gem 'sass-rails', '>= 4'
gem 'uglifier'

gem 'jquery-rails'
gem 'kaminari'
gem 'slim-rails'

gem 'redcarpet'
gem 'sanitize'

gem 'carrierwave'
gem 'config'
gem 'mini_magick'

gem 'draper'
gem 'jbuilder'
gem 'listen', '~> 3.0'
gem 'sidekiq'
gem 'sidekiq-cron'
gem 'sidekiq-failures'
gem 'sinatra', require: false
gem 'sitemap_generator'

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby'

gem 'pry-rails'

# App server
gem 'unicorn'

# Mails 500 errors
gem 'exception_notification'

# New Relic
gem 'newrelic_rpm'

group :development, :test do
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
end

group :development do
  # show slow queries
  gem 'bullet'
  gem 'rack-mini-profiler'

  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rbenv', require: false
  gem 'capistrano-sidekiq', require: false
end

group :test do
  gem 'capybara'
  gem 'shoulda-matchers'

  gem 'coveralls', require: false
  gem 'simplecov', require: false
end
