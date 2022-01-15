require 'rails_helper'

RSpec.describe 'merchants bulk discount index page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')

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

    @bd1 = @merchant1.bulk_discounts.create!(threshold: 10, discount: 10)
    @bd2 = @merchant1.bulk_discounts.create!(threshold: 15, discount: 15)
    @bd3 = @merchant1.bulk_discounts.create!(threshold: 20, discount: 20)

    visit merchant_bulk_discounts_path(@merchant1.id)
  end

  it 'the link from the merchants dashboard takes the user to the merchants bulk discount page' do
    visit merchant_dashboard_index_path(@merchant1.id)
    click_link "View All My Discounts"
    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1.id))

    expect(page).to have_content("Bulk Discounts Index Page")
  end

  it 'has a list of all of the merchants bulk discounts including threshold and percentage' do
    expect(page).to have_content("Threshold: 10, Discount: 10.0%")
    expect(page).to have_content("Threshold: 15, Discount: 15.0%")
    expect(page).to have_content("Threshold: 20, Discount: 20.0%")
  end

  it 'has a link to go to the bulk discounts view page' do
    expect(page).to have_link("View Bulk Discount ##{@bd1.id}", href: merchant_bulk_discount_path(@merchant1.id, @bd1.id))
    expect(page).to have_link("View Bulk Discount ##{@bd2.id}", href: merchant_bulk_discount_path(@merchant1.id, @bd2.id))
    expect(page).to have_link("View Bulk Discount ##{@bd3.id}", href: merchant_bulk_discount_path(@merchant1.id, @bd3.id))
  end

  it 'has a link to create a new bulk discount' do
    click_link "Create a New Bulk Discount"

    expect(current_path).to eq("/merchant/#{@merchant1.id}/bulk_discounts/new")

    fill_in :discount, with: 10
    fill_in :threshold, with: 10
    click_button "Create Discount"

    expect(current_path).to eq("/merchant/#{@merchant1.id}/bulk_discounts")

    expect(page).to have_content("Threshold: 10")
    expect(page).to have_content("Discount: 10")
  end

  # Merchant Bulk Discount Create
  #
  # As a merchant
  # When I visit my bulk discounts index
  # Then I see a link to create a new discount
  # When I click this link
  # Then I am taken to a new page where I see a form to add a new bulk discount
  # When I fill in the form with valid data
  # Then I am redirected back to the bulk discount index
  # And I see my new bulk discount listed
end
