require 'rails_helper'

RSpec.describe "Discounts Index Page" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Test Merchant')
    @discount1 = @merchant1.discounts.create!(threshold: 5, percentage: 5, name: "5% Discount")
    @discount2 = @merchant1.discounts.create!(threshold: 15, percentage: 15, name: "15% Discount")

    @discount3 = @merchant2.discounts.create!(threshold: 10, percentage: 10, name: "10% Discount")
  end


  it "shows all discounts offered by this merchant" do
    visit merchant_discounts_path(@merchant1)

    expect(page).to have_content("5% Discount")
    expect(page).to have_content("15% Discount")
    expect(page).to have_content("Current Discounts for Hair Care:")
    expect(page).to have_content("Threshold: 5")
    expect(page).to have_content("Percent Discount: 5%")
    expect(page).to have_content("Threshold: 15")
    expect(page).to have_content("Percent Discount: 15%")

    expect(page).to_not have_content("Threshold: 10")
    expect(page).to_not have_content("Percent Discount: 10%")
    expect(page).to_not have_content("10% Discount")
  end
  
end
