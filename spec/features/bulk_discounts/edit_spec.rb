require 'rails_helper'

RSpec.describe 'bulk discount edit page' do 
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @bulk_discount_1 = BulkDiscount.create!(percentage: 0.10, quantity_threshhold: 10, merchant: @merchant1)
    @bulk_discount_2 = BulkDiscount.create!(percentage: 0.15, quantity_threshhold: 15, merchant: @merchant1)

    visit edit_merchant_bulk_discount_path(@merchant1, @bulk_discount_1)
  end

  it 'will have fields that are pre-populated with current data' do 

    visit edit_merchant_bulk_discount_path(@merchant1, @bulk_discount_1)
  
    expect(page).to have_field(:percentage)
    expect(page).to have_field(:quantity_threshhold, with: 10)
  end

  it 'will update the discount' do 
    visit merchant_bulk_discount_path(@merchant1, @bulk_discount_1)

    expect(page).to have_content("percentage: 0.1")
    expect(page).to have_content("quantity threshhold: 10")

    visit edit_merchant_bulk_discount_path(@merchant1, @bulk_discount_1)

    fill_in :quantity_threshhold, with: 15
    click_button "Update Discount"

    visit merchant_bulk_discount_path(@merchant1, @bulk_discount_1)

    expect(page).to have_content("percentage: 0.1")
    expect(page).to have_content("quantity threshhold: 15")

  end
end