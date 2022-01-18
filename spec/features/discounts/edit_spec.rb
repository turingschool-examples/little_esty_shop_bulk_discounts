require 'rails_helper'

describe 'discount edit' do
  before do
    @merchant = Merchant.create!(name: "Hair care")
    @discount1 = @merchant.discounts.create!(name: "discount1", percent_off: 10, min_quantity: 3)
    visit merchant_discount_path(@merchant, @discount1)
  end

  it 'discount show page displays link to edit discount' do
    expect(page).to have_link("Edit this discount")
  end

  it 'navigates to edit discount form when link is clicked' do
    click_link("Edit this discount")
    expect(current_path).to eq(edit_merchant_discount_path(@merchant, @discount1))
  end
end
