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
    it { should have_many :transactions }
    it { should have_many(:bulk_discounts).through(:merchants) }
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

  describe 'bulk_discounts instance methods' do
    before(:each) do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @merchant2 = Merchant.create!(name: 'Car Decals')
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
      @item_9 = Item.create!(name: "Rainbow", description: "Virtue signal sticker for your back window", unit_price: 5, merchant_id: @merchant1.id)
      @item_10 = Item.create!(name: "Barbed wire", description: "Tell the world you are tough", unit_price: 5, merchant_id: @merchant1.id)
      @item_11 = Item.create!(name: "You name for pres", description: "Everyone wants to vote for you", unit_price: 5, merchant_id: @merchant2.id)
      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @customer_2 = Customer.create!(first_name: 'Geraldine', last_name: 'Jones')
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
      @invoice_2 = Invoice.create!(customer_id: @customer_2.id, status: 2, created_at: "2012-03-27 14:54:09")

      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 10, unit_price: 10, status: 2)
      @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 12, unit_price: 10, status: 1)
      @ii_12 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_9.id, quantity: 1, unit_price: 10, status: 1)
      @ii_13 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_11.id, quantity: 5, unit_price: 10, status: 1)

      @bulk_discount_1 = @merchant1.bulk_discounts.create!(percent_discount: 15, quantity_threshold: 10)
      @bulk_discount_2 = @merchant1.bulk_discounts.create!(percent_discount: 25, quantity_threshold: 12)
      @bulk_discount_3 = @merchant2.bulk_discounts.create!(percent_discount: 10, quantity_threshold: 5)
    end

    it 'has method for find_discounted_items' do
      expect(@invoice_1.find_discounted_items(@merchant1.id)).to eq([@ii_1, @ii_11])
    end

    it 'has method for finding non_discounted_items' do
      expect(@invoice_1.non_discounted_items(@merchant1.id)).to eq([@ii_12])
    end

    it 'has method for discounted_revenue' do
      expect(@invoice_1.discounted_revenue(@merchant1.id)).to eq(175)
    end
  end
end
