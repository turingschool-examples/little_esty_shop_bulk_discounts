require 'rails_helper'

RSpec.describe 'bulk discount index' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Computer Parts')
    @merchant3 = Merchant.create!(name: 'Pet Gear')

    @bulk_discount_1 = BulkDiscount.create!(name: '5% off', percentage_discount: 5, quantity_threshold: 5, merchant_id: @merchant1.id)
    @bulk_discount_2 = BulkDiscount.create!(name: '10% off', percentage_discount: 10, quantity_threshold: 10, merchant_id: @merchant2.id)
    @bulk_discount_3 = BulkDiscount.create!(name: '15% off', percentage_discount: 15, quantity_threshold: 15, merchant_id: @merchant3.id)
    @bulk_discount_4 = BulkDiscount.create!(name: '20% off', percentage_discount: 20, quantity_threshold: 20, merchant_id: @merchant3.id)
    @bulk_discount_5 = BulkDiscount.create!(name: '25% off', percentage_discount: 25, quantity_threshold: 25, merchant_id: @merchant2.id)
    @bulk_discount_6 = BulkDiscount.create!(name: '30% off', percentage_discount: 30, quantity_threshold: 30, merchant_id: @merchant1.id)

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
    @customer_2 = Customer.create!(first_name: 'Cecilia', last_name: 'Jones')
    @customer_3 = Customer.create!(first_name: 'Mariah', last_name: 'Carrey')
    @customer_4 = Customer.create!(first_name: 'Leigh Ann', last_name: 'Bron')
    @customer_5 = Customer.create!(first_name: 'Sylvester', last_name: 'Nader')
    @customer_6 = Customer.create!(first_name: 'Herber', last_name: 'Coon')

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

    @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
    @transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_3.id)
    @transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_4.id)
    @transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_5.id)
    @transaction5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice_6.id)
    @transaction6 = Transaction.create!(credit_card_number: 879799, result: 1, invoice_id: @invoice_7.id)
    @transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_2.id)
    visit merchant_bulk_discounts_path(@merchant1)
  end

  it 'lists all the merchants bulk discounts, their attributes and a link to their show page' do

    within "#bulk-discounts-#{@bulk_discount_1.id}" do
      expect(page).to have_content("Percentage Discount: 5%")
      expect(page).to have_content("Quantity Threshold: #{@bulk_discount_1.quantity_threshold}")

      click_link("Link to #{@bulk_discount_1.name}")

      expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @bulk_discount_1))
    end
    visit merchant_bulk_discounts_path(@merchant1)

    within "#bulk-discounts-#{@bulk_discount_6.id}" do
      expect(page).to have_content("Percentage Discount: 30%")
      expect(page).to have_content("Quantity Threshold: #{@bulk_discount_6.quantity_threshold}")
      expect(page).to have_link("Link to #{@bulk_discount_6.name}")

      click_link("Link to #{@bulk_discount_6.name}")

      expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @bulk_discount_6))
    end
  end

  it 'displays the next 3 upcoming US holidays' do

    within "holidays"
      expect(page).to have_content("Upcoming Holidays")
      expect(page).to have_content("Memorial Day")
      expect(page).to have_content("Independence Day")
      expect(page).to have_content("Labour Day")
  end

  it 'allows user to fill in a form to create a new bulk disount' do

    expect(page).to have_link('Create New Discount')

    click_link('Create New Discount')

    expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
    fill_in :name, with: "labor day sale"
    fill_in :percentage_discount, with: 25
    fill_in :quantity_threshold, with: 5
    click_button "Submit"

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))

    expect(page).to have_content("labor day sale")
  end
#
# Then next to each bulk discount I see a link to delete it
# When I click this link
# Then I am redirected back to the bulk discounts index page
# And I no longer see the discount listed

  it 'has a button to delete each bulk discount' do

    within "#bulk-discounts-#{@bulk_discount_1.id}" do
      expect(page).to have_content(@bulk_discount_1.name)

      click_button('Delete')

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
    end
    expect(page).to_not have_content(@bulk_discount_1.name)
    expect(page).to have_content(@bulk_discount_6.name)
  end
end
