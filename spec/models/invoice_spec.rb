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
  describe "bulk discount methods" do
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
      it "can find the total bulk discount revenue" do
        expect(@invoice_A.total_revenue).to eq(520)
        expect(@invoice_A.total_bulk_discount_revenue).to eq(439)
      end
      it "can find the discount percentage for an invoice item, if any" do
        expect(@invoice_A.find_discount_percentages).to eq([30, 25, 15])
      end
    end
  end
end
