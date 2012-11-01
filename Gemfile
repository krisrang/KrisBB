source 'https://rubygems.org'
ruby "1.9.3"

gem 'rails', '~> 3.2.8'
gem 'foreman'
gem 'capistrano'
gem 'puma'
gem 'pusher'
gem 'em-http-request'

# Persistence & caching
gem 'mongoid'
gem 'memcachier'
gem 'dalli'

# Frontend
gem 'jquery-rails'
gem 'simple_form'
gem 'kaminari'
gem 'twitter-bootstrap-rails'

# Auth & auth
gem 'bcrypt-ruby'
gem 'sorcery'
gem 'cancan'

# Misc frameworks, libs
gem 'rails_config'
gem 'aws-sdk'
gem 'rdiscount'
gem 'mini_magick'
gem 'carrierwave'
gem 'carrierwave-mongoid', git: 'git://github.com/jnicklas/carrierwave-mongoid.git', branch: 'mongoid-3.0'
gem 'fog'
gem 'airbrake'
gem 'oj'
gem 'newrelic_rpm'
gem 'newrelic_moped'
gem 'girl_friday'

# Mailer
gem 'premailer-rails3'
gem 'hpricot'
gem 'mail_view'
gem 'action_mailer_cache_delivery'

group :assets do
  gem 'eco'
  gem 'execjs'
  gem 'therubyracer'
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'compass-rails'
  gem 'oily_png'
  gem 'asset_sync'
  gem 'js-routes'
end

group :development do
  gem 'terminal-notifier-guard'
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

  gem 'spork', '~> 1.0rc'
  gem 'spork-rails'
  gem 'guard-spork'
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'guard-cucumber'
end

