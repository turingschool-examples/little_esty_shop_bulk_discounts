require 'rails_helper'

RSpec.describe 'Bulk Discount dashboard/index' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Putney General Store')

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

    @discount_1 = BulkDiscount.create!(name: "Bargain Bin Discount", percentage_discount: 0.2, quantity_threshold: 10, merchant: @merchant1)

    visit  merchant_bulk_discounts_path(@merchant1)
  end

  it 'I see all of my bulk discounts including their percentage discount and quantity thresholds' do
    expect(page).to have_content(@discount_1.name)
    expect(page).to have_content("Discount: #{@discount_1.discount_percent}%")
    expect(page).to have_content("Quantity Threshold: #{@discount_1.quantity_threshold}")
  end

  it 'And each bulk discount listed includes a link to its show page' do
    within("#discount-#{@discount_1.id}") do
      expect(page).to have_link("#{@discount_1.name}")
      click_on("#{@discount_1.name}")
    end
    expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @discount_1))
  end

  it 'can display the next 3 upcoming holidays' do
    expect(page).to have_content("Memorial Day")
    expect(page).to have_content("Independence Day")
    expect(page).to have_content("Labor Day")
  end


  it 'has a form to fill out which will create a new discount' do

    expect(page).to have_link('Create a new discount')
    click_link('Create a new discount')
    expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
    fill_in :name, with: "going out of business sale"
    fill_in :percentage_discount, with: 50
    fill_in :quantity_threshold, with: 10
    click_button "Submit"

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))

    expect(page).to have_content("going out of business sale")
  end
end




# As a merchant
# When I visit my bulk discounts index
# Then I see a link to create a new discount
# When I click this link
# Then I am taken to a new page where I see a form to add a new bulk discount
# When I fill in the form with valid data
# Then I am redirected back to the bulk discount index
# And I see my new bulk discount listed
