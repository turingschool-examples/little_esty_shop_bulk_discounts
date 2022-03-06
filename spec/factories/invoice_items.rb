FactoryBot.define do
  factory :invoice_item, class: InvoiceItem do
    status {[0,1,2].sample}
    # item
    # invoice
  end
end
