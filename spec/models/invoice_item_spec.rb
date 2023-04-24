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
    it { should have_many(:bulk_discounts).through(:item) }
  end

  describe "class methods" do
    before(:each) do
      @m1 = Merchant.create!(name: 'Merchant 1')
      @c1 = Customer.create!(first_name: 'Bilbo', last_name: 'Baggins')
      @c2 = Customer.create!(first_name: 'Frodo', last_name: 'Baggins')
      @c3 = Customer.create!(first_name: 'Samwise', last_name: 'Gamgee')
      @c4 = Customer.create!(first_name: 'Aragorn', last_name: 'Elessar')
      @c5 = Customer.create!(first_name: 'Arwen', last_name: 'Undomiel')
      @c6 = Customer.create!(first_name: 'Legolas', last_name: 'Greenleaf')
      @item_1 = Item.create!(name: 'Shampoo', description: 'This washes your hair', unit_price: 10, merchant_id: @m1.id)
      @item_2 = Item.create!(name: 'Conditioner', description: 'This makes your hair shiny', unit_price: 8, merchant_id: @m1.id)
      @item_3 = Item.create!(name: 'Brush', description: 'This takes out tangles', unit_price: 5, merchant_id: @m1.id)
      @i1 = Invoice.create!(customer_id: @c1.id, status: 2)
      @i2 = Invoice.create!(customer_id: @c1.id, status: 2)
      @i3 = Invoice.create!(customer_id: @c2.id, status: 2)
      @i4 = Invoice.create!(customer_id: @c3.id, status: 2)
      @i5 = Invoice.create!(customer_id: @c4.id, status: 2)
      @ii_1 = InvoiceItem.create!(invoice_id: @i1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
      @ii_2 = InvoiceItem.create!(invoice_id: @i1.id, item_id: @item_2.id, quantity: 1, unit_price: 8, status: 0)
      @ii_3 = InvoiceItem.create!(invoice_id: @i2.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 2)
      @ii_4 = InvoiceItem.create!(invoice_id: @i3.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 1)
    end

    it 'incomplete_invoices' do
      expect(InvoiceItem.incomplete_invoices).to eq([@i1, @i3])
    end

    it 'applied_discounts' do
      merchant = Merchant.create!(name: 'Discount Rev')
      merchant_2 = Merchant.create!(name: 'More Discounts')

      bulk_discount_1 = BulkDiscount.create!(merchant_id: merchant.id, percentage_discount: 10, quantity_threshold: 20)
      bulk_discount_2 = BulkDiscount.create!(merchant_id: merchant.id, percentage_discount: 20, quantity_threshold: 25)
      bulk_discount_3 = BulkDiscount.create!(merchant_id: merchant_2.id, percentage_discount: 15, quantity_threshold: 20)
      
      customer = Customer.create!(first_name: "John", last_name: "Doe")

      invoice = Invoice.create!(customer_id: customer.id, status: 2)
      invoice2 = Invoice.create!(customer_id: customer.id, status: 2)

      item_1 = Item.create!(name: "Item 1", description: "Item 1 desc", merchant_id: merchant.id, unit_price: 100)
      item_2 = Item.create!(name: "Item 2", description: "Item 2 desc", merchant_id: merchant.id, unit_price: 200)
      item_3 = Item.create!(name: "Item 3", description: "Item 3 desc", merchant_id: merchant.id, unit_price: 300)
      item_4 = Item.create!(name: "Item 4", description: "Item 4 desc", merchant_id: merchant.id, unit_price: 400)
      item_5 = Item.create!(name: "Item 5", description: "Item 5 desc", merchant_id: merchant.id, unit_price: 500)
      item_6 = Item.create!(name: "Item 6", description: "Item 6 desc", merchant_id: merchant.id, unit_price: 600)
      item_7 = Item.create!(name: "Item 7", description: "Item 7 desc", merchant_id: merchant.id, unit_price: 700)
      item_8 = Item.create!(name: "Item 8", description: "Item 8 desc", merchant_id: merchant.id, unit_price: 800)
      item_9 = Item.create!(name: "Item 9", description: "Item 9 desc", merchant_id: merchant.id, unit_price: 900)
      item_10 = Item.create!(name: "Item 10", description: "Item 10 desc", merchant_id: merchant.id, unit_price: 1000)
      item_11 = Item.create!(name: "Item 11", description: "Item 11 desc", merchant_id: merchant_2.id, unit_price: 1000)

      ii_6 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item_6.id, quantity: 10, unit_price: 600, status: 1)
      ii_7 = InvoiceItem.create!(invoice_id: invoice.id, item_id: item_7.id, quantity: 20, unit_price: 700, status: 1)
      ii_8 =InvoiceItem.create!(invoice_id: invoice.id, item_id: item_8.id, quantity: 20, unit_price: 800, status: 1)
      ii_9 = InvoiceItem.create!(invoice_id: invoice.id, item_id: item_9.id, quantity: 25, unit_price: 900, status: 1)
      ii_10 = InvoiceItem.create!(invoice_id: invoice.id, item_id: item_10.id, quantity: 25, unit_price: 1000, status: 1)

      expect(ii_7.applied_discounts).to eq(bulk_discount_1)
      expect(ii_8.applied_discounts).to eq(bulk_discount_1)
      expect(ii_9.applied_discounts).to eq(bulk_discount_2)
      expect(ii_10.applied_discounts).to eq(bulk_discount_2)
    end
  end
end
