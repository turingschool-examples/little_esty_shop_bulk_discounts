require 'rails_helper'

RSpec.describe Invoice, type: :model do
  before(:each) do
    @merchant = Merchant.create!(name: 'Discount Rev')

    @bulk_discount_1 = BulkDiscount.create!(merchant_id: @merchant.id, percentage_discount: 10, quantity_threshold: 20)
    @bulk_discount_2 = BulkDiscount.create!(merchant_id: @merchant.id, percentage_discount: 20, quantity_threshold: 25)
    
    @customer = Customer.create!(first_name: "John", last_name: "Doe")

    @invoice = Invoice.create!(customer_id: @customer.id, status: 2)

    @item_1 = Item.create!(name: "Item 1", description: "Item 1 desc", merchant_id: @merchant.id, unit_price: 100)
    @item_2 = Item.create!(name: "Item 2", description: "Item 2 desc", merchant_id: @merchant.id, unit_price: 200)
    @item_3 = Item.create!(name: "Item 3", description: "Item 3 desc", merchant_id: @merchant.id, unit_price: 300)
    @item_4 = Item.create!(name: "Item 4", description: "Item 4 desc", merchant_id: @merchant.id, unit_price: 400)
    @item_5 = Item.create!(name: "Item 5", description: "Item 5 desc", merchant_id: @merchant.id, unit_price: 500)
    @item_6 = Item.create!(name: "Item 6", description: "Item 6 desc", merchant_id: @merchant.id, unit_price: 600)
    @item_7 = Item.create!(name: "Item 7", description: "Item 7 desc", merchant_id: @merchant.id, unit_price: 700)
    @item_8 = Item.create!(name: "Item 8", description: "Item 8 desc", merchant_id: @merchant.id, unit_price: 800)
    @item_9 = Item.create!(name: "Item 9", description: "Item 9 desc", merchant_id: @merchant.id, unit_price: 900)
    @item_10 = Item.create!(name: "Item 10", description: "Item 10 desc", merchant_id: @merchant.id, unit_price: 1000)

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice.id, item_id: @item_1.id, quantity: 5, unit_price: 100, status: 1)
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice.id, item_id: @item_2.id, quantity: 5, unit_price: 200, status: 1)
    @ii_3 = InvoiceItem.create!(invoice_id: @invoice.id, item_id: @item_3.id, quantity: 10, unit_price: 300, status: 1)
    @ii_4 = InvoiceItem.create!(invoice_id: @invoice.id, item_id: @item_4.id, quantity: 10, unit_price: 400, status: 1)
    @ii_5 = InvoiceItem.create!(invoice_id: @invoice.id, item_id: @item_5.id, quantity: 15, unit_price: 500, status: 1)
    @ii_6 = InvoiceItem.create!(invoice_id: @invoice.id, item_id: @item_6.id, quantity: 15, unit_price: 600, status: 1)
    @ii_7 = InvoiceItem.create!(invoice_id: @invoice.id, item_id: @item_7.id, quantity: 20, unit_price: 700, status: 1)
    @ii_8 = InvoiceItem.create!(invoice_id: @invoice.id, item_id: @item_8.id, quantity: 20, unit_price: 800, status: 1)
    @ii_9 = InvoiceItem.create!(invoice_id: @invoice.id, item_id: @item_9.id, quantity: 25, unit_price: 900, status: 1)
    @ii_10 = InvoiceItem.create!(invoice_id: @invoice.id, item_id: @item_10.id, quantity: 25, unit_price: 1000, status: 1)

    
  end
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
      merchant1 = Merchant.create!(name: 'Hair Care')
      item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: merchant1.id, status: 1)
      item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: merchant1.id)
      customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
      InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 9, unit_price: 10, status: 2)
      InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_8.id, quantity: 1, unit_price: 10, status: 1)

      expect(invoice_1.total_revenue).to eq(100)
    end

    it "total_discounted_revenue" do
      expect(@invoice.total_discounted_revenue).to eq(90,000)
    end
# Join our Invoice.invoice_items to items where the merchant has a bulk discount
# select all of our invoice items where the quantity meets the highest quantity threshold
# multiply the ii.quantity by the ii.unit price * (bd.discount price / 100)

  # bulk discount 1 hits ii 7 and 8
  # bulk discount 2 hits 9 and 10
  # total rev = 102,500
  # total before discounted = 25,000
  # discount 1 
  # 20 x 700 = 14,000 * .1 = 1,400 total after discount = 12,600
  # 20 x 800 = 16,000 * .1 = 1,600 total after discount = 14,400

  # discount 2
  # 25 x 900 = 22,500 * .2 = 4,500 total after discount = 18,000
  # 25 x 1000 = 25,000 * .2 = 5,000 total after discount = 20,000

  # total after discount = 90,000
  end
end
