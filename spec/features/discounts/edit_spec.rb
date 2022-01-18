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

  it 'has a form to edit the discount with info pre-populated' do
    visit edit_merchant_discount_path(@merchant, @discount1)
    expect(page).to have_field('Discount name:', with: @discount1.name)
    expect(page).to have_field('Percent off:', with: @discount1.percent_off)
    expect(page).to have_field('Minimum quantity:', with: @discount1.min_quantity)
  end

  it 'updates the discount when you hit submit and redirects to show page' do 
end
