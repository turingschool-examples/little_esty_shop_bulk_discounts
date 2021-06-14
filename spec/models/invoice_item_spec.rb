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
  describe 'class methods' do
    describe 'eligible_items' do
      it "returns an array of items eligible for discounts" do
        @merchant1 = Merchant.create!(name: 'Hair Care')
        @merchant2 = Merchant.create!(name: 'Tester')
        @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
        @item_3 = Item.create!(name: "This one should show up", description: "Please show up!", unit_price: 20, merchant_id: @merchant1.id, status: 1)
        @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
        @item_2 = Item.create!(name: "Merchant2 Item", description: "This shouldn't show up", unit_price: 200, merchant_id: @merchant2.id)
        @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
        @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
        @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
        @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 1, unit_price: 15, status: 1)
        @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 100, unit_price: 200, status: 1)
        @ii_3 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_3.id, quantity: 5, unit_price: 20, status: 1)
        @discount1 = Discount.create!(percentage_discount: 0.50, quantity_threshold: 5, merchant_id: @merchant1.id)
        @discount2 = Discount.create!(percentage_discount: 0.75, quantity_threshold: 500, merchant_id: @merchant1.id)
        # @ii_1.reload
        expect(InvoiceItem.eligible_items).to eq([@ii_1, @ii_3])
      end
    end
  end
end

