require 'rails_helper'

RSpec.describe 'Merchant Discount Show Page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Test Merchant')
    @discount1 = @merchant1.discounts.create!(threshold: 5, percentage: 5, name: "5% Off Deal")
    @discount2 = @merchant1.discounts.create!(threshold: 15, percentage: 15, name: "15% Off Deal")

    @discount3 = @merchant2.discounts.create!(threshold: 10, percentage: 10, name: "10% Discount")

    visit merchant_discount_path(@merchant1.id, @discount1.id)

  end

  it "shows discount attributes" do
    expect(page).to have_content("5% Off Deal:")
    expect(page).to have_content("Percent Discount: 5%")
    expect(page).to have_content("Threshold Quantity: 5")

    expect(page).to_not have_content("15% Off Deal:")
    expect(page).to_not have_content("Percent Discount: 15%")
    expect(page).to_not have_content("Threshold Quantity: 15")
  end

  it "links to edit page" do
    expect(page).to have_link("Edit Discount")
    click_link("Edit Discount")
    expect(current_path).to eq(edit_merchant_discount_path(@merchant1.id, @discount1.id))
  end
end
