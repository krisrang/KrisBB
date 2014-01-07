source 'https://rubygems.org'
ruby "2.1.0"

gem 'rails', '~> 3.2.16'
gem 'foreman'
gem 'puma'
gem 'pusher'
gem 'em-http-request'

# Persistence & caching
gem 'mongoid'
gem 'dalli'

# Frontend
gem 'simple_form'
gem 'kaminari'
gem 'twitter-bootstrap-rails'

# Auth & auth
gem 'bcrypt-ruby'
gem 'sorcery', '0.8.1'
gem 'cancan'

# Misc frameworks, libs
gem 'rails_config'
gem 'rdiscount'
gem 'mini_magick'
gem 'carrierwave'
gem 'carrierwave-mongoid'
gem 'fog'
gem 'sentry-raven'
gem 'newrelic_rpm'
gem 'oj'
gem 'girl_friday'
gem 'unf'
gem 'ci_reporter'
gem 'le'

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
  gem "binding_of_caller"
  gem "better_errors"
end

group :test, :development do
  gem 'faker'
  gem 'rspec-rails'
  gem 'cucumber-rails', require: false
  gem 'factory_girl_rails'
  gem 'mongoid-rspec'
  gem 'email_spec'
  gem 'poltergeist'
  gem 'database_cleaner'

  gem 'rb-fsevent'
end

gem 'rails_12factor', group: :production
