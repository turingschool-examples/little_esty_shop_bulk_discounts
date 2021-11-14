require 'rails_helper'

RSpec.describe 'new form' do
  it 'has a form to create a new discount',:vcr do
    merchant = Merchant.create!(name: 'Hair Care')
    visit new_merchant_discount_path(merchant)

    fill_in "Percentage Discount", with: 30
    fill_in "Quantity Threshold", with: 6

    click_on "Submit"

    expect(current_path).to eq(merchant_discounts_path(merchant))

    expect(page).to have_content(30)
    expect(page).to have_content(6)
  end

  it "shows a flash message when the user does not fill out a section of the form" do
    merchant = Merchant.create!(name: 'Hair Care')
    visit new_merchant_discount_path(merchant)

    fill_in "Percentage Discount", with: nil
    fill_in "Quantity Threshold", with: 6

    click_on "Submit"

    expect(page).to have_content("All fields must be completed, get your act together.")

    fill_in "Percentage Discount", with: 30
    fill_in "Quantity Threshold", with: nil

    click_on "Submit"

    expect(page).to have_content("All fields must be completed, get your act together.")
  end
end
