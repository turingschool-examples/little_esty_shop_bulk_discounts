require 'rails_helper'

describe "merchant discounts index page" do
  before :each do
    @merchant_a = Merchant.create!(name: "Adam's Apples")
    @customer_1 = Customer.create!(first_name: 'Mike', last_name: 'Lazowski')
	  @item_a1 = Item.create!(name: "Gala", description: "crisp sweet", unit_price: 10, merchant: @merchant_a)
    @item_a2 = Item.create!(name: "Fuji", description: "japanese-style", unit_price: 20, merchant: @merchant_a)
    @invoice_a = Invoice.create!(merchant: @merchant_a, customer: @customer_1, status: 2)
    @transaction_1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice: @invoice_a)
	  @discount_a = BulkDiscount.create!(name: "Going Out of Business", discount: 0.2, threshold: 10, merchant: @merchant_a)

    visit merchant_bulk_discounts_path(@merchant_a.id)
  end
  
  it "can see a list all of my discounts and their information" do
    expect(page).to have_content(@discount_a.name)
    expect(page).to have_content("Discount: #{@discount_a.discount_to_percentage}%")
    expect(page).to have_content("Threshold: #{@discount_a.threshold}")
  end

  it "displays a link for each discount to it's respective show page" do
    expect(page).to have_link("#{@discount_a.name}")

    click_link("#{@discount_a.name}")

    expect(current_path).to eq(merchant_bulk_discount_path(@merchant_a, @discount_a))
  end

  it "has a link to create a new discount" do
    expect(page).to have_link('Offer New Discount')

    click_link('Offer New Discount')
    expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant_a))
  end

  it "allows me to delete a discount" do
    within("#discount-#{@discount_a.id}") do
      expect(page).to have_content(@discount_a.name)
      expect(page).to have_button('Delete')
    end
    
    within("#discount-#{@discount_a.id}") do 
      click_button('Delete')
    end

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_a))
    expect(page).to_not have_content(@discount_a.name)
  end

  it "will not allow me to delte a discount if there is a pending invoice to which that discount applies" do 
    @invoice_a = Invoice.create!(merchant: @merchant_a, customer: @customer_1, status: 1)
    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_a.id, item_id: @item_a1.id, quantity: 10, unit_price: 10, status: 0)
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_a.id, item_id: @item_a2.id, quantity: 9, unit_price: 8, status: 0)

    within("#discount-#{@discount_a.id}") do
      expect(page).to have_content(@discount_a.name)
      expect(page).to have_button('Delete')
    end
    
    within("#discount-#{@discount_a.id}") do 
      click_button('Delete')
    end

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_a))
    expect(page).to have_content(@discount_a.name)
    expect(page).to have_content("Cannot delete this discount while applicable invoices are pending")
  end
end