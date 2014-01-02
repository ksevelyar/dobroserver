source 'https://rubygems.org'

gem 'rails', '~>4.0.2'
gem 'pg'

gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'

gem 'jquery-rails'
gem 'slim-rails'
# gem 'turbolinks'

gem 'kaminari'

gem 'sanitize'
gem 'redcarpet'

gem 'carrierwave'
gem 'mini_magick'

gem 'jbuilder'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby'


group :development, :test do
  gem 'pry-rails'

  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

group :development do
  gem 'spring'

  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rvm', ">=0.1.0", require: false
end

group :test do
  gem 'shoulda-matchers'

  gem 'coveralls', require: false
  gem 'simplecov', require: false
end

# Production
# ----------

# App server
gem 'unicorn'

# Mails 500 errors
gem 'exception_notification'

# New Relic
gem 'newrelic_rpm'
