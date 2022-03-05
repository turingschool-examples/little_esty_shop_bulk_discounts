require 'rails_helper'

describe "merchant bulk discount show" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @discount1 = BulkDiscount.create!(percent_discount: 20, qty_threshold: 10, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(percent_discount: 30, qty_threshold: 15, merchant_id: @merchant1.id)

    visit merchant_bulk_discount_path(@merchant1, @discount1)
  end

  it "shows percentage and quantity thresholds" do
    expect(page).to have_content(@discount1.percent_discount)
    expect(page).to have_content(@discount1.qty_threshold)
  end

  it "shows link to edit discount - form has pre-populated info" do
    click_link "Edit Discount"
    expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant1, @discount1))

    click_button
    expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @discount1))
    expect(page).to have_content(20)
  end

  it "edit form updates info" do
    click_link "Edit Discount"

    expect(page).to have_field('Percent discount', with: 20)

    fill_in 'Qty threshold', with: 47
    fill_in 'Percent discount', with: 19

    click_button
    expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @discount1))
    expect(page).to have_content("47")
  end
end
