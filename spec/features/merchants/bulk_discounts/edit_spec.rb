require 'rails_helper'

RSpec.describe 'Edit Bulk Discount' do
  describe 'User story 5' do
    it 'has a pre-populated form to edit the discount' do
      merchant_1 = create(:merchant)

      bulk_discount_1 = merchant_1.bulk_discounts.create!(quantity_threshold: 10, percentage: 5)

      visit merchant_bulk_discount_path(merchant_1, bulk_discount_1.id)

      expect(page).to have_content("Quantity Threshold: 10")
      expect(page).to have_content("Percentage: 5")
      
      click_link('Edit bulk discount')
      
      fill_in('quantity_threshold', with: 20)
      click_button('Update bulk discount')
      
      expect(current_path).to eq(merchant_bulk_discount_path(merchant_1, bulk_discount_1.id))
      expect(page).to have_content("Quantity Threshold: 20")
      expect(page).to have_content("Percentage: #{bulk_discount_1.percentage}")
      expect(page).to_not have_content("Quantity Threshold: 10")
      
      click_link('Edit bulk discount')
      
      fill_in('percentage', with: 15)
      click_button('Update bulk discount')
      
      expect(current_path).to eq(merchant_bulk_discount_path(merchant_1, bulk_discount_1.id))
      expect(page).to have_content("Percentage: 15")
      expect(page).to have_content("Quantity Threshold: 20")
      expect(page).to_not have_content("Percentage: 5")
    end
  end
end