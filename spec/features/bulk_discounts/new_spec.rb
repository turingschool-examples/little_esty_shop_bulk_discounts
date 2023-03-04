require 'rails_helper'

describe 'bulk discount new' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')

    @discount1 = BulkDiscount.create!(name: 'Cheap Things', percentage: 20, quantity_threshold: 10, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(name: 'Mythical Deals', percentage: 30, quantity_threshold:15, merchant_id: @merchant1.id)
    @discount3 = BulkDiscount.create!(name: 'Surplus Value', percentage: 40, quantity_threshold: 20, merchant_id: @merchant1.id)
    @discount4 = BulkDiscount.create!(name: 'Discount Galore', percentage: 50, quantity_threshold: 25, merchant_id: @merchant2.id)
  end
end

describe 'user story 2' do
  it 'displays see a link to create a new discount' do
    visit merchant_bulk_discounts_path(@merchant1)
    
    expect(page).to have_link('Add Discount')

    click_link('Add Discount')

    expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
  end

  it 'has a form when filled with valid data it redirects back to the bulk discount index' do 
    click_link('Add Discount')
    fill_in "Name", with: "Bargain Time"
    fill_in "Percentage", with: "75"
    fill_in "Quantity threshold", with: "30"
    click_button "Submit"
    # save_and_open_page
    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
    # expect(page).to have_content("Bargain Time")
    # expect(page).to have_content("75")
    # expect(page).to have_content("30")
  end
end 