require 'rubygems'
require 'spork'

Spork.prefork do
  unless ENV['DRB'] || ENV['TDDIUM']
    require 'simplecov'
    SimpleCov.start 'rails'
  end

  require 'cucumber/rails'
  require 'capybara/poltergeist'

  Capybara.default_selector = :css
  Capybara.javascript_driver = :poltergeist
  Capybara.default_wait_time = 5
end

Spork.each_run do
  if ENV['DRB'] && !ENV['TDDIUM']
    require 'simplecov'
    SimpleCov.start 'rails'
  end

  ActionController::Base.allow_rescue = false

  begin
    DatabaseCleaner.strategy = :truncation
  rescue NameError
    raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
  end

  Cucumber::Rails::Database.javascript_strategy = :truncation
  FactoryGirl.reload
end
