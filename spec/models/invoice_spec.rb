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
    before :each do 
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @merchant2 = Merchant.create!(name: 'Bob')
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)      
      @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
      @item_2 = Item.create!(name: "ASDF", description: "asdf", unit_price: 10, merchant_id: @merchant2.id)

      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
      
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
      @ii_111 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 10, unit_price: 1, status: 2)
      @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 1, unit_price: 10, status: 1)
      @ii_1111 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 100, unit_price: 10, status: 2)
    end

    it "total_revenue" do
      expect(@invoice_1.total_revenue).to eq(1110)
    end

    it "total_merchant_revenue_with_discounts" do 
      bulk_discount1 = @merchant1.bulk_discounts.create!(percentage: 50, threshold: 8)
      bulk_discount2 = @merchant2.bulk_discounts.create!(percentage: 50, threshold: 1000)
      expect(@invoice_1.total_merchant_revenue_with_discounts(@merchant1)).to eq(60)
      expect(@invoice_1.total_merchant_revenue_with_discounts(@merchant2)).to eq(1000)
    end


    

    it "total_invoice_revenue_with_discounts" do 
      bulk_discount1 = @merchant1.bulk_discounts.create!(percentage: 50, threshold: 8)
      bulk_discount2 = @merchant2.bulk_discounts.create!(percentage: 50, threshold: 1000)
      expect(@invoice_1.total_invoice_revenue_with_discounts).to eq(1060)
    end

     it "total_invoice_revenue_without_discounts" do 
      bulk_discount1 = @merchant1.bulk_discounts.create!(percentage: 50, threshold: 8)
      bulk_discount2 = @merchant2.bulk_discounts.create!(percentage: 50, threshold: 1000)
      invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
      ii_11111 = InvoiceItem.create!(invoice_id: invoice_2.id, item_id: @item_2.id, quantity: 100, unit_price: 10, status: 2)

      expect(@invoice_1.total_invoice_revenue_without_discounts).to eq(1010)
      expect(invoice_2.total_invoice_revenue_without_discounts).to eq(1000)
    end
  end
end
