require 'rails_helper'

RSpec.describe 'new page to fill in form to add a new bulk discount' do
  before :each do
      @merchant1 = Merchant.create!(name: 'Hair Care')
  end

  it 'displays a link to create a new discount' do
      visit merchant_bulk_discounts_path(@merchant1)

      expect(page).to have_link('Create New Discount')
      click_link 'Create New Discount'
      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
  end

  it 'can create a new bulk discount' do
    visit new_merchant_bulk_discount_path(@merchant1)

    fill_in 'Percentage Discount', with: 12
    fill_in 'Quantity Threshold', with: 22

    click_button "Create New Bulk Discount"

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))

    expect(page).to have_content('Percentage Discount: 12')
    expect(page).to have_content('Quantity Threshold: 22')
  end
end
