FactoryBot.define do
  factory :invoice, class: Invoice do
    status {[0,1,2].sample}
   #  customer
   #
   #  trait :with_transactions do
   #    after(:build) do |invoice|
   #      invoice.transactions = FactoryBot.build_list(:transaction, 7)
   #    end
   #  end
   #  trait :with_invoice_items do
   #    after(:build) do |invoice|
   #      invoice.invoice_items = FactoryBot.build_list(:invoice_item, 7)
   #    end
   #  end
   #  trait :with_a_invoice_item_and_items do
   #    after(:build) do |invoice|
   #      invoice.invoice_items << FactoryBot.build(:invoice_item, :with_items)
   #    end
   #  end
   #  trait :with_a_invoice_item_and_items do
   #   after(:build) do |invoice|
   #     invoice.invoice_items << FactoryBot.build(:invoice_item, :with_items)
   #   end
   #  end
   #  trait :with_a_item_and_merchants do
   #   after(:build) do |invoice|
   #     invoice.items << FactoryBot.build(:item, :with_merchants)
   #   end
   # end
 end
end
