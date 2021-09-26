require 'rails_helper'

RSpec.describe 'create discount page' do
  before(:each) do
    @merchant = Merchant.create!(name: "John Sandman")

    visit new_merchant_discount_path(@merchant)
  end

  it 'creates a new discount' do
    fill_in 'Percentage', with: '10'
    fill_in 'Threshold', with: '5'
    click_button 'Submit'
save_and_open_page
    expect(current_path).to eq(merchant_discounts_path(@merchant))
    expect(page).to have_content("New discount created")
  end
end
