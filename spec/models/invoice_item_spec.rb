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
  end

  describe "bulk discount " do
    before(:each) do
        @merchant1 = Merchant.create!(name: 'Hair Care')
        @merchant2 = Merchant.create!(name: 'Target')

        @discount = Discount.create!(quantity_threshold: 7, percentage_discount: 15, merchant_id: @merchant1.id)
        @discount2 = Discount.create!(quantity_threshold: 10, percentage_discount: 30, merchant_id: @merchant1.id)
        @discount3 = Discount.create!(quantity_threshold: 15, percentage_discount: 25, merchant_id: @merchant1.id)

        @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')

        @invoice_A = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")

        @item_A = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
        @ii_A = InvoiceItem.create!(invoice_id: @invoice_A.id, item_id: @item_A.id, quantity: 12, unit_price: 10, status: 2)
        #84
        @item_B = Item.create!(name: "Comb", description: "This cleans your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
        @ii_B = InvoiceItem.create!(invoice_id: @invoice_A.id, item_id: @item_B.id, quantity: 5, unit_price: 10, status: 2)
        #50
        @item_C = Item.create!(name: "Broom", description: "This cleans your house", unit_price: 10, merchant_id: @merchant1.id, status: 1)
        @ii_C = InvoiceItem.create!(invoice_id: @invoice_A.id, item_id: @item_C.id, quantity: 15, unit_price: 10, status: 2)
        #105
        @item_D = Item.create!(name: "Mop", description: "This cleans your floor", unit_price: 10, merchant_id: @merchant2.id, status: 1)
        @ii_D = InvoiceItem.create!(invoice_id: @invoice_A.id, item_id: @item_D.id, quantity: 20, unit_price: 10, status: 2)
        #200
    end
    xit "can find the discount percentage for an invoice item, if any" do
      expect(@ii_A.find_discount_percentage).to eq(30)
      expect(@ii_D.find_discount_percentage).to eq(nil)
    end
  end
end
