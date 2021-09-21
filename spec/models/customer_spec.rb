require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "validations" do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end
  describe "relationships" do
    it { should have_many :invoices }
    it { should have_many(:merchants).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'instance methods' do
    before(:each) do
      @customer = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @invoice_1 = Invoice.create!(customer_id: @customer.id, status: 2)
      @invoice_2 = Invoice.create!(customer_id: @customer.id, status: 2)
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 0, created_at: "2012-03-27 14:54:09")
      @ii_2 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0, created_at: "2012-03-29 14:54:09")
      @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
      @transaction2 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_2.id)
    end

    it 'number_of_transactions' do
      expect(@customer.number_of_transactions).to eq(2)
    end
  end

  describe 'class methods' do
    before(:each) do
      @customer = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @customer_2 = Customer.create!(first_name: 'Cecilia', last_name: 'Jones')
      @customer_3 = Customer.create!(first_name: 'Mariah', last_name: 'Carrey')
      @customer_4 = Customer.create!(first_name: 'Leigh Ann', last_name: 'Bron')
      @customer_5 = Customer.create!(first_name: 'Sylvester', last_name: 'Nader')
      @customer_6 = Customer.create!(first_name: 'Herber', last_name: 'Kuhn')
      @invoice_1 = Invoice.create!(customer_id: @customer.id, status: 2)
      @invoice_1a = Invoice.create!(customer_id: @customer.id, status: 2)
      @invoice_2 = Invoice.create!(customer_id: @customer_2.id, status: 2)
      @invoice_3 = Invoice.create!(customer_id: @customer_3.id, status: 2)
      @invoice_4 = Invoice.create!(customer_id: @customer_4.id, status: 2)
      @invoice_5 = Invoice.create!(customer_id: @customer_5.id, status: 2)
      @invoice_6 = Invoice.create!(customer_id: @customer_6.id, status: 2)
      @merchant1 = Merchant.create!(name: 'Hair Care')

      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)

      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 0, created_at: "2012-03-27 14:54:09")
      @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1a.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0, created_at: "2012-03-29 14:54:09")
      @ii_3 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 0, created_at: "2012-03-27 14:54:09")
      @ii_4 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0, created_at: "2012-03-29 14:54:09")
      @ii_5 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 0, created_at: "2012-03-27 14:54:09")
      @ii_6 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0, created_at: "2012-03-29 14:54:09")
      @ii_7 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 0, created_at: "2012-03-27 14:54:09")
      @ii_8 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0, created_at: "2012-03-29 14:54:09")

      @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
      @transaction2 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1a.id)
      @transaction2 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_2.id)
      @transaction2 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_3.id)
      @transaction2 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_4.id)
      @transaction2 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_5.id)
    end

    it 'top_customers' do
      expect(Customer.top_customers).to eq([@customer, @customer_2, @customer_3, @customer_4, @customer_5])
    end
  end
end
