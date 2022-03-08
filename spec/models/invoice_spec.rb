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
      @merchant_1 = Merchant.create!(name: 'Mugs Galore', status: 0)
      @merchant_2 = Merchant.create!(name: 'Happy Candles', status: 0)

      @item_1 = @merchant_1.items.create!(name: "Coffee Mug", description: "fancy fancy", unit_price: 100, status: 0)
      @item_2 = @merchant_1.items.create!(name: "Big Coffee Mug", description: "the big one", unit_price: 200, status: 0)
      @item_3 = @merchant_2.items.create!(name: "Candles", description: "These go through your ears", unit_price: 50, status: 1)

      @customer_1 = Customer.create!(first_name: "Harry", last_name: "Potter")

      @invoice_1 = @customer_1.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09')

      @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, unit_price: @item_1.unit_price, quantity: 10, status: 0)
      @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_1.id, unit_price: @item_2.unit_price, quantity: 5, status: 0)
      @invoice_item_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_1.id, unit_price: @item_3.unit_price, quantity: 10, status: 0)

      @bulk_discount_1 = @merchant_1.bulk_discounts.create!( qty_threshold: 10, percent_discount: 10)
      @bulk_discount_2 = @merchant_2.bulk_discounts.create!( qty_threshold: 5, percent_discount: 5)
    end

    it '#total_revenue' do
      total_revenue = (@invoice_item_1.unit_price * @invoice_item_1.quantity) + (@invoice_item_2.unit_price * @invoice_item_2.quantity) + (@invoice_item_3.unit_price * @invoice_item_3.quantity)

      expect(@invoice_1.total_revenue).to eq(total_revenue)
    end

    it '#discounted_total_revenue' do
      total_revenue = @invoice_1.total_revenue - @invoice_1.discount

      expect(@invoice_1.discounted_total_revenue).to eq(total_revenue)
    end

    it '#total_revenue_by_merchant unit price by quantity of item on invoice and adds together to show revenue of merchant' do
      total_revenue = (@invoice_item_1.unit_price * @invoice_item_1.quantity) + (@invoice_item_2.unit_price * @invoice_item_2.quantity)

      expect(@invoice_1.total_revenue_by_merchant(@merchant_1.id)).to eq(total_revenue)
    end

    it '#discounted_revenue_by_merchant(merch_id)' do
      total_revenue = (90) * @invoice_item_1.quantity + (@invoice_item_2.unit_price * @invoice_item_2.quantity)

      expect(@invoice_1.discounted_revenue_by_merchant(@merchant_1.id)).to eq(total_revenue)
    end

    it '#discounts_by_merchant - revenue of merchant on invoice with bulk discounts applied' do
      total_discount = @invoice_item_1.unit_price * @invoice_item_1.quantity * (@bulk_discount_1.percent_discount / 100.00)

      expect(@invoice_1.discounts_by_merchant(@merchant_1.id)).to eq(total_discount)
    end

    it "other items from other merchants not affected" do
      total_discount = @invoice_item_1.unit_price * @invoice_item_1.quantity * (@bulk_discount_1.percent_discount / 100.00)

      expect(@invoice_1.discounts_by_merchant(@merchant_1.id)).to eq(total_discount)
    end

    it '#discount - amount discounted from invoice' do
      total_discounts_invoice_1 = (@invoice_item_2.unit_price * @invoice_item_2.quantity * (@bulk_discount_1.percent_discount / 100.00)) + (@invoice_item_3.unit_price * @invoice_item_3.quantity * (@bulk_discount_2.percent_discount / 100.00)).to_f

      expect(@invoice_1.discount).to eq(total_discounts_invoice_1.to_f)
    end
  end
end
