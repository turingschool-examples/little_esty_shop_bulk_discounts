require 'rails_helper'

describe "merchant discounts index" do
  before :each do
    @merchant_a = Merchant.create!(name: "Adam's Apples")
    @customer_1 = Customer.create!(first_name: 'Mike', last_name: 'Lazowski')
	@item_a1 = Item.create!(name: "Gala", description: "crisp sweet", unit_price: 10, merchant: @merchant_a)
    @item_a2 = Item.create!(name: "Fuji", description: "japanese-style", unit_price: 20, merchant: @merchant_a)
    @invoice_a = Invoice.create!(merchant: @merchant_a, customer: @customer_1, status: 2)
    @transaction_1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice: @invoice_a)
	@discount_a = BulkDiscount.create!(discount: 0.2, threshold: 10, merchant: @merchant_a)

    visit new_merchant_bulk_discount_path
  end
  
  xit "has a form to create a new discount" do
    expect(page).to have_content()
    expect(page).to have_button('Submit')

    fill_in :name, with: 'Blackest Friday'
    fill_in :discount, with: 0.5
    fill_in :name, with: 20

    click_button('Submit')

    expect(current_path).to eq(merchant_bulk_discounts_path)

    expect(page).to have_content('Blackest Friday')
    expect(page).to have_content(0.5)
    expect(page).to have_content(20)
  end
end