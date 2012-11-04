source 'https://rubygems.org'
ruby "1.9.3"

gem 'rails', '~> 3.2.8'
gem 'capistrano'
gem 'foreman'
gem 'puma'
gem 'pusher'
gem 'em-http-request'

# Persistence & caching
gem 'mongoid'
gem 'memcachier'
gem 'dalli'

# Frontend
gem 'simple_form'
gem 'kaminari'

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

# Assets
gem 'eco'
gem 'execjs'
gem 'therubyracer'
gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'
gem 'compass'
gem 'oily_png'
gem 'asset_sync'
gem 'jquery-rails'
gem 'js-routes'
gem 'turbo-sprockets-rails3'
gem 'twitter-bootstrap-rails'
gem 'less-rails'

group :development do
  gem 'terminal-notifier-guard'
  gem 'capistrano-unicorn', require: false
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

