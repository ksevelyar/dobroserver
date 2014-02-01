source 'https://rubygems.org'

# ruby '2.1.0'

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

gem 'pry-rails'

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

group :development do
  # show slow queries
  gem "bullet"

  # only for :development, works faster than webrick
  gem 'puma'
  gem 'spring'

  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rvm', ">=0.1.0", require: false
end

group :test do
  gem 'shoulda-matchers'
  gem 'capybara'

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
