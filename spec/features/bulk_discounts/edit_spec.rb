require 'rails_helper'

RSpec.describe 'bulk_discount edit' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')
  
    @bulk_discount1 = @merchant1.bulk_discounts.create!(percentage: 10, threshold: 15)
    @bulk_discount2 = @merchant1.bulk_discounts.create!(percentage: 15, threshold: 25)
    @bulk_discount3 = @merchant1.bulk_discounts.create!(percentage: 25, threshold: 30)
    @bulk_discount4 = @merchant2.bulk_discounts.create!(percentage: 50, threshold: 2)
  end 

  it 'has a form to edit a bulk discount' do
    visit edit_merchant_bulk_discount_path(@merchant1, @bulk_discount1)

    fill_in 'Percentage', with: 54
    fill_in 'Threshold', with: 7
    click_button 'Create Bulk Discount'

    expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @bulk_discount1))

    expect(page).to have_content("You can get 54% off if you buy 7 or more items.")
  end
end
