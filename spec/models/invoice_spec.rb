# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
  end
  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many :transactions }
    it { should have_many(:bulk_discounts).through(:merchants) }
  end

  describe 'instance methods' do
    before do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @item_1 = Item.create!(name: 'Shampoo', description: 'This washes your hair', unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @item_2 = Item.create!(name: 'Butterfly Clip', description: 'This holds up your hair but in a clip', unit_price: 5, merchant_id: @merchant1.id)
      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @merchant2 = create(:merchant)
      @item_2_1 = create(:item, merchant_id: @merchant2.id)
      @item_2_2 = create(:item, merchant_id: @merchant2.id)
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: '2012-03-27 14:54:09')
      @invoice_item1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
      @invoice_item2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 1, unit_price: 10, status: 1)
    end
    it 'total_revenue' do
      expect(@invoice_1.total_revenue).to eq(100)
    end

    describe '#merchant_total_revenue(merchant)' do
      it 'returns the total revenue of the merchant (without discounts)' do
        @invoice_item3 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2_1.id, quantity: 9, unit_price: 1, status: 2)
        @invoice_item4 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2_2.id, quantity: 1, unit_price: 1, status: 1)
        expect(@invoice_1.merchant_total_revenue(@merchant1)).to eq(100)
        expect(@invoice_1.merchant_total_revenue(@merchant2)).to eq(10)
      end
    end

    describe '#merchant_total_revenue_discounted(merchant)' do
      it 'returns the discounted total revenue for a merchant' do
        BulkDiscount.create!(percent_discounted: 50, quantity_threshold: 5, merchant_id: @merchant1.id)
        BulkDiscount.create!(percent_discounted: 50, quantity_threshold: 5, merchant_id: @merchant2.id)
        @invoice_item3 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2_1.id, quantity: 9, unit_price: 1, status: 2)
        @invoice_item4 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2_2.id, quantity: 1, unit_price: 1, status: 1)
        expect(@invoice_1.merchant_total_revenue_discounted(@merchant1)).to eq(55)
        expect(@invoice_1.merchant_total_revenue_discounted(@merchant2)).to eq(5.5)
      end

      it 'excludes items that are below the quantity threshold' do
        BulkDiscount.create!(percent_discounted: 50, quantity_threshold: 9, merchant_id: @merchant1.id)
        BulkDiscount.create!(percent_discounted: 50, quantity_threshold: 5, merchant_id: @merchant2.id)
        invoice_item3 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2_1.id, quantity: 9, unit_price: 1, status: 2)
        invoice_item4 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2_2.id, quantity: 1, unit_price: 1, status: 1)
        invoice_item5 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 10, unit_price: 10, status: 1)

        expect(@invoice_1.merchant_total_revenue_discounted(@merchant1)).to eq(105)
        expect(@invoice_1.merchant_total_revenue_discounted(@merchant2)).to eq(5.5)
      end
    end

    describe '#discount_total_revenue' do
      describe 'gives a discounted total for a merchant, based on quantity of invoice items, and percent off' do
        it 'Only discounts invoice_item 1, but still includes 10 cents from invoice_item 2' do
          BulkDiscount.create!(percent_discounted: 50, quantity_threshold: 5, merchant_id: @merchant1.id)
          expect(@invoice_1.discount_total_revenue).to eq(55)
        end

        it 'does not change total revenue if neither of the invoice items meet threshold ' do
          BulkDiscount.create!(percent_discounted: 50, quantity_threshold: 10, merchant_id: @merchant1.id)
          expect(@invoice_1.discount_total_revenue).to eq(100)
          expect(@invoice_1.discount_total_revenue).to eq(100)

        end

        it 'only gives the highest bulk discount available' do
          BulkDiscount.create!(percent_discounted: 10, quantity_threshold: 1, merchant_id: @merchant1.id)
          BulkDiscount.create!(percent_discounted: 40, quantity_threshold: 1, merchant_id: @merchant1.id)
          BulkDiscount.create!(percent_discounted: 20, quantity_threshold: 1, merchant_id: @merchant1.id)
          expect(@invoice_1.discount_total_revenue).to eq(60)
        end

        it 'combination of bulk discounts (each item has a different discount)' do
          BulkDiscount.create!(percent_discounted: 10, quantity_threshold: 1, merchant_id: @merchant1.id)
          BulkDiscount.create!(percent_discounted: 40, quantity_threshold: 5, merchant_id: @merchant1.id)
          expect(@invoice_1.discount_total_revenue).to eq(63)
        end

        it 'another merchants with no discounts items are not being affected by discounts' do
          merchant2 = create(:merchant)
          item_3 = Item.create!(name: 'Shampoo', description: 'This washes your hair', unit_price: 10, merchant_id: merchant2.id, status: 1)
          invoice_item3 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: item_3.id, quantity: 1, unit_price: 10, status: 1)
          BulkDiscount.create!(percent_discounted: 50, quantity_threshold: 5, merchant_id: @merchant1.id)
          expect(@invoice_1.discount_total_revenue).to eq(65)
        end
      end
    end
  end
end
