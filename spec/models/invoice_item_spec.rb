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
    it { should have_many(:merchants).through :item}
    it { should have_many(:bulk_discounts).through :merchants}
  end

  describe "class methods" do
    before(:each) do
      @m1 = Merchant.create!(name: 'Merchant 1')
      @c1 = Customer.create!(first_name: 'Bilbo', last_name: 'Baggins')
      @c2 = Customer.create!(first_name: 'Frodo', last_name: 'Baggins')
      @c3 = Customer.create!(first_name: 'Samwise', last_name: 'Gamgee')
      @c4 = Customer.create!(first_name: 'Aragorn', last_name: 'Elessar')
      @c5 = Customer.create!(first_name: 'Arwen', last_name: 'Undomiel')
      @c6 = Customer.create!(first_name: 'Legolas', last_name: 'Greenleaf')
      @item_1 = Item.create!(name: 'Shampoo', description: 'This washes your hair', unit_price: 10, merchant_id: @m1.id)
      @item_2 = Item.create!(name: 'Conditioner', description: 'This makes your hair shiny', unit_price: 8, merchant_id: @m1.id)
      @item_3 = Item.create!(name: 'Brush', description: 'This takes out tangles', unit_price: 5, merchant_id: @m1.id)
      @i1 = Invoice.create!(customer_id: @c1.id, status: 2)
      @i2 = Invoice.create!(customer_id: @c1.id, status: 2)
      @i3 = Invoice.create!(customer_id: @c2.id, status: 2)
      @i4 = Invoice.create!(customer_id: @c3.id, status: 2)
      @i5 = Invoice.create!(customer_id: @c4.id, status: 2)
      @ii_1 = InvoiceItem.create!(invoice_id: @i1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
      @ii_2 = InvoiceItem.create!(invoice_id: @i1.id, item_id: @item_2.id, quantity: 1, unit_price: 8, status: 0)
      @ii_3 = InvoiceItem.create!(invoice_id: @i2.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 2)
      @ii_4 = InvoiceItem.create!(invoice_id: @i3.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 1)
    end
    it 'incomplete_invoices' do
      expect(InvoiceItem.incomplete_invoices).to eq([@i1, @i3])
    end
  end

  describe 'instance methods' do
    describe '#discount_applied' do
      before :each do
        @merchant1 = Merchant.create!(name: 'Hair Care')
        @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
        @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
        @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
        @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
        @ii_1a = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
        @ii_1b = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 12, unit_price: 6, status: 1)
        @ii_1c = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 2, unit_price: 6, status: 1)
        @bulk_discount1a = @merchant1.bulk_discounts.create!(percentage_discount: 0.2, quantity_threshold: 5)
        @bulk_discount1b = @merchant1.bulk_discounts.create!(percentage_discount: 0.5, quantity_threshold: 12)
      end
      it 'returns the bulk discount that applies to an invoice item if any apply at all' do
        expect(@ii_1b.discount_applied).to be_a BulkDiscount
        expect(@ii_1b.discount_applied.percentage_discount).to eq(0.5)
        expect(@ii_1b.discount_applied.quantity_threshold).to eq(12)

        expect(@ii_1a.discount_applied).to be_a BulkDiscount
        expect(@ii_1a.discount_applied.percentage_discount).to eq(0.2)
        expect(@ii_1a.discount_applied.quantity_threshold).to eq(5)

        expect(@ii_1c.discount_applied).to be_nil
      end
    end
  end
end
