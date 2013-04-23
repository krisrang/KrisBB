source 'https://rubygems.org'
ruby "2.0.0"

gem 'rails', '~> 3.2.13'
gem 'capistrano'
gem 'foreman'
gem 'puma', '2.0.0.b7'
gem 'pusher'
gem 'em-http-request'
gem 'meow-logger'

# Persistence & caching
gem 'mongoid'
gem 'memcachier'
gem 'dalli'

# Frontend
gem 'simple_form'
gem 'kaminari'
gem 'twitter-bootstrap-rails'

# Auth & auth
gem 'bcrypt-ruby'
gem 'sorcery'
gem 'cancan'

# Misc frameworks, libs
gem 'rails_config'
gem 'rdiscount'
gem 'mini_magick'
gem 'carrierwave'
gem 'carrierwave-mongoid'
gem 'fog'
gem 'airbrake'
gem 'oj'
gem 'girl_friday'

# Mailer
gem 'premailer-rails3'
gem 'hpricot'
gem 'mail_view'
gem 'action_mailer_cache_delivery'

group :assets do
  gem 'eco'
  gem 'execjs'
  gem "therubyracer"
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'compass-rails'
  gem 'oily_png'
  gem 'asset_sync'
  gem 'js-routes'
  gem 'less-rails'
  gem 'jquery-rails'
  gem 'jquery-atwho-rails', "~> 0.1.7"
  gem 'turbo-sprockets-rails3'
end

group :development do
  gem 'terminal-notifier-guard'
  gem 'meow-deploy', require: false
  gem "binding_of_caller"
  gem "better_errors"
end

group :test do
  gem 'simplecov', require: false
  gem 'faker'
end

group :test, :development do
  gem 'rb-fsevent'

  gem 'rspec-rails'
  gem 'cucumber-rails', require: false
  gem 'factory_girl_rails'
  gem 'mongoid-rspec'

  gem 'email_spec'
  gem 'poltergeist'
  gem 'database_cleaner'
end

