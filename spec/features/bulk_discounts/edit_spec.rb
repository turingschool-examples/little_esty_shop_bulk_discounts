require 'rails_helper'

describe 'bulk discounts edit page' do
  before(:each) do
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @bd1 = @merchant1.bulk_discounts.create!(percentage: 25, quantity_threshold: 30)
  end

  it 'updates with valid information' do
    visit edit_merchant_bulk_discount_path(@merchant1, @bd1)

    fill_in :percentage, with: 30
    fill_in :quantity_threshold, with: 35
    
    click_on "Update Discount"

    expect(page).to have_content('Percentage Discount: 30')
    expect(page).to have_content('Quantity Threshold: 35')
    expect(page).to have_current_path("/merchant/#{@merchant1.id}/bulk_discounts/#{@bd1.id}")
  end

  it 'redirects with invalid information' do
    visit edit_merchant_bulk_discount_path(@merchant1, @bd1)

    fill_in :percentage, with: 'asdf'
    fill_in :quantity_threshold, with: ''

    click_on "Update Discount"

    expect(page).to have_content("Error! Please update fields with valid content")
    expect(page).to have_current_path("/merchant/#{@merchant1.id}/bulk_discounts/#{@bd1.id}/edit")
  end
end