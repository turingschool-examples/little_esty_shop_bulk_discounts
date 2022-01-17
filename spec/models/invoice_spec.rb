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
end

describe 'bulk discounts instance methods' do 
  let!(:merchant_1) {Merchant.create!(name: 'Hair Care')}

  let!(:bulk_discount_1) {merchant_1.bulk_discounts.create!(markdown: 10, quantity_threshold: 10)}
  let!(:bulk_discount_2) {merchant_1.bulk_discounts.create!(markdown: 20, quantity_threshold: 20)}

  let!(:customer_1) {Customer.create!(first_name: 'Joey', last_name: 'Smith')}
  let!(:customer_2) {Customer.create!(first_name: 'Patsy', last_name: 'Cline')}

  let!(:invoice_1) {customer_1.invoices.create!(status: 2)}
  let!(:invoice_2) {customer_2.invoices.create!(status: 2)}
  let!(:invoice_3) {customer_2.invoices.create!(status: 2)}
  let!(:invoice_4) {customer_2.invoices.create!(status: 2)}

  let!(:item_1) {merchant_1.items.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10)}
  let!(:item_2) {merchant_1.items.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 20)}
  let!(:item_3) {merchant_1.items.create!(name: "Head Band", description: "This Keeps hair out of your face", unit_price: 30)}
  let!(:item_4) {merchant_1.items.create!(name: "Curlers", description: "This makes hair curly", unit_price: 40)}

  let!(:i_i_1) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 100, unit_price: 10, status: 2)} 
  let!(:i_i_2) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_2.id, quantity: 10, unit_price: 20, status: 2)} 
  let!(:i_i_3) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_3.id, quantity: 1, unit_price: 30, status: 2)} 
  let!(:i_i_4) {InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_4.id, quantity: 1, unit_price: 40, status: 2)} 
  let!(:i_i_5) {InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_1.id, quantity: 1, unit_price: 10, status: 2)} 
  let!(:i_i_6) {InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_2.id, quantity: 1, unit_price: 20, status: 2)} 
  let!(:i_i_7) {InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_3.id, quantity: 1, unit_price: 30, status: 2)} 
  let!(:i_i_8) {InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_1.id, quantity: 1, unit_price: 10, status: 2)} 
  let!(:i_i_9) {InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_2.id, quantity: 20, unit_price: 20, status: 2)} 
  let!(:i_i_10) {InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_3.id, quantity: 20, unit_price: 30, status: 2)} 

  it 'can calculate the total discounted revenue' do 
    expect(invoice_1.total_discounted_revenue).to eq(1010.0)
    expect(invoice_2.total_discounted_revenue).to eq(40.0)
    expect(invoice_3.total_discounted_revenue).to eq(60.0)
    expect(invoice_4.total_discounted_revenue).to eq(810.0)
  end
end 
