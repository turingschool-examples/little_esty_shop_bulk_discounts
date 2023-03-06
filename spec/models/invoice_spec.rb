require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
  end
  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    # it { should have_many(:bulk_discounts).through(:invoice_items)}
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewlery')

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
    @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 10, merchant_id: @merchant1.id)
    @item_2 = Item.create!(name: "Bracelet", description: "Wrist Bling", unit_price: 10, merchant_id: @merchant2.id)

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 1, unit_price: 10, status: 1)
    @ii_3 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 10, unit_price: 10, status: 1)
    
    @bulk_discount_1 = BulkDiscount.create!(name: "20% off of 9", percentage_discount: 0.20, quantity_threshold: 9, merchant_id: @merchant1.id)
    @bulk_discount_3 = BulkDiscount.create!(name: "10% off of 10", percentage_discount: 0.10, quantity_threshold: 10, merchant_id: @merchant1.id)
    @bulk_discount_2 = BulkDiscount.create!(name: "10% off of 10", percentage_discount: 0.10, quantity_threshold: 10, merchant_id: @merchant2.id)
  end 

  describe "instance methods" do
    it "total_revenue" do
      expect(@invoice_1.total_revenue).to eq(200)

      ii_3 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 2)

      expect(@invoice_1.total_revenue).to eq(210)
    end

    it 'invoice_items_for_merchant' do
      expect(@invoice_1.invoice_items_for_merchant(@merchant1.id)).to eq([@ii_1, @ii_2])
      expect(@invoice_1.invoice_items_for_merchant(@merchant2.id)).to eq([@ii_3])
    end

    it 'prediscount_revenue_total_for_merchant' do
      expect(@invoice_1.prediscount_revenue_total_for_merchant(@merchant1.id)).to eq(100)
      expect(@invoice_1.prediscount_revenue_total_for_merchant(@merchant2.id)).to eq(100)
    end

    it 'discounted_revenue_total_for_merchant' do
      expect(@invoice_1.discounted_revenue_total_for_merchant(@merchant1.id)).to eq(82)
      expect(@invoice_1.discounted_revenue_total_for_merchant(@merchant2.id)).to eq(90)
    end

    it 'prediscount_revenue_total' do
      expect(@invoice_1.prediscount_revenue_total).to eq(200)
      ii_3 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 2)
      @invoice_1.reload
      expect(@invoice_1.prediscount_revenue_total).to eq(210)
    end

    it 'discounted_revenue_total' do
      expect(@invoice_1.discounted_revenue_total).to eq(172)
      ii_3 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
      @invoice_1.reload
      expect(@invoice_1.discounted_revenue_total).to eq(244)
    end
  end
end
