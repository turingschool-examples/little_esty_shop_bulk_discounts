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

    describe "total_invoice_discount" do
      it 'returns the total discount for my merchant from this invoice' do
        merchant_1 = create(:merchant)
  
        bulk_discount_1 = merchant_1.bulk_discounts.create!(quantity_threshold: 10, percentage: 5)
        bulk_discount_2 = merchant_1.bulk_discounts.create!(quantity_threshold: 15, percentage: 10)
  
        customer_1 = create(:customer)
  
        item_1 = create(:item, unit_price: 150, merchant: merchant_1)
        item_2 = create(:item, unit_price: 100, merchant: merchant_1)
        item_3 = create(:item, unit_price: 200, merchant: merchant_1)
        
        invoice_1 = create(:invoice, customer: customer_1)
        
        invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: item_1, quantity: 10, unit_price: 1500)
        invoice_item_2 = create(:invoice_item, invoice: invoice_1, item: item_2, quantity: 17, unit_price: 1700)
        invoice_item_3 = create(:invoice_item, invoice: invoice_1, item: item_3, quantity: 5, unit_price: 1000)
  

        expect(invoice_1.total_revenue).to eq(48900)
        expect(invoice_1.total_invoice_discount).to eq(3640)
        expect(invoice_1.merchant_total_revenue_with_discount).to eq(45260)
      end
    end

    describe "merchant_total_revenue_with_discout" do
      it 'returns the total revenue with discount for my merchant' do
        merchant_1 = create(:merchant)
  
        bulk_discount_1 = merchant_1.bulk_discounts.create!(quantity_threshold: 10, percentage: 5)
        bulk_discount_2 = merchant_1.bulk_discounts.create!(quantity_threshold: 15, percentage: 10)
  
        customer_1 = create(:customer)
  
        item_1 = create(:item, unit_price: 150, merchant: merchant_1)
        item_2 = create(:item, unit_price: 100, merchant: merchant_1)
        item_3 = create(:item, unit_price: 200, merchant: merchant_1)
        
        invoice_1 = create(:invoice, customer: customer_1)
        
        invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: item_1, quantity: 10, unit_price: 1500)
        invoice_item_2 = create(:invoice_item, invoice: invoice_1, item: item_2, quantity: 17, unit_price: 1700)
        invoice_item_3 = create(:invoice_item, invoice: invoice_1, item: item_3, quantity: 5, unit_price: 1000)
  
        expect(invoice_1.merchant_total_revenue_with_discount).to eq(45260)
      end
    end
  end
end
