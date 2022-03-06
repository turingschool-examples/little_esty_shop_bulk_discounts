FactoryBot.define do
  factory :discount, class: Discount do
    name {"#{(Faker::TvShows::Simpsons.character)}'s Deal"}
    threshold { 10 }
    percent_discount { 20 }

    merchant
  end
end
