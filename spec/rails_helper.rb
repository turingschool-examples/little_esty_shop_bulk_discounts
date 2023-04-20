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
end

def test_data
  @merchant1 = Merchant.create!(name: 'Hair Care')
  @merchant2 = Merchant.create!(name: 'Jewelry')

  @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
  @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
  @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
  @item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant1.id)
  @item_7 = Item.create!(name: "Scrunchie", description: "This holds up your hair but is bigger", unit_price: 3, merchant_id: @merchant1.id)
  @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)

  @item_5 = Item.create!(name: "Bracelet", description: "Wrist bling", unit_price: 200, merchant_id: @merchant2.id)
  @item_6 = Item.create!(name: "Necklace", description: "Neck bling", unit_price: 300, merchant_id: @merchant2.id)

  @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
  @customer_2 = Customer.create!(first_name: 'Cecilia', last_name: 'Jones')
  @customer_3 = Customer.create!(first_name: 'Mariah', last_name: 'Carrey')
  @customer_4 = Customer.create!(first_name: 'Leigh Ann', last_name: 'Bron')
  @customer_5 = Customer.create!(first_name: 'Sylvester', last_name: 'Nader')
  @customer_6 = Customer.create!(first_name: 'Herber', last_name: 'Kuhn')

  @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
  @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-28 14:54:09")
  @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2)
  @invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 2)
  @invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 2)
  @invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 2)
  @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 2)

  @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 0)
  @ii_2 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
  @ii_3 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_2.id, quantity: 2, unit_price: 8, status: 2)
  @ii_4 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_3.id, quantity: 3, unit_price: 5, status: 1)
  @ii_6 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_4.id, quantity: 1, unit_price: 1, status: 1)
  @ii_7 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_7.id, quantity: 1, unit_price: 3, status: 1)
  @ii_8 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_8.id, quantity: 1, unit_price: 5, status: 1)
  @ii_9 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_4.id, quantity: 1, unit_price: 1, status: 1)

  @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
  @transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_2.id)
  @transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_3.id)
  @transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_4.id)
  @transaction5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice_5.id)
  @transaction6 = Transaction.create!(credit_card_number: 879799, result: 0, invoice_id: @invoice_6.id)
  @transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_7.id)
end
