require 'rubygems'
require 'spork'
#require 'spork/ext/ruby-debug'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'

  # Mongoid models reload
  require 'rails/mongoid'
  Spork.trap_class_method(Rails::Mongoid, :load_models)

  # Routes and app/ classes reload
  require 'rails/application'
  Spork.trap_method(Rails::Application::RoutesReloader, :reload!)
  Spork.trap_method(Rails::Application, :eager_load!)

  # Load railties
  require File.expand_path('../../config/environment', __FILE__)
  Rails.application.railties.all { |r| r.eager_load! }

  require 'rspec/rails'
  require 'rspec/autorun'
  require 'email_spec'
  require 'capybara/rspec'
  require 'capybara/poltergeist'

  RSpec.configure do |config|
    config.include(EmailSpec::Helpers)
    config.include(EmailSpec::Matchers)

    config.mock_with :rspec

    # Clean up the database
    config.before(:suite) { DatabaseCleaner.strategy = :truncation }
    config.before(:suite) { DatabaseCleaner.orm      = :mongoid }
    config.before(:each)  { DatabaseCleaner.clean }

    config.infer_base_class_for_anonymous_controllers = false
    config.order = "random"
  end

  ActiveSupport::DescendantsTracker.clear
  ActiveSupport::Dependencies.clear

  Capybara.default_selector = :css
  Capybara.javascript_driver = :poltergeist
  Capybara.default_wait_time = 5
end

Spork.each_run do
  FactoryGirl.reload

  I18n.backend.reload!
  Dir[Rails.root.join('spec/support/**/*.rb')].each {|f| require f}
  Dir[Rails.root.join('spec/views/**/*.rb')].each   {|f| require f}
end
