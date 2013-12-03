require 'rubygems'

ENV["RAILS_ENV"] ||= 'test'

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
  config.include(FactoryGirl::Syntax::Methods)
  config.include(Mongoid::Matchers)
  config.include(Sorcery::TestHelpers::Rails, type: :controller)

  config.mock_with :rspec

  # Clean up the database
  config.before(:suite) { DatabaseCleaner.strategy = :truncation }
  config.before(:suite) { DatabaseCleaner.orm      = :mongoid }
  config.before(:each)  { DatabaseCleaner.clean }

  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"

  config.tty = true
end

ActiveSupport::DescendantsTracker.clear
ActiveSupport::Dependencies.clear

Capybara.default_selector = :css
Capybara.javascript_driver = :poltergeist
Capybara.default_wait_time = 5

GirlFriday::Queue.immediate!
