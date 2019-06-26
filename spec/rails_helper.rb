require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

require 'database_cleaner'

# Protect the DBs
abort('Must be run in test') unless Rails.env.test?

require 'rspec/rails'
require 'devise'

Dir[Rails.root.join('spec/support/*.rb')].each { |file| require file }

RSpec.configure do |config|
  # Sqlite won't do transactions. I would have used a decent DB really
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

end
