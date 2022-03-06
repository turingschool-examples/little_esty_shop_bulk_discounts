FactoryBot.define do
  factory :discount do
    name {"#{(Faker::TvShows::Simpsons.unique.character)}'s Deal"}
    quantity_threshold { 10 }
    percentage { 20 }

    merchant
  end
end
