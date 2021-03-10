require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "validations" do
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
  end
  describe "relationships" do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end

  describe "instance methods" do
    it "It can return the best discount" do
      @merchant_1 = Merchant.create!(name: 'Hair care')
      @discount_1 = BulkDiscount.create!(name:"small discount", percentage_discount: 0.10, quantity_threshold: 4, merchant_id: @merchant_1.id)
      @discount_2 = BulkDiscount.create!(name:"medium discount", percentage_discount: 0.15, quantity_threshold: 6, merchant_id: @merchant_1.id)
      @discount_3 = BulkDiscount.create!(name:"huge discount", percentage_discount: 0.20, quantity_threshold: 10, merchant_id: @merchant_1.id)

      @customer_1 = Customer.create!(first_name: "kyle", last_name: "schulz")
      @invoice_1 = Invoice.create(customer_id: @customer_1.id, status: 0)
      @item_1 = Item.create!(name: "name 1", description: "item 1", unit_price: 4, merchant_id: @merchant_1.id)
      @item_2 = Item.create!(name: "name 2", description: "item 2", unit_price: 2, merchant_id: @merchant_1.id)
      @item_3 = Item.create!(name: "name 3", description: "item 3", unit_price: 3, merchant_id: @merchant_1.id)
      @item_4 = Item.create!(name: "name 4", description: "item 4", unit_price: 5, merchant_id: @merchant_1.id)
      @merchant_1.items << [@item_1, @item_2, @item_3, @item_4]
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 10, unit_price: 4, status: 2)
      @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 7, unit_price: 3, status: 1)
      @ii_3 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_3.id, quantity: 5, unit_price: 3, status: 1)
      @ii_4 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_4.id, quantity: 2, unit_price: 4, status: 1)

      expect(@ii_1.find_discount).to eq(@discount_2.id)
    end
  end
end
