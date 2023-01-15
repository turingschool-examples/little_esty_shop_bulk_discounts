require 'rails_helper'

RSpec.describe 'Edit discount page' do 
  before :each do
    @merchant_1 = Merchant.create!(name: 'Hair Care')
    @merchant_2 = Merchant.create!(name: 'Target')

    @discount_1 = @merchant_1.discounts.create!(threshold: 5, percentage: 5)
    @discount_2 = @merchant_1.discounts.create!(threshold: 10, percentage: 10)
    @discount_3 = @merchant_1.discounts.create!(threshold: 25, percentage: 25)
    @discount_4 = @merchant_1.discounts.create!(threshold: 30, percentage: 30)
    @discount_5 = @merchant_1.discounts.create!(threshold: 50, percentage: 50)
    @discount_6 = @merchant_2.discounts.create!(threshold: 8, percentage: 65)
  end
  describe 'user story 5 (part 2)' do 
    it 'After clicking the edit link, I am taken to a edit page where attributes are pre-populated. After submitting user is redirected back to the discount show page' do 
      visit merchant_discount_path(@merchant_1, @discount_1)

      click_link("Edit Discount")

      expect(current_path).to eq(edit_merchant_discount_path(@merchant_1, @discount_1))
      expect(page).to have_field("Threshold", with: 5)
      expect(page).to have_field("Percentage", with: 5)

      fill_in("Threshold", with: 20)
      fill_in("Percentage", with: 20)
      click_button("Update Discount")

      expect(current_path).to eq(merchant_discount_path(@merchant_1, @discount_1))
      expect(page).to have_content("Quantity Threshold: 20")
      expect(page).to have_content("Discount Percentage: 20")
  end

    it 'displays a flash message if the edit form is not filled out' do 
      visit merchant_discount_path(@merchant_1, @discount_1)

      click_link("Edit Discount")

      expect(current_path).to eq(edit_merchant_discount_path(@merchant_1, @discount_1))
      expect(page).to have_field("Threshold", with: 5)
      expect(page).to have_field("Percentage", with: 5)

      fill_in("Threshold", with: "")
      fill_in("Percentage", with: "")
      click_button("Update Discount")

      expect(page).to have_content("Please fill in all fields!")
    end
  end
end