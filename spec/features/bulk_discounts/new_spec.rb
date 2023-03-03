require 'rails_helper'

RSpec.describe 'bulk_discount new' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')
  
    @bulk_discount1 = @merchant1.bulk_discounts.create!(percentage: 10, threshold: 15)
    @bulk_discount2 = @merchant1.bulk_discounts.create!(percentage: 15, threshold: 25)
    @bulk_discount3 = @merchant1.bulk_discounts.create!(percentage: 25, threshold: 30)
    @bulk_discount4 = @merchant2.bulk_discounts.create!(percentage: 50, threshold: 2)
  end 

  it 'has a form to create a new bulk discount' do
    visit new_merchant_bulk_discount_path(@merchant1)

    fill_in 'Percentage', with: 18
    fill_in 'Threshold', with: 3
    click_button 'Create Bulk Discount'

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))

    expect(page).to have_content("Percentage: 18")
    expect(page).to have_content("Threshold: 3")
  end
end
