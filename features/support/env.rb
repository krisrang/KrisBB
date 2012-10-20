require 'rubygems'
require 'spork'

Spork.prefork do
  require 'cucumber/rails'
  require 'capybara/poltergeist'
  require 'email_spec'
  require 'email_spec/cucumber'

  Capybara.register_driver :poltergeist do |app|
    if RUBY_PLATFORM.downcase.include?("darwin")
      Capybara::Poltergeist::Driver.new(app, 
        phantomjs: "#{Rails::root}/features/support/darwin/phantomjs/bin/phantomjs")
    elsif RUBY_PLATFORM.downcase.include?("linux")
      bits = 1.size == 4 ? "32" : "64"
      Capybara::Poltergeist::Driver.new(app, 
        phantomjs: "#{Rails::root}/features/support/linux#{bits}/phantomjs/bin/phantomjs")
    end
  end

  Capybara.default_selector = :css
  Capybara.javascript_driver = :poltergeist
  Capybara.default_wait_time = 5

  GirlFriday::Queue.immediate!

  AfterStep('@wait-ajax') do
    begin
      step 'I wait until all Ajax requests are complete'
    rescue
    end
  end
end

Spork.each_run do
  ActionController::Base.allow_rescue = false

  begin
    DatabaseCleaner.strategy = :truncation
  rescue NameError
    raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
  end

  Cucumber::Rails::Database.javascript_strategy = :truncation
  FactoryGirl.reload
  ActionMailer::Base.deliveries.clear
end
