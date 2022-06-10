require 'rails_helper'

RSpec.describe "Deleting a Discount" do
  before :each do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @discount1 = @merchant1.discounts.create!(threshold: 5, percentage: 5, name: "5% Discount")

      visit merchant_discounts_path(@merchant1.id)
  end

  it "can delete a merchants discount" do
    expect(page).to have_content("5% Discount")
    click_button "Delete Discount"
    expect(current_path).to eq(merchant_discounts_path(@merchant1.id))
    expect(page).to_not have_content("5% Discount")
    expect(page).to_not have_button("Delete Discount")
  end
end
