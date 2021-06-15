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
  describe 'instance methods' do
    describe 'apply_discounts' do
      it "updates the discounted_price" do
        @merchant1 = Merchant.create!(name: 'Hair Care')
        @merchant2 = Merchant.create!(name: 'Tester')
        @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
        @item_2 = Item.create!(name: "This one should show up", description: "Please show up!", unit_price: 20, merchant_id: @merchant1.id, status: 1)
        @item_3 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
        @item_99 = Item.create!(name: "Merchant2 Item", description: "This shouldn't show up", unit_price: 200, merchant_id: @merchant2.id)
        @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
        @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
        @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 10, unit_price: 10, status: 2)
        @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 5, unit_price: 20, status: 1)
        @ii_3 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_3.id, quantity: 1, unit_price: 15, status: 1)
        @ii_99 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_99.id, quantity: 100, unit_price: 200, status: 1)
        @discount1 = Discount.create!(percentage_discount: 0.50, quantity_threshold: 5, merchant_id: @merchant1.id)
        @discount2 = Discount.create!(percentage_discount: 0.75, quantity_threshold: 10, merchant_id: @merchant1.id)
        @discount3 = Discount.create!(percentage_discount: 0.85, quantity_threshold: 5000, merchant_id: @merchant1.id)

        @invoice_1.invoice_items.each do |ii|
          ii.apply_discount
        end

        @ii_1.reload
        @ii_2.reload
        @ii_3.reload
        @ii_99.reload

        expect(@ii_1.discounted_price).to eq(2.5)
        expect(@ii_2.discounted_price).to eq(10)
        expect(@ii_3.discounted_price).to eq(15)
        expect(@ii_99.discounted_price).to eq(200)
      end
    end
    describe 'has_discount' do
      it 'returns true if a discount was applied' do
        @merchant1 = Merchant.create!(name: 'Hair Care')
        @merchant2 = Merchant.create!(name: 'Tester')
        @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
        @item_2 = Item.create!(name: "This one should show up", description: "Please show up!", unit_price: 20, merchant_id: @merchant1.id, status: 1)
        @item_3 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
        @item_99 = Item.create!(name: "Merchant2 Item", description: "This shouldn't show up", unit_price: 200, merchant_id: @merchant2.id)
        @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
        @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
        @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 10, unit_price: 10, status: 2)
        @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 5, unit_price: 20, status: 1)
        @ii_3 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_3.id, quantity: 1, unit_price: 15, status: 1)
        @ii_99 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_99.id, quantity: 100, unit_price: 200, status: 1)
        @discount1 = Discount.create!(percentage_discount: 0.50, quantity_threshold: 5, merchant_id: @merchant1.id)
        @discount2 = Discount.create!(percentage_discount: 0.75, quantity_threshold: 10, merchant_id: @merchant1.id)
        @discount3 = Discount.create!(percentage_discount: 0.85, quantity_threshold: 5000, merchant_id: @merchant1.id)

        @invoice_1.invoice_items.each do |ii|
          ii.apply_discount
        end

        @ii_1.reload
        @ii_2.reload
        @ii_3.reload
        @ii_99.reload

        expect(@ii_1.has_discount?).to eq(true)
        expect(@ii_2.has_discount?).to eq(true)
        expect(@ii_3.has_discount?).to eq(false)
        expect(@ii_99.has_discount?).to eq(false)
      end
    end
    describe 'applied_discount' do
      it 'returns the discount object that was applied' do
        @merchant1 = Merchant.create!(name: 'Hair Care')
        @merchant2 = Merchant.create!(name: 'Tester')
        @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
        @item_2 = Item.create!(name: "This one should show up", description: "Please show up!", unit_price: 20, merchant_id: @merchant1.id, status: 1)
        @item_3 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
        @item_99 = Item.create!(name: "Merchant2 Item", description: "This shouldn't show up", unit_price: 200, merchant_id: @merchant2.id)
        @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
        @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
        @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 10, unit_price: 10, status: 2)
        @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 5, unit_price: 20, status: 1)
        @ii_3 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_3.id, quantity: 1, unit_price: 15, status: 1)
        @ii_99 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_99.id, quantity: 100, unit_price: 200, status: 1)
        @discount1 = Discount.create!(percentage_discount: 0.50, quantity_threshold: 5, merchant_id: @merchant1.id)
        @discount2 = Discount.create!(percentage_discount: 0.75, quantity_threshold: 10, merchant_id: @merchant1.id)
        @discount3 = Discount.create!(percentage_discount: 0.85, quantity_threshold: 5000, merchant_id: @merchant1.id)

        @invoice_1.invoice_items.each do |ii|
          ii.apply_discount
        end

        @ii_1.reload
        @ii_2.reload
        @ii_3.reload
        @ii_99.reload
        
        expect(@ii_1.applied_discount).to eq(@discount2.id)
        expect(@ii_2.applied_discount).to eq(@discount1.id)
        expect(@ii_3.applied_discount).to eq(nil)
        expect(@ii_99.applied_discount).to eq(nil)
      end
    end
  end
end
