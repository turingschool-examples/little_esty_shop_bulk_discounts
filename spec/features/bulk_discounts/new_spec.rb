require 'rails_helper'

RSpec.describe 'new bulk discount' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @bulk_discount_1 = BulkDiscount.create!(name: '5% off', percentage_discount: 5, quantity_threshold: 5, merchant_id: @merchant1.id)

    visit new_merchant_bulk_discount_path(@merchant1)
  end

  it 'given invalid data, redirects user to new form page and displays an error message' do
    fill_in "Name", with: "Kyle"
    fill_in "Percentage discount", with: ''
    fill_in "Quantity threshold", with: ''

    click_button "Submit"

    expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))

    expect(page).to have_content("Name Nice, try. Don't put this on Kyle! He doesn't even work here!, Percentage discount is not a number, Percentage discount Please enter a number 1-99, Quantity threshold is not a number")
  end
end
