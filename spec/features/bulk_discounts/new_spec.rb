require 'rails_helper'

RSpec.describe 'bulk discounts new page' do
  let!(:merchant_1) {Merchant.create!(name: 'Hair Care')}
  let!(:merchant_2) {Merchant.create!(name: 'Hayleys Comcics')}

  let!(:bulk_discount_1) {merchant_1.bulk_discounts.create!(markdown: 10, quantity_threshold: 10)}
  let!(:bulk_discount_2) {merchant_1.bulk_discounts.create!(markdown: 20, quantity_threshold: 20)}
  let!(:bulk_discount_3) {merchant_2.bulk_discounts.create!(markdown: 30, quantity_threshold: 30)}

  let!(:customer_1) {Customer.create!(first_name: 'Joey', last_name: 'Smith')}
  let!(:customer_2) {Customer.create!(first_name: 'Cecilia', last_name: 'Jones')}
  let!(:customer_3) {Customer.create!(first_name: 'Mariah', last_name: 'Carrey')}
  let!(:customer_4) {Customer.create!(first_name: 'Leigh Ann', last_name: 'Bron')}
  let!(:customer_5) {Customer.create!(first_name: 'Sylvester', last_name: 'Nader')}
  let!(:customer_6) {Customer.create!(first_name: 'Herber', last_name: 'Kuhn')}

  let!(:invoice_1) {customer_1.invoices.create!(status: 2)}
  let!(:invoice_2) {customer_1.invoices.create!(status: 2)}
  let!(:invoice_3) {customer_2.invoices.create!(status: 2)}
  let!(:invoice_4) {customer_3.invoices.create!(status: 2)}
  let!(:invoice_5) {customer_4.invoices.create!(status: 2)}
  let!(:invoice_6) {customer_5.invoices.create!(status: 2)}
  let!(:invoice_7) {customer_6.invoices.create!(status: 1)}

  let!(:item_1) {merchant_1.items.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10)}
  let!(:item_2) {merchant_1.items.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8)}
  let!(:item_3) {merchant_1.items.create!(name: "Brush", description: "This takes out tangles", unit_price: 5)}
  let!(:item_4) {merchant_1.items.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1)}

  let!(:i_i_1) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 1, unit_price: 10, status: 0)}
  let!(:i_i_2) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_2.id, quantity: 1, unit_price: 8, status: 0)}
  let!(:i_i_3) {InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_3.id, quantity: 1, unit_price: 5, status: 2)}
  let!(:i_i_4) {InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_4.id, quantity: 1, unit_price: 5, status: 1)}
  let!(:i_i_5) {InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_4.id, quantity: 1, unit_price: 5, status: 1)}
  let!(:i_i_6) {InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_4.id, quantity: 1, unit_price: 5, status: 1)}
  let!(:i_i_7) {InvoiceItem.create!(invoice_id: invoice_6.id, item_id: item_4.id, quantity: 1, unit_price: 5, status: 1)}

  let!(:transaction1) {invoice_1.transactions.create!(credit_card_number: 203942, result: 1)}
  let!(:transaction2) {invoice_3.transactions.create!(credit_card_number: 230948, result: 1)}
  let!(:transaction3) {invoice_4.transactions.create!(credit_card_number: 234092, result: 1)}
  let!(:transaction4) {invoice_5.transactions.create!(credit_card_number: 230429, result: 1)}
  let!(:transaction5) {invoice_6.transactions.create!(credit_card_number: 102938, result: 1)}
  let!(:transaction6) {invoice_7.transactions.create!(credit_card_number: 879799, result: 1)}
  let!(:transaction7) {invoice_2.transactions.create!(credit_card_number: 203942, result: 1)}

  it 'fills in the form to create a new bulk discount', :vcr do 
    visit new_merchant_bulk_discount_path(merchant_1)

    fill_in :markdown, with: 100
    fill_in :quantity_threshold, with: 100 
    click_button "Submit"

    expect(current_path).to eq(merchant_bulk_discounts_path(merchant_1))
    expect(page).to have_content("Markdown: 100")
    expect(page).to have_content("Quantity Threshold: 100")
  end

  it 'fills in the form with invalid data and returns errors' do 
    visit new_merchant_bulk_discount_path(merchant_1)

    fill_in :markdown, with: "Yummy"
    fill_in :quantity_threshold, with: "Pizza" 
    click_button "Submit"

    expect(current_path).to eq(new_merchant_bulk_discount_path(merchant_1))
    expect(page).to have_content("Markdown is not a number, Quantity threshold is not a number. Please Try Again")
  end

  it 'submits a blank form and returns errors' do 
    visit new_merchant_bulk_discount_path(merchant_1)

    fill_in :markdown, with: ""
    fill_in :quantity_threshold, with: "" 
    click_button "Submit"

    expect(current_path).to eq(new_merchant_bulk_discount_path(merchant_1))
    expect(page).to have_content("Markdown can't be blank, Markdown is not a number, Quantity threshold can't be blank, Quantity threshold is not a number. Please Try Again")
  end

  it 'submits a form with values too high and returns errors' do 
    visit new_merchant_bulk_discount_path(merchant_1)

    fill_in :markdown, with: "101"
    fill_in :quantity_threshold, with: "101" 
    click_button "Submit"

    expect(current_path).to eq(new_merchant_bulk_discount_path(merchant_1))
  
    expect(page).to have_content("Markdown must be less than or equal to 100. Please Try Again")
  end

  it 'submits a form with values too low and returns errors' do 
    visit new_merchant_bulk_discount_path(merchant_1)

    fill_in :markdown, with: "0"
    fill_in :quantity_threshold, with: "-1" 
    click_button "Submit"

    expect(current_path).to eq(new_merchant_bulk_discount_path(merchant_1))
    
    expect(page).to have_content("Markdown must be greater than or equal to 1, Quantity threshold must be greater than or equal to 0. Please Try Again")
  end
end