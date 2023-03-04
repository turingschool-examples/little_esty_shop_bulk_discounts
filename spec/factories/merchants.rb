# frozen_string_literal: true

FactoryBot.define do
  factory :merchant do
    name { Faker::Company.name }
  end
end
