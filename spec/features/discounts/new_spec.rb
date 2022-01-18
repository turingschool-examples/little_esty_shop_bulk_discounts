require 'rails_helper'

describe 'new discount page' do
  before do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    visit new_merchant_discount_path(@merchant1)
  end

  it 'has a form to create discount' do
    expect(page).to have_field("Discount Name")
    expect(page).to have_field("Minimum Quantity")
    expect(page).to have_field("Percent Off")
  end

  it 'creates a new discount when form is filled' do
    fill_in("Discount Name", with: "Valentine's Day Discount")
    fill_in("Minimum Quantity", with: 2)
    fill_in("Percent Off", with: 14)

    click_button("Create Discount")
    
    expect(current_path).to eq(merchant_discounts_path(@merchant1))
    expect(page).to have_content("Valentine's Day Discount")
  end
end
