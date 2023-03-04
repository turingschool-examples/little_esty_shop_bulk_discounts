FactoryBot.define do
  factory :bulk_discount do
    merchant_id { Faker::Number.within(range: 1..100) }
    percent_discounted { Faker::Number.within(range: 1..100) }
    quantity_threshold { Faker::Number.within(range: 1..10) }
  end
end
