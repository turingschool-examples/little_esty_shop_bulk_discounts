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
    it { should have_many(:bulk_discounts).through(:merchants)}
  end

  before :each do 
    @merchant1 = Merchant.create!(name: 'Hair Care')
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @item_2 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)

      @merchant2 = Merchant.create!(name: 'Care Hair')
      @item_3 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant2.id)

      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
      @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 12, unit_price: 6, status: 1)
      @ii_3 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_3.id, quantity: 20, unit_price: 4, status: 1)

      @discount1 = @merchant1.bulk_discounts.create(percentage_discount: 0.20 , quantity_threshold: 10)
      @discount2 = @merchant1.bulk_discounts.create(percentage_discount: 0.15 , quantity_threshold: 4)
      @discount3 = @merchant1.bulk_discounts.create(percentage_discount: 0.10 , quantity_threshold: 5)
      @discount4 = @merchant2.bulk_discounts.create(percentage_discount: 0.50 , quantity_threshold: 1)

  end

  describe "instance methods" do
    it "#total_revenue" do

      expect(@invoice_1.total_revenue).to eq(242.0)
    end
    
    it "#discounted_revenue" do

      expect(@invoice_1.discounted_revenue).to eq(174.1)
    end

    it "#merchant_total_revenue" do

      expect(@invoice_1.merchant_total_revenue(@merchant1)).to eq(162)
      expect(@invoice_1.merchant_total_revenue(@merchant2)).to eq(80.0)
      
    end

    it "#discounted_merchant_revenue" do 

      expect(@invoice_1.discounted_merchant_revenue(@merchant1)).to eq(134.1)
      expect(@invoice_1.discounted_merchant_revenue(@merchant2)).to eq(40.0)
    end
  end 
end
