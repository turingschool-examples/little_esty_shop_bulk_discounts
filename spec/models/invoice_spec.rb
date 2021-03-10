require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
  end
  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many :transactions}
  end
  describe "instance methods" do
    it "can return total_revenue" do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
      @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 1, unit_price: 10, status: 1)

      expect(@invoice_1.total_revenue).to eq(100)
    end

    it "can return discounted_revenue" do
      @merchant_1 = Merchant.create!(name: 'Hair care')
      @discount_1 = BulkDiscount.create!(name:"small discount", percentage_discount: 0.10, quantity_threshold: 6, merchant_id: @merchant_1.id)
      @discount_2 = BulkDiscount.create!(name:"medium discount", percentage_discount: 0.15, quantity_threshold: 10, merchant_id: @merchant_1.id)

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

      expect(@invoice_1.discounted_revenue).to eq(75.9)
    end
  end


    describe "AR methods" do
      it "can return the total savings relation object and can calculate total_savings" do
        @merchant_1 = Merchant.create!(name: 'Hair care')
        @discount_1 = BulkDiscount.create!(name:"small discount", percentage_discount: 0.10, quantity_threshold: 6, merchant_id: @merchant_1.id)
        @discount_2 = BulkDiscount.create!(name:"medium discount", percentage_discount: 0.15, quantity_threshold: 10, merchant_id: @merchant_1.id)

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

        expect(@invoice_1.total_savings_relation[0].max).to eq(6.0)
        expect(@invoice_1.total_savings_relation[1].max).to eq(2.1)
        expect(@invoice_1.total_savings).to eq(8.1)
      end
    end
end
