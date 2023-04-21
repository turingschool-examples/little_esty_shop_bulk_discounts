# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
require 'simplecov'
SimpleCov.start
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  Shoulda::Matchers.configure do |config|
      config.integrate do |with|
        with.test_framework :rspec
        with.library :rails
      end
    end

    def test_data
      @merchant_1 = Merchant.create(name: "James Franco", status: "enabled" )
      @merchant_2 = Merchant.create(name: "George R.R. Martin", status: "enabled" )
      @merchant_3 = Merchant.create(name: "Chris Rock", status: "enabled" )
      @merchant_4 = Merchant.create(name: "Lisa", status: "enabled" )
      @merchant_5 = Merchant.create(name: "Nicole", status: "enabled" )

      @bulk_discount_1 = @merchant_1.bulk_discounts.create(name: "10% off over 5", percentage_discount: 10, quantity_threshold: 5)
      @bulk_discount_2 = @merchant_2.bulk_discounts.create(name: "20% off over 5", percentage_discount: 20, quantity_threshold: 5)
      @bulk_discount_3 = @merchant_3.bulk_discounts.create(name: "30% off over 5", percentage_discount: 30, quantity_threshold: 5)
      @bulk_discount_4 = @merchant_4.bulk_discounts.create(name: "40% off over 5", percentage_discount: 40, quantity_threshold: 5)
      @bulk_discount_5 = @merchant_5.bulk_discounts.create(name: "50% off over 5", percentage_discount: 50, quantity_threshold: 5)

      @bulk_discount_1_1 = @merchant_1.bulk_discounts.create(name: "20% off over 10", percentage_discount: 20, quantity_threshold: 10)

      
    end
end
