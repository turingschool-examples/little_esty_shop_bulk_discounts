require 'rails_helper'

RSpec.describe 'merchant discount edit page' do
  before(:each) do
    @merchant = Merchant.create!(name: "John Sandman")
    @discount = @merchant.discounts.create!(percentage: 10, threshold: 5, name: "Discount")

    visit edit_merchant_discount_path(@merchant, @discount)
  end

  it 'edits an existing discount' do
    fill_in "Percentage", with: '15'
    fill_in "Threshold", with: '12'
    fill_in "Name", with: 'First Discount'
    click_button "Submit"

    expect(current_path).to eq(merchant_discounts_path(@merchant))
    expect(page).to have_content("Discount updated.")
  end
end
