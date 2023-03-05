require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
  end

  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many :transactions}
    it { should have_many :invoice_items}
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many(:bulk_discounts).through(:merchants) }
  end

  describe "instance methods" do
    before :each do 
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
      
      @merchant2 = Merchant.create!(name: 'Jewelry')
      @item_5 = Item.create!(name: "Bracelet", description: "Wrist bling", unit_price: 200, merchant_id: @merchant2.id)

      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 1)
      @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 12, unit_price: 6, status: 1)
      @ii_10 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_5.id, quantity: 40, unit_price: 1.33, status: 1)

      @bd_basic = @merchant1.bulk_discounts.create!(title: "Basic", percentage_discount: 0.1, quantity_threshold: 5)
      @bd_super = @merchant1.bulk_discounts.create!(title: "Super", percentage_discount: 0.25, quantity_threshold: 10)
      @bd_seasonal = @merchant1.bulk_discounts.create!(title: "Seasonal", percentage_discount: 0.05, quantity_threshold: 5)  
    end

    it "#total_revenue" do
      expect(@invoice_1.total_revenue).to eq(215.2)
    end

    # it "#merch_total_revenue" do
    #   expect(@invoice_1.total_revenue).to eq(162.0)
    # end

    it "#total_discount_amount" do 
      expect(@invoice_1.total_discount_amount).to eq(27)
    end
  end
end
