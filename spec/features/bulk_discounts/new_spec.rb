require 'rails_helper'

describe 'bulk discounts new page' do
  before(:each) do
    @merchant1 = Merchant.create!(name: 'Hair Care')
  end

  it 'creates with valid information' do
    visit new_merchant_bulk_discount_path(@merchant1)

    fill_in :percentage, with: 10
    fill_in :quantity_threshold, with: 3

    click_on "Create Discount"

    expect(page).to have_content('Percentage Discount: 10')
    expect(page).to have_content('Quantity Threshold: 3')
    expect(page).to have_current_path("/merchant/#{@merchant1.id}/bulk_discounts")
  end

  it 'redirects with invalid information' do
    visit new_merchant_bulk_discount_path(@merchant1)

    fill_in :percentage, with: ""
    fill_in :quantity_threshold, with: ""

    click_on "Create Discount"
    
    expect(page).to have_content("Error! Please enter a valid discount.")
    expect(page).to have_current_path("/merchant/#{@merchant1.id}/bulk_discounts/new")
  end
end