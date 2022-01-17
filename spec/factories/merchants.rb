FactoryBot.define do
  factory :merchant do
    name {Faker::Space.galaxy}
    invoices
    items
  end
end 
