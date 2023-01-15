require 'rails_helper'

RSpec.describe 'Create new discount' do 
  before :each do
    @merchant_1 = Merchant.create!(name: 'Hair Care')
  end
  describe 'user story 2 (part 2)' do 
    it 'displays a form to create a new discount' do 
      visit new_merchant_discount_path(@merchant_1)

      fill_in("Threshold", with: 5)
      fill_in("Percentage", with: 15)
      click_on("Submit")

      expect(current_path).to eq(merchant_discounts_path(@merchant_1))
      #sad path
      visit new_merchant_discount_path(@merchant_1)

      fill_in("Threshold", with: "")
      fill_in("Percentage", with: 15)
      click_on("Submit")

      expect(current_path).to eq(new_merchant_discount_path(@merchant_1))
      expect(page).to have_content("Please fill in all fields!")
    end
  end
end