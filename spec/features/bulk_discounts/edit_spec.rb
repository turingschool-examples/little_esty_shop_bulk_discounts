require 'rails_helper'

describe "merchant discount edit page" do
  before :each do
    @merchant_a = Merchant.create!(name: "Adam's Apples")
    @customer_1 = Customer.create!(first_name: 'Mike', last_name: 'Lazowski')
	@item_a1 = Item.create!(name: "Gala", description: "crisp sweet", unit_price: 10, merchant: @merchant_a)
    @item_a2 = Item.create!(name: "Fuji", description: "japanese-style", unit_price: 20, merchant: @merchant_a)
    @invoice_a = Invoice.create!(merchant: @merchant_a, customer: @customer_1, status: 2)
    @transaction_1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice: @invoice_a)
	@discount_a = BulkDiscount.create!(name: "Going Out of Business", discount: 0.2, threshold: 10, merchant: @merchant_a)

    visit edit_merchant_bulk_discount_path(@discount_a.id)
  end
  
  xit "prepopulates discount's current attributes" do

  end

  xit "I can change the attributes and submit to edit and return to show page" do
    fill_in :name, with: "Regular Sale"
    fill_in :discount, with: 0.1
    fill_in :threshold, with: 5

    click_button('Submit')

    expect(current_path).to eq(merchant_bulk_discount_path(@discount_a.id))

    expect(page).to have_content("Regular Sale")
    expect(page).to have_content(0.1)
    expect(page).to have_content(5)
  end
end