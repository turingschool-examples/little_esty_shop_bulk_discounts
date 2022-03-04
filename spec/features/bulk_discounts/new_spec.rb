require 'rails_helper'

describe "merchant bulk discounts create" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
  end

  it "new page includes form to add bulk discount" do
    visit merchant_bulk_discounts_path(@merchant1)
    click_link("Create New Discount")
    expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))

    fill_in :percent_discount, with: 50
    fill_in :qty_threshold, with: 45

    click_button

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
    expect(page).to have_content("50")
    expect(page).to have_content("45")
  end
end
