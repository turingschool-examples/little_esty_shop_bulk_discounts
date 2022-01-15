require 'rails_helper'

RSpec.describe 'merchant bulk discounts index' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    bd_1 = BulkDiscount.create!(percentage: 20, threshold: 10, merchant_id: @merchant1.id)
    bd_2 = BulkDiscount.create!(percentage: 25, threshold: 15, merchant_id: @merchant1.id)
    visit "/merchant/#{@merchant1.id}/discounts"
  end

  it 'creates new bulk discount' do
    click_link 'New Discount'
    expect(current_path).to eq("/merchant/#{@merchant1.id}/discounts/new")
    fill_in 'percentage', with: 21
    fill_in 'threshold', with: 11
    click_button 'Submit'

    expect(current_path).to eq("/merchant/#{@merchant1.id}/discounts")
    expect(page).to have_content('Discount: 21%')
    expect(page).to have_content('Threshold: 11')
  end
end
