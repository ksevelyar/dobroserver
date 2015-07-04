source 'https://rubygems.org'

gem 'rails', '~> 4.2'
gem 'pg'

gem 'sass-rails', '>= 4'
gem 'uglifier'
gem 'coffee-rails'
gem 'foundation-rails'

gem 'jquery-rails'
gem 'slim-rails'
gem 'kaminari'

gem 'sanitize'
gem 'redcarpet'

gem 'rails_config'
gem 'carrierwave'
gem 'mini_magick'

gem 'jbuilder'
gem 'sitemap_generator'
gem 'draper'

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
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

group :development do
  # show slow queries
  gem 'bullet'

  # only for :development, works faster than webrick
  gem 'puma'

  gem 'spring'
  gem 'quiet_assets'

  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rvm', '>=0.1.0', require: false
end

group :test do
  gem 'shoulda-matchers'
  gem 'capybara'

  gem 'coveralls', require: false
  gem 'simplecov', require: false
end
