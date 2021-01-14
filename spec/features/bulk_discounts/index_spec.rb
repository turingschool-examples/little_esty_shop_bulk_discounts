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

    visit merchant_bulk_discounts_path
  end
  
  it "can see a list all of my discounts and their information" do
    expect(page).to have_content(@discount_a.name)
    expect(page).to have_content(@discount_a.discount)
    expect(page).to have_content(@discount_a.threshold)
  end

  it "displays a link for each discount to it's respective show page" do
    expect(page).to have_link("#{@discount_a.name}")

    click_link("#{@discount_a.name}")

    expect(current_path).to eq(merchant_bulk_discount_path(@discount_a.id))
  end

  it "has a link tocreate a new discount" do
    expect(page).to have_link('Offer new discount')

    click_link('Offer new discount')
    expect(current_path).to eq(new_merchant_bulk_discount_path)
  end

  it "allows me to delete a discount" do
    expect(page).to have_content(@discount_a.name)
    expect(page).to have_button('Delete')

    click_button('Delete')

    expect(current_path).to eq(merchant_bulk_discounts_path)
    expect(page).to_not have_content(@discount_a.name)
  end
end