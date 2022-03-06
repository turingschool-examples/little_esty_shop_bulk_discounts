FactoryBot.define do
  factory :customer do
    first_name {Faker::Name.first_name}
    last_name {Faker::Dessert.variety}
    #
    # trait :with_invoices do
    #   after(:build) do |customer|
    #     customer.invoices = FactoryBot.build_list(:invoice, 7)
    #   end
    # end
    # trait :with_a_invoice_and_merchants do
    #   after(:build) do |customer|
    #     customer.invoices >> FactoryBot.build(:invoice, :with_merchants)
    #   end
    # end
    # trait :with_a_invoice_and_transactions do
    #   after(:build) do |customer|
    #     customer.invoices >> FactoryBot.build(:invoice, :with_transactions)
    #   end
    # end
  end
end
