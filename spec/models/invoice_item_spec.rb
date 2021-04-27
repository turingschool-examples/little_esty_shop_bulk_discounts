require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  before(:each) do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2,  created_at: "2012-03-27 14:54:09")
    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 10, unit_price: 10, status: 2, created_at: "2012-03-27 14:54:09")

    @bulk_discount_2 = BulkDiscount.create!(name: '30% off', percentage_discount: 30, quantity_threshold: 15, merchant_id: @merchant1.id)
    @bulk_discount_1 = BulkDiscount.create!(name: '20% off', percentage_discount: 20, quantity_threshold: 10, merchant_id: @merchant1.id)
  end

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
    it { should have_one(:merchant).through(:item)}
    it { should have_many(:bulk_discounts).through(:merchant)}
  end

  describe "instance methods" do
    describe "#revenue_no_discount_applied" do
      it "can calculate revenue for one item with no discount applied" do

        expect(@ii_1.revenue_no_discount_applied).to eq(100)
      end
    end

    describe "#discount_applied" do
      it 'can calculate correct discount applied' do

        expect(@ii_1.discount_applied).to eq(@bulk_discount_1)
      end
    end

    describe "revenue_with_discount_applied" do
      it 'can calculate revenue with correct discounts applied' do

      expect(@ii_1.revenue_with_discount_applied).to eq(80)
      end
    end

    describe "total_discount" do
      it 'can calculate the total discount applied' do

        expect(@ii_1.total_discount).to eq(20)
      end
    end
  end
end
