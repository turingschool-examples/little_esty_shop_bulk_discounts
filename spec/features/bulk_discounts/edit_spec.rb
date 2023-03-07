require 'rails_helper'

RSpec.describe 'BulkDiscount#Show' do
  before(:each) do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Hair Care')

    @bulk_discount1 = BulkDiscount.create!(discount_percent: 20, quantity_threshold: 10, merchant_id: @merchant1.id)
    @bulk_discount2 = BulkDiscount.create!(discount_percent: 30, quantity_threshold: 40, merchant_id: @merchant1.id)
    @bulk_discount3 = BulkDiscount.create!(discount_percent: 50, quantity_threshold: 10000, merchant_id: @merchant1.id)

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
    @customer_2 = Customer.create!(first_name: 'Cecilia', last_name: 'Jones')
    @customer_3 = Customer.create!(first_name: 'Mariah', last_name: 'Carrey')
    @customer_4 = Customer.create!(first_name: 'Leigh Ann', last_name: 'Bron')
    @customer_5 = Customer.create!(first_name: 'Sylvester', last_name: 'Nader')
    @customer_6 = Customer.create!(first_name: 'Herber', last_name: 'Kuhn')

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2)
    @invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 2)
    @invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 2)
    @invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 2)
    @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 1)

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)
    @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
    @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
    @item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant1.id)

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 1, unit_price: 8, status: 0)
    @ii_3 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 2)
    @ii_4 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_5 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_6 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_7 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)

    @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
    @transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_3.id)
    @transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_4.id)
    @transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_5.id)
    @transaction5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice_6.id)
    @transaction6 = Transaction.create!(credit_card_number: 879799, result: 1, invoice_id: @invoice_7.id)
    @transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_2.id)
    
    visit edit_merchant_bulk_discount_path(@merchant1, @bulk_discount1)
  end

  #add discount to invoice items when needed
  
  describe "As a merchant" do
    describe "User Story 5" do
      it "has a form to edit the discounts with attributes pre-populated in the form" do
        expect(page).to have_content("Edit Bulk Discount")
        
        expect(page).to have_field(:discount_percent, with: @bulk_discount1.discount_percent)
        expect(page).to have_field(:quantity_threshold, with: @bulk_discount1.quantity_threshold)
      end
      
      it "can edit the discount" do
        fill_in :discount_percent, with: 47
        fill_in :quantity_threshold, with: 383
        click_button "Update Bulk Discount"
        
        expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @bulk_discount1))
        expect(page).to have_content("Bulk Discount Updated")
        expect(page).to have_content(47)
        expect(page).to have_content(383)
      end

      it "will render a message if the form is filled out incorrectly" do
        fill_in :discount_percent, with: ""
        fill_in :quantity_threshold, with: ""
        click_button "Update Bulk Discount"
        
        expect(page).to have_content("All fields must be completed, get your act together.")
      end
    end
  end
end