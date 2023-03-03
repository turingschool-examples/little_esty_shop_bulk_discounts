require 'rails_helper'

RSpec.describe 'Bulk Discounts Index' do

  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Dandelion Plants')

    @fifteen = @merchant1.bulk_discounts.create!(percentage_discount: 0.15, quantity_threshold: 15)
    @twenty = @merchant1.bulk_discounts.create!(percentage_discount: 0.20, quantity_threshold: 20)
    @twenty_five = @merchant1.bulk_discounts.create!(percentage_discount: 0.25, quantity_threshold: 30)
    @thirty = @merchant1.bulk_discounts.create!(percentage_discount: 0.30, quantity_threshold: 50)

    @fifty = @merchant2.bulk_discounts.create!(percentage_discount: 0.50, quantity_threshold: 100)

    visit merchant_bulk_discounts_path(@merchant1)
  end

  it 'I see all bulk discounts with percentage discount and quantity thresholds' do
    
    expect(page).to have_content("Hair Care's Bulk Discounts")
    expect(page).to_not have_content("Dandelion Plant's Bulk Discounts")
    
    within "#discount_list" do 
      expect(page).to have_content("15% Discount")
      expect(page).to have_content("Quantity Threshold: 15")

      expect(page).to have_content("20% Discount")
      expect(page).to have_content("Quantity Threshold: 20")

      expect(page).to have_content("25% Discount")
      expect(page).to have_content("Quantity Threshold: 30")

      expect(page).to have_content("30% Discount")
      expect(page).to have_content("Quantity Threshold: 50")

      expect(page).to_not have_content("50% Discount")
      expect(page).to_not have_content("Quantity Threshold: 100")
    end
  end

  it 'Each Discount links to its` show page' do
    expect(page).to have_link("15% Discount")
    expect(page).to have_link("20% Discount")
    expect(page).to have_link("25% Discount")
    expect(page).to have_link("30% Discount")
    click_link("15% Discount")

    expect(current_path).to eq("/merchant/#{@merchant1.id}/bulk_discounts/#{@fifteen.id}")
  end

  it 'I see a link to create a new discount' do
    expect(page).to have_link("Create New Discount")
  end

  it 'When I click this link, I am taken to a new page' do
    click_link("Create New Discount")
    expect(current_path).to eq("/merchant/#{@merchant1.id}/bulk_discounts/new")
  end
end