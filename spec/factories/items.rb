FactoryBot.define do
  factory :item do
    name {Faker::Coffee.variety}
    description {Faker::Hipster.sentence}
    unit_price {Faker::Number.decimal(l_digits: 2)}

    # trait :with_invoice_items do
    #   after(:build) do |item|
    #     item.invoice_items = FactoryBot.build_list(:invoice_items, 7)
    #   end
    # end
    # trait :with_a_invoice_item_and_invoices do
    #   after(:build) do |item|
    #     merchant.invoice_items << FactoryBot.build(:invoice_items, :with_invoices)
    #   end
    # end
    #
    # merchant


  end
end
