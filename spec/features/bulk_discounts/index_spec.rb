require 'rails_helper'

describe "merchant discounts index" do
  before :each do
    @merchant_a = Merchant.create!(name: "Adam's Apples")
    @customer_1 = Customer.create!(first_name: 'Mike', last_name: 'Lazowski')
	@item_a1 = Item.create!(name: "Gala", description: "crisp sweet", unit_price: 10, merchant: @merchant_a)
    @item_a2 = Item.create!(name: "Fuji", description: "japanese-style", unit_price: 20, merchant: @merchant_a)
    @invoice_a = Invoice.create!(merchant: @merchant_a, customer: @customer_1, status: 2)
    @transaction_1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice: @invoice_a)
	@discount_a = BulkDiscount.create!(discount: 0.2 threshold: 10 merchant: @merchant_a)

    visit merchant_bulk_discounts_path
  end
  
  it "can see a list of all the names of my items and not items for other merchants" do
    expect(page).to have_link("#{@discount_a.name}")
    expect(page).to have_content(@discount_a.discount)
    expect(page).to have_content(@discount_a.threshold)

    click_link("#{@discount_a.name}")

    expect(current_path).to eq(merchant_discounts_path(@discount_a.id))
  end
end