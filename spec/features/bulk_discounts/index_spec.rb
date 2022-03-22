require 'rails_helper'

RSpec.describe 'bulk discounts index page' do
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

  it 'shows all the bulk discounts ids that belong to a merchant', :vcr do 
    visit merchant_bulk_discounts_path(merchant_1)

    within "#discount_id-#{bulk_discount_1.id}" do 
      expect(page).to have_content(bulk_discount_1.id)
      expect(page).to_not have_content(bulk_discount_2.id)
  
      expect(page).to_not have_content(bulk_discount_3.id)
    end

    within "#discount_id-#{bulk_discount_2.id}" do 
      expect(page).to have_content(bulk_discount_2.id)
      expect(page).to_not have_content(bulk_discount_1.id)
  
      expect(page).to_not have_content(bulk_discount_3.id)
    end
  end

  it 'shows all of the bulk discounts percentages that belong to a merchant', :vcr do 
    visit merchant_bulk_discounts_path(merchant_1)

    within "#markdown-#{bulk_discount_1.markdown}" do 
      expect(page).to have_content(bulk_discount_1.markdown)
      expect(page).to_not have_content(bulk_discount_2.markdown)
  
      expect(page).to_not have_content(bulk_discount_3.markdown)
    end

    within "#markdown-#{bulk_discount_2.markdown}" do 
      expect(page).to have_content(bulk_discount_2.markdown)
      expect(page).to_not have_content(bulk_discount_1.markdown)
  
      expect(page).to_not have_content(bulk_discount_3.markdown)
    end
  end

  it 'shows all of the bulk discounts quantitty thresholds that belong to a merchant', :vcr do
     visit merchant_bulk_discounts_path(merchant_1)
     
     within "#quantity_threshold-#{bulk_discount_1.quantity_threshold}" do 
      expect(page).to have_content(bulk_discount_1.quantity_threshold)
      expect(page).to_not have_content(bulk_discount_2.quantity_threshold)
  
      expect(page).to_not have_content(bulk_discount_3.quantity_threshold)
    end

    within "#quantity_threshold-#{bulk_discount_2.quantity_threshold}" do 
      expect(page).to have_content(bulk_discount_2.quantity_threshold)
      expect(page).to_not have_content(bulk_discount_1.quantity_threshold)
  
      expect(page).to_not have_content(bulk_discount_3.quantity_threshold)
    end
  end

  it 'can click the bulk discount id link and be taken to that bulk discounts show page', :vcr do 
    visit merchant_bulk_discounts_path(merchant_1)

    click_link "#{bulk_discount_1.id}"

    expect(current_path).to eq(merchant_bulk_discount_path(merchant_1, bulk_discount_1))
  end

  it 'can click the link to create a new bulk discount for the current merchant', :vcr do 
    visit merchant_bulk_discounts_path(merchant_1)

    click_link "Create Discount"
    
    expect(current_path).to eq(new_merchant_bulk_discount_path(merchant_1))
  end

  it 'can click a link to delete a bulk discount for the current merchant', :vcr do 
    visit merchant_bulk_discounts_path(merchant_1)

    click_link "Delete Discount With ID: #{bulk_discount_1.id}"

    expect(current_path).to eq(merchant_bulk_discounts_path(merchant_1))
    
    expect(page).to_not have_content(bulk_discount_1.id)
  end

  it 'displays the the three upcoming holidays', :vcr do 
    visit merchant_bulk_discounts_path(merchant_1)

    within "#holidays" do
      expect(page).to have_content("Good Friday")
      expect(page).to have_content("2022-04-15")
      expect(page).to have_content("Memorial Day")
      expect(page).to have_content("2022-05-30")
      expect(page).to have_content("Juneteenth")
      expect(page).to have_content("2022-06-20")
    end
  end
end