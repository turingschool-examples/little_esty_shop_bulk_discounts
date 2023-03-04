# frozen_string_literal: true

FactoryBot.define do
  factory :invoice do
    customer_id { Faker::Number.within(range: 1..174) }
    status { [0, 1, 2].sample }
  end
end
