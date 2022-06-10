require 'rails_helper'

RSpec.describe "Discounts Create Page" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
  end

  it "can create a new discount" do
     visit new_merchant_discount_path(@merchant1)
     fill_in 'name', with: "Memorial Day Special"
     fill_in "threshold", with: 25
     fill_in 'percentage', with: 25

     click_on 'Create Discount'
     expect(current_path).to eq(merchant_discounts_path(@merchant1))

     expect(page).to have_content("Memorial Day Special")
     expect(page).to have_content("Threshold: 25")
     expect(page).to have_content("Percent Discount: 25%")
  end

end
