require 'rails_helper'

RSpec.describe 'merchant bulk discount edit' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Po House Pub')

    @discount_1 = BulkDiscount.create!(percentage_discount: 5, quantity:  10, merchant_id: @merchant1.id)
    @discount_2 = BulkDiscount.create!(percentage_discount: 78, quantity:  68, merchant_id: @merchant2.id)

    visit merchant_bulk_discount_path(@merchant1, @discount_1)
  end

  it 'has a link to edit the bulk discounts' do
    expect(page).to have_link("Edit Bulk Discount")

    click_link "Edit Bulk Discount"

    expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant1, @discount_1))
  end

  it 'has a form to edit the discount' do
    visit edit_merchant_bulk_discount_path(@merchant1, @discount_1)

    fill_in 'Percentage Discount', with: 15
    fill_in 'Quantity Threshold', with: 22

    click_on "Submit Bulk Discount Updates"

    expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @discount_1))

  end
end
