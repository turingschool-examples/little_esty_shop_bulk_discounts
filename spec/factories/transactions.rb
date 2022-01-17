FactoryBot.define do
  factory :transaction do
    result {[0,1].sample}
    credit_card_number {Faker::Finance.credit_card}
    invoice
  end
end 
