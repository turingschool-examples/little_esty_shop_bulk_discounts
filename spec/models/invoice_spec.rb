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
    it "total_revenue" do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
      @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 1, unit_price: 10, status: 1)

      expect(@invoice_1.total_revenue).to eq(100)
    end
  end

    it "example 1 can calculate total revenue with one bulk discount where no items meet threshold" do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 5, unit_price: 10, status: 2)
      @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 5, unit_price: 5, status: 1)

      @bulk_discount_1 = BulkDiscount.create!(name: '20% off', percentage_discount: 20, quantity_threshold: 10, merchant_id: @merchant1.id)

      expect(@invoice_1.total_revenue).to eq(75)
      expect(@invoice_1.total_revenue_with_discounts).to eq(75)
    end

    it "example 2 can calculate total revenue with two bulk discounts where one item meets threshold" do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")

      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 10, unit_price: 10, status: 2)
      @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 5, unit_price: 5, status: 1)

      @bulk_discount_1 = BulkDiscount.create!(name: '20% off', percentage_discount: 20, quantity_threshold: 10, merchant_id: @merchant1.id)

      expect(@invoice_1.total_revenue).to eq(125)
      expect(@invoice_1.total_revenue_with_discounts).to eq(130)
    end

    it "example 3 can calculate total revenue with two bulk discounts where both item meet threshold" do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")

      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 12, unit_price: 10, status: 2)
      @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 15, unit_price: 5, status: 1)

      @bulk_discount_1 = BulkDiscount.create!(name: '20% off', percentage_discount: 20, quantity_threshold: 10, merchant_id: @merchant1.id)
      @bulk_discount_2 = BulkDiscount.create!(name: '30% off', percentage_discount: 30, quantity_threshold: 15, merchant_id: @merchant1.id)

      expect(@invoice_1.total_revenue).to eq(195)
      expect(@invoice_1.total_revenue_with_discounts).to eq(170.50)
    end

    it "example 4 can calculate total revenue with two bulk discounts where both item meet threshold" do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")

      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 12, unit_price: 10, status: 2)
      @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 15, unit_price: 5, status: 1)

      @bulk_discount_1 = BulkDiscount.create!(name: '20% off', percentage_discount: 20, quantity_threshold: 10, merchant_id: @merchant1.id)
      @bulk_discount_2 = BulkDiscount.create!(name: '15% off', percentage_discount: 30, quantity_threshold: 15, merchant_id: @merchant1.id)

      expect(@invoice_1.total_revenue).to eq(195)
      expect(@invoice_1.total_revenue_with_discounts).to eq(159.25)
    end

    it "example 5 can calculate total revenue with two bulk discounts where both item meet threshold and multiple merchants on invoice" do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @merchant2 = Merchant.create!(name: 'Dog Care')

      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
      @item_12 = Item.create!(name: "Dog Treat", description: "Liver", unit_price: 10, merchant_id: @merchant2.id)
      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")

      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 12, unit_price: 10, status: 2)
      @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 15, unit_price: 5, status: 1)
      @ii_12 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_12.id, quantity: 15, unit_price: 10, status: 1)

      @bulk_discount_1 = BulkDiscount.create!(name: '20% off', percentage_discount: 20, quantity_threshold: 10, merchant_id: @merchant1.id)
      @bulk_discount_2 = BulkDiscount.create!(name: '30% off', percentage_discount: 30, quantity_threshold: 15, merchant_id: @merchant2.id)


      expect(@invoice_1.total_revenue).to eq(345)
      expect(@invoice_1.total_revenue_with_discounts).to eq(298.50)
    end
end
