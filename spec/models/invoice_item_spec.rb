require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
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
    it {should have_one :merchant}
    it { should have_one(:merchant).through(:item) }
    it { should have_many(:bulk_discounts).through(:merchant) }

  end

  describe "class methods" do
    before(:each) do
      @m1 = Merchant.create!(name: 'Merchant 1')
      @m2 = Merchant.create!(name: 'Merchant 2')

      @c1 = Customer.create!(first_name: 'Bilbo', last_name: 'Baggins')
      @c2 = Customer.create!(first_name: 'Frodo', last_name: 'Baggins')
      @c3 = Customer.create!(first_name: 'Samwise', last_name: 'Gamgee')
      @c4 = Customer.create!(first_name: 'Aragorn', last_name: 'Elessar')
      @c5 = Customer.create!(first_name: 'Arwen', last_name: 'Undomiel')
      @c6 = Customer.create!(first_name: 'Legolas', last_name: 'Greenleaf')

      @item_1 = Item.create!(name: 'Shampoo', description: 'This washes your hair', unit_price: 10, merchant_id: @m1.id)
      @item_2 = Item.create!(name: 'Conditioner', description: 'This makes your hair shiny', unit_price: 8, merchant_id: @m1.id)
      @item_3 = Item.create!(name: 'Brush', description: 'This takes out tangles', unit_price: 5, merchant_id: @m1.id)

      @item_4 = Item.create!(name: 'Bracelet', description: 'Wrist Bling', unit_price: 5, merchant_id: @m2.id)
      @item_5 = Item.create!(name: 'Necklace', description: 'Neck Bling', unit_price: 5, merchant_id: @m2.id)
      @item_6 = Item.create!(name: 'Ring', description: 'Fingie Bling', unit_price: 5, merchant_id: @m2.id)

      @i1 = Invoice.create!(customer_id: @c1.id, status: 2)
      @i2 = Invoice.create!(customer_id: @c1.id, status: 2)
      @i3 = Invoice.create!(customer_id: @c2.id, status: 2)
      @i4 = Invoice.create!(customer_id: @c3.id, status: 2)
      @i5 = Invoice.create!(customer_id: @c4.id, status: 2)
      @i6 = Invoice.create!(customer_id: @c4.id, status: 2)
      @i7 = Invoice.create!(customer_id: @c4.id, status: 2)
      @i8 = Invoice.create!(customer_id: @c4.id, status: 2)

      @ii_1 = InvoiceItem.create!(invoice_id: @i1.id, item_id: @item_1.id, quantity: 10, unit_price: 10, status: 0)
      @ii_2 = InvoiceItem.create!(invoice_id: @i1.id, item_id: @item_2.id, quantity: 20, unit_price: 8, status: 1)
      @ii_3 = InvoiceItem.create!(invoice_id: @i2.id, item_id: @item_3.id, quantity: 15, unit_price: 5, status: 2)
      @ii_4 = InvoiceItem.create!(invoice_id: @i3.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 1)
      @ii_5 = InvoiceItem.create!(invoice_id: @i6.id, item_id: @item_4.id, quantity: 1, unit_price: 10, status: 2)
      @ii_6 = InvoiceItem.create!(invoice_id: @i7.id, item_id: @item_5.id, quantity: 30, unit_price: 5, status: 2)
      @ii_7 = InvoiceItem.create!(invoice_id: @i8.id, item_id: @item_6.id, quantity: 29, unit_price: 5, status: 2)

      @bulk_discount_1 = @m1.bulk_discounts.create!(name: "10% off 10 items", percentage_discount: 0.10, quantity_threshold: 10)
      @bulk_discount_2 = @m1.bulk_discounts.create!(name: "20% off 20 items", percentage_discount: 0.20, quantity_threshold: 20)
      @bulk_discount_3 = @m2.bulk_discounts.create!(name: "30% off 30 items", percentage_discount: 0.30, quantity_threshold: 30)
      @bulk_discount_4 = @m2.bulk_discounts.create!(name: "50% off 1 items", percentage_discount: 0.50, quantity_threshold: 1)
    end
    it 'incomplete_invoices' do
      expect(InvoiceItem.incomplete_invoices).to eq([@i1, @i3])
    end

    describe 'instance methods' do
      it 'best_discount' do
        expect(@ii_1.best_discount).to eq(@bulk_discount_1)
        expect(@ii_2.best_discount).to eq(@bulk_discount_2)
        expect(@ii_3.best_discount).to eq(@bulk_discount_1)
        expect(@ii_4.best_discount).to eq(nil)
        expect(@ii_5.best_discount).to eq(@bulk_discount_4)
        expect(@ii_6.best_discount).to eq(@bulk_discount_4)
        expect(@ii_7.best_discount).to eq(@bulk_discount_4)
      end

      it 'prediscount_revenue' do
        expect(@ii_1.prediscount_revenue).to eq(100)
        expect(@ii_2.prediscount_revenue).to eq(160)
        expect(@ii_3.prediscount_revenue).to eq(75)
        expect(@ii_4.prediscount_revenue).to eq(5)
        expect(@ii_5.prediscount_revenue).to eq(10)
        expect(@ii_6.prediscount_revenue).to eq(150)
        expect(@ii_7.prediscount_revenue).to eq(145)
      end

      it 'total_discounted_revenue' do
        expect(@ii_1.total_discounted_revenue).to eq(90)
        expect(@ii_2.total_discounted_revenue).to eq(128)
        expect(@ii_3.total_discounted_revenue).to eq(67.5)
        expect(@ii_4.total_discounted_revenue).to eq(5)
        expect(@ii_5.total_discounted_revenue).to eq(5)
        expect(@ii_6.total_discounted_revenue).to eq(75)
        expect(@ii_7.total_discounted_revenue).to eq(72.5)

      end
    end
  end
end
