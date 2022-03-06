FactoryBot.define do
  factory :merchant, class: Merchant do
    name {Faker::Space.galaxy}

    # trait :with_items do
    #   after(:build) do |merchant|
    #     merchant.items = FactoryBot.build_list(:item, 7)
    #   end
    # end
    # trait :with_a_item_and_invoice_items do
    #   after(:build) do |merchant|
    #     merchant.items << FactoryBot.build(:item, :with_invoice_items)
    #   end
    # end
    # trait :with_a_invoice_item_and_invoices do
    #   after(:build) do |merchant|
    #     merchant.invoice_items << FactoryBot.build(:invoice_items, :with_invoices)
    #   end
    # end
    # trait :with_a_invoice_and_customers do
    #   after(:build) do |merchant|
    #     merchant.invoices << FactoryBot.build(:invoices, :with_customers)
    #   end
    # end
    # trait :with_a_invoice_and_transactions do
    #   after(:build) do |merchant|
    #     merchant.invoices << FactoryBot.build(:invoices, :with_transactions)
    #   end
    # end
  end
end
