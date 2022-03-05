FactoryBot.define do
  factory :invoice_item do
    status {[0,1,2].sample}
    merchant
    invoice
  end
end
