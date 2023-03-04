require 'rails_helper'

RSpec.describe 'bulk discount index page' do 
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @bulk_discount_1 = BulkDiscount.create!(percentage: 0.10, quantity_threshhold: 10, merchant: @merchant1)
    @bulk_discount_2 = BulkDiscount.create!(percentage: 0.15, quantity_threshhold: 15, merchant: @merchant1)

    visit merchant_bulk_discounts_path(@merchant1)
  end

  it 'will have a list of all discounts for that merchant' do 
    expect(page).to have_content("Discount: %10")
    expect(page).to have_content("Amount of items needed for discount: #{@bulk_discount_1.quantity_threshhold}")
    expect(page).to have_content("Discount: %15")
    expect(page).to have_content("Amount of items needed for discount: #{@bulk_discount_2.quantity_threshhold}")
  end

  it 'will have a link to the show page of each bulk discount' do 
    within "#discount-#{@bulk_discount_1.id}" do 
      expect(page).to have_link("Discount")

      click_link "Discount"

      expect(current_path).to eq("/merchant/#{@merchant1.id}/bulk_discounts/#{@bulk_discount_1.id}")
  end

  visit merchant_bulk_discounts_path(@merchant1)

    within "#discount-#{@bulk_discount_2.id}" do 
      expect(page).to have_link("Discount")

      click_link "Discount"

      expect(current_path).to eq("/merchant/#{@merchant1.id}/bulk_discounts/#{@bulk_discount_2.id}")
    end
  end

  it 'will have a link to create a new discount' do 
    expect(page).to have_link("Create New Discount")

    click_on "Create New Discount"

    expect(current_path).to eq("/merchant/#{@merchant1.id}/bulk_discounts/new")
  end

  it 'will have a link next to each discount to delete it' do 
    within "#discount-#{@bulk_discount_1.id}" do 
      expect(page).to have_button("Delete Discount")

      click_button "Delete Discount"
    end
      
      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
      expect(page).to_not have_content("Discount: %10")
      expect(page).to_not have_content("Amount of items needed for discount: #{@bulk_discount_1.quantity_threshhold}")
  end
end