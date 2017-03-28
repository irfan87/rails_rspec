#Replace with below for Option 2: with 'selenium-webdriver'
    #Note: if selenium-webdriver gem does not update to newest Firefox version fast enough for you
    #you can download a specific version of Firefox and configure to use that version in tests
    #example:
      #Capybara.register_driver :selenium do |app|
        #require 'selenium/webdriver'
        #Selenium::WebDriver::Firefox::Binary.path = "/home/user/Sites/firefox46/firefox"
        #Capybara::Selenium::Driver.new(app, :browser => :firefox)
      #end
  ENV['RAILS_ENV'] ||= 'test'
  require File.expand_path('../../config/environment', __FILE__)
  # Prevent database truncation if the environment is production
  abort("The Rails environment is running in production mode!") if Rails.env.production?
  require 'spec_helper'
  require 'rspec/rails'
  require 'capybara/rspec'
  require 'simple_bdd'
  require 'shoulda/matchers'

  ActiveRecord::Migration.maintain_test_schema!

  RSpec.configure do |config|
    config.include FactoryGirl::Syntax::Methods

    # config.fixture_path = "#{::Rails.root}/spec/fixtures"

    config.use_transactional_fixtures = false

    config.before(:suite) do
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
      DatabaseCleaner.strategy = :transaction
    end

    config.before(:each, :js => true) do
      DatabaseCleaner.strategy = :truncation
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

    config.include SimpleBdd, type: :feature

    Shoulda::Matchers.configure do |config|
      config.integrate do |with|
        with.test_framework :rspec
        with.library :rails
      end
    end

    config.infer_spec_type_from_file_location!

    config.filter_rails_from_backtrace!

  end
