require 'rails_helper'

RSpec.describe 'bulk discounts new page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')

    visit new_merchant_bulk_discount_path(@merchant1)
  end

  it 'contains a form to create a new bulk discount' do
    fill_in "Percent", with: 25
    fill_in "Quantity", with: 150
    click_button "Submit"

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
    
    within("#discounts") do
      expect(page).to have_content("Discount: 25")
      expect(page).to have_content("Quantity Threshold: 150")
    end
  end
end