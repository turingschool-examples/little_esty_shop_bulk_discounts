require 'rails_helper'

RSpec.describe "bulk discount new page" do 
  before :each do 
  @merchant1 = Merchant.create!(name: 'Hair Care')
  @bulk_discount_1 = BulkDiscount.create!(percentage: 0.10, quantity_threshhold: 10, merchant: @merchant1)
  @bulk_discount_2 = BulkDiscount.create!(percentage: 0.15, quantity_threshhold: 15, merchant: @merchant1)
  
  visit new_merchant_bulk_discount_path(@merchant1)
  end 

  it 'will have a form to create a new bulk discount' do 
    expect(page).to have_field("percentage")
    expect(page).to have_field("quantity threshhold")
  end

  it 'will create a new bulk discount and display it on the index page' do
    fill_in :percentage, with: 0.20
    fill_in :quantity_threshhold, with: 20
    click_button "Create New Discount"

    expect(current_path).to eq( merchant_bulk_discounts_path(@merchant1))
    expect(page).to have_content("Discount: %20")
    expect(page).to have_content("Amount of items needed for discount: 20")
  end

  it 'will have an error message when all required fields are not validated' do
    fill_in :percentage, with: 0.20
    click_button "Create New Discount"

    expect(page).to have_content("Discount not created: Required information missing.")
    expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
  end 
end